using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EventMagnet.modal;

namespace EventMagnet.site
{
    public partial class create_customer : System.Web.UI.Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                customer cust = (customer)Session["cust"];

                if (cust != null)
                {
                    // Assuming that id, name, and email are of type int, string, and string respectively
                    txtId.Text = cust.id.ToString();
                    txtName.Text = cust.name;
                    txtEmail.Text = cust.email;
                }
            }
        }

        protected void resetBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("create-customer.aspx");
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string birthdatestring = txtbirthDate.Value;

                if (DateTime.TryParse(birthdatestring, out DateTime birthdate))
                {
                    string name = txtName.Text;
                    string email = txtEmail.Text;
                    string phone = txtPhone.Text;
                    string ic_no = txtIc.Text;
                    string address_one = txtAddress.Text;
                    string address_two = txtAddress2.Text;
                    string city = txtCity.Text;
                    string state = txtState.Text;
                    string postcode = txtPostCode.Text;
                    string country = txtCountry.Text;
                    string gender = ddlGender.Text;

                    string sql = "UPDATE Customer SET name = @name, email = @email, birthdate = @birthdate, phone = @phone, ic_no = @ic_no, address_one = @address_one, address_two = @address_two, city = @city, state = @state, postcode = @postcode, country = @country, gender = @gender WHERE name = @name";

                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand(sql, con))
                        {
                            cmd.Parameters.AddWithValue("@name", name);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@birthdate", birthdate);
                            cmd.Parameters.AddWithValue("@phone", phone);
                            cmd.Parameters.AddWithValue("@gender", gender);
                            cmd.Parameters.AddWithValue("@ic_no", ic_no);
                            cmd.Parameters.AddWithValue("@address_one", address_one);
                            cmd.Parameters.AddWithValue("@address_two", address_two);
                            cmd.Parameters.AddWithValue("@city", city);
                            cmd.Parameters.AddWithValue("@state", state);
                            cmd.Parameters.AddWithValue("@postcode", postcode);
                            cmd.Parameters.AddWithValue("@country", country);

                            cmd.ExecuteNonQuery();
                        }
                        con.Close();

                        Response.Redirect("index.aspx");
                    }
                }
            }
        }

        protected void CVIc_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string ic_no = args.Value;

            string sql = "SELECT COUNT(*) FROM Customer WHERE ic_no = @ic_no";

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

        protected void CVPhone_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string phone = args.Value;

            string sql = "SELECT COUNT(*) FROM Customer WHERE phone = @phone";

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

        protected void CVEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            customer cust = (customer)Session["cust"];
            int customerId = cust.id;

            // Check if the email is used by other users
            string sql = "SELECT COUNT(*) FROM Customer WHERE email = @email AND id <> @customerId";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@customerId", customerId);

                    int count = (int)cmd.ExecuteScalar();

                    // If count is greater than 0, it means the email is used by other users
                    args.IsValid = (count == 0);
                }

                con.Close();
            }
        }
    }
}