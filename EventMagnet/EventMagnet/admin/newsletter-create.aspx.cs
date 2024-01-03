using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using System.Data.SqlClient;
using EventMagnet.modal;

namespace EventMagnet.zDEl_admin
{
    public partial class newsletter_create : System.Web.UI.Page
    {
        //initialize the connection string
        string cs = Global.CS;

        string imageDestination = "~/admin/images/newsletter/";

        string webPageName = "";

        public string username = "";
        public string position = "";
        public string organizationName = "";

        public modal.admin currentUser = null;

        EventMagnetEntities db = new EventMagnetEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            webPageName = Path.GetFileName(Request.Path);

            //setting up the user 
            if (Session["admin"] != null)
            {
                modal.admin admin = (modal.admin)Session["admin"];
                currentUser = admin;
            }
            
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("newsletter-index.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("newsletter-create.aspx");
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            //initialize db to get the count of the record
            modal.EventMagnetEntities db = new modal.EventMagnetEntities();
            List<newsletter> dataList = db.newsletters.ToList();
            int recordCount = dataList.Count + 1;
            model.newsletter newNews = new model.newsletter();

            try
            {
                //get the user input
                string title = txtTitle.Text;
                string body = txtNewsContent.Text;
                int orgId = (int)Session["currentOrgId"];

                if (fuNewsImg.HasFile)
                {
                    string fileName = Path.GetFileName(fuNewsImg.FileName);

                    //check the image validation
                    if (cvNewsImg.IsValid)
                    {
                        fileName = Guid.NewGuid().ToString("N") + ".jpg";
                        newNews.title = txtTitle.Text;
                        newNews.body= txtNewsContent.Text;
                        newNews.img_src = fileName;
                        newNews.organization_id = orgId;

                        //set destination path for image
                        string destinationPath = Server.MapPath(imageDestination) + fileName;

                        //SaveFile to local path
                        SaveFile(fuNewsImg.PostedFile,destinationPath);

                        //Add record into database
                        //InsertRecordIntoDB(newNews);
                        if(InsertRecordIntoDB(newNews) == 1)
                        {
                            lblMessage.CssClass = "text-capitalize form-label-lg text-success";
                            lblMessage.Text = "Record Created Successfully !";
                        }
                        else
                        {
                            lblMessage.CssClass = "text-capitalize form-label-lg text-danger";
                            lblMessage.Text = "Record Failed To Create ! ";
                        }
                    }
                    else
                    {
                        cvNewsImg.ErrorMessage = "⚠️ Invalid Format !";
                    }
                    txtTitle.Text = "";
                    txtNewsContent.Text = "";
                    fuNewsImg = null;
                }
            }
            catch (HttpException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch (Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }
        }

        protected void cvNewsImg_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Check if the file extension is not ".png"
            string fileName = fuNewsImg.FileName;
            string fileExtension = Path.GetExtension(fileName)?.ToLower();

            if (fileExtension == ".jpg" || fileExtension == ".png")
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
                Response.Redirect("../error-page.aspx");
            }
        }

        public int InsertRecordIntoDB(model.newsletter newRecord)
        {
            int result = 0;
            try
            {
                model.newsletter newRecordInfo = newRecord;

                //sql insert statement
                string sql = "INSERT INTO newsletter (title, body, img_src, organization_id) VALUES (@title, @body, @img_src, @organization_id)";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                //add value into parameter
                cmd.Parameters.AddWithValue("@title", newRecord.title);
                cmd.Parameters.AddWithValue("@body", newRecord.body);
                cmd.Parameters.AddWithValue("@img_src", newRecord.img_src);
                cmd.Parameters.AddWithValue("@organization_id", newRecord.organization_id);

                //open connection
                conn.Open();

                int rowAffected = cmd.ExecuteNonQuery();

                //close connection
                if(rowAffected > 0)
                {
                    result = 1;
                }
                else
                {
                    result = 0;
                }

            }
            catch(SqlException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch (IOException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch (InvalidCastException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch (Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }

            return result;
        }

    }
}