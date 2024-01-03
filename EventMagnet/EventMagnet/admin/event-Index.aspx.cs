using EventMagnet.controller;
using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;

namespace EventMagnet.zDEl_admin
{
    public partial class eventManagement : System.Web.UI.Page
    {
        eventDA event_DA = new eventDA();
        event_venueDA event_venue_DA = new event_venueDA();
        ticketDA ticket_DA = new ticketDA();
        order_itemDA order_item_DA = new order_itemDA();
        cust_orderDA cust_order_DA = new cust_orderDA();

        string currentUrl = HttpContext.Current.Request.Url.AbsoluteUri;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataBind();
            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string location = "event-create.aspx";
            Response.Redirect(location);
        }

        protected string GetEventStatus(object startDate, object endDate)
        {
            DateTime startDateTime = Convert.ToDateTime(startDate);
            DateTime endDateTime = Convert.ToDateTime(endDate);
            DateTime today = DateTime.Today;

            if (today < startDateTime)
            {
                return "<span class=\"badge bg-label-primary me-1\">Incoming</span>";
            }
            else if (today > endDateTime)
            {
                return "<span class=\"badge bg-label-danger me-1\">Completed</span>";
            }
            else
            {
                return "<span class=\"badge bg-label-success me-1\">Ongoing</span>";
            }
        }

        protected void btn_edit_Click(object sender, EventArgs e)
        {
            Button btn_edit = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn_edit.NamingContainer;
            HiddenField hfEventID = (HiddenField)item.FindControl("hfEventID");
            HiddenField hfOrganizationID = (HiddenField)item.FindControl("hfOrganizationID");

            if (hfEventID != null)
            {
                string eventID = hfEventID.Value;
                Response.Redirect($"~/admin/event-update.aspx?eventID={eventID}&organizationID={hfOrganizationID.Value}");
            }

        }

        protected void btn_ViewEvent_Click(object sender, EventArgs e)
        {
           Button btn_ViewEvent = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn_ViewEvent.NamingContainer;
            HiddenField hfEventID = (HiddenField)item.FindControl("hfEventID");
            HiddenField hfOrganizationID = (HiddenField)item.FindControl("hfOrganizationID");

            if (hfEventID != null)
            {
                string eventID = hfEventID.Value;
                Response.Redirect($"~/admin/event-view.aspx?eventID={eventID}&organizationID={hfOrganizationID.Value}");
            }
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            //Action item 
            Button btn_delete =  (Button)sender;
            RepeaterItem item = (RepeaterItem)btn_delete.NamingContainer;
            HiddenField hfEventID = (HiddenField)item.FindControl("hfEventID");
            HiddenField hfOrganizationID = (HiddenField)item.FindControl("hfOrganizationID");

            string eventID = hfEventID.Value;
            string organizationID = hfOrganizationID.Value;

            // event , event_venue , ticket , order_item, cust_order
            try
            {
                model.@event crnt_event = event_DA.retrieveEventByEventId(int.Parse(eventID));
                model.event_venue crnt_eventVenue = event_venue_DA.getEventVenueByEventID(int.Parse(eventID));
                List<model.ticket> ticketList = ticket_DA.retriveTicketInfoByEventID(int.Parse(eventID));

                List<int> ticketIDs = ticket_DA.retriveTicketInfoByEventID(int.Parse(eventID)).Select(x => x.id).ToList();
                List<model.order_item> orderItemList = order_item_DA.retrieveOrderItemsByTicketIDs(ticketIDs);
                List<model.cust_order> custOrders = cust_order_DA.getCustOrderByOrderItems(orderItemList);

                string modalHeader = "Delete Confirmation";
                string msgHeaderPrompter = "<strong>Are You Sure You Want To Delete The Event ?</strong><br />";
                msgHeaderPrompter += $"'{crnt_event.name}'<br /> Held on {crnt_event.start_date.ToString("dd-MM-yyyy")} until {crnt_event.end_date.ToString("dd-MM-yyyy")}";
                getDeleteModalPrompterUp(modalHeader, msgHeaderPrompter, true);

                //Setting Value 
                Session["selectedEventID"] = crnt_event.id;
                Session["selectedOrganizationID"] = organizationID;

            }
            catch (Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }

        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            // Access values from hidden fields

            if (Session["selectedEventID"] != null && Session["selectedOrganizationID"] != null)
            {
                ViewState["eventModal_confirmation"] = false;

                int eventID = int.Parse(Session["selectedEventID"].ToString());
                int organizationID = int.Parse(Session["selectedOrganizationID"].ToString());

                Session.Remove("selectedEventID");
                Session.Remove("selectedOrganizationID");

                try
                {
                    model.@event crnt_event = event_DA.retrieveEventByEventId(int.Parse(eventID.ToString()));
                    model.event_venue crnt_eventVenue = event_venue_DA.getEventVenueByEventID(int.Parse(eventID.ToString()));
                    List<model.ticket> ticketList = ticket_DA.retriveTicketInfoByEventID(int.Parse(eventID.ToString()));

                    //Fetching each Ticket ID
                    List<int> ticketIDs = ticket_DA.retriveTicketInfoByEventID(int.Parse(eventID.ToString())).Select(x => x.id).ToList();

                    List<model.order_item> orderItemList = order_item_DA.retrieveOrderItemsByTicketIDs(ticketIDs);
                    List<model.cust_order> custOrders = cust_order_DA.getCustOrderByOrderItems(orderItemList);

                    //Change All Status become 0 - soft delete
                    bool eventVenueSuccess = event_venue_DA.softDeleteEventVenueStatus(crnt_eventVenue.id);
                    bool orderItemSuccess = order_item_DA.softDeleteOrderItemStatus(orderItemList);
                    bool ticketListSuccess = ticket_DA.softDeleteTickets(ticketIDs);

                    bool eventSuccess = event_DA.softDeleteEvent(crnt_event.id);
                    bool custOrdersSuccess = cust_order_DA.softDeleteCustOrder(orderItemList);

                    if(eventVenueSuccess && ticketListSuccess && eventSuccess)
                    {
                        string msgDetais = $"You had Deleted {crnt_event.name} on {DateTime.Now}";
                        getSuccessModalPrompterUp("Operation Completed Succesfully", msgDetais, true);
                    }
                    else
                    {
                        string msgDetais = $"Please Contact to Support Service to Proceed.";
                        getSuccessModalPrompterUp("Operation Denied", msgDetais, true);
                    }


                }
                catch(Exception ex)
                {
                    Response.Redirect("../error-page.aspx");
                }

            }
           
        }

        protected void successConfirmationBtn_Click(object sender, EventArgs e)
        {
            ViewState["success_eventModal_confirmation"] = false;

            Response.Redirect("~/admin/event-index.aspx");
        }

        public void getDeleteModalPrompterUp(string header, string message, bool modalConfirmationUp)
        {
            ViewState["eventModal_header"] = header;
            ViewState["eventModal_promtperMsg"] = message;
            ViewState["eventModal_confirmation"] = true;
        }

        public void getSuccessModalPrompterUp(string header, string message, bool modalConfirmationUp)
        {
            ViewState["success_eventModal_header"] = header;
            ViewState["success_eventModal_promtperMsg"] = message;
            ViewState["success_eventModal_confirmation"] = true;
        }
    }
}