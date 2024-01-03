using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.site
{
    public partial class site : System.Web.UI.MasterPage
    {

        string webPageName = "";

        public string username = "";

        string cs = Global.CS;
        string imageDestination = "~/site/images/";

        protected void Page_Load(object sender, EventArgs e)
        {
            webPageName = Path.GetFileName(Request.Path);
            
            // Access Control List
            if (Session["cust"] == null)
            {
                if (
                    // non-customer access control list
                    // it lists the page that non-customer cannot access
                    webPageName == "account-profile-confirm.aspx" ||
                    webPageName == "account-profile-update.aspx" ||
                    webPageName == "account-profile.aspx" ||
                    webPageName == "checkout.aspx" ||
                    webPageName == "payment.aspx" ||
                    webPageName.Contains("payment-") ||
                    webPageName == "ticket-history.aspx"
                    )
                {
                    Response.Redirect("account-login.aspx");
                }
            }

            
            // set username
            lblUsername.Text = "";

            if (Session["cust"] != null)
            {
                customer cust = (customer)Session["cust"];
                lblUsername.Text = cust.name;

                string sql = "SELECT * FROM customer WHERE id = @id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();

                cmd.Parameters.AddWithValue("@id", cust.id);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    ViewState["imgSource"] = imageDestination + Convert.ToString(dr["img_src"]);
                    ImgUpload.ImageUrl = ViewState["imgSource"].ToString();
                    ImgUpload.AlternateText = Convert.ToString(dr["img_src"]);
                }
                con.Close();
            }

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("account-login.aspx");
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("account-register.aspx");
        }
    }
}