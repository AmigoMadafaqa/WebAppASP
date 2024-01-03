using EventMagnet.modal;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.site
{
    public partial class checkout : System.Web.UI.Page
    {
        private Dictionary<ticket, int> ticketMap = new Dictionary<ticket, int>();
        private @event eventItem = new @event();
        public void Page_Init(object sender, EventArgs e)
        {

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (!Page.IsPostBack)
            //{
            //    testData();
            //}

            if (Session["ticketDetail_ticketMap"] != null && Session["ticketDetail_event"] != null)
            {
                Session["checkout_ticketMap"] = (Dictionary<ticket, int>)Session["ticketDetail_ticketMap"];
                Session["checkout_event"] = (@event)Session["ticketDetail_event"];

                if (Session["checkout_ticketMap"] != null && Session["checkout_event"] != null)
                {
                    renderContainer();
                }
                else
                {
                    // prompt cart empty message and selec ticket message

                }
            }

        }

        void renderContainer() 
        {
            ticketMap = (Dictionary<ticket, int>)Session["checkout_ticketMap"];
            eventItem = (@event)Session["checkout_event"];

            renderCheckoutSection();
            renderSubPriceSection();
        }

        protected void renderCheckoutSection()
        {
            checkoutSection.Controls.Clear();
            int i = -1;
            int ticketTypeQty = 0;
            foreach (KeyValuePair<ticket, int> ticketItem in ticketMap)
            {
                i++;
                if (ticketItem.Value == 0) { continue; }
                
                string btnAddID = "btnAdd_" + i.ToString();
                string btnMinusID = "btnMinus_" + i.ToString();
                string btnDelID = "btnDelete_" + i.ToString();
                string lblQtyID = "lblQty_" + i.ToString();


                Button btnMinus = new Button();
                btnMinus.ID = btnMinusID;
                btnMinus.Text = "-";
                btnMinus.CssClass = "btn-add-minus";
                btnMinus.UseSubmitBehavior = false;
                btnMinus.CommandName = lblQtyID;
                btnMinus.CommandArgument = i.ToString();
                btnMinus.Command += new CommandEventHandler(this.btnMinus_Click);
                btnMinus.Attributes.Add("runat", "server");


                Button btnAdd = new Button();
                btnAdd.ID = btnAddID;
                btnAdd.Text = "+";
                btnAdd.CssClass = "btn-add-minus";
                btnAdd.UseSubmitBehavior = false;
                btnAdd.CommandName = lblQtyID;
                btnAdd.CommandArgument = i.ToString();
                btnAdd.Command += new CommandEventHandler(this.btnAdd_Click);
                btnAdd.Attributes.Add("runat", "server");

                Button btnDel = new Button();
                btnDel.ID = btnDelID;
                btnDel.Text = "X";
                btnDel.CssClass = "btn-add-minus";
                btnDel.UseSubmitBehavior = true;
                btnDel.CommandArgument = i.ToString();
                btnDel.Command += new CommandEventHandler(this.btnDel_Click);
                btnDel.Attributes.Add("runat", "server");
                btnDel.OnClientClick = "return confirm('Are You Sure To Delete This Ticket ?');";


                Label lblQty = new Label();
                lblQty.ID = lblQtyID;
                lblQty.Text = ticketItem.Value.ToString();


                checkoutSection.Controls.Add(new LiteralControl(
                @"
                    <div class=""row border-top border-bottom"">
                        <div class=""row main align-items-center"">
                            <div class=""col-2"">
                                <img class=""img-fluid"" src=""images/events/"+ eventItem.img_src +@""">
                            </div>
                            <div class=""col"">
                                <div class=""row text-muted"">" + eventItem.name + @"</div>
                                <div class=""row"">" + ticketItem.Key.name + @" Ticket</div>
                            </div>
                            <div class=""col"" style=""text-align: center;"">
                "));

                checkoutSection.Controls.Add(btnMinus);
                checkoutSection.Controls.Add(lblQty);
                checkoutSection.Controls.Add(btnAdd);


                checkoutSection.Controls.Add(new LiteralControl(
                    @"
                                </div>
                                <div class=""col"" style=""display:flex;justify-content:space-between;"">RM " + ticketItem.Key.price.ToString("0.00") + @" "
));

                checkoutSection.Controls.Add(btnDel);


                // <span class=""close"">&#10005;</span>
                checkoutSection.Controls.Add(new LiteralControl(@"</div>
                            </div>
                        </div>
                    "));

                ticketTypeQty++;               
            }

            ltlTicketTypeQty.Text = ticketTypeQty.ToString();

            if (ticketTypeQty <= 0) {
                checkoutSection.Controls.Add(new LiteralControl(
                @"
                    <div class=""row border-top border-bottom"">
                        <div class=""row main align-items-center"">
                            There are no items in the checkout. Go to our <a href=""event-show.aspx""><b>Event Page</b></a> to choose your ticket                            
                        </div>
                    </div>
                "));
            }
        }

        protected void renderSubPriceSection()
        {
            float totalPrice = 0f;
            float subPrice = 0f;

            subPriceSection.Controls.Clear();


            foreach (KeyValuePair<ticket, int> ticketItem in ticketMap)
            {
                if (ticketItem.Value == 0) { continue; }

                subPrice = (float)(ticketItem.Key.price * ticketItem.Value);
                totalPrice += subPrice;

                subPriceSection.Controls.Add(new LiteralControl(
                    @"
                    <div class=""row"">
                        <div class=""col"" style=""padding-left: 0;"">" + ticketItem.Key.name + @" Ticket</div>
                        <div class=""col text-right"">RM " + subPrice.ToString() + @"</div>
                    </div>
                    "));
            }

            subPriceSection.Controls.Add(new LiteralControl(
                    @"
                    <div class=""row"" style=""margin-top:20px"">
                        <div class=""col"" style=""padding-left: 0;"">Ticket Price</div>
                        <div class=""col text-right"">RM " + totalPrice.ToString() + @"</div>
                    </div>
                    "));

            Session["checkout_totalPrice"] = totalPrice;

        }


        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            string data = "";
            ticketMap = (Dictionary<ticket, int>)Session["checkout_ticketMap"];
            ticket tempTicket = ticketMap.ElementAt(0).Key;

            data += ticketMap[tempTicket].ToString() + "<br/>";

            foreach (KeyValuePair<ticket, int> ticketItem in ticketMap)
            {
                data += ticketItem.Key.name + " : " + ticketItem.Value.ToString() + "<br/>";
            }


            //Session["payment_ticketMap"] = Session["checkout_ticketMap"];
            //Session["payment_event"] = eventItem;


            if (Session["ticketDetail_ticketMap"] != null){
                Response.Redirect("payment.aspx"); 
            }

        }

        protected void btnAdd_Click(object sender, CommandEventArgs e)
        {
            Label lblQty = (Label)checkoutSection.FindControl(e.CommandName);
            lblQty.Text = (int.Parse(lblQty.Text) + 1).ToString();

            int index = Convert.ToInt32(e.CommandArgument);

            ticket tempTicket = ticketMap.ElementAt(index).Key;

            ticketMap[tempTicket] = int.Parse(lblQty.Text);


            Session["checkout_ticketMap"] = ticketMap;
            //renderSubPriceSection();

            renderContainer();
        }

        protected void btnMinus_Click(object sender, CommandEventArgs e)
        {
            Label lblQty = (Label)checkoutSection.FindControl(e.CommandName);
            int itemQty = int.Parse(lblQty.Text);

            if (itemQty <= 1)
            {
                Session["checkout_ticketMap"] = ticketMap;
                return;
            }

            lblQty.Text = (itemQty - 1).ToString();


            int index = Convert.ToInt32(e.CommandArgument);

            ticket tempTicket = ticketMap.ElementAt(index).Key;
            ticketMap[tempTicket] = int.Parse(lblQty.Text);

            Session["checkout_ticketMap"] = ticketMap;
            //renderSubPriceSection();

            renderContainer();

        }

        protected void btnDel_Click(object sender, CommandEventArgs e)
        {
            // prompt confirmation message



        
            int index = Convert.ToInt32(e.CommandArgument);

            ticket tempTicket = ticketMap.ElementAt(index).Key;

            ticketMap[tempTicket] = 0;

            Session["checkout_ticketMap"] = ticketMap;

            int ticketCount = 0;
            foreach (var kvp in ticketMap)
            {
                ticketCount += kvp.Value;
            }

            if (ticketCount == 0)
            {
                Session.Remove("ticketDetail_ticketMap");
            }

            //renderSubPriceSection();

            renderContainer();
        }


        void testData()
        {

            EventMagnetEntities db = new EventMagnetEntities();

            int[] qty = new int[3] { 3, 0, 5 };

            Dictionary<ticket, int> _ticketMap = new Dictionary<ticket, int>();

            IQueryable<ticket> ticketDB = (IQueryable<ticket>)db.tickets.AsQueryable()
                                 .Where(x => x.event_id == 1);
            int i = 0;
            foreach (ticket ticketItem in ticketDB)
            {
                _ticketMap.Add(ticketItem, qty[i]);
                i++;
            }


            Session["checkout_ticketMap"] = _ticketMap;


            @event _eventItem = new @event();

            IQueryable<@event> eventDB = (IQueryable<@event>)db.events.AsQueryable()
                                 .Where(x => x.id == 1);
            foreach (@event evt in eventDB)
            {
                _eventItem = evt;
            }

            Session["checkout_event"] = _eventItem;

        }


    }
}