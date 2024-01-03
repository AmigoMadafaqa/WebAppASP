using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.admin
{
    public partial class index : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;

        int orgId;
        DateTime firstDay;
        DateTime lastDay;

        public float profitAmount = 0f;
        public float paymentAmount = 0f;
        public float transactionAmount = 0f;
        public Dictionary<string,float> paymentMethodTransaction = new Dictionary<string, float>();
        public float balance = 0f;
        public int totalOrder = 0;
        public int totalSales = 0;
        public float currentYearRevenue = 0f;
        public float previousYearRevenue = 0f;
        public int numOfCust = 0;
        public int numOfEvent = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            paymentMethodTransaction.Add("F", 0f);
            paymentMethodTransaction.Add("B", 0f);
            paymentMethodTransaction.Add("C", 0f);
            paymentMethodTransaction.Add("P", 0f);
            paymentMethodTransaction.Add("T", 0f);

            if (Session["currentOrgId"] != null) {
                int year = DateTime.Now.Year - 1;  // THIS REMEMBER CHANGE BACK TO 2024
                firstDay = new DateTime(year, 1, 1);
                lastDay = firstDay.AddYears(2).AddTicks(-1); // THIS REMEMBER CHANGE BACK TO 2024

                orgId = (int)Session["currentOrgId"];
                profitAmount = getProfitFee(orgId, firstDay, lastDay);
                paymentAmount = getPaymentFee(orgId, firstDay, lastDay);
                transactionAmount = getTransactionFee(orgId, firstDay, lastDay);
                paymentMethodTransaction = getPaymentMethodTransaction(orgId, firstDay, lastDay);
                ltlBalanceAmount.Text = getPaymentFee(orgId, firstDay, lastDay).ToString("0.00");
                totalOrder = getTotalOrder(orgId, firstDay, lastDay);
                totalSales = getTotalSales(orgId, firstDay, lastDay);

                currentYearRevenue = getProfitFee(orgId, new DateTime(DateTime.Now.Year, 1, 1), new DateTime(DateTime.Now.Year+1, 1, 1).AddTicks(-1));
                previousYearRevenue = getProfitFee(orgId, new DateTime(DateTime.Now.Year-1, 1, 1), new DateTime(DateTime.Now.Year, 1, 1).AddTicks(-1));

                numOfCust = getCustomerNumber(orgId, firstDay, lastDay);
                numOfEvent = getEventNumber(orgId, firstDay, lastDay);
        }

        }

        float getProfitFee(int orgId, DateTime startDate, DateTime endDate)
        {
            float profit = 0f;

            SqlConnection con = new SqlConnection(cs);
            

            // insert payment method record
            string query = @"
                
            SELECT SUM(price) AS profit
            FROM event e
	            LEFT JOIN ticket t ON e.id = t.event_id
	            LEFT JOIN order_item oi ON t.id = oi.ticket_id
	            LEFT JOIN cust_order co ON co.id = oi.cust_order_id
            WHERE e.organization_id = @orgId
	            AND co.status = 1 
	            AND oi.status = 1
	            AND t.status = 1
	            AND e.status = 1
                AND (co.create_datetime BETWEEN @startDate AND @endDate)
             
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            try {
                profit = (float) Convert.ToDecimal(cmd.ExecuteScalar());
            }catch(Exception ex)
            {
                profit = 0f;
            }
                       
            con.Close();

            return profit;
        }

        float getPaymentFee(int orgId, DateTime startDate, DateTime endDate) 
        {
            float transaction = 0f;

            SqlConnection con = new SqlConnection(cs);
            

            // insert payment method record
            string query = @"
                
                SELECT SUM(payment_fee) AS total_payment_fee, SUM(price) AS total_profit
                FROM event e
	                LEFT JOIN ticket t ON e.id = t.event_id
	                LEFT JOIN order_item oi ON t.id = oi.ticket_id
	                LEFT JOIN cust_order co ON co.id = oi.cust_order_id
	                LEFT JOIN customer_payment cp ON cp.id = co.customer_payment_id
                WHERE e.organization_id = @orgId
	                AND co.status = 1
	                AND oi.status = 1
	                AND t.status = 1
	                AND e.status = 1             
                    AND (co.create_datetime BETWEEN @startDate AND @endDate)
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            try
            {
                while (dr.Read())
                {
                    transaction += (float)Convert.ToDecimal(dr["total_payment_fee"]);

                    transaction += (float)Convert.ToDecimal(dr["total_profit"]);
                }
            }
            catch (Exception ex)
            {
                transaction = 0f;
            }

            dr.Close();

            con.Close();

            return transaction;
        }


        float getTransactionFee(int orgId, DateTime startDate, DateTime endDate) {

            return getExpensesFee(orgId, startDate, endDate) + getPaymentFee(orgId, startDate, endDate);

        }


        float getExpensesFee(int orgId, DateTime startDate, DateTime endDate) 
        {
            float transaction = 0f;

            SqlConnection con = new SqlConnection(cs);


            // insert payment method record
            string query = @"
                
                SELECT SUM(payment_fee) AS total_payment_fee, SUM(price) AS total_profit
                FROM organization org
	                LEFT JOIN billing b ON org.id = b.organization_id
	                LEFT JOIN organization_payment op ON b.organization_payment_id = op.id	                
                WHERE org.id = @orgId
	                AND b.status = 1
                    AND (b.create_datetime BETWEEN @startDate AND @endDate)
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            try
            {
                while (dr.Read())
                {
                    transaction += (float)Convert.ToDecimal(dr["total_payment_fee"]);

                    transaction += (float)Convert.ToDecimal(dr["total_profit"]);
                }
            }
            catch (Exception ex)
            {
                transaction = 0f;
            }

            dr.Close();

            con.Close();

            return transaction;

        }



        Dictionary<String, float> getPaymentMethodTransaction(int orgId, DateTime startDate, DateTime endDate) 
        {
            Dictionary<String, float> trans = new Dictionary<String, float>();
            trans.Add("F", 0f);
            trans.Add("B", 0f);
            trans.Add("C", 0f);
            trans.Add("P", 0f);
            trans.Add("T", 0f);

            SqlConnection con = new SqlConnection(cs);
            

            // insert payment method record
            string query = @"
                
                SELECT payment_fee, price AS profit, payment_method
                FROM event e
	                LEFT JOIN ticket t ON e.id = t.event_id
	                LEFT JOIN order_item oi ON t.id = oi.ticket_id
	                LEFT JOIN cust_order co ON co.id = oi.cust_order_id
	                LEFT JOIN customer_payment cp ON cp.id = co.customer_payment_id
                WHERE e.organization_id = @orgId
	                AND co.status = 1
	                AND oi.status = 1
	                AND t.status = 1
	                AND e.status = 1     
                    AND (co.create_datetime BETWEEN @startDate AND @endDate)

            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());
            
            con.Open();
            
            SqlDataReader dr = cmd.ExecuteReader();

            try
            {
                while (dr.Read())
                {
                    float profit = (float)Convert.ToDecimal(dr["profit"]);
                    float paymentFee = (float)Convert.ToDecimal(dr["payment_fee"]);
                    string payMethod = (string)Convert.ToString(dr["payment_method"]);

                    if (payMethod == "F" || payMethod == "B" ||
                        payMethod == "C" || payMethod == "P" ||
                        payMethod == "T")
                    {
                        trans[payMethod] = trans[payMethod] + profit + paymentFee;
                    }
                }

            }
            catch (Exception ex)
            {

            }

            dr.Close();

            con.Close();

            return trans;
        }


        int getTotalOrder(int orgId, DateTime startDate, DateTime endDate)
        {
            int order = 0;

            SqlConnection con = new SqlConnection(cs);


            // insert payment method record
            string query = @"
                
            SELECT COUNT(DISTINCT co.id) AS total_order
            FROM event e
	            LEFT JOIN ticket t ON e.id = t.event_id
	            LEFT JOIN order_item oi ON t.id = oi.ticket_id
	            LEFT JOIN cust_order co ON co.id = oi.cust_order_id
            WHERE e.organization_id = @orgId
	            AND oi.status = 1
	            AND t.status = 1
	            AND e.status = 1
                AND (co.create_datetime BETWEEN @startDate AND @endDate)
             
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            try
            {
                order = (int)Convert.ToDecimal(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                order = 0;
            }

            con.Close();

            return order;
        }

        int getTotalSales(int orgId, DateTime startDate, DateTime endDate)
        {
            int sales = 0;

            SqlConnection con = new SqlConnection(cs);

            // insert payment method record
            string query = @"
                
            SELECT COUNT(DISTINCT co.id) AS total_sales
            FROM event e
	            LEFT JOIN ticket t ON e.id = t.event_id
	            LEFT JOIN order_item oi ON t.id = oi.ticket_id
	            LEFT JOIN cust_order co ON co.id = oi.cust_order_id
            WHERE e.organization_id = @orgID
	            AND co.status = 1 
	            AND oi.status = 1
	            AND t.status = 1
	            AND e.status = 1
                AND (co.create_datetime BETWEEN @startDate AND @endDate)
             
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            try
            {
                sales = (int)Convert.ToDecimal(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                sales = 0;
            }

            con.Close();

            return sales;
        }


        int getCustomerNumber(int orgId, DateTime startDate, DateTime endDate) 
        {
            int custNum = 0;

            SqlConnection con = new SqlConnection(cs);

            // insert payment method record
            string query = @"
                
            
            SELECT COUNT(DISTINCT c.id) AS total_customer
            FROM event e
	            JOIN ticket t ON e.id = t.event_id
	            JOIN order_item oi ON t.id = oi.ticket_id
	            JOIN cust_order co ON co.id = oi.cust_order_id
				JOIN customer c ON c.id = co.customer_id
            WHERE e.organization_id = @orgId
	            AND co.status = 1 
	            AND oi.status = 1
	            AND t.status = 1
	            AND e.status = 1
				AND c.status = 1			
                AND (co.create_datetime BETWEEN @startDate AND @endDate)
             
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            try
            {
                custNum = (int)Convert.ToDecimal(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                custNum = 0;
            }

            con.Close();

            return custNum;
        }

        int  getEventNumber(int orgId, DateTime startDate, DateTime endDate) 
        {
            int eventNum = 0;

            SqlConnection con = new SqlConnection(cs);

            // insert payment method record
            string query = @"

               SELECT COUNT(id) 
                FROM event 
                WHERE status = 1 
                    AND organization_id = @orgId
                    AND (create_datetime BETWEEN @startDate AND @endDate)

            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            cmd.Parameters.AddWithValue("@startDate", startDate.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDate.ToString());

            con.Open();

            try
            {
                eventNum = (int)Convert.ToDecimal(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                eventNum = 0;
            }

            con.Close();

            return eventNum;
        }

        protected void btnIncome_Click(object sender, EventArgs e)
        {
            ltlBalanceAmount.Text = getPaymentFee(orgId, firstDay, lastDay).ToString("0.00");
            btnIncome.CssClass = "nav-link active";
            btnExpenses.CssClass = "nav-link";
            btnProfit.CssClass = "nav-link";           
        }

        protected void btnExpenses_Click(object sender, EventArgs e)
        {
            ltlBalanceAmount.Text = getExpensesFee(orgId, firstDay, lastDay).ToString("0.00");
            btnIncome.CssClass = "nav-link";
            btnExpenses.CssClass = "nav-link active";
            btnProfit.CssClass = "nav-link";
        }

        protected void btnProfit_Click(object sender, EventArgs e)
        {
            ltlBalanceAmount.Text = getProfitFee(orgId, firstDay, lastDay).ToString("0.00");
            btnIncome.CssClass = "nav-link";
            btnExpenses.CssClass = "nav-link";
            btnProfit.CssClass = "nav-link active";
        }
    }
}