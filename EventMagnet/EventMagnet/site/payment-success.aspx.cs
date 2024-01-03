using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Stripe;
using System.Configuration;
using EventMagnet.modal;
using System.Security.Cryptography;
using System.Drawing;

namespace EventMagnet.site
{

    public partial class payment_success : System.Web.UI.Page
    {
    
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;
        public bool isSuccessPayment = false;

        public cust_order custOrder = new cust_order();
        public float priceAmount = 0f;
        public string paymentMethod = "Invalid";
        public Guid custOrderUUID = new Guid();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.Params["custOrderUUID"] != null && Request.Params["billType"] != null && Request.Params["status_id"] != null)
            {
                // toyyibpay

                custOrderUUID = Guid.Parse(Request.Params["custOrderUUID"]);
                string billType = Request.Params["billType"];
                int status_id = 3;
                try
                {
                    status_id = int.Parse(Request.Params["status_id"]);
                }
                catch (Exception) { status_id = 3; }

                if (!custOrderUUID.Equals(Guid.Empty) && billType == "F" && status_id == 1)
                {
                    // success payment
                    setCustOrderStatus(custOrderUUID, 1);
                    isSuccessPayment = true;
                }
            }
            else if (Request.Params["custOrderUUID"] != null && Request.Params["billplz[paid]"] != null)
            {
                // billplz payment

                custOrderUUID = Guid.Parse(Request.Params["custOrderUUID"]);
                string isPaid = Request.Params["billplz[paid]"];

                if (!custOrderUUID.Equals(Guid.Empty) && isPaid == "true")
                {
                    // success payment
                    setCustOrderStatus(custOrderUUID, 1);
                    isSuccessPayment = true;
                }
            }
            else if (Request.Params["custOrderUUID"] != null && Request.Params["billType"] != null && Request.Params["success"] != null)
            {
                // stripe, paypal, Touch 'n Go payment

                custOrderUUID = Guid.Parse(Request.Params["custOrderUUID"]);
                string billType = Request.Params["billType"];
                bool isSuccess = false;

                try
                {
                    int successStatus = int.Parse(Request.Params["success"]);
                    isSuccess = successStatus == 1;
                }
                catch (Exception) { isSuccess = false; }

                if (!custOrderUUID.Equals(Guid.Empty) && isSuccess)
                {
                    if (billType == "C")
                    {
                        // success payment in stripe payment
                        setCustOrderStatus(custOrderUUID, 1);
                        isSuccessPayment = true;
                    }
                    else if (billType == "P")
                    {
                        // success payment in PayPal
                        setCustOrderStatus(custOrderUUID, 1);
                        isSuccessPayment = true;
                    }
                    else if (billType == "T")
                    {
                        // success payment in Touch 'n GO
                        setCustOrderStatus(custOrderUUID, 1);
                        isSuccessPayment = true;
                    }
                }
            }

            Session.Remove("paymentAmount");
            Session.Remove("custOrderUUID");

            Session.Remove("ticketDetail_ticketMap");
            Session.Remove("ticketDetail_event");

            if (!custOrderUUID.Equals(Guid.Empty)) {
                custOrder = getCustOrder(custOrderUUID);
                priceAmount = getTotalPrice(custOrderUUID);
                paymentMethod = getPaymentName(custOrderUUID);
            }

            testtest.Text = "";

        }

        int setCustOrderStatus(Guid custOrderUUID, int status) 
        {
            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = "UPDATE cust_order SET status = @status WHERE uuid = @uuid";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@uuid", custOrderUUID.ToString());

            int result = cmd.ExecuteNonQuery();

            con.Close();

            return result;
        }

        cust_order getCustOrder(Guid custOrderUUID) 
        {
            cust_order custOrder = new cust_order();            

            EventMagnetEntities db = new EventMagnetEntities();
            
            IQueryable<cust_order> custOrderDB = db.cust_order.AsQueryable()
                               .Where(x => x.uuid.ToString() == custOrderUUID.ToString());

            custOrderDB = custOrderDB.Take(1);

            foreach (cust_order custOrderItem in custOrderDB)
            {
                custOrder = custOrderItem;
            }

            return custOrder;
        }

        float getTotalPrice(Guid custOrderUUID) 
        {
            float totalPrice = 0f;

            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // calculate ticket payment price
            string query = 
                @"
                    SELECT co.id, (COUNT(oi.id) * t.price) AS num_of_ticket

                    FROM cust_order co, order_item oi, ticket t

                    WHERE co.uuid = @uuid
                        AND co.id = oi.cust_order_id
                        AND oi.ticket_id = t.id
                    GROUP BY co.id, oi.ticket_id, t.price
                ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", custOrderUUID.ToString());

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                totalPrice += (float) Convert.ToDouble(dr["num_of_ticket"]);
            }

            dr.Close();


            // add ticket payment price with payment fee
            query =
                @"
                    SELECT payment_fee 

                    FROM cust_order co, customer_payment cp

                    WHERE co.uuid = @uuid
                        AND co.customer_payment_id = cp.id
                ";

            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", custOrderUUID.ToString());

            float paymentFee = 0f;
            try
            {
                paymentFee = (float)Convert.ToDouble(cmd.ExecuteScalar());
            }catch (Exception ex)
            {
                paymentFee = 0f;
            }

            totalPrice += paymentFee;
            
            con.Close();

            return totalPrice;
        }

        private string getPaymentName(Guid custOrderUUID)
        {
            string paymentName = "";

            SqlConnection con = new SqlConnection(cs);
            
            // add ticket payment price with payment fee
            string query =
                @"
                    SELECT payment_method

                    FROM cust_order co, customer_payment cp

                    WHERE co.uuid = @uuid
                        AND co.customer_payment_id = cp.id
                "
            ;
            con.Open();

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", custOrderUUID.ToString());

            string paymentCode = "";
            try
            {
                paymentCode = Convert.ToString(cmd.ExecuteScalar());
                paymentName = getPaymentMethodName(paymentCode);
            }
            catch (Exception ex)
            {
                paymentName = "Invalid";
            }

            con.Close();

            return paymentName;
        }

        private string getPaymentMethodName(string paymentMethodCode)
        {
            string paymentMethodName = "";
            switch (paymentMethodCode)
            {
                case "F":
                    paymentMethodName = "FPX";
                    break;
                case "B":
                    paymentMethodName = "Billplz FPX";
                    break;
                case "C":
                    paymentMethodName = "Credit/Debit Card";
                    break;
                case "P":
                    paymentMethodName = "PayPal";
                    break;
                case "T":
                    paymentMethodName = "Touch 'n Go";
                    break;
                default:
                    break;
            }
            return paymentMethodName;
        }


        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void btnOrderPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("ticket-history.aspx");
        }


    }
}