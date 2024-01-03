using EventMagnet.controller;
using Newtonsoft.Json;

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.Remoting.Messaging;

using EventMagnet.modal;
using System.Data.SqlClient;

using Stripe;
using Stripe.Checkout;
using System.Configuration;
using static System.Text.Json.JsonElement;
using System.Text.Json;
using System.Threading.Tasks;

namespace EventMagnet.site
{
    public partial class payment : System.Web.UI.Page
    {
        private Dictionary<ticket, int> ticketMap = new Dictionary<ticket, int>();
        private @event eventItem = new @event();
        //private Dictionary<string, float> paymentFeeDict = new Dictionary<string, float>();

        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {            
            //paymentFeeDict.Add("F", 1f);
            //paymentFeeDict.Add("B", 1.1f);
            //paymentFeeDict.Add("C", 1.2f); // 4% + RM1
            //paymentFeeDict.Add("P", 0f);
            //paymentFeeDict.Add("T", 0f);
            

            if (Session["checkout_ticketMap"] != null && Session["checkout_event"] != null)
            {
                ticketMap = (Dictionary<ticket, int>)Session["checkout_ticketMap"];
                eventItem = (@event)Session["checkout_event"];
                renderPaymentSection();


                ltlTicketPrice.Text = ((float) Session["checkout_totalPrice"]).ToString("0.00");
                updateProcessingFee();
                updateTotalPrice();
            }
            else
            {
                // prompt cart empty message and selec ticket message

            }
           
        }

        float paymentFeeCalculation(string paymentCode, float price)
        {
            float processingFee = 0f;

            switch (paymentCode)
            {
                case "F":
                    processingFee = 1f;
                    break;
                case "B":
                    processingFee = 1.2f;
                    break;
                case "C":
                    processingFee = (float)Math.Round(((double)price * 0.04) + 1, 2);
                    break;
                case "P":
                    processingFee = 0f;
                    break;
                case "T":
                    processingFee = 0f;
                    break;
                default:
                    break;

            }
            return processingFee;
        }

        protected void renderPaymentSection()
        {
            paymentSection.Controls.Clear();
            int i = -1;
            int ticketTypeQty = 0;
            foreach (KeyValuePair<ticket, int> ticketItem in ticketMap)
            {
                i++;
                if (ticketItem.Value == 0) { continue; }

                string lblQtyID = "lblQty_" + i.ToString();

                Label lblQty = new Label();
                lblQty.ID = lblQtyID;
                lblQty.Text = ticketItem.Value.ToString();


                paymentSection.Controls.Add(new LiteralControl(
                @"
                    <div class=""row border-top border-bottom"">
                        <div class=""row main align-items-center"">
                            <div class=""col-2"">
                                <img class=""img-fluid"" src=""images/events/" + eventItem.img_src +@""">
                            </div>
                            <div class=""col"">
                                <div class=""row text-muted"">" + eventItem.name + @"</div>
                                <div class=""row"">" + ticketItem.Key.name + @" Ticket</div>
                            </div>
                            <div class=""col"" style=""text-align: center;"">
                "));

                paymentSection.Controls.Add(lblQty);


                paymentSection.Controls.Add(new LiteralControl(
                    @"
                                </div>
                                <div class=""col"">RM " + ticketItem.Key.price.ToString("0.00") + @"</div>
                            </div>
                        </div>"
                ));

                ticketTypeQty++;

            }

            ltlTicketTypeQty.Text = ticketTypeQty.ToString();
        }


        void updateProcessingFee() 
        {
            ltlProcessingFee.Text = paymentFeeCalculation(ddlPaymentMethod.SelectedItem.Value, float.Parse(ltlTicketPrice.Text)).ToString("0.00");
        }

        void updateTotalPrice()
        {
            try {
                float ticketPayment = float.Parse(ltlTicketPrice.Text);

                if (ticketPayment > 0)
                {
                    float processingFee = float.Parse(ltlProcessingFee.Text);
                    ltlTotalPrice.Text = (ticketPayment + processingFee).ToString("0.00");
                }
                else
                {
                    ltlTotalPrice.Text = "0.00";
                }

            }
            catch (Exception)
            {
                ltlTotalPrice.Text = "0.00";
            }
        }

        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            updateProcessingFee();
            updateTotalPrice();
        }


        protected async void btnConfirm_Click(object sender, EventArgs e)
        {
            float totalPrice = 0f;
            try {
                totalPrice = float.Parse(ltlTotalPrice.Text);
            }catch (Exception) { }

            if (totalPrice <= 0f) 
            { 
                // prompt error message
                return; 
            }

            int custOrderId = createOrder(ddlPaymentMethod.SelectedItem.Value, paymentFeeCalculation(ddlPaymentMethod.SelectedItem.Value, float.Parse(ltlTicketPrice.Text)));

            if (custOrderId == -1)
            {
                // ticket quantity is exceeded
                lblTicketError.Text = getError(ticketErrorList);
                ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(),
                      "showTicketErrorMsg();", true);
                testtest.Text = "asd -" + getError(ticketErrorList);
                return;
            }


            Guid custOrderUUID = getCustOrderUUID(custOrderId);
            customer cust = (customer)Session["cust"];
            organization org = controller.Account.GetOrgInfo(((@event)Session["checkout_event"]).organization_id);

            switch (ddlPaymentMethod.SelectedItem.Value)
            {
                case "F":
                    string billUrlToyyibPay = await paymentFPXToyyibPay(totalPrice, org.collection_id_toyyibpay, custOrderUUID);
                    Response.Redirect(billUrlToyyibPay, false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                case "B":
                    string billUrlBillplz = paymentFPXBillplz("Ticket Payment", totalPrice, cust.name, cust.phone, cust.email, org.collection_id_billplz, custOrderUUID);
                    testtest.Text = billUrlBillplz;
                    Response.Redirect(billUrlBillplz, false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                case "C":
                    string billUrlStripe = paymentStrip("Bill-" + custOrderUUID.ToString() + "-Ticket Payment", totalPrice, custOrderUUID);
                    Response.Redirect(billUrlStripe, false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                case "P":
                    Session["paymentAmount"] = totalPrice;
                    Session["custOrderUUID"] = custOrderUUID;
                    Response.Redirect("payment-paypal.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                case "T":
                    Session["paymentAmount"] = totalPrice;
                    Session["custOrderUUID"] = custOrderUUID;
                    Response.Redirect("payment-tng.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                default:
                    break;
            }            
        }


        List<TicketError> ticketErrorList = new List<TicketError>();

        protected int createOrder(string paymentMethod, float paymentFee)
        {
            customer cust = (customer)Session["cust"];
            @event eventItem = (@event)Session["checkout_event"];

            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // check if the ticket is available in quantity
            string query = @"
                SELECT t.id, t.name, t.total_qty, COUNT(oi.id) AS used_qty
                FROM cust_order co 
	                LEFT JOIN order_item oi ON co.id = oi.cust_order_id
	                LEFT JOIN ticket t ON oi.ticket_id = t.id
	                LEFT JOIN event e ON t.event_id = e.id
                WHERE co.status = 1
	                AND oi.status = 1
	                AND t.status = 1
	                AND e.status = 1
	                AND e.id = @eventId
                GROUP BY t.id, t.name, t.total_qty
            ";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@eventId", eventItem.id);
            SqlDataReader dr = cmd.ExecuteReader();

            bool isTicketExist = false;
            int ticketId = 0;
            int total_qty = 0;
            int used_qty = 0;
            ticketErrorList = new List<TicketError>();

            while (dr.Read()) { 
                isTicketExist = true;
                ticketId = Convert.ToInt32(dr["id"]);
                total_qty = Convert.ToInt32(dr["total_qty"]);
                used_qty = Convert.ToInt32(dr["used_qty"]);

                foreach (KeyValuePair<ticket, int> ticketItem in ticketMap)
                {
                    if (ticketItem.Key.id == ticketId)
                    {
                        int difference = total_qty - used_qty - ticketItem.Value;

                        if (difference < 0) { 
                            // means ticket quantity is not enough
                            TicketError error = new TicketError();
                            error.id = ticketId;
                            error.name = ticketItem.Key.name;
                            error.qty_left = ticketItem.Value - Math.Abs(difference);

                            ticketErrorList.Add(error);
                        }
                        break;
                    }
                    
                }

            }
            dr.Close();

            if (ticketErrorList.Count > 0 || !isTicketExist) {
                // means the ticket quantity is not enough
                return -1;
            }


            // insert payment method record
            query = "insert into customer_payment (payment_method, payment_fee) output INSERTED.ID values (@paymentMethod, @paymentFee)";
            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@paymentMethod", paymentMethod);
            cmd.Parameters.AddWithValue("@paymentFee", paymentFee);

            int paymentId = (int) cmd.ExecuteScalar();
            


            // insert customer order record
            Guid orderUUID = Guid.NewGuid();

            query = "insert into cust_order (uuid, status, customer_id, customer_payment_id) output INSERTED.ID values (@uuid, 2, @customerId, @paymentId)";
            cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", orderUUID);
            cmd.Parameters.AddWithValue("@customerId", cust.id);
            cmd.Parameters.AddWithValue("@paymentId", paymentId);

            int custOrderId = (int)cmd.ExecuteScalar();


            // insert order item record
            query = "insert into order_item (uuid, status, cust_order_id, ticket_id) output INSERTED.ID values (@uuid, 1, @custOrderId, @ticketId)";

            foreach (KeyValuePair<ticket, int> ticketItem in ticketMap)
            {
                //if (ticketItem.Value == 0) { continue; }

                for (int i = 0; i < ticketItem.Value; i++) 
                { 
                    Guid orderItemUUID = Guid.NewGuid();
                    cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@uuid", orderItemUUID);
                    cmd.Parameters.AddWithValue("@custOrderId", custOrderId);
                    cmd.Parameters.AddWithValue("@ticketId", ticketItem.Key.id);

                    cmd.ExecuteNonQuery();
                }
            }

            con.Close();
            testtest.Text = custOrderId.ToString();
            return custOrderId;            
        }

        Guid getCustOrderUUID(int custOrderId) 
        {
            EventMagnetEntities db = new EventMagnetEntities();

            IQueryable<cust_order> custOrderDB = (IQueryable<cust_order>)db.cust_order.AsQueryable()
                                 .Where(x => x.id == custOrderId);

            Guid custOrderUUID = new Guid();

            foreach (cust_order custOrder in custOrderDB)
            {
                custOrderUUID = custOrder.uuid;
                break;
            }
            return custOrderUUID;
        }

        async Task<string> paymentFPXToyyibPay(float priceAmount, string collectionId, Guid custOrderUUID)
        { 
        
            var someData = new Dictionary<string, string>
            {
                { "userSecretKey", "q8bborp6-mxnp-xdec-q898-aysih5igempt" },
                { "categoryCode", collectionId }, // "bd09g0iu"
                { "billName", "Ticket Payment" },
                { "billDescription", "Ticket Payment for Event Magnet" },
                { "billPriceSetting", "1" },
                { "billPayorInfo", "1" },
                { "billAmount", (priceAmount*100).ToString() },
                { "billReturnUrl", "https://localhost:44325/site/payment-success.aspx?&billType=F&custOrderUUID=" + custOrderUUID.ToString() },
                { "billCallbackUrl", "http://bizapp.my/paystatus" },
                { "billExternalReferenceNo", "ABCDEFG" },
                { "billTo", "KC Macha" }, // can leave blank
                { "billEmail", "kcmacha0521@gmail.com" },
                { "billPhone", "0184700496" },
                { "billSplitPayment", "0" },
                { "billSplitPaymentArgs", "" },
                { "billPaymentChannel", "2" },
                { "billContentEmail", "Thank you for purchasing our product!" },
                { "billChargeToCustomer", "1" },
                { "billExpiryDate", DateTime.Now.AddDays(3).ToString() },
                { "billExpiryDays", "3" }
            };

            string billUrl = "https://toyyibpay.com/";

            using (var httpClient = new HttpClient())
            {
                var response = await httpClient.PostAsync("https://toyyibpay.com/index.php/api/createBill", new FormUrlEncodedContent(someData));

                var result = await response.Content.ReadAsStringAsync();
                JsonElement jsonObj = System.Text.Json.JsonSerializer.Deserialize<dynamic>(result);
                ArrayEnumerator objArr = jsonObj.EnumerateArray();

                objArr.MoveNext(); // will return boolean, true if bill is created, else no bill is created

                JsonElement obj = objArr.Current;

                var bill = System.Text.Json.JsonSerializer.Deserialize<Dictionary<string, string>>(obj);

                billUrl += bill["BillCode"];

            }

            return billUrl;
        }

        string paymentFPXBillplz(string paymentTitle, float priceAmount, string userName, string userPhone, string userEmail, string collectionId, Guid custOrderUUID)
        {

            // Create A Bill Example for ASP.NET

            string domain = "www.billplz-sandbox.com";

            string api_key = "b78511f5-4ea3-409c-9780-1fc110a25c10";
            string collection_id = collectionId;
            string email = userEmail;
            string phone = userPhone;
            string name = userName;
            string amount = (priceAmount * 100).ToString();
            string callback_url = "https://www.google.com"; // perhaps can callback to controller there
            string redirect_url = "https://localhost:44325/site/payment-success.aspx?custOrderUUID=" + custOrderUUID.ToString() + "&billType=B";
            string description = paymentTitle; // "Payment for Event Magnet Ticket"


            /*
            
            string domain = "www.billplz-sandbox.com";

            string api_key = "b78511f5-4ea3-409c-9780-1fc110a25c10";
            string collection_id = "gqeghdkh";
            string email = "machachoco1212@gmail.com";
            string phone = "60184700496";
            string name = "KC Tan";
            string amount = "500";
            string callback_url = "https://google.com"; // perhaps can callback to controller there
            string redirect_url = "https://localhost:44325/site/payment-success.aspx";
            string description = "Payment for Event Magnet Ticket";

             */

            Bill bill = new Bill();

            WebRequest req = WebRequest.Create(@"https://" + domain + "/api/v3/bills?collection_id=" + collection_id + "&email=" + email + "&mobile=" + phone + "&name=" + name + "&amount="
              + amount + "&callback_url=" + callback_url + "&description=" + description + "&redirect_url=" + redirect_url);

            req.Method = "POST";
            req.Headers["Authorization"] = "Basic " + Convert.ToBase64String(Encoding.Default.GetBytes(api_key));

            bool redirectToPaymentGateway = false;
            try
            {
                HttpWebResponse resp = req.GetResponse() as HttpWebResponse;

                if (resp.StatusCode == HttpStatusCode.OK)
                {
                    // Read the response body as string
                    Stream dataStream = resp.GetResponseStream();
                    StreamReader reader = new StreamReader(dataStream);
                    string data = reader.ReadToEnd();
                    bill = JsonConvert.DeserializeObject<Bill>(data);

                    resp.Close();

                    redirectToPaymentGateway = true;
                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

            if (redirectToPaymentGateway)
            {
                //redirect user to billplz website for payment
                return bill.Url;
            }
            return "";

        }

        string paymentStrip(string paymentTitle , float priceAmount, Guid custOrderUUID) 
        {

            // Set your secret key. Remember to switch to your live secret key in production.
            // See your keys here: https://dashboard.stripe.com/apikeys
            StripeConfiguration.ApiKey = "sk_test_51OQ9Y1KAaQ7pOSkfORhLw7ENdL6YGIqPwzNpa67daJrlfUQ0S855AKaDBsQFJJVsbw6wI3E7TcMksF5kPScvL80B00SuEu5N6X";


            var options = new PriceCreateOptions
            {
                Currency = "myr",
                UnitAmount = Convert.ToInt64(priceAmount*100),
                ProductData = new PriceProductDataOptions { Name = paymentTitle },
            };
            var service = new PriceService();
            Price price = service.Create(options);

            // "T0002 - Event Magnet Ticket - Cust ID 0013"


            //string stripeSecretKey = "sk_test_51OQ9Y1KAaQ7pOSkfORhLw7ENdL6YGIqPwzNpa67daJrlfUQ0S855AKaDBsQFJJVsbw6wI3E7TcMksF5kPScvL80B00SuEu5N6X";
            //StripeConfiguration.ApiKey = stripeSecretKey;
            //Console.WriteLine("Content-Type: application/json");



            string YOUR_DOMAIN = "https://localhost:44325";
            var checkoutSessionOptions = new SessionCreateOptions
            {
                LineItems = new List<SessionLineItemOptions>
                {
                    new SessionLineItemOptions
                    {
                        Price = price.Id,
                        Quantity = 1
                    }
                },
                Mode = "payment",
                SuccessUrl = YOUR_DOMAIN + "/site/payment-success.aspx?success=1&billType=C&custOrderUUID="+custOrderUUID.ToString(),
                CancelUrl = YOUR_DOMAIN + "/site/payment-success.aspx?success=0&billType=C&custOrderUUID=" + custOrderUUID.ToString()
            };
            var servicePay = new SessionService();
            var checkoutSession = servicePay.Create(checkoutSessionOptions);
            return checkoutSession.Url;
        }



        void sendOTP(string phoneNumber, string smsContent)
        {
            var settings = new
            {
                url = "https://api.d7networks.com/messages/v1/send",
                method = "POST",
                timeout = 0,
                headers = new
                {
                    Content_Type = "application/json",
                    Accept = "application/json",
                    Authorization = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoLWJhY2tlbmQ6YXBwIiwic3ViIjoiZjAzY2Y1MzAtM2RlNC00ZTFjLThmYzctYjNjY2Q3ZjQyYmNkIn0.SkwKTEtb7PwAhhGQ6zyy1lyDtnjb0a0bXDdef6BeZMI"
                },
                data = JsonConvert.SerializeObject(new
                {
                    messages = new[]
         {
            new
            {
                channel = "sms",
                recipients = new[] { phoneNumber }, // "+60175876088" 
                content = smsContent, // "Hi, Your OTP verification code is 567092",
                msg_type = "text",
                data_coding = "text"
            }
        },
                    message_globals = new
                    {
                        originator = "SignOTP",
                        report_url = "https://the_url_to_recieve_delivery_report.com"
                    }
                })
            };
            
            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                RequestUri = new Uri(settings.url),
                Method = HttpMethod.Post,
                Content = new StringContent(settings.data, Encoding.UTF8, "application/json")
            };

            foreach (var header in settings.headers.GetType().GetProperties())
            {
                request.Headers.Add(header.Name, header.GetValue(settings.headers, null).ToString());
            }

            var response = client.SendAsync(request).Result;
            var responseContent = response.Content.ReadAsStringAsync().Result;
            Console.WriteLine(responseContent); 
        }



        public class TicketError { 

            public int id;
            public string name;
            public int qty_left;

            public TicketError()
            {
            }

        }


        public string getError(List<TicketError> list)
        {
            string errMsg = "";

            for (int i = 0; i < list.Count; i++) {
                if (list[i].qty_left > 0)
                {
                    errMsg += list[i].name + " Ticket left " + list[i].qty_left + "<br/>";
                }
                else {
                    errMsg += list[i].name + " Ticket has sold out<br/>";
                }
            }

            return errMsg;
        }


    }
}