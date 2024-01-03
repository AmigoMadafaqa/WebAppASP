using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace EventMagnet.admin
{
    public partial class create_organization : System.Web.UI.Page
    {
        string cs = Global.CS;
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void resetBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("organization-create.aspx");
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            string imageDestination = "~/admin/images/avatars/";

            if (Page.IsValid)
            {
                if (img.HasFile)
                {
                    string fileName = Path.GetFileName(img.FileName);
                    if (CVImg.IsValid)
                    {
                        fileName = Guid.NewGuid().ToString("N").ToString() + ".jpg";
                        string destinationPath = Server.MapPath(imageDestination) + fileName;
                        string name = txtName.Text;
                        string descp = txtDesc.Text;
                        string website_link = txtWeb.Text;
                        string email = txtEmail.Text;
                        string phone = txtPhone.Text;
                        string address_one = txtAddress.Text;
                        string address_two = txtAddress2.Text;
                        string city = txtCity.Text;
                        string state = txtState.Text;
                        string postcode = txtPostcode.Text;
                        string country = txtCountry.Text;
                        int organization_id = 0;

                        string sql = "INSERT INTO organization (name, descp, website_link, email, phone, address_one, address_two, city, state, postcode, country, status, img_src) output INSERTED.ID VALUES (@name, @descp, @website_link, @email, @phone, @address_one, @address_two, @city, @state, @postcode, @country, @status, @img_src);";

                        using (SqlConnection con = new SqlConnection(cs))
                        {
                            con.Open();
                            using (SqlCommand cmd = new SqlCommand(sql, con))
                            {
                                cmd.Parameters.AddWithValue("@name", name);
                                cmd.Parameters.AddWithValue("@descp", descp);
                                cmd.Parameters.AddWithValue("@website_link", website_link);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue("@phone", phone);
                                cmd.Parameters.AddWithValue("@address_two", address_two);
                                cmd.Parameters.AddWithValue("@address_one", address_one);
                                cmd.Parameters.AddWithValue("@city", city);
                                cmd.Parameters.AddWithValue("@state", state);
                                cmd.Parameters.AddWithValue("@postcode", postcode);
                                cmd.Parameters.AddWithValue("@country", country);
                                cmd.Parameters.AddWithValue("@status", 1);
                                cmd.Parameters.AddWithValue("@img_src", Path.GetFileName(img.FileName));

                                try
                                {
                                    organization_id = Convert.ToInt32(cmd.ExecuteScalar());
                                }
                                catch (Exception ex)
                                {
                                    organization_id = 0;
                                }
                            }

                            sql = @"               
                                insert into organization_admin 
                                (is_owner, create_datetime, status, admin_id, organization_id) values 
                                (@is_owner, @create_datetime, @status, @admin_id, @organization_id)            
                                ";

                            using (SqlCommand cmd = new SqlCommand(sql, con))
                            {
                                cmd.Parameters.AddWithValue("@is_owner", 1);
                                cmd.Parameters.AddWithValue("@create_datetime", DateTime.Now.ToString());
                                cmd.Parameters.AddWithValue("@status", 1);
                                cmd.Parameters.AddWithValue("@admin_id", ((modal.admin)Session["admin"]).id);
                                cmd.Parameters.AddWithValue("organization_id", organization_id);

                                cmd.ExecuteNonQuery();
                            }
                            con.Close();

                            SaveFile(img.PostedFile, destinationPath);
                            img = null;

                            Response.Redirect("organization-index.aspx");
                        }
                    }
                    else
                    {
                        //return message for the customValidator
                        CVImg.ErrorMessage = "⚠️ Invalid Format !";
                    }
                }
            }
        }

        public void SaveFile(HttpPostedFile file, string destinationPath)
        {
            try
            {
                string directory = Path.GetDirectoryName(destinationPath);
                if (!Directory.Exists(directory))
                {
                    Directory.CreateDirectory(directory);
                }
                file.SaveAs(destinationPath);

            }
            catch (Exception ex)
            {
                Response.Write("Error Uploading File ... " + ex.Message);
            }
        }

        protected void btnIndex_Click(object sender, EventArgs e)
        {
            Response.Redirect("organization-index.aspx");
        }

        protected void CVEmail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string email = args.Value;

            string sql = "SELECT COUNT(*) FROM organization WHERE email = @email";

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

            string sql = "SELECT COUNT(*) FROM organization WHERE phone = @phone";

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

        protected void cvImg_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Check if the file extension is not ".png"
            string fileName = img.FileName;
            string fileExtension = Path.GetExtension(fileName)?.ToLower();

            if (fileExtension == ".jpg")
            {
                // The file extension is correct, set IsValid to true
                args.IsValid = true;
            }
            else
            {
                // The file extension is not ".png", set IsValid to false
                args.IsValid = false;
            }
        }
    }
}