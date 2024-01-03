using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using EventMagnet.controller;
using EventMagnet.modal;
using System.IO;
using System.Web.Services;
using System.Data.SqlTypes;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Runtime.Remoting.Messaging;
using System.Web.Services.Description;
using System.Runtime.Serialization;

namespace EventMagnet.zDEl_admin
{
    public partial class event_details : System.Web.UI.Page
    {
        eventDA event_DA = new eventDA();
        event_venueDA event_venue_DA = new event_venueDA();
        ticketDA ticket_DA = new ticketDA();
        order_itemDA order_item_DA = new order_itemDA();
        cust_orderDA cust_order_DA = new cust_orderDA();
        venueDA venue_DA = new venueDA();

        HttpPostedFile uploadedFile_event = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                if (Session["admin"] == null || Session["currentOrgId"] == null || Session["isInnerAdmin"] == null)
                {
                    Response.Redirect("admin-login.aspx");
                    return;
                }
                // Postback, recreate and rebind dynamic controls
                RecreateTicketSection();
                RenderTicketSection();
            }
            else
            {
                if (Session["admin"] == null || Session["currentOrgId"] == null || Session["isInnerAdmin"] == null)
                {
                    Response.Redirect("admin-login.aspx");
                    return;
                }
                // Initial page load
                LoadEventData();
                RenderTicketSection();
            }

            if (fileUpload.HasFile)
            {
                if(Request.QueryString["eventID"] != null)
                {
                    int eventID = int.Parse(Request.QueryString["eventID"]);
                    model.@event tempUseEvent = event_DA.retrieveEventByEventId(eventID);

                    Session["uploaded_file_event"] = fileUpload.PostedFile;
                    uploadedFile_event = fileUpload.PostedFile;

                    //HttpPostedFile uploadedFileStream = fileUpload.PostedFile;
                    string imagesDestination_admin = "~/admin/images/events/";
                    string imagesDestination_site = "../site/images/events/";

                    string tempUse_fileName = tempUseEvent.img_src;

                    // Map the virtual paths to physical paths
                    string destinationPath_Admin = Server.MapPath(imagesDestination_admin) + tempUse_fileName;
                    string destinationPath_site = Server.MapPath(imagesDestination_site) + tempUse_fileName;

                    File.Delete(destinationPath_Admin);
                    File.Delete(destinationPath_Admin);

                    string filename = Guid.NewGuid().ToString("N") + ".jpg";
                    Session["filename"] = filename;
                    ImageHandler img = new ImageHandler(fileUpload.FileContent);

                    img.ResizeToRectangle(400, 350);

                    string destinationPath_Admin_save = Server.MapPath(imagesDestination_admin) + filename;
                    string destinationPath_site_save = Server.MapPath(imagesDestination_site) + filename;

                    img.SaveAs(destinationPath_Admin_save);
                    img.SaveAs(destinationPath_site_save);

                    /*
                    string fileName = Path.GetFileName(uploadedFileStream.FileName);
                    string destinationPath_Admin = Server.MapPath(imagesDestination_admin) + fileName;
                    string destinationPath_site = Server.MapPath(imagesDestination_site) + fileName;
                    SaveFile(uploadedFileStream, destinationPath_Admin);
                    SaveFile(uploadedFileStream, destinationPath_site);
                    */
                }
            }
        }

        private void LoadEventData()
        {
            if (Request.QueryString["eventID"] != null && Request.QueryString["organizationID"] != null)
            {
                int eventID = int.Parse(Request.QueryString["eventID"]);
                int organizationID = int.Parse(Request.QueryString["organizationID"]);

                try
                {
                    modal.@event event_current = event_DA.retrieveEventByEventId(eventID);
                    modal.event_venue eventVenue_current = event_venue_DA.getEventVenueByEventID(eventID);
                    model.venue venue_current = venue_DA.GetVenueByEventId(eventID);
                    List<model.ticket> ticketList_current = ticket_DA.retriveTicketInfoByEventID(eventID);

                    ViewState["imgSource"] = event_current.img_src;
                    txtEventName.Text = event_current.name;
                    keyWords.Text = event_current.keyword;
                    ddlVenue.SelectedValue = venue_current.id.ToString();
                    categoryListDll.SelectedValue = event_current.category_name.ToString();
                    startDatePicker.Value = event_current.start_date.ToString("yyyy-MM-dd");
                    endDatePicker.Value = event_current.end_date.ToString("yyyy-MM-dd");
                    startTime.Value = event_current.start_time.ToString(@"hh\:mm");
                    endTime.Value = event_current.end_time.ToString(@"hh\:mm");
                    eventDescription.Text = event_current.descp;

                    ticketStartTime.Value = event_current.ticket_sale_start_datetime.ToString("yyyy-MM-ddTHH:mm");
                    ticketEndTime.Value = event_current.ticket_sale_end_datetime.ToString("yyyy-MM-ddTHH:mm");

                    Session["ori_ticketlist"] = ticketList_current;
                }
                catch (Exception ex)
                {
                    Response.Redirect("../error-page.aspx");
                }
            }
        }

        public void RenderTicketSection()
        {
            ticketSectionPlaceHolder.Controls.Clear();

            int eventID = int.Parse(Request.QueryString["eventID"]);
            int organizationID = int.Parse(Request.QueryString["organizationID"]);

            List<model.ticket> ticketList_current = ticket_DA.retriveTicketInfoByEventID(eventID);

            for (int i = 0; i < ticketList_current.Count; i++)
            {
                if (ticketList_current[i] != null)
                {
                    int counter = 1 + i;

                    //change form DDL to 
                    //string ticketNameddl_ID = "ticketNameDDL_" + counter.ToString();
                    string ticketNameTextBox_ID = "ticketName_" + counter.ToString();
                    string ticketPricetextBox_ID = "ticketPrice_" + counter.ToString();
                    string totalQuantitytextBox_ID = "totalQuantity_" + counter.ToString();

                    //string rfv_TicketNameDDL_ID = "rfvTicketNameDDL_" + counter.ToString();
                    string rfv_TicketName_ID = "rfv_ticketName_" + counter.ToString();
                    string rfv_TicketPrice_ID = "rfvTicketPrice_" + counter.ToString();
                    string rfv_TotalQuantity_ID = "rfvTotalQuantity_" + counter.ToString();

                    /*
                    DropDownList ticketNameDDL = new DropDownList();
                    ticketNameDDL.ID = ticketNameddl_ID;
                    ticketNameDDL.CssClass = "form-select";
                    ticketNameDDL.Items.Add(new ListItem("Standard", "Standard"));
                    ticketNameDDL.Items.Add(new ListItem("Silver", "Silver"));
                    ticketNameDDL.Items.Add(new ListItem("Gold", "Gold"));
                    ticketNameDDL.Items.Add(new ListItem("VVIP", "VVIP"));
                    ticketNameDDL.Items.Add(new ListItem("Premium VIP", "Premium VIP"));
                    ticketNameDDL.Items.Add(new ListItem("Elderly", "Elderly"));
                    ticketNameDDL.Items.Add(new ListItem("Adult", "Adult"));
                    ticketNameDDL.Items.Add(new ListItem("Children", "Children"));
                    ticketNameDDL.SelectedValue = ticketList_current[i].name;
                    */

                    TextBox ticketNameTextBox = new TextBox();
                    ticketNameTextBox.ID = ticketNameTextBox_ID;
                    ticketNameTextBox.CssClass = "form-control";
                    ticketNameTextBox.Text = ticketList_current[i].name;

                    RequiredFieldValidator rfvTicketName = new RequiredFieldValidator();
                    rfvTicketName.ID = rfv_TicketName_ID;
                    rfvTicketName.ControlToValidate = ticketNameTextBox_ID;
                    rfvTicketName.ErrorMessage = "⚠️ Ticket Name is required.";
                    rfvTicketName.Display = ValidatorDisplay.Dynamic;
                    rfvTicketName.CssClass = "text-danger";

                    TextBox ticketPriceTextBox = new TextBox();
                    ticketPriceTextBox.ID = ticketPricetextBox_ID;
                    ticketPriceTextBox.CssClass = "form-control";
                    ticketPriceTextBox.TextMode = TextBoxMode.Number;
                    ticketPriceTextBox.Text = ticketList_current[i].price.ToString();

                    RequiredFieldValidator rfvTicketPrice = new RequiredFieldValidator();
                    rfvTicketPrice.ID = rfv_TicketPrice_ID;
                    rfvTicketPrice.ControlToValidate = ticketPricetextBox_ID;
                    rfvTicketPrice.ErrorMessage = "⚠️ Ticket Price is required.";
                    rfvTicketPrice.Display = ValidatorDisplay.Dynamic;
                    rfvTicketPrice.CssClass = "text-danger";

                    TextBox totalQuantityTextBox = new TextBox();
                    totalQuantityTextBox.ID = totalQuantitytextBox_ID;
                    totalQuantityTextBox.CssClass = "form-control";
                    totalQuantityTextBox.TextMode = TextBoxMode.Number;
                    totalQuantityTextBox.Attributes["min"] = "1";
                    totalQuantityTextBox.Text = ticketList_current[i].total_qty.ToString();

                    RequiredFieldValidator rfvTotalQuantity = new RequiredFieldValidator();
                    rfvTotalQuantity.ID = rfv_TotalQuantity_ID;
                    rfvTotalQuantity.ControlToValidate = totalQuantitytextBox_ID;
                    rfvTotalQuantity.ErrorMessage = "⚠️ Total Quantity is required.";
                    rfvTotalQuantity.Display = ValidatorDisplay.Dynamic;
                    rfvTotalQuantity.CssClass = "text-danger";

                    ticketSectionPlaceHolder.Controls.Add(new LiteralControl(
                        @"
             <div class=""row"">
               <div class=""mb-3 col-md-5"">
                  <label for=""ticketName"" class=""form-label"">Ticket Name</label>
            "));

                    ticketSectionPlaceHolder.Controls.Add(ticketNameTextBox);
                    ticketSectionPlaceHolder.Controls.Add(rfvTicketName);

                    ticketSectionPlaceHolder.Controls.Add(new LiteralControl(
                        @"
            </div>
               <div class=""mb-3 col-md-3"">
                  <label for=""ticketPrice"" class=""form-label"">Ticket Price</label>
                  <div class=""input-group input-group-merge"">
                     <span class=""input-group-text"">RM</span>
            "));

                    ticketSectionPlaceHolder.Controls.Add(ticketPriceTextBox);
                    ticketSectionPlaceHolder.Controls.Add(rfvTicketPrice);

                    ticketSectionPlaceHolder.Controls.Add(new LiteralControl(
                        @"
            </div>
               </div>
               <div class=""mb-3 col-md-2"">
                  <label for=""totalQuantity"" class=""form-label"">Total Quantity</label>
            "));
                    ticketSectionPlaceHolder.Controls.Add(totalQuantityTextBox);
                    ticketSectionPlaceHolder.Controls.Add(rfvTotalQuantity);

                    ticketSectionPlaceHolder.Controls.Add(new LiteralControl(
                        @"
                </div>
            </div>
            "));
                }
            }
        }

        private void RecreateTicketSection()
        {
            List<model.ticket> ori_ticketList = (List<model.ticket>)Session["ori_ticketlist"];

            if (ori_ticketList != null)
            {
                for (int i = 0; i < ori_ticketList.Count; i++)
                {
                    int counter = 1 + i;
                    string ticketNameTextBox_ID = "ticketName_" + counter.ToString();
                    string ticketPricetextBox_ID = "ticketPrice_" + counter.ToString();
                    string totalQuantitytextBox_ID = "totalQuantity_" + counter.ToString();

                    TextBox ticketNameDDL = (TextBox)ticketSectionPlaceHolder.FindControl(ticketNameTextBox_ID);
                    TextBox ticketPriceTextBox = (TextBox)ticketSectionPlaceHolder.FindControl(ticketPricetextBox_ID);
                    TextBox totalQuantityTextBox = (TextBox)ticketSectionPlaceHolder.FindControl(totalQuantitytextBox_ID);

                    if (ticketNameDDL != null && ticketPriceTextBox != null && totalQuantityTextBox != null)
                    {
                        // Rebind the DropDownList with the previous selection
                        ticketNameDDL.Text = ori_ticketList[i].name;

                        // Set the TextBox values
                        ticketPriceTextBox.Text = ori_ticketList[i].price.ToString();
                        totalQuantityTextBox.Text = ori_ticketList[i].total_qty.ToString();
                    }
                }
            }
        }

        public List<modal.ticket> RetriveTicketSectionData()
        {
            List<model.ticket> ori_ticketList = (List<model.ticket>)Session["ori_ticketlist"];
            Session.Remove("ori_ticketlist");
            List<model.ticket> new_ticketList = new List<model.ticket>();

            if (ori_ticketList != null)
            {
                for (int i = 0; i < ori_ticketList.Count; i++)
                {
                    int counter = 1 + i;

                    string ticketNameTextBox_ID = "ticketName_" + counter.ToString();
                    string ticketPricetextBox_ID = "ticketPrice_" + counter.ToString();
                    string totalQuantitytextBox_ID = "totalQuantity_" + counter.ToString();

                    TextBox ticketNameTextBox = (TextBox)ticketSectionPlaceHolder.FindControl(ticketNameTextBox_ID);
                    TextBox ticketPriceTextBox = (TextBox)ticketSectionPlaceHolder.FindControl(ticketPricetextBox_ID);
                    TextBox totalQuantityTextBox = (TextBox)ticketSectionPlaceHolder.FindControl(totalQuantitytextBox_ID);

                    if (ticketNameTextBox != null && ticketPriceTextBox != null && totalQuantityTextBox != null)
                    {
                        string ticketName = ticketNameTextBox.Text;
                        decimal ticketPrice = Convert.ToDecimal(ticketPriceTextBox.Text);
                        int totalQuantity = Convert.ToInt32(totalQuantityTextBox.Text);

                        ori_ticketList[i].name = ticketName;
                        ori_ticketList[i].price = ticketPrice;
                        ori_ticketList[i].total_qty = totalQuantity;

                        new_ticketList.Add(ori_ticketList[i]);
                    }
                }
            }

            return new_ticketList;
        }

        protected void btnConfirmUpdate_Click(object sender, EventArgs e)
        {
            modal.@event newEvent = new @event();
            List<model.ticket> updatedTicketList = RetriveTicketSectionData();
            modal.event_venue newEventVenue = new event_venue();

            ViewState["eventModal_confirmation"] = false; //set the modal hide

            if (Request.QueryString["eventID"] != null && Request.QueryString["organizationID"] != null)
            {

                int eventID = int.Parse(Request.QueryString["eventID"]);
                int organizationID = int.Parse(Request.QueryString["organizationID"]);

                modal.@event event_current = event_DA.retrieveEventByEventId(eventID); //temp use 
                modal.event_venue eventVenue_current = event_venue_DA.getEventVenueByEventID(eventID); //temp use

                HttpPostedFile event_fileUpload = uploadedFile_event; //from global 
                HttpPostedFile session_fileUpload = (HttpPostedFile)Session["uploaded_file_event"]; //from session
                Session.Remove("uploaded_file_event");

                try
                {
                    string fileName = "";
                    string imagesDestination_admin = "~/admin/images/events/";
                    string imagesDestination_site = "../site/images/events/";

                    if(event_fileUpload != null || session_fileUpload != null)
                    {
                        if (Session["filename"] != null)
                        {
                            fileName = Session["filename"].ToString();
                        }
                        string destinationPath_Admin = Server.MapPath(imagesDestination_admin) + fileName;
                        string destinationPath_site = Server.MapPath(imagesDestination_site) + fileName;
                        //SaveFile(session_fileUpload, destinationPath_Admin);
                        //SaveFile(session_fileUpload, destinationPath_site);
                    }
                    else
                    {
                        fileName = event_current.img_src;
                    }

                    //Event 
                    newEvent.id = eventID; //use default
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
                    newEvent.create_datetime = event_current.create_datetime;
                    newEvent.organization_id = event_current.organization_id;

                    //eventVenue
                    newEventVenue.id = eventVenue_current.id; //use default
                    newEventVenue.book_date = eventVenue_current.book_date; //use edfault
                    newEventVenue.status = 1;
                    newEventVenue.venue_id = int.Parse(ddlVenue.SelectedValue.ToString());
                    newEventVenue.event_id = eventID;

                    //Execution of Update Operation
                    bool event_success_indicator = event_DA.updateEventByID(newEvent);
                    bool event_venue_success_indicator = event_venue_DA.updateEventVenueByID(newEventVenue);

                    if (updatedTicketList != null)
                    {
                        for (int i = 0; i < updatedTicketList.Count; i++)
                        {
                            bool ticket_success = ticket_DA.updateTicketByID(updatedTicketList[i]);
                        }
                    }

                    string modalHeader = "Event Edited Successfully ";
                    string modalMessage = "Click Confirm Button To Proceed To Index Page";

                    getSuccessConfirmationUp(modalHeader, modalMessage, true);

                }
                catch(Exception ex)
                {
                    Response.Redirect("../error-page.aspx");
                }
            }
        }

        public void getUpdateConfirmationUp(string header, string message, bool modalConfirmationUp)
        {
            ViewState["eventModal_header"] = header;
            ViewState["eventModal_promtperMsg"] = message;
            ViewState["eventModal_confirmation"] = true;
        }

        public void getSuccessConfirmationUp(string header, string message, bool modalConfirmationUp)
        {
            ViewState["success_eventModal_header"] = header;
            ViewState["success_eventModal_promtperMsg"] = message;
            ViewState["success_eventModal_confirmation"] = true;
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            string modalHeader = "Are You Sure You Want To Edit ? ";
            string modalMessage = "Click Confirm Button To Proceed";

            getUpdateConfirmationUp(modalHeader, modalMessage, true);
        }

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
                Response.Redirect("../error-page.aspx");

            }
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

        protected void btn_confirmSuccess_Click(object sender, EventArgs e)
        {
            ViewState["success_eventModal_confirmation"] = false;
            Response.Redirect("event-index.aspx");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Response.Redirect("event-index.aspx");
        }
    }

}