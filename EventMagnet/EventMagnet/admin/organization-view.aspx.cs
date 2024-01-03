using EventMagnet.modal;
using Stripe.Terminal;
using System;
using System.Collections.Generic;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using System.Data.SqlClient;

namespace EventMagnet.admin
{
    public partial class organization_view : System.Web.UI.Page
    {
        string cs = Global.CS;
        string imageDestination = "~/admin/images/avatars/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string organizationId = Request.QueryString["organizationId"] ?? "";

                if (!string.IsNullOrEmpty(organizationId))
                {
                    //retrieve customer info based on id
                    string sql = "SELECT * FROM organization WHERE id = @organizationId";

                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();

                    cmd.Parameters.AddWithValue("@organizationId", organizationId);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        ViewState["imgSource"] = imageDestination + Convert.ToString(dr["img_src"]);
                        ImgUpload.ImageUrl = ViewState["imgSource"].ToString();
                        txtOrganizationId.Text = dr["id"].ToString();
                        txtOrganizationName.Text = (string)dr["name"];
                        txtDescription.Text = (string)dr["descp"];
                        txtEmail.Text = (string)dr["email"];
                        txtPhone.Text = (string)dr["phone"];
                        txtWebsiteLink.Text = (string)dr["website_link"];
                        txtAddressOne.Text = (string)dr["address_one"];
                        txtAddressTwo.Text = (string)dr["address_two"];
                        txtPostcode.Text = (string)dr["postcode"];
                        txtCity.Text = (string)dr["city"];
                        txtState.Text = (string)dr["state"];
                        txtCountry.Text = (string)dr["country"];
                    }

                    con.Close();
                }
                else
                {
                    // customerId is not provided in the query string, handle accordingly
                }
            }
        }

        protected void btnBackOrg_Click(object sender, EventArgs e)
        {
            Response.Redirect("organization-index.aspx");
        }
    }
}