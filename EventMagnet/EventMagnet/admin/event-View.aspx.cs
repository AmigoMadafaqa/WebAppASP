using Checkout.Workflows.Conditions.Request;
using model = EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using EventMagnet.controller;
using EventMagnet.modal;

namespace EventMagnet.zDEl_admin
{
    public partial class event_view : System.Web.UI.Page
    {
        //VStudio Provided 
        model.EventMagnetEntities db = new model.EventMagnetEntities();
        //custome data access 
        ticketDA ticket_DA = new ticketDA();
        eventDA event_DA = new eventDA();
        event_venueDA event_venue_DA = new event_venueDA();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["eventID"] != null)
                {
                    string eventID = Request.QueryString["eventID"];

                    try
                    {
                        if (int.TryParse(eventID, out int eventId))
                        {
                            model.event_venue temp_EV = event_venue_DA.getEventVenueByEventID(eventId);
                            //Query to Fetch Record
                            IQueryable<model.@event> eventQuery = db.events.AsQueryable().Where(x => x.id == eventId && x.status == 1);
                            IQueryable<model.ticket> ticketQuery = db.tickets.AsQueryable().Where(x => x.event_id == eventId && x.status == 1);
                            IQueryable<model.venue> venueQuery = db.venues.AsQueryable().Where(x => x.id == temp_EV.venue_id && x.status == 1);

                            //Retrieved Value
                            var r_Event = eventQuery.FirstOrDefault();
                            List<model.ticket> ticketList = ticketQuery.ToList();
                            var r_Venue = venueQuery.FirstOrDefault();

                            if (r_Event != null)
                            {
                                //fetching organization information
                                int organizationID = r_Event.organization_id;
                                IQueryable<model.organization> organizationQuery = db.organizations.AsQueryable().Where(x => x.id == organizationID);
                                var r_organization = organizationQuery.FirstOrDefault();

                                //Display Value On Web 
                                //Images
                                ViewState["imgSource"] = r_Event.img_src;
                                lbleventName.Text = r_Event.name;
                                lblEventDescription.Text = r_Event.descp;
                                lblOrganizationName.Text = r_organization.name;
                                lblVenue.Text = r_Venue.name;

                                txtStartDate.Text = r_Event.start_date.ToString("dd-MM-yyyy");
                                txtEndDate.Text = r_Event.end_date.ToString("dd-MM-yyyy");

                                txtstartTime.Text = DateTime.Today.Add(r_Event.start_time).ToString("h:mm tt");
                                txtEndTime.Text = DateTime.Today.Add(r_Event.end_time).ToString("h:mm tt");

                                txtTicketStartDate.Text = r_Event.ticket_sale_start_datetime.ToString("dd-MM-yyyy hh:mm tt");
                                txtTicketEndDate.Text = r_Event.ticket_sale_end_datetime.ToString("dd-MM-yyyy hh:mm tt");


                                //Ticket information Section
                                Session["ticketList"] = ticketList;

                                remainQty.Text = calculateRemainingTicketForEvent(eventId).ToString();

                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("../error-page.aspx");
                    }
                }
            }
        }

        public int calculateRemainingTicketForEvent(int eventID)
        {
            int remainingTickets = 0;
            if (eventID > 0)
            {
                using (EventMagnetEntities db = new EventMagnetEntities())
                {
                    try
                    {
                        var totalAvailableTickets = db.tickets.Where(x => x.event_id == eventID).Sum(x => x.total_qty);
                        var totalSoldTickets = db.order_item.Where(t => t.ticket.event_id == eventID).Count();

                        remainingTickets = totalAvailableTickets - totalSoldTickets;
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("../error-page.aspx");
                    }
                }
            }

            return remainingTickets;
        }

        public int calculateTotalSoldInEachTicket(int ticketId)
        {
            int totalSoldTickets = 0;

            if (ticketId > 0)
            {
                using (EventMagnetEntities db = new EventMagnetEntities())
                {
                    try
                    {
                        totalSoldTickets = db.order_item.Count(item => item.ticket_id == ticketId);
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("../error-page.aspx");

                    }
                }
            }
            return totalSoldTickets;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Session.Remove("ticketList");
            Response.Redirect("~/admin/event-index.aspx");
        }
    }
}