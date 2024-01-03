using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using EventMagnet.modal;
using Stripe;

namespace EventMagnet.site
{
    public partial class editProfile : System.Web.UI.Page
    {
        string cs = Global.CS;
        string imageDestination = "~/site/images/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Retrieve customer object from session
                customer cust = (customer)Session["cust"];

                // Check if the customer object is not null
                if (cust != null)
                {
                    // Use the customer's name to fetch additional data from the database
                    int id = cust.id;

                    // Your database query to fetch additional data based on the name
                    string sql = "SELECT * FROM customer WHERE id = @id";

                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();

                    cmd.Parameters.AddWithValue("@id", id);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        ViewState["imgSource"] = imageDestination + Convert.ToString(dr["img_src"]);
                        ImgUpload.ImageUrl = ViewState["imgSource"].ToString();
                        Session["customerId"] = dr["id"];
                        txtId.Text = dr["id"].ToString();
                        txtName.Text = (string)dr["name"];
                        txtIc.Text = (string)dr["ic_no"];
                        txtEmail.Text = (string)dr["email"];
                        ddlGender.Text = (string)dr["gender"];
                        txtBirth.Text = ((DateTime)dr["birthdate"]).ToString("yyyy-MM-dd");
                        txtPhone.Text = (string)dr["phone"];
                        txtAddress.Text = (string)dr["address_one"];
                        txtAddress2.Text = (string)dr["address_two"];
                        txtCity.Text = (string)dr["city"];
                        txtPostCode.Text = (string)dr["postcode"];
                        txtState.Text = (string)dr["state"];
                        txtCountry.Text = (string)dr["country"];
                    }
                    con.Close();
                }
            }
        }

        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            
        }

        protected void resetBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("account-profile-update.aspx"); 
        }

        protected void savebtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Retrieve the birthdate from the database (it's already a DateTime)
                DateTime birthdate = Convert.ToDateTime(txtBirth.Text);

                string name = txtName.Text;
                string ic_no = txtIc.Text;
                string email = txtEmail.Text;
                string phone = txtPhone.Text;
                string gender = ddlGender.Text;
                string address_one = txtAddress.Text;
                string address_two = txtAddress2.Text;
                string city = txtCity.Text;
                string postcode = txtPostCode.Text;
                string state = txtState.Text;
                string country = txtCountry.Text;
                int customerId = (int)Session["customerId"];

                string sql = "UPDATE customer SET name = @name, email = @email, gender = @gender, birthdate = @birthdate, phone = @phone, ic_no = @ic_no, address_one = @address_one, address_two = @address_two, city = @city, postcode = @postcode, state = @state, country = @country WHERE id = @customerId";
                    
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@name", name);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@birthdate", birthdate);
                        cmd.Parameters.AddWithValue("@phone", phone);
                        cmd.Parameters.AddWithValue("@ic_no", ic_no);
                        cmd.Parameters.AddWithValue("@gender", gender);
                        cmd.Parameters.AddWithValue("@address_one", address_one);
                        cmd.Parameters.AddWithValue("@address_two", address_two);
                        cmd.Parameters.AddWithValue("@city", city);
                        cmd.Parameters.AddWithValue("@postcode", postcode);
                        cmd.Parameters.AddWithValue("@state", state);
                        cmd.Parameters.AddWithValue("@country", country);
                        cmd.Parameters.AddWithValue("@customerId", customerId);

                        cmd.ExecuteNonQuery();
                    }
                    con.Close();

                    customer cust = (customer)Session["cust"];
                    if (cust != null)
                    {
                        cust.name = name;
                        Session["cust"] = cust;
                    }

                    Response.Redirect("account-profile.aspx");
                }
            }
        }

        protected void CVIc_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string ic_no = args.Value;
            int customerId = (int)Session["customerId"];

            // Check if the ic_no is used by other users
            string sql = "SELECT COUNT(*) FROM Customer WHERE ic_no = @ic_no AND id <> @customerId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@ic_no", ic_no);
            cmd.Parameters.AddWithValue("@customerId", customerId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the email is used by other users
            args.IsValid = (count == 0);
        }

        protected void CVPhone_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string phone = args.Value;
            int customerId = (int)Session["customerId"];

            // Check if the phone is used by other users
            string sql = "SELECT COUNT(*) FROM Customer WHERE phone = @phone AND id <> @customerId";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@customerId", customerId);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the email is used by other users
            args.IsValid = (count == 0);
        }

        protected void CVEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;
            int customerId = (int)Session["customerId"];

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