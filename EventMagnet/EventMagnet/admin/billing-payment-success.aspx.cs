using EventMagnet.modal;
using Stripe;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.admin
{
    public partial class billing_payment_success : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;
        public bool isSuccessPayment = false;

        public billing bill = new billing();
        public float priceAmount = 0f;
        public string paymentMethod = "Invalid";
        public Guid billingUUID = new Guid();

        protected void Page_Load(object sender, EventArgs e)
        {


            if (Request.Params["billingUUID"] != null && Request.Params["billType"] != null && Request.Params["status_id"] != null)
            {
                // toyyibpay

                billingUUID = Guid.Parse(Request.Params["billingUUID"]);
                string billType = Request.Params["billType"];
                int status_id = 3;
                try
                {
                    status_id = int.Parse(Request.Params["status_id"]);
                }
                catch (Exception) { status_id = 3; }

                if (!billingUUID.Equals(Guid.Empty) && billType == "F" && status_id == 1)
                {
                    // success payment
                    setBillingStatus(billingUUID, 1);
                    isSuccessPayment = true;
                }
                else
                {
                    setBillingStatus(billingUUID, 0);
                }
            }
            else if (Request.Params["billingUUID"] != null && Request.Params["billplz[paid]"] != null)
            {
                // billplz payment

                billingUUID = Guid.Parse(Request.Params["billingUUID"]);
                string isPaid = Request.Params["billplz[paid]"];

                if (!billingUUID.Equals(Guid.Empty) && isPaid == "true")
                {
                    // success payment
                    setBillingStatus(billingUUID, 1);
                    isSuccessPayment = true;
                }
                else 
                {
                    setBillingStatus(billingUUID, 0);
                }
            }
            else if (Request.Params["billingUUID"] != null && Request.Params["billType"] != null && Request.Params["success"] != null)
            {
                // stripe, paypal, Touch 'n Go payment

                billingUUID = Guid.Parse(Request.Params["billingUUID"]);
                string billType = Request.Params["billType"];
                bool isSuccess = false;

                try
                {
                    int successStatus = int.Parse(Request.Params["success"]);
                    isSuccess = successStatus == 1;
                }
                catch (Exception) { isSuccess = false; }

                if (!billingUUID.Equals(Guid.Empty) && isSuccess)
                {
                    if (billType == "C")
                    {
                        // success payment in stripe payment
                        setBillingStatus(billingUUID, 1);
                        isSuccessPayment = true;
                    }
                    else if (billType == "P")
                    {
                        // success payment in PayPal
                        setBillingStatus(billingUUID, 1);
                        isSuccessPayment = true;
                    }
                    else if (billType == "T")
                    {
                        // success payment in Touch 'n GO
                        setBillingStatus(billingUUID, 1);
                        isSuccessPayment = true;
                    }
                    else {
                        setBillingStatus(billingUUID, 0);
                    }
                }
            }

            //Session.Remove("billingPaymentAmount");
            //Session.Remove("billingUUID");

            if (!billingUUID.Equals(Guid.Empty))
            {
                bill = getBilling(billingUUID);
                priceAmount = getTotalPrice(billingUUID);
                paymentMethod = getPaymentName(billingUUID);
            }


        }


        int setBillingStatus(Guid billingUUID, int status)
        {
            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = "UPDATE billing SET status = @status WHERE uuid = @uuid";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@uuid", billingUUID.ToString());

            int result = cmd.ExecuteNonQuery();

            con.Close();

            return result;
        }

        billing getBilling(Guid billingUUID)
        {
            billing billRecord = new billing();

            EventMagnetEntities db = new EventMagnetEntities();

            IQueryable<billing> billingDB = db.billings.AsQueryable()
                               .Where(x => x.uuid.ToString() == billingUUID.ToString());

            billingDB = billingDB.Take(1);

            foreach (billing billItem in billingDB)
            {
                billRecord = billItem;
            }

            return billRecord;
        }

        float getTotalPrice(Guid billingUUID)
        {
            float totalPrice = 0f;

            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // calculate ticket payment price
            string query =
                @"
                    SELECT b.price, p.payment_fee

                    FROM billing b, organization_payment p

                    WHERE b.uuid = @uuid
                        AND b.organization_payment_id = p.id                   
                ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", billingUUID.ToString());

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                totalPrice = (float)Convert.ToDouble(dr["price"]) + (float)Convert.ToDouble(dr["payment_fee"]);
                break;
            }

            dr.Close();

            con.Close();

            return totalPrice;
        }

        private string getPaymentName(Guid billingUUID)
        {
            string paymentName = "";

            SqlConnection con = new SqlConnection(cs);

            // add ticket payment price with payment fee
            string query =
                @"
                    SELECT payment_method

                    FROM billing co, organization_payment cp

                    WHERE co.uuid = @uuid
                        AND co.organization_payment_id = cp.id
                "
            ;
            con.Open();

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", billingUUID.ToString());

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

        protected void btnBillingPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("billing.aspx");
        }
    }
}