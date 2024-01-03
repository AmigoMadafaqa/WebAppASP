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
    public partial class edit_admin_profile : System.Web.UI.Page
    {
        string cs = Global.CS;
        string imageDestination = "~/admin/images/avatars/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                model.admin admin = (model.admin)Session["admin"];
                if (admin != null)
                {
                    // Your database query to fetch additional data based on the id
                    string sql = "SELECT * FROM admin WHERE id = @id";

                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();

                    cmd.Parameters.AddWithValue("@id", admin.id);
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        ViewState["imgSource"] = imageDestination + Convert.ToString(dr["img_src"]);
                        ImgUpload.ImageUrl = ViewState["imgSource"].ToString();
                        txtUserName.Text = (string)dr["name"];
                        txtEmail.Text = (string)dr["email"];
                        ddlGender.Text = (string)dr["gender"];
                        txtIdentificationNumber.Text = (string)dr["ic_no"];
                        txtBirth.Text = ((DateTime)dr["birthdate"]).ToString("yyyy-MM-dd");
                        txtPhone.Text = (string)dr["phone"];
                        txtAddressOne.Text = (string)dr["address_one"];
                        txtAddressTwo.Text = (string)dr["address_two"];
                        txtCity.Text = (string)dr["city"];
                        txtPostcode.Text = (string)dr["postcode"];
                        txtState.Text = (string)dr["state"];
                        txtCountry.Text = (string)dr["country"];
                    }
                    con.Close();
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string birthdatestring = txtBirth.Text;

                if (DateTime.TryParse(birthdatestring, out DateTime birthdate))
                {
                    string name = txtUserName.Text;
                    string email = txtEmail.Text;
                    string phone = txtPhone.Text;
                    string ic_no = txtIdentificationNumber.Text;
                    string gender = ddlGender.Text;
                    string address_one = txtAddressOne.Text;
                    string address_two = txtAddressTwo.Text;
                    string state = txtState.Text;
                    string city = txtCity.Text;
                    string postcode = txtPostcode.Text;
                    string country = txtCountry.Text;

                    string sql = "UPDATE admin SET name = @name, email = @email, birthdate = @birthdate, city = @city, address_two = @address_two, gender = @gender, phone = @phone, ic_no = @ic_no, address_one = @address_one, state = @state, postcode = @postcode, country = @country WHERE id = @id";

                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand(sql, con))
                        {
                            cmd.Parameters.AddWithValue("@id", ((model.admin)Session["admin"]).id);
                            cmd.Parameters.AddWithValue("@name", name);
                            cmd.Parameters.AddWithValue("@email", email);
                            cmd.Parameters.AddWithValue("@birthdate", birthdate);
                            cmd.Parameters.AddWithValue("@phone", phone);
                            cmd.Parameters.AddWithValue("@gender", gender);
                            cmd.Parameters.AddWithValue("@ic_no", ic_no);
                            cmd.Parameters.AddWithValue("@city", city);
                            cmd.Parameters.AddWithValue("@address_one", address_one);
                            cmd.Parameters.AddWithValue("@address_two", address_two);
                            cmd.Parameters.AddWithValue("@state", state);
                            cmd.Parameters.AddWithValue("@postcode", postcode);
                            cmd.Parameters.AddWithValue("@country", country);

                            cmd.ExecuteNonQuery();
                        }
                        con.Close();

                        if (Session["admin"] != null)
                        {
                            ((model.admin)Session["admin"]).name = name;
                        }

                        Response.Redirect("edit-admin-profile.aspx");
                    }
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void CVIc_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string ic_no = args.Value;

            // Check if the ic_no is used by other users
            string sql = "SELECT COUNT(*) FROM admin WHERE ic_no = @ic_no AND id <> @id";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@ic_no", ic_no);
            cmd.Parameters.AddWithValue("@id", ((model.admin)Session["admin"]).id);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the ic number is used by other users
            args.IsValid = (count == 0);
        }

        protected void CVPhone_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string phone = args.Value;

            // Check if the phone is used by other users
            string sql = "SELECT COUNT(*) FROM admin WHERE phone = @phone AND id <> @id";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@id", ((model.admin)Session["admin"]).id);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the phone is used by other users
            args.IsValid = (count == 0);
        }

        protected void CVEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            // Check if the email is used by other users
            string sql = "SELECT COUNT(*) FROM admin WHERE email = @email AND id <> @id";

            SqlConnection con = new SqlConnection(cs);

            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@id", ((model.admin)Session["admin"]).id);

            con.Open();

            int count = (int)cmd.ExecuteScalar();

            con.Close();

            // If count is greater than 0, it means the email is used by other users
            args.IsValid = (count == 0);
        }
    }
}