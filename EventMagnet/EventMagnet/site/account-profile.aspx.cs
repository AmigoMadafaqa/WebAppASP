using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Stripe;
using EventMagnet.modal;


namespace EventMagnet.site
{
    public partial class customer_profile : System.Web.UI.Page
    {
        string cs = Global.CS;
        string imageDestination = "~/site/images/";

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("cust");
            Response.Redirect("account-login.aspx");
        }

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
                        txtName.Text = (string)dr["name"];
                        txtIc.Text = (string)dr["ic_no"];
                        txtEmail.Text = (string)dr["email"];
                        string gender = (string)dr["gender"];

                        if (gender == "M")
                        {
                            gender = "Male";
                        }
                        else
                        {
                            gender = "Female";
                        }
                        txtGender.Text = gender;
                        txtBirth.Text = dr["birthdate"].ToString();
                        txtPhone.Text = (string)dr["phone"];
                        txtAddress.Text = (string)dr["address_one"];
                        txtAddress2.Text = (string)dr["address_two"];
                        txtPostCode.Text = (string)dr["postcode"];
                        txtCity.Text = (string)dr["city"];
                        txtState.Text = (string)dr["state"];
                        txtCountry.Text = (string)dr["country"];
                    }
                    con.Close();
                }
            }
        }

        protected void btnEditDetail_Click1(object sender, EventArgs e)
        {
            Response.Redirect("account-profile-update.aspx");
        }
        
    }
}