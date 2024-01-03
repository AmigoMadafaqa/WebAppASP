using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Xml.Linq;
using EventMagnet.modal;

namespace EventMagnet.site
{
    public partial class register : System.Web.UI.Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            string sql = "SELECT COUNT(*) FROM Customer WHERE email = @email";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", email);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            if (count > 0)
            {
                args.IsValid = false;
            }


        }

        protected void regBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string name = txtUsername.Text;
                string password = txtPass.Text;
                string email = txtEmail.Text;

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Insert new member account
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Customer (name, birthdate, phone, ic_no, email, gender, address_one, address_two, postcode, city, state, country, password, status, img_src) VALUES (@name, @birthdate, @phone, @ic_no,  @email, @gender, @address_one, @address_two, @postcode, @city, @state, @country, @password, @status, @img_src)", con))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@password", BCrypt.Net.BCrypt.HashPassword(password, 13));
                        cmd.Parameters.AddWithValue("@birthdate", "");
                        cmd.Parameters.AddWithValue("@phone", "");
                        cmd.Parameters.AddWithValue("@ic_no", "");
                        cmd.Parameters.AddWithValue("@gender", "");
                        cmd.Parameters.AddWithValue("@address_one", "");
                        cmd.Parameters.AddWithValue("@address_two", "");
                        cmd.Parameters.AddWithValue("@postcode", "");
                        cmd.Parameters.AddWithValue("@city", "");
                        cmd.Parameters.AddWithValue("@state", "");
                        cmd.Parameters.AddWithValue("@country", "");
                        cmd.Parameters.AddWithValue("@status", 1);
                        cmd.Parameters.AddWithValue("@img_src", "like-01.jpg");

                        int newMemberId = Convert.ToInt32(cmd.ExecuteScalar());

                        EventMagnetEntities db = new EventMagnetEntities();
                        IEnumerable<customer> custDB = db.customers;
                        
                        customer newCustomer = db.customers.FirstOrDefault(c => c.email == email);
                        if (newCustomer != null)
                        {
                            // Set the newly registered customer in the session
                            Session["cust"] = newCustomer;
                        }

                        Response.Redirect($"account-profile-confirm.aspx?name={Uri.EscapeDataString(name)}");
                    }

                    con.Close();
                }
            }
        }

        protected void cbPrivacy_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbPrivacy.Checked;
        }

        protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (captchaCode.Text.ToLower() == Session["sessionCaptcha"].ToString())
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
    }
}