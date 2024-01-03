using EventMagnet.modal;
using Stripe;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using model = EventMagnet.modal;

namespace EventMagnet.admin
{
    public partial class customer_update : System.Web.UI.Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string customerId = Request.QueryString["customerId"] ?? "";

                if (!string.IsNullOrEmpty(customerId))
                {
                    //retrieve customer info based on id
                    string sql = "SELECT * FROM customer WHERE id = @customerId";

                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();

                    cmd.Parameters.AddWithValue("@customerId", customerId);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        txtBirth.Text = ((DateTime)dr["birthdate"]).ToString("yyyy-MM-dd");
                        txtId.Text = dr["id"].ToString();
                        txtCustomerName.Text = (string)dr["name"];
                        ddlGender.Text = (string)dr["gender"];
                        IC.Text = (string)dr["ic_no"];
                        txtEmail.Text = (string)dr["email"];
                        txtPhone.Text = (string)dr["phone"];
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

        protected void btnSaveChangesCust_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Retrieve the birthdate from the database (it's already a DateTime)
                DateTime birthdate = Convert.ToDateTime(txtBirth.Text);

                string id = txtId.Text;
                string name = txtCustomerName.Text;
                string gender = ddlGender.Text;
                string ic_no = IC.Text;
                string email = txtEmail.Text;
                string phone = txtPhone.Text;
                string address_one = txtAddressOne.Text;
                string address_two = txtAddressTwo.Text;
                string postcode = txtPostcode.Text;
                string city = txtCity.Text;
                string state = txtState.Text;
                string country = txtCountry.Text;

                string sql = "UPDATE Customer SET name = @name, email = @email, birthdate = @birthdate, gender = @gender, phone = @phone, ic_no = @ic_no, address_one = @address_one, address_two = @address_two, postcode = @postcode, city = @city, state = @state, country = @country WHERE id = @customerId";

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@customerId", id);
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@gender", gender);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@birthdate", birthdate);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@ic_no", ic_no);
                        cmd.Parameters.AddWithValue("@address_one", address_one);
                        cmd.Parameters.AddWithValue("@address_two", address_two);
                        cmd.Parameters.AddWithValue("@postcode", postcode);
                        cmd.Parameters.AddWithValue("@city", city);
                        cmd.Parameters.AddWithValue("@state", state);
                        cmd.Parameters.AddWithValue("@country", country);

                        cmd.ExecuteNonQuery();
                    }
                    con.Close();

                    Response.Redirect("customer-list.aspx");
                }
            }
        }

        protected void btnResetCust_Click(object sender, EventArgs e)
        {
            Response.Redirect("customer-list.aspx");
        }

        protected void CVIc_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string ic_no = args.Value;
            string customerId = Request.QueryString["customerId"] ?? "";

            // Check if the ic_no is used by other users
            string sql = "SELECT COUNT(*) FROM Customer WHERE ic_no = @ic_no AND id <> @customerId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@ic_no", ic_no);
            cmd.Parameters.AddWithValue("@customerId", customerId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the ic number is used by other users
            args.IsValid = (count == 0);
        }

        protected void CVPhone_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string phone = args.Value;
            string customerId = Request.QueryString["customerId"] ?? "";

            // Check if the phone is used by other users
            string sql = "SELECT COUNT(*) FROM Customer WHERE phone = @phone AND id <> @customerId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@customerId", customerId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the phone is used by other users
            args.IsValid = (count == 0);
        }

        protected void CVEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;
            string customerId = Request.QueryString["customerId"] ?? "";

            // Check if the email is used by other users
            string sql = "SELECT COUNT(*) FROM Customer WHERE email = @email AND id <> @customerId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@customerId", customerId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the email is used by other users
            args.IsValid = (count == 0);
        }
    }
}