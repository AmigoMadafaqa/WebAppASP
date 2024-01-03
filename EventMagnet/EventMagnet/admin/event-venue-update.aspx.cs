using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using model = EventMagnet.modal;
using EventMagnet.controller;
using EventMagnet.modal;
using System.Deployment.Internal;

namespace EventMagnet.zDEl_admin
{
    public partial class event_venue_update : System.Web.UI.Page
    {
        string cs = Global.CS;
        string imageDestination = "~/admin/images/venues/";
        HttpPostedFile newUploadFile = null;
        //model.venue venueRecord = new model.venue();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["venueID"] != null)
                {
                    int venueId = int.Parse(Request.QueryString["venueID"]);

                    try
                    {
                        model.venue current_venue = getRecordById(venueId);
                        ViewState["imgSource"] = imageDestination + current_venue.img_src;
                        txtName.Text = current_venue.name;
                        txtDesc.Text = current_venue.descp;
                        txtAddr.Text = current_venue.address;
                        txtPhNo.Text = current_venue.phone_contact;
                        txtEmail.Text = current_venue.email_contact;

                        //if got upload image
                        if (fuImgUpd.HasFile)
                        {
                            model.venue tempRecord = getRecordById(venueId);
                            Session["newUploadFile"] = fuImgUpd.PostedFile;
                            newUploadFile = fuImgUpd.PostedFile;

                            //set the destinationpath
                            string imageFolder = "~/admin/images/venues/";
                            string temp_fileName = tempRecord.img_src;

                            //map virtual paths to physical path
                            string destinationPath = Server.MapPath(imageFolder) + temp_fileName;

                            File.Delete(destinationPath);

                            string filename = Guid.NewGuid().ToString("N") + ".jpg";
                            ImageHandler img = new ImageHandler(fuImgUpd.FileContent);

                            img.ResizeToRectangle(400, 350);

                            string destinationPath_save = Server.MapPath(imageFolder) + filename;

                            img.SaveAs(destinationPath_save);
                        }
                    }catch (Exception ex)
                    {
                        Response.Redirect("../error-page.aspx");
                    }
                }
            }

                    
        }

                public int UpdateVenueRecord(model.venue updRecord)
                {
                    int result = 0;

                    try
                    {
                        model.venue recordVenue = updRecord;

                        //prepare sql statement
                        string updSql = "UPDATE venue SET name=@name, descp=@desc, address=@addr, phone_contact=@phNo, email_contact=@email, status=@status, img_src=@img_src WHERE id=@id";

                        SqlConnection conn = new SqlConnection(cs);
                        SqlCommand cmd = new SqlCommand(updSql, conn);

                        //add value into parameter
                        cmd.Parameters.AddWithValue("@name", updRecord.name);
                        cmd.Parameters.AddWithValue("@desc", updRecord.descp);
                        cmd.Parameters.AddWithValue("@addr", updRecord.address);
                        cmd.Parameters.AddWithValue("@phNo", updRecord.phone_contact);
                        cmd.Parameters.AddWithValue("@email", updRecord.email_contact);
                        cmd.Parameters.AddWithValue("@id", updRecord.id);
                        cmd.Parameters.AddWithValue("@status", updRecord.status);
                        cmd.Parameters.AddWithValue("@img_src", updRecord.img_src);


                        //open the connection
                        conn.Open();
                        int rowAffected = cmd.ExecuteNonQuery();
                        conn.Close();

                        if (rowAffected > 0)
                        {
                            result = 1;
                        }
                    } catch (SqlException ex)
                    {
                //Response.Write(ex.Message);
                Response.Redirect("../error-page.aspx");
            }
            catch (Exception ex)
                    {
                //Response.Write(ex.Message);
                Response.Redirect("../error-page.aspx");
            }
            return result;
                }

        protected void btnUpd_Click(object sender, EventArgs e)
        {
            model.venue newRecord = new model.venue();
            //string fileName = "";
            if (Request.QueryString["venueId"] != null)
            {
                int venueId = int.Parse(Request.QueryString["venueId"]);

                model.venue currentRecord = getRecordById(venueId);

                //get from global
                HttpPostedFile venue_fileUpload = newUploadFile;
                HttpPostedFile session_fileUpload = (HttpPostedFile)Session["newUploadFile"];
                Session.Remove("newUploadFile");
                try
                {
                    string fileName = "";
                    string imageFolder = "~/admin/images/venues";

                    if (venue_fileUpload != null || session_fileUpload != null)
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
                    string name = txtName.Text;
                    string desc = txtDesc.Text;
                    string addr = txtAddr.Text;
                    string phNo = txtPhNo.Text;
                    string email = txtEmail.Text;
                    string id = lblVenueId.Text;
                    string status = lblStatus.Text;
                    if (status == "Active")
                    {
                        status = "1";
                    }
                    else
                    {
                        status = "0";
                    }
                    //assign all values get into newrecord
                    newRecord.id = currentRecord.id;
                    newRecord.name = name;
                    newRecord.descp = desc;
                    newRecord.address = addr;
                    newRecord.phone_contact = phNo;
                    newRecord.email_contact = email;
                    newRecord.status = Byte.Parse(status);
                    newRecord.img_src = fileName;

                    if (UpdateVenueRecord(newRecord) == 1)
                    {
                        lblComment.CssClass = "text-success";
                        lblComment.Text = "Record Updated Successfully !";
                    }
                    else
                    {
                        lblComment.CssClass = "text-danger";
                        lblComment.Text = "Record Update Failed ! Please Contact Admin For Assistance !";
                    }
                }
                catch (Exception ex)
                {
                    Response.Redirect("../error-page.aspx");
                }
            }
        }
                protected void btnChgStatus_Click(object sender, EventArgs e)
                {
                    if (Page.IsValid)
                    {
                        if (lblStatus.Text == "Inactive")
                        {
                            lblStatus.CssClass = "text-success";
                            lblStatus.Text = "Active";
                            btnChgStatus.Visible = false;
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
                Response.Redirect("../error-page.aspx");
            }
        }

                public model.venue getRecordById(int id)
                {
            model.venue venueRecord = new model.venue();
            string imageFolder = "~/admin/images/venues/";
                try { 
                    string sql = "SELECT * FROM venue WHERE id = @venueID";

                    SqlConnection con = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, con);
                    con.Open();

                    cmd.Parameters.AddWithValue("@venueID", id);
                    SqlDataReader read = cmd.ExecuteReader();

                    while (read.Read())
                    {
                        venueRecord.id = Convert.ToInt32(read["id"]);
                        venueRecord.name = Convert.ToString(read["name"]);
                        venueRecord.descp = Convert.ToString(read["descp"]);
                        venueRecord.address = Convert.ToString(read["address"]);
                        venueRecord.email_contact = Convert.ToString(read["email_contact"]);
                        venueRecord.phone_contact = Convert.ToString(read["phone_contact"]);
                        venueRecord.img_src = Convert.ToString(read["img_src"]);
                        venueRecord.status = Convert.ToByte(read["status"]);
                    }
                    con.Close();

                    if (venueRecord.status == 1)
                    {
                        btnChgStatus.Visible = false;
                        lblStatus.CssClass = "text-success form-label-lg form-control";
                        lblStatus.Text = "Active";
                    }
                    else
                    {
                        btnChgStatus.Visible = true;
                        lblStatus.CssClass = "text-danger form-label-lg form-control";
                        lblStatus.Text = "Inactive";
                    }

                    //set the src of the image
                    //ImageUpload.ImageUrl = imgPath;
                    if (fuImgUpd.HasFile)
                    {
                        Session["newUploadFile"] = fuImgUpd.PostedFile;
                        newUploadFile = fuImgUpd.PostedFile;
             
                        //map the path with the old record
                        string destinationPath = Server.MapPath(imageFolder) + venueRecord.img_src;
             
                        //dlt the old file
                        File.Delete(destinationPath);
             
                        string fileName = Guid.NewGuid().ToString("N") + ".jpg";
                        Session["filename"] = fileName;
                        ImageHandler img = new ImageHandler(fuImgUpd.FileContent);
             
                        string newDestinationPath = Server.MapPath(imageFolder) + fileName;
                        //resize the image
                        img.ResizeToRectangle(400, 350);
             
                        img.SaveAs(newDestinationPath);
                  }
                }
                    catch (SqlException ex)
                    {
                Response.Redirect("../error-page.aspx");
            }
            catch (Exception ex)
                    {
                Response.Redirect("../error-page.aspx");
            }
            return venueRecord;
            }

        }
    } 