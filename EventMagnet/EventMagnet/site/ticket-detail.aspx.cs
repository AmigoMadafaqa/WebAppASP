using Checkout.Payments;
using EventMagnet.controller;
using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Linq.Expressions;
using System.Security.Cryptography;
using System.Security.Cryptography.Xml;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace EventMagnet.site
{
    public partial class ticket_details : System.Web.UI.Page
    {
        eventDA event_DA = new eventDA();
        event_venueDA event_venue_DA = new event_venueDA();
        ticketDA ticket_DA = new ticketDA();
        order_itemDA order_item_DA = new order_itemDA();
        cust_orderDA cust_order_DA = new cust_orderDA();
        venueDA venue_DA = new venueDA();

        int eventID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                load_event();
            }
            else
            {
                renderTicketSection();
            }
        }

        public void load_event()
        {
            if (Request.QueryString["eventID"] != null)
            {
                eventID = int.Parse(Request.QueryString["eventID"].ToString());
                int remainTicket = int.Parse(Request.QueryString["ticketRemain"].ToString());

                try
                {
                    @event event_curr = event_DA.retrieveEventByEventId(eventID);
                    event_venue eventVenue_curr = event_venue_DA.getEventVenueByEventID(eventID);
                    venue venue_curr = venue_DA.GetVenueByEventId(eventID);
                    List<ticket> ticketList = ticket_DA.retriveTicketInfoByEventID(eventID);

                    ViewState["img_src"] = event_curr.img_src;
                    eventNametxt.Text = event_curr.name;
                    ticketRemainTxt.Text = remainTicket + " Tickets still available";
                    eventDescriptionTxt.Text = event_curr.descp;

                    dateTimeTxt.Text = $"{event_curr.start_date.ToString("dddd, MMM-yyyy")} on {event_curr.start_time.ToString(@"hh\:mm")} to {event_curr.end_date.ToString("dddd, MMM-yyyy")} on {event_curr.end_time.ToString(@"hh\:mm")}";


                    locationTxt.Text = venue_curr.name + " , " + venue_curr.address;

                    Session["ticketList"] = ticketList;
                    renderTicketSection();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }
        }
        public void renderTicketSection()
        {
            quantityticketContent.Controls.Clear();
            List<ticket> ticketList = (List<ticket>)Session["ticketList"];

            for (int i = 0; i < ticketList.Count; i++)
            {
                int counter = 1 + i;

                string ticketIDTxt_ID = "ticketIDTxt_" + counter.ToString();
                string ticketNameTxt_ID = "ticketNameTxt_" + counter.ToString();
                string priceTxt_ID = "priceTxt_" + counter.ToString();

                string btnMinus_ID = "btnMinus_" + counter.ToString();
                string txtQuantity_ID = "txtQuantity_" + counter.ToString();
                string btnPlus_ID = "btnPlus_" + counter.ToString();

                Literal ticketID_literal = new Literal();
                ticketID_literal.ID = ticketIDTxt_ID;
                ticketID_literal.Visible = false;
                ticketID_literal.Text = ticketList[i].id.ToString();

                Literal ticketName_literal = new Literal();
                ticketName_literal.ID = ticketNameTxt_ID;
                ticketName_literal.Text = ticketList[i].name;

                Literal price_literal = new Literal();
                price_literal.ID = priceTxt_ID;
                price_literal.Text = ticketList[i].price.ToString();

                Button btnMinus_button = new Button();
                btnMinus_button.ID = btnMinus_ID;
                btnMinus_button.CssClass = "minus";
                btnMinus_button.Text = "-";
                btnMinus_button.UseSubmitBehavior = false;
                btnMinus_button.CommandName = txtQuantity_ID;
                btnMinus_button.Command += new CommandEventHandler(this.btnMinus_Click);

                Button btnPlus_button = new Button();
                btnPlus_button.ID = btnPlus_ID;
                btnPlus_button.CssClass = "plus";
                btnPlus_button.Text = "+";
                btnPlus_button.UseSubmitBehavior = false;
                btnPlus_button.CommandName = txtQuantity_ID;
                btnPlus_button.Command += new CommandEventHandler(this.btnPlus_Click);

                TextBox txtQuantity_button = new TextBox();
                txtQuantity_button.ID = txtQuantity_ID;
                txtQuantity_button.Text = "0";
                txtQuantity_button.CssClass = "input-text qty text";
                txtQuantity_button.Columns = 4;
                txtQuantity_button.Attributes["pattern"] = "[0-9]+";
                txtQuantity_button.Attributes["inputmode"] = "numeric";
                txtQuantity_button.AutoPostBack = true;

                quantityticketContent.Controls.Add(new LiteralControl(@"<div class=""col-md-6"">
            <div class=""left-content"">"));
                quantityticketContent.Controls.Add(ticketID_literal);
                quantityticketContent.Controls.Add(new LiteralControl(@"<h6>"));
                quantityticketContent.Controls.Add(ticketName_literal);
                quantityticketContent.Controls.Add(new LiteralControl(@" Ticket</h6>
                <p id=""ticketPrice"">RM "));
                quantityticketContent.Controls.Add(price_literal);
                quantityticketContent.Controls.Add(new LiteralControl(@" per ticket</p>
            </div>
        </div>
        <div class=""col-md-5"">
            <div class=""right-content"">
                <div class=""quantity buttons_added"">"));
                quantityticketContent.Controls.Add(btnMinus_button);
                quantityticketContent.Controls.Add(txtQuantity_button);
                quantityticketContent.Controls.Add(btnPlus_button);
                quantityticketContent.Controls.Add(new LiteralControl(@"</div>
            </div>
        </div>"));
            }
        }

        protected void btnMinus_Click(object sender, CommandEventArgs e)
        {
            TextBox totalQuantity = (TextBox)quantityticketContent.FindControl(e.CommandName);
            int itemQty = int.Parse(totalQuantity.Text);

            //debugMsg.Text = "Total Quantity : " + totalQuantity.ID + ", Text : " + totalQuantity.Text;
            

            if (itemQty > 0)
            {
                totalQuantity.Text = (itemQty - 1).ToString();
            }
            UpdateTotalAmount();

        }

        protected void btnPlus_Click(object sender, CommandEventArgs e)
        {
            TextBox totalQuantity = (TextBox)quantityticketContent.FindControl(e.CommandName);
            totalQuantity.Text = (int.Parse(totalQuantity.Text) + 1).ToString();

            //debugMsg.Text = "Total Quantity : " + totalQuantity.ID + ", Text : " + totalQuantity.Text;

            UpdateTotalAmount();

        }

        public List<Dictionary<ticket, int>> getAllSectionValue()
        {
            List<Dictionary<ticket, int>> newMapList = new List<Dictionary<ticket, int>>();
            List<ticket> temp_ticket = (List<ticket>)Session["ticketList"];

            for (int i = 0; i < temp_ticket.Count; i++)
            {
                int counter = 1 + i;

                string ticketIDTxt_ID = "ticketIDTxt_" + counter.ToString();
                string txtQuantity_ID = "txtQuantity_" + counter.ToString();

                Literal ticketID_literal = (Literal)quantityticketContent.FindControl(ticketIDTxt_ID);
                TextBox totalQuanity_txtBox = (TextBox)quantityticketContent.FindControl(txtQuantity_ID);

                if (ticketID_literal != null && totalQuanity_txtBox != null)
                {
                    ticket temp_ticket_model = new ticket();
                    int totalQuantity_Event = int.Parse(totalQuanity_txtBox.Text);

                    if (totalQuantity_Event > 0)
                    {
                        temp_ticket_model = temp_ticket[i];

                        Dictionary<ticket, int> ticketMap = new Dictionary<ticket, int>();
                        ticketMap.Add(temp_ticket_model, totalQuantity_Event);

                        newMapList.Add(ticketMap);
                    }
                }
            }

            return newMapList;
        }


        protected void UpdateTotalAmount()
        {
            List<Dictionary<ticket, int>> ticketQuantities = getAllSectionValue();

            decimal totalAmount = 0;

            foreach (var ticketMap in ticketQuantities)
            {
                foreach (var kvp in ticketMap)
                {
                    ticket currentTicket = kvp.Key;
                    int quantity = kvp.Value;
                    totalAmount += currentTicket.price * quantity;
                }
            }

            litTotalAmount.Text = string.Format("RM {0:N2}", totalAmount);
        }

        protected void btnPurchaseTickets_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (Request.QueryString["eventID"] != null)
                {
                    eventID = int.Parse(Request.QueryString["eventID"].ToString());
                }

                List<Dictionary<ticket, int>> ticketQuantities = getAllSectionValue();
                Dictionary<ticket, int> ticketMap_val = new Dictionary<ticket, int>();
                foreach (var ticketMap in ticketQuantities)
                {
                    
                    foreach (var kvp in ticketMap)
                    {
                        if (Session["ticketDetail_ticketMap"] != null)
                        {
                            getPrompterModalUp("Are You Sure To Purchase Ticket", "This will replace the previous records in the carts", true);
                            return;
                        }

                        ticket currentTicket = kvp.Key;
                        int quantity = kvp.Value;
                            
                        ticketMap_val.Add(currentTicket, quantity);
                        
                    }
                }
                Session["ticketDetail_ticketMap"] = ticketMap_val;

                @event evenrItem = event_DA.retrieveEventByEventId(eventID);
                Session["ticketDetail_event"] = evenrItem;

                Response.Redirect("checkout.aspx");

                //Response.Redirect("checkout.aspx");
            }
        }

        public void getPrompterModalUp(string header, string msg, bool confirmation)
        {
            ViewState["eventModal_header"] = header;
            ViewState["eventModal_promtperMsg"] = msg;
            ViewState["eventModal_confirmation"] = confirmation;
        }

        protected void createSession_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (Request.QueryString["eventID"] != null)
                {
                    eventID = int.Parse(Request.QueryString["eventID"].ToString());
                }

                List<Dictionary<ticket, int>> ticketQuantities = getAllSectionValue();
                Dictionary<ticket, int> ticketMap_val = new Dictionary<ticket, int>();
                foreach (var ticketMap in ticketQuantities)
                {

                    foreach (var kvp in ticketMap)
                    {
                        ticket currentTicket = kvp.Key;
                        int quantity = kvp.Value;

                        ticketMap_val.Add(currentTicket, quantity);

                    }
                }
                Session["ticketDetail_ticketMap"] = ticketMap_val;

                @event evenrItem = event_DA.retrieveEventByEventId(eventID);
                Session["ticketDetail_event"] = evenrItem;

                Response.Redirect("checkout.aspx");

            }
        }
    }
}