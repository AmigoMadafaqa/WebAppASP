using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using model = EventMagnet.modal;

namespace EventMagnet.admin
{
    public partial class admin_register : System.Web.UI.Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CVEmailMatch(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            string sql = "SELECT COUNT(*) FROM admin WHERE email = @email";

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

        protected void CVPhone_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string phone = args.Value;

            string sql = "SELECT COUNT(*) FROM admin WHERE phone = @phone";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@phone", phone);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            if (count > 0)
            {
                args.IsValid = false;
            }
        }

        protected void CVIc_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string ic_no = args.Value;

            string sql = "SELECT COUNT(*) FROM admin WHERE ic_no = @ic_no";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@ic_no", ic_no);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            if (count > 0)
            {
                args.IsValid = false;
            }
        }

        

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string birthdatestring = txtBirth.Text;

                    if (DateTime.TryParse(birthdatestring, out DateTime birthdate))
                    {
                        string name = txtUsername.Text;
                        string email = txtEmail.Text;
                        string password = txtPass.Text;
                        string phone = txtPhone.Text;
                        string ic_no = txtIdentificationNumber.Text;
                        string gender = ddlGender.Text;
                        string address_one = txtAddressOne.Text;
                        string address_two = txtAddress2.Text;
                        string state = txtState.Text;
                        string city = txtCity.Text;
                        string postcode = txtPostcode.Text;
                        string country = txtCountry.Text;

                        string sql = "INSERT INTO admin (name, birthdate, password, phone, ic_no, email, gender, address_one, address_two, postcode, city, state, country, status, img_src) VALUES (@name, @birthdate, @password, @phone, @ic_no, @email, @gender, @address_one, @address_two, @postcode, @city, @state, @country, @status, @img_src)";

                        using (SqlConnection con = new SqlConnection(cs))
                        {
                            con.Open();

                            // Insert new member account
                            using (SqlCommand cmd = new SqlCommand(sql, con))
                            {
                                cmd.Parameters.AddWithValue("@name", name);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue("@password", BCrypt.Net.BCrypt.HashPassword(password, 13));
                                cmd.Parameters.AddWithValue("@birthdate", birthdate);
                                cmd.Parameters.AddWithValue("@phone", phone);
                                cmd.Parameters.AddWithValue("@ic_no", ic_no);
                                cmd.Parameters.AddWithValue("@gender", gender);
                                cmd.Parameters.AddWithValue("@address_one", address_one);
                                cmd.Parameters.AddWithValue("@address_two", address_two);
                                cmd.Parameters.AddWithValue("@postcode", postcode);
                                cmd.Parameters.AddWithValue("@city", city);
                                cmd.Parameters.AddWithValue("@state", state);
                                cmd.Parameters.AddWithValue("@country", country);
                                cmd.Parameters.AddWithValue("@status", 1);
                                cmd.Parameters.AddWithValue("@img_src", "1.png");

                                int newMemberId = Convert.ToInt32(cmd.ExecuteScalar());

                                EventMagnetEntities db = new EventMagnetEntities();
                                IEnumerable<model.admin> adminDB = db.admins;

                                // Retrieve the newly registered admin
                                model.admin newAdmin = db.admins.FirstOrDefault(a => a.email == email);

                                if (newAdmin != null)
                                {
                                    Session["admin"] = newAdmin;
                                }

                                Response.Redirect("admin-login.aspx");
                            }
                            con.Close();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("An error occurred: " + ex.Message);
                }
            }
        }

        protected void cbxCustomValidator(object source, ServerValidateEventArgs args)
        {
            args.IsValid = cbPrivacy.Checked;
        }
    }
}