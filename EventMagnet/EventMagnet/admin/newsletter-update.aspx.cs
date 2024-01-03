using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using System.Data.SqlClient;
//using Stripe;
using System.IO;
using System.Web.Caching;
using Microsoft.SqlServer.Server;
using EventMagnet.controller;
using static EventMagnet.zDEl_admin.event_venue_index;
using System.Data;

namespace EventMagnet.zDEl_admin
{
    public partial class newsletter_update : System.Web.UI.Page
    {
        string cs = Global.CS;
        
        HttpPostedFile newFileUpload = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            model.newsletter newsRecord = new model.newsletter();
            string imageFolder = "~/admin/images/newsletter/";
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["NewsletterID"] != null)
                {
                    string newsId = Request.QueryString["NewsletterID"].ToString();
                    try
                    {
                        model.newsletter currentRecord = GetRecordById(int.Parse(newsId));

                        //set the text for the label
                        lblNewsID.Text = currentRecord.id.ToString();
                        lblCreateDT.Text = currentRecord.create_datetime.ToString();
                        lblOrgId.Text = currentRecord.organization_id.ToString();
                        //set the text for the textbox
                        txtNewsTitle.Text = currentRecord.title;
                        txtNewsContent.Text = currentRecord.body;
                        //set the image url for image
                        ViewState["imgSource"]= imageFolder + currentRecord.img_src;

                        //if got upload image
                        if (fileUpload.HasFile)
                        {
                            model.newsletter tempRecord = GetRecordById(int.Parse(newsId));
                            //set session
                            Session["newUploadFile"] = fileUpload.PostedFile;
                            newFileUpload = fileUpload.PostedFile;

                            //store old imgsrc
                            string temp_fileName = tempRecord.img_src;

                            //map virtual paths to physical path
                            string destinationPath = Server.MapPath(imageFolder) + temp_fileName;

                            //delete old file
                            File.Delete(destinationPath);

                            string fileName = Guid.NewGuid().ToString("N") + ".jpg";
                            ImageHandler img = new ImageHandler(fileUpload.FileContent);

                            //resize img
                            img.ResizeToRectangle(400, 350);

                            string destinationPath_save = Server.MapPath(imageFolder) + fileName;

                            img.SaveAs(destinationPath_save);
                        }
                    }
                    catch (Exception ex)
                    { 
                        Response.Redirect("../error-page.aspx");
                    }
                }
            }
        }

        protected void btnUpd_Click(object sender, EventArgs e)
        {
            //initialize one model.newsletter to store the field changed
            model.newsletter updNews = new model.newsletter();
            string imageFolder = "~/admin/images/newsletter/";
            if (Request.QueryString["NewsletterId"] != null)
            {
                int newsId = int.Parse(Request.QueryString["NewsletterId"]);

                model.newsletter currentRecord = GetRecordById(newsId);

                //get from global
                HttpPostedFile news_fileUpload = newFileUpload;
                HttpPostedFile session_fileUpload = (HttpPostedFile)Session["newUploadFile"];
                Session.Remove("newUploadFile");

                try
                {
                    string fileName = "";
                    //imageFolder from global
                    if (news_fileUpload != null || session_fileUpload != null)
                    {
                        if (Session["filename"] != null)
                        {
                            fileName = Session["filename"].ToString();
                        }
                        string destinationPath = Server.MapPath(imageFolder) + fileName;
                        
                    }
                    else
                    {
                        fileName = currentRecord.img_src;
                    }

                    //get input from text
                    string title = txtNewsTitle.Text;
                    string body = txtNewsContent.Text;
                    string id = lblNewsID.Text;
                    string status = lblStatus.Text;

                    if (status == "Active")
                    {
                        updNews.status = Byte.Parse("1");
                    }
                    else
                    {
                        updNews.status = Byte.Parse("0");
                    }

                    //assign record into updRecord
                    updNews.id = currentRecord.id;
                    updNews.title = title;
                    updNews.body = body;
                    updNews.img_src = fileName;
                    string destinationPath_save = Server.MapPath(imageFolder) + fileName;

                    SaveFile(fileUpload.PostedFile, destinationPath_save);

                    if (UpdNewsRecord(updNews) == 1)
                    {
                        
                        lblComment.CssClass = "text-success";
                        lblComment.Text = "Record Updated Successfully !";
                    }
                    else
                    {
                        lblComment.CssClass = "text-danger";
                        lblComment.Text = "Record Updated Failed ! ";
                    }
                }
                catch (InvalidCastException ex)
                {
                    Response.Redirect("../error-page.aspx");
                }
                catch (Exception ex)
                {
                    Response.Redirect("../error-page.aspx");
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
                //file.SaveAs(destinationPath);

            }
            catch (Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }
        }

        public int UpdNewsRecord(model.newsletter updNews)
        {
            int result = 0;
            model.newsletter updDetails = updNews;

            try
            {
                string updSql = "UPDATE newsletter SET title = @title, body = @body, create_datetime = @create_datetime, status = @status, img_src = @img_src WHERE id=@id";

                //prepare sql connection
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(updSql, conn);

                //add value into parameter
                cmd.Parameters.AddWithValue("@title", updNews.title);
                cmd.Parameters.AddWithValue("@body", updNews.body);
                cmd.Parameters.AddWithValue("@create_datetime", DateTime.Now);
                cmd.Parameters.AddWithValue("@status", updNews.status);
                cmd.Parameters.AddWithValue("@img_src", updNews.img_src);
                cmd.Parameters.AddWithValue("@id", updNews.id);
                

                //open connection
                conn.Open();

                int rowAffected = cmd.ExecuteNonQuery();
                conn.Close();

                if (rowAffected > 0)
                {
                    result = 1;
                }
            }
            catch (InvalidCastException ex) {
                Response.Redirect("../error-page.aspx");
            }
            catch (SqlException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch (System.IO.IOException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch (Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            return result;
        }

        protected void btnActivate_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if(lblStatus.Text == "Inactive")
                {
                    lblStatus.CssClass = "text-success form-label-lg text-capitalize form-control";
                    lblStatus.Text = "Active";
                    btnActivate.Visible = false;
                }
            }
        }

        //global imageFolder
        public model.newsletter GetRecordById(int id)
        {
            model.newsletter newsRecord = new model.newsletter();
            string imageFolder = "~/admin/images/newsletter/";
            try
            {
                string sql = "SELECT * FROM newsletter WHERE id=@newsId";

                //prepare sqlConnection
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                //open connection
                conn.Open();

                //add value to the parameter
                cmd.Parameters.AddWithValue("@newsId", id);

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    newsRecord.id = Convert.ToInt32(reader["id"]);
                    newsRecord.title = Convert.ToString(reader["title"]);
                    newsRecord.body = Convert.ToString(reader["body"]);
                    newsRecord.img_src = Convert.ToString(reader["img_src"]);
                    newsRecord.status = Convert.ToByte(reader["status"]);
                    newsRecord.create_datetime = Convert.ToDateTime(reader["create_datetime"]);
                    newsRecord.organization_id = Convert.ToInt32(reader["organization_id"]);
                }
                conn.Close();

                if (newsRecord.status == 1)
                {
                    lblStatus.CssClass = "text-success form-label-lg form-control text-capitalize";
                    lblStatus.Text = "Active";

                    btnActivate.Visible = false;
                }
                else
                {
                    lblStatus.CssClass = "text-danger form-label-lg form-control text-capitalize";
                    lblStatus.Text = "Inactive";

                    btnActivate.Visible = true;
                }

                if (fileUpload.HasFile)
                {
                    Session["newUploadFile"] = fileUpload.PostedFile;
                    newFileUpload = fileUpload.PostedFile;
            
                    //map the path with the old record
                    string destinationPath = Server.MapPath(imageFolder) + newsRecord.img_src;
            
                    //dlt the old file
                    File.Delete(destinationPath);
            
                    string fileName = Guid.NewGuid().ToString("N") + ".jpg";
                    Session["filename"] = fileName;
                    ImageHandler img = new ImageHandler(fileUpload.FileContent);
            
                    string newDestinationPath = Server.MapPath(imageFolder) + fileName;
                    //resize the image
                    img.ResizeToRectangle(400, 350);
            
                    img.SaveAs(newDestinationPath);
                }
            }
            catch(Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            return newsRecord;
        }
    }
}