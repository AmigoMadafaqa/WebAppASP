using Stripe;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace EventMagnet.admin
{
    public partial class customer_view : System.Web.UI.Page
    {
        string cs = Global.CS;
        string imageDestination = "~/site/images/";

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
                        ViewState["imgSource"] = imageDestination + Convert.ToString(dr["img_src"]);
                        ImgUpload.ImageUrl = ViewState["imgSource"].ToString();
                        txtCustomerId.Text = dr["id"].ToString();
                        txtCustName.Text = (string)dr["name"];
                        txtIC.Text = (string)dr["ic_no"];
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
                        txtEmail.Text = (string)dr["email"];
                        txtBirth.Text = dr["birthdate"].ToString();
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

        protected void btnBackCust_Click(object sender, EventArgs e)
        {
            Server.Transfer("customer-list.aspx");
        }
    }
}