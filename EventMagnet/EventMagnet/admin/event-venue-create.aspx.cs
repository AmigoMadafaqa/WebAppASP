using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

using model = EventMagnet.modal;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using BCrypt.Net;
using EventMagnet.controller;


namespace EventMagnet.admin
{
    
    public partial class event_venue_create : System.Web.UI.Page
    {
        //initialize the connection string
        string cs = Global.CS;

        string webPageName = "";

        public string username = "";
        public string position = "";
        public string organizationName = "";

        //initialise protected get and set for notification purpose
        protected string notiTitle {  get; set; }
        protected string notiBody { get; set; }
        protected string buttonId { get; set; }
        protected string url { get; set; }


        public modal.admin currentUser = null;

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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("event-venue-create.aspx");
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            Response.Redirect("event-venue-index.aspx");
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            model.EventMagnetEntities db = new model.EventMagnetEntities();
            List<venue> dataList = db.venues.ToList();
            int recordCount = dataList.Count + 1;
            modal.venue newVenue = new venue(); 

            //image variable
            string imageDestination = "~/admin/images/venues/";
 
            try
            {
                //get input
                string name = txtVName.Text;
                string desc = txtVDesc.Text;
                string addr = txtVAddr.Text;
                string phNo = txtPhNo.Text;
                string email = txtEmail.Text;

                //get the img file name
                if (fuVenueImg.HasFile)
                {
                    string fileName = Path.GetFileName(fuVenueImg.FileName);

                    //check the image extension
                    if (cvVenueImg.IsValid)
                    {
                        fileName = Guid.NewGuid().ToString("N").ToString() + ".jpg";

                        //store item into newVenue
                        newVenue.name = name;
                        newVenue.descp = desc;
                        newVenue.address = addr;
                        newVenue.phone_contact = phNo;
                        newVenue.email_contact = email;
                        newVenue.img_src = fileName;
                       // newVenue.status = status;

                        //set destination path
                        string destinationPath = Server.MapPath(imageDestination) + fileName;

                        //calling InsertIntoDB function to insert record
                        if(InsertVenueIntoDB(newVenue) ==1)
                        {
                            //calling SaveFile function to save the image to local path
                            SaveFile(fuVenueImg.PostedFile, destinationPath);
                            //set info for notification
                            notiTitle = "Venue Created Successfully";
                            notiBody = $"Venue Has Created Successfully ! ";
                            buttonId = btnCreate.ID;
                            url = $"event-venue-view.aspx?venueID={recordCount}";

                            // Set values for the notification in JavaScript
                            string script = $@"
                                                if ('Notification' in window) {{
                                                    if (Notification.permission === 'granted') {{
                                                        showNotification('{notiTitle}', '{notiBody}', '{buttonId}', '{url}');
                                                    }} else {{
                                                        Notification.requestPermission().then((permission) => {{
                                                            if (permission === 'granted') {{
                                                                showNotification('{notiTitle}', '{notiBody}', '{buttonId}', '{url}');
                                                            }} else {{
                                                                console.log('Notification access denied or not given');
                                                            }}
                                                        }});
                                                    }}
                                                }}

                                                function showNotification(title, body, buttonId, url) {{
                                                    const showNotiBtn = document.getElementById(buttonId);

                                                    if (showNotiBtn != null) {{
                                                        const notification = new Notification(title, {{
                                                            body: body,
                                                        }});

                                                        notification.addEventListener('click', () => {{
                                                            window.open(url);
                                                        }});
                                                    }} else {{
                                                        console.error('Button not found with ID:', buttonId);
                                                    }}
                                                }}
                                            ";

                            // Register the script block
                            Page.ClientScript.RegisterStartupScript(this.GetType(), "VenueCreateNotification", script, true);
                        }
                        //Response.Redirect("event-venue-index.aspx");
                        txtEmail.Text = "";
                        txtPhNo.Text = "";
                        txtVAddr.Text = "";
                        txtVDesc.Text = "";
                        txtVName.Text = "";
                        fuVenueImg= null;
                    }
                    else
                    {
                        //return message for the customValidator
                        cvVenueImg.ErrorMessage = "⚠️ Invalid Format !";
                    }
                }
            }catch (HttpException ex)
            {
                Response.Redirect("../error-page.aspx");
            }
            catch(Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }
        }

        //insert record into database
        private int InsertVenueIntoDB(modal.venue newVenue)
        {
            int result = 0;

                try
                {
                    modal.venue venueInfo = newVenue;

                    //sql statement
                    string sql = "INSERT INTO venue (name, descp, address, phone_contact, email_contact, img_src)" + " VALUES (@name, @desc, @addr, @phNo, @email, @img_src)";

                    SqlConnection conn = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    //add value to cmd
                    cmd.Parameters.AddWithValue("@name", venueInfo.name);
                    cmd.Parameters.AddWithValue("@desc", venueInfo.descp);
                    cmd.Parameters.AddWithValue("@addr", venueInfo.address);
                    cmd.Parameters.AddWithValue("@phNo", venueInfo.phone_contact);
                    cmd.Parameters.AddWithValue("@email", venueInfo.email_contact);
                    cmd.Parameters.AddWithValue("@img_src", venueInfo.img_src);

                    //open connection
                    conn.Open();
                    int rowAffected = cmd.ExecuteNonQuery();
                    conn.Close();

                    if (rowAffected > 0)
                    {
                        result = 1;
                    }

                }catch (Exception ex)
                {
                Response.Redirect("../error-page.aspx");
            }

            return result;
        }


        //save uploaded file into path
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

            }catch(Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }
        }

        //validation for file uploaded extension
        protected void cvVenueImg_ServerValidate(object source, ServerValidateEventArgs args)
        {
            // Check if the file extension is not ".png"
            string fileName = fuVenueImg.FileName;
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
    }

    }