using BCrypt.Net;
using EventMagnet.controller;
using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace EventMagnet.admin
{
    public partial class customer_list : System.Web.UI.Page
    {
        custDA customer_DA = new custDA();
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // DataBind to evaluate data binding expressions
                DataBind();
            }
        }

        
        protected void viewBtn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            // Get the data item associated with the clicked row
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hfCustID = (HiddenField)item.FindControl("hfCustID");

            if (hfCustID != null)
            {
                string customerId = hfCustID.Value.ToString();
                // Redirect to the details page with the customer ID as a query parameter
                Response.Redirect($"~/admin/customer-view.aspx?customerId={customerId}");
            }
        }
        
        protected void btn_edit_cust_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            // Get the data item associated with the clicked row
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hfCustID = (HiddenField)item.FindControl("hfCustID");

            if (hfCustID != null)
            {
                string customerId = hfCustID.Value.ToString();
                // Redirect to the details page with the customer ID as a query parameter
                Response.Redirect($"~/admin/customer-update.aspx?customerId={customerId}");
            }
        }

        protected void btn_delete_cust_Click(object sender, EventArgs e)
        {
            string sql = "UPDATE Customer SET status = 0 WHERE id = @customerId";

            Button btn = (Button)sender;
            // Get the data item associated with the clicked row
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hfCustID = (HiddenField)item.FindControl("hfCustID");

            if (hfCustID != null)
            {
                string customerId = hfCustID.Value.ToString();

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@customerId", customerId);
                        cmd.ExecuteNonQuery();
                    }
                    con.Close();

                    // Redirect to the organization list page after deletion
                    Response.Redirect("customer-list.aspx");
                }
            }
        }
    }
}