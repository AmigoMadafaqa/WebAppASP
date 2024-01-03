using EventMagnet.controller;
using EventMagnet.modal;
using Stripe;
using Stripe.Climate;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;

namespace EventMagnet.admin
{
    public partial class organization_list : System.Web.UI.Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // DataBind to evaluate data binding expressions
                DataBind();
            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("organization-create.aspx");
        }

        protected void btn_edit_org_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            // Get the data item associated with the clicked row
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hfOrgID = (HiddenField)item.FindControl("hfOrgID");

            if (hfOrgID != null)
            {
                string orgId = hfOrgID.Value.ToString();
                // Redirect to the details page with the customer ID as a query parameter
                Response.Redirect($"organization-update.aspx?organizationId={orgId}");
            }
        }

        protected void viewButton1_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            // Get the data item associated with the clicked row
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hfOrgID = (HiddenField)item.FindControl("hfOrgID");

            if (hfOrgID != null)
            {
                string orgId = hfOrgID.Value.ToString();
                // Redirect to the details page with the customer ID as a query parameter
                Response.Redirect($"organization-view.aspx?organizationId={orgId}");
            }
        }

        protected void btn_delete_org_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            // Get the data item associated with the clicked row
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hfOrgID = (HiddenField)item.FindControl("hfOrgID");

            string sql = "UPDATE organization SET status = 0 WHERE id = @orgId";

            if (hfOrgID != null)
            {
                string orgId = hfOrgID.Value.ToString();
                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);

                con.Open();
                cmd.Parameters.AddWithValue("@orgId", orgId);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            Response.Redirect("organization-index.aspx");
        }

    }
}