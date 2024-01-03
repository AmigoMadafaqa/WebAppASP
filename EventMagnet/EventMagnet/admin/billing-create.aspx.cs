using EventMagnet.modal;
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
    public partial class billing_create : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) { 
                setDefaultDate();
            }
        }

        void setDefaultDate() { 
            cldDate.SelectedDate = DateTime.Now;
            txtIssueDate.Text = cldDate.SelectedDate.ToString();
        }


        protected void saveBilling(object sender, EventArgs e)
        {
            
            decimal price = 0;
            int orgId = 0;
            try
            {
                price = Convert.ToDecimal(txtAmount.Text);
                orgId = int.Parse(ddlOrganization.SelectedValue);
            }
            catch (Exception)
            {
                price = 0;
                orgId = 0;
            }


            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = @"
                INSERT INTO organization_payment (payment_method, payment_fee) output INSERTED.ID VALUES ('Z', 0.0)";
            SqlCommand cmd = new SqlCommand(query, con);
            int paymentId = (int)cmd.ExecuteScalar();


            // insert billing record
            query = @"
                INSERT INTO billing (uuid,name,price,status,create_datetime,organization_id,organization_payment_id) VALUES (@uuid,@name,@price,@status,@create_datetime,@organization_id,@organization_payment_id) ";

            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", Guid.NewGuid().ToString());
            cmd.Parameters.AddWithValue("@name", txtTitle.Text);
            cmd.Parameters.AddWithValue("@price", price);
            cmd.Parameters.AddWithValue("@status", 2);
            cmd.Parameters.AddWithValue("@create_datetime", cldDate.SelectedDate.ToString());
            cmd.Parameters.AddWithValue("@organization_id", orgId);
            cmd.Parameters.AddWithValue("@organization_payment_id", paymentId);

            cmd.ExecuteNonQuery();

            con.Close();

            Response.Redirect("billing.aspx");
        }

        protected void cancelButton(object sender, EventArgs e)
        {
            Response.Redirect("billing.aspx");

        }
        protected void onChangeDate(object sender, EventArgs e)
        {
            txtIssueDate.Text = cldDate.SelectedDate.ToString();
        }
    }
}