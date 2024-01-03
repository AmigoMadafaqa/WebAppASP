using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using EventMagnet.controller;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Net.NetworkInformation;
using System.Web.Management;
using System.Web.Services;
using System.Data.Entity.Migrations.Sql;
using Stripe.Identity;
using System.Data.Entity.Infrastructure;
using Stripe;
using System.Runtime.Serialization;

namespace EventMagnet.zDEl_admin
{
    public partial class event_create : System.Web.UI.Page
    {
        public string username = "";
        public string position = "";
        public string organizationName = "";
        public modal.admin currentUser = null;

        eventDA event_DA = new eventDA();
        event_venueDA eventVenue_DA = new event_venueDA();
        ticketDA ticket_DA = new ticketDA();

        string cs = Global.CS;

        static int renderTicket_counter = 1;
        List<model.ticket> global_ticketList = new List<model.ticket>();

        string API_KEY = "AIzaSyC9qWWZVpY5sJ0kZtBhtODzz_013PZ5agc";
        string api_url = "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent";

        string debugMessage = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            ViewState["api_key"] = API_KEY;
            ViewState["api_url"] = api_url;

            //setting up the user 
            if (Session["admin"] != null)
            {
                modal.admin admin = (modal.admin)Session["admin"];
                currentUser = admin;
            }

            GenerateTicketInputSection();

            if (!Page.IsPostBack)
            {
                List<string> ticketNameType = GetTicketType();

                try
                {
                    //GenerateTicketInputSection();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }

            }


        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("event-create.aspx");
        }


        //creating dynamic input section for ticket
        public void GenerateTicketInputSection()
        {
            ticketSection.Controls.Clear();

            for (int i = 0; i < renderTicket_counter; i++)
            {
                int counter = 1 + i;
                string ticket_Name_ID = "ticketName_" + counter.ToString();
                string ticket_Price_ID = "ticketPrice_" + counter.ToString();
                string ticket_TotalQty_ID = "ticketQty_" + counter.ToString();

                string rfv_ticketName_ID = "rfvTicketName_" + counter.ToString();
                string rfv_ticketPrice_ID = "rfvTicketPrice_" + counter.ToString();

                string rfv_totalQty_ID = "rfvTotalQty_" + counter.ToString();

                //regular expression needed, Price Only
                string rxv_ticketPrice_ID = "rxvTicketPrice_" + counter.ToString();

                TextBox ticketNameTextBox = new TextBox();
                ticketNameTextBox.ID = ticket_Name_ID;
                ticketNameTextBox.CssClass = "form-control";
                ticketNameTextBox.Text = "";

                TextBox ticketPrice_TextBox = new TextBox();
                ticketPrice_TextBox.ID = ticket_Price_ID;

                ticketPrice_TextBox.CssClass = "form-control";
                ticketPrice_TextBox.Text = "";

                TextBox totalQty_textbox = new TextBox();
                totalQty_textbox.ID = ticket_TotalQty_ID;
                totalQty_textbox.CssClass = "form-control";
                totalQty_textbox.TextMode = TextBoxMode.Number;
                totalQty_textbox.Attributes["min"] = "1";
                totalQty_textbox.Text = "";

                RequiredFieldValidator ticketName_RFV = new RequiredFieldValidator();
                ticketName_RFV.ID = rfv_ticketName_ID;
                ticketName_RFV.ErrorMessage = "⚠️ Please enter [Ticket Name]";
                ticketName_RFV.ControlToValidate = ticket_Name_ID;
                ticketName_RFV.Display = ValidatorDisplay.Dynamic;
                ticketName_RFV.CssClass = "text-danger";

                RequiredFieldValidator ticketPrice_RFV = new RequiredFieldValidator();
                ticketPrice_RFV.ID = rfv_ticketPrice_ID;
                ticketPrice_RFV.ErrorMessage = "⚠️ Please enter [Ticket Price]";
                ticketPrice_RFV.ControlToValidate = ticket_Price_ID;
                ticketPrice_RFV.Display = ValidatorDisplay.Dynamic;
                ticketPrice_RFV.CssClass = "text-danger";

                RequiredFieldValidator totalQty_RFV = new RequiredFieldValidator();
                totalQty_RFV.ID = rfv_totalQty_ID;
                totalQty_RFV.ErrorMessage = "⚠️ Please Enter [Ticket Quantity]";
                totalQty_RFV.ControlToValidate = ticket_TotalQty_ID;
                totalQty_RFV.Display = ValidatorDisplay.Dynamic;
                totalQty_RFV.CssClass = "text-danger";

                RegularExpressionValidator ticketPrice_RXV = new RegularExpressionValidator();
                ticketPrice_RXV.ID = rxv_ticketPrice_ID;
                ticketPrice_RXV.ErrorMessage = "⚠️ Please enter a valid numeric value for RM0.00";
                ticketPrice_RXV.ControlToValidate = ticket_Price_ID;
                ticketPrice_RXV.Display = ValidatorDisplay.Dynamic;
                ticketPrice_RXV.CssClass = "text-danger";
                ticketPrice_RXV.ValidationExpression = @"^\d+(\.\d{1,2})?$";

                ticketSection.Controls.Add(new LiteralControl(@"
                <div class=""row"">
                   <div class=""mb-3 col-md-4"">
                      <label for=""ticketName"" class=""form-label"">Ticket Name</label>
                "));

                ticketSection.Controls.Add(ticketNameTextBox);
                ticketSection.Controls.Add(ticketName_RFV);

                ticketSection.Controls.Add(new LiteralControl(@"
                 </div>
                   <div class=""mb-3 col-md-4"">
                      <label for=""ticketPrice"" class=""form-label"">Ticket Price</label>
                      <div class=""input-group input-group-merge"">
                         <span class=""input-group-text"">RM</span>
                "));

                ticketSection.Controls.Add(ticketPrice_TextBox);
                ticketSection.Controls.Add(new LiteralControl(@"</div>"));

                ticketSection.Controls.Add(ticketPrice_RFV);
                ticketSection.Controls.Add(ticketPrice_RXV);

                ticketSection.Controls.Add(new LiteralControl(@"
                </div>
                   <div class=""mb-4 col-md-3"">
                      <label for=""totalQuantity"" class=""form-label"">Total Quantity</label>
                "));

                ticketSection.Controls.Add(totalQty_textbox);
                ticketSection.Controls.Add(totalQty_RFV);

                ticketSection.Controls.Add(new LiteralControl(@"
                    </div>
                </div>"));

            }
        }

        //Notice : Use for retrived the info for , Name, Price & Total
        //Qty only , 
        // Missing ; Evnet ID 
        public List<model.ticket> gettPlaceHolderTicketValue()
        {
            List<model.ticket> ticket_list = new List<model.ticket>();

            for (int i = 0; i < renderTicket_counter; i++)
            {
                try
                {
                    int counter = 1 + i;
                    string ticket_Name_ID = "ticketName_" + counter.ToString();
                    string ticket_Price_ID = "ticketPrice_" + counter.ToString();
                    string ticket_TotalQty_ID = "ticketQty_" + counter.ToString();

                    TextBox ticketName_textbox = (TextBox)ticketSection.FindControl(ticket_Name_ID);
                    TextBox ticketPrice_textbox = (TextBox)ticketSection.FindControl(ticket_Price_ID);
                    TextBox totalQuantity_textbox = (TextBox)ticketSection.FindControl(ticket_TotalQty_ID);

                    if (ticketName_textbox != null && ticketPrice_textbox != null && totalQuantity_textbox != null)
                    {
                        model.ticket temp_ticket = new ticket();
                        string ticketName = ticketName_textbox.Text;
                        decimal ticketPrice = Convert.ToDecimal(ticketPrice_textbox.Text);
                        int totalQuantity = Convert.ToInt32(totalQuantity_textbox.Text);

                        temp_ticket.name = ticketName;
                        temp_ticket.price = ticketPrice;
                        temp_ticket.total_qty = totalQuantity;

                        ticket_list.Add(temp_ticket);
                    }
                }
                catch (Exception e)
                {
                    Debug.WriteLine(e.Message);
                }
            }

            return ticket_list;
        }

        public void recreateTicketSectionValue(List<model.ticket> current_TicketList)
        {
            List<model.ticket> ticket_list = current_TicketList;

            for(int i = 0; i < ticket_list.Count; i++)
            {
                int counter = 1 + i;
                string ticket_Name_ID = "ticketName_" + counter.ToString();
                string ticket_Price_ID = "ticketPrice_" + counter.ToString();
                string ticket_TotalQty_ID = "ticketQty_" + counter.ToString();

                TextBox ticketName_textbox = (TextBox)ticketSection.FindControl(ticket_Name_ID);
                TextBox ticketPrice_textbox = (TextBox)ticketSection.FindControl(ticket_Price_ID);
                TextBox totalQuantity_textbox = (TextBox)ticketSection.FindControl(ticket_TotalQty_ID);

                if (ticketName_textbox != null && ticketPrice_textbox != null && totalQuantity_textbox != null)
                {
                    ticketName_textbox.Text = ticket_list[i].name;
                    ticketPrice_textbox.Text = ticket_list[i].price.ToString();
                    totalQuantity_textbox.Text = ticket_list[i].total_qty.ToString();
                    
                }
            }
        }

        protected void btn_ticketGenerate_Click(object sender, EventArgs e)
        {
            // Save ticket information to 
            List<model.ticket> pre_ticketList = gettPlaceHolderTicketValue();
            renderTicket_counter++;

            GenerateTicketInputSection();
            recreateTicketSectionValue(pre_ticketList);
        }

        // Create Event & Create 
        protected void btnCreateEventTicket_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                List<modal.ticket> ticketList = gettPlaceHolderTicketValue();
                modal.@event newEvent = new @event();
                modal.event_venue newEventVenue = new event_venue();

                //Event Images Variable
                string imagesDestination_admin = "~/admin/images/events/";
                string imagesDestination_site = "../site/images/events/";
                string fileName = "";

                //Upload the file to folder
                if (fileUpload.HasFile)
                {
                    //fileName = Path.GetFileName(fileUpload.PostedFile.FileName);
                    fileName = Guid.NewGuid().ToString("N") + ".jpg";
                    ImageHandler img = new ImageHandler(fileUpload.FileContent);
                    img.ResizeToRectangle(400, 350);
                    string destinationPath_Admin = Server.MapPath(imagesDestination_admin) + fileName;
                    string destinationPath_site = Server.MapPath(imagesDestination_site) + fileName;
                    //SaveFile(fileUpload.PostedFile, destinationPath_Admin);
                    //SaveFile(fileUpload.PostedFile, destinationPath_site);

                    img.SaveAs(destinationPath_Admin);
                    img.SaveAs(destinationPath_site);
                }

                //setting up the value 
                // Event Model 
                newEvent.name = txtEventName.Text;

                string evenStartDate = startDatePicker.Value;
                string evenEndDate = endDatePicker.Value;
                string eventStartTime = startTime.Value;
                string eventEndTime = endTime.Value;
                string ticketStartSalesTime = ticketStartTime.Value.ToString();
                string ticketEndSalesTime = ticketEndTime.Value.ToString();

                newEvent.start_date = DateTime.ParseExact(evenStartDate, "yyyy-MM-dd", null);
                newEvent.end_date = DateTime.ParseExact(evenEndDate, "yyyy-MM-dd", null);
                newEvent.start_time = TimeSpan.ParseExact(eventStartTime, "hh':'mm", null);
                newEvent.end_time = TimeSpan.ParseExact(eventEndTime, "hh':'mm", null);
                newEvent.ticket_sale_start_datetime = DateTime.ParseExact(ticketStartSalesTime, "yyyy-MM-ddTHH:mm", null);
                newEvent.ticket_sale_end_datetime = DateTime.ParseExact(ticketEndSalesTime, "yyyy-MM-ddTHH:mm", null);
                newEvent.descp = eventDescription.Text;
                newEvent.keyword = ConvertToHashTags(keyWords.Text);
                newEvent.category_name = categoryListDll.SelectedValue.ToString();
                newEvent.img_src = fileName;
                newEvent.status = 1;
                newEvent.create_datetime = DateTime.Now;
                newEvent.organization_id = (int)Session["currentOrgId"];

                //Operation Inserting Value to Database
                int event_result = event_DA.SaveEventToDatabase(newEvent);

                //Retrive the inserted Event Modal 
                modal.@event event_temp = event_DA.getEventByEventNameOrganizationCategories(newEvent.name, newEvent.organization_id, newEvent.category_name);

                for(int i = 0; i < ticketList.Count; i++)
                {
                    if (ticketList[i] != null)
                    {
                        ticketList[i].event_id = event_temp.id;
                        ticketList[i].status = 1;

                        int ticket_result = ticket_DA.SaveTicketToDatabase(ticketList[i]);
                    }
                }

                //Event Venue Modal
                newEventVenue.book_date = newEvent.start_date;
                newEventVenue.status = 1;
                newEventVenue.venue_id = int.Parse(ddlVenue.SelectedValue.ToString());
                newEventVenue.event_id = event_temp.id;

                // Activate DA operation 
                int eventVenueResult = eventVenue_DA.insertVenueIntoDatabase(newEventVenue);

                //prompt Success Msg 
                string eventModal_header = "Event Created Successfully.";
                string eventModal_promtperMsg = $"You Had Created Event : {newEvent.name} <br />";
                getPrompterModalUp(eventModal_header, eventModal_promtperMsg, true);
            }


        }


        public void getPrompterModalUp(string header, string msg, bool confirmation)
        {
            ViewState["eventModal_header"] = header;
            ViewState["eventModal_promtperMsg"] = msg;
            ViewState["eventModal_confirmation"] = confirmation;
        }

        public void getPrompterModalDown()
        {
            ViewState["eventModal_confirmation"] = false;
        }
        //********************************* Additional Functional *********************************
        //Save File Function 
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
                string errorMsg = "Error Uploading file: " + ex.Message;
                Debug.WriteLine(errorMsg);
                
            }
        }


        private List<string> GetTicketType()
        {
            List<string> ticketType = new List<string> {
                "Standard",
                "Silver",
                "Gold",
                "VVIP",
                "Premium VIP",
                "Elderly",
                "Adult",
                "Children"
            };
            return ticketType;
        }


        public static string ConvertToHashTags(string input)
        {
            string[] words = input.Split(' ');

            string result = string.Join(" ", words.Select(word =>
            {
                if (word.StartsWith("#"))
                {
                    return word;
                }
                else
                {
                    return "#" + word;
                }
            }));

            return result;
        }

        protected void cvfileUpload_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (fileUpload.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(fileUpload.FileName).ToLower();

                string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" }; // Add more if needed
                if (Array.IndexOf(allowedExtensions, fileExtension) == -1)
                {
                    args.IsValid = false;
                    cvfileUpload.ErrorMessage = "⚠️ Unsupported File Type.";
                }
                else
                {
                    args.IsValid = true;
                }
            }
            else
            {
 
                args.IsValid = false;
                cvfileUpload.ErrorMessage = "⚠️ Please Upload Your File.";
            }
        }

    }
}