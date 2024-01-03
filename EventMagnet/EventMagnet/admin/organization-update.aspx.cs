using EventMagnet.modal;
using Stripe;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using model = EventMagnet.modal;

namespace EventMagnet.admin
{
    public partial class organization_update : System.Web.UI.Page
    {
        string cs = Global.CS;

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
                        txtOrganizationId.Text = dr["id"].ToString();
                        txtOrganizationName.Text = (string)dr["name"];
                        orgDescription.Text = (string)dr["descp"];
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

        protected void btnSaveChangesOrg_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string id = txtOrganizationId.Text;
                string name = txtOrganizationName.Text;
                string descp = orgDescription.Text;
                string email = txtEmail.Text;
                string phone = txtPhone.Text;
                string website_link = txtWebsiteLink.Text;
                string address_one = txtAddressOne.Text;
                string address_two = txtAddressTwo.Text;
                string postcode = txtPostcode.Text;
                string city = txtCity.Text;
                string state = txtState.Text;
                string country = txtCountry.Text;

                string sql = "UPDATE organization SET name = @name, email = @email, descp = @descp, phone = @phone, website_link = @website_link, address_one = @address_one, address_two = @address_two, postcode = @postcode, city = @city, state = @state, country = @country WHERE id = @organizationId";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@organizationId", id);
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@descp", descp);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@website_link", website_link);
                        cmd.Parameters.AddWithValue("@address_one", address_one);
                        cmd.Parameters.AddWithValue("@address_two", address_two);
                        cmd.Parameters.AddWithValue("@postcode", postcode);
                        cmd.Parameters.AddWithValue("@city", city);
                        cmd.Parameters.AddWithValue("@state", state);
                        cmd.Parameters.AddWithValue("@country", country);

                        cmd.ExecuteNonQuery();
                    }
                    con.Close();

                    Response.Redirect("organization-index.aspx");
                }
            }
        }


        protected void btnResetOrg_Click(object sender, EventArgs e)
        {
            Response.Redirect("organization-index.aspx");
        }

        protected void CVPhone_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string phone = args.Value;
            string organizationId = Request.QueryString["organizationId"] ?? "";

            // Check if the phone is used by other organizations
            string sql = "SELECT COUNT(*) FROM organization WHERE phone = @phone AND id <> @organizationId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@organizationId", organizationId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the phone is used by other organizations
            args.IsValid = (count == 0);
        }

        protected void CVEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;
            string organizationId = Request.QueryString["organizationId"] ?? "";

            // Check if the email is used by other organizations
            string sql = "SELECT COUNT(*) FROM organization WHERE email = @email AND id <> @organizationId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@organizationId", organizationId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the email is used by other organizations
            args.IsValid = (count == 0);
        }
    }
}