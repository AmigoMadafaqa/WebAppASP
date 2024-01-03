using EventMagnet.controller;
using EventMagnet.modal;
using Newtonsoft.Json;
using Stripe.Checkout;
using Stripe;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net;
using System.Text.Json;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Text.Json.JsonElement;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Configuration;

namespace EventMagnet.admin
{
    public partial class billing_payment : System.Web.UI.Page
    {
        string title = "";
        float price = 0f;
        Guid uuid = new Guid();
        modal.admin staff = new modal.admin();
        organization org = new organization(); // get Event Magnet organization info

        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["billingTitle"] != null &&
                Session["billingPrice"] != null &&
                Session["billingUUID"] != null &&
                    Session["admin"] != null)
            {
                title = (string)Session["billingTitle"];
                price = (float)Session["billingPrice"];
                uuid = (Guid)Session["billingUUID"];
                staff = (modal.admin)Session["admin"];
                org = controller.Account.GetOrgInfo(11); // get Event Magnet organization info
            }
            lblPrice.Text = price.ToString("0.00");
            updateProcessingFee();
            updateTotalPrice();
        }

        void updateProcessingFee()
        {
            float processingFee = paymentFeeCalculation(ddlPaymentMethod.SelectedItem.Value, price);

            ltlProcessingFee.Text = processingFee.ToString("0.00");

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
                    processingFee = (float) Math.Round(((double)price * 0.04) + 1, 2);
                    break;               
                default:
                    break;

            }
            return processingFee;         
        }


        void updateTotalPrice()
        {
            try
            {                
                if (price > 0)
                {
                    float processingFee = float.Parse(ltlProcessingFee.Text);
                    ltlTotalPrice.Text = (price + processingFee).ToString("0.00");
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

        protected void btnReturn(object sender, EventArgs e)
        {
            Response.Redirect("billing.aspx");
        }

        protected async void btnConfirm_Click(object sender, EventArgs e)
        {
            updatePaymentMethod(ddlPaymentMethod.SelectedItem.Value, float.Parse(ltlProcessingFee.Text), uuid, org.id);

            float totalPrice = 0f;
            try
            {
                totalPrice = float.Parse(ltlTotalPrice.Text);
            }
            catch (Exception) { }

            if (price <= 0f)
            {
                // prompt error message
                return;
            }

            switch (ddlPaymentMethod.SelectedItem.Value)
            {
                case "F":
                    string billUrlToyyibPay = await paymentFPXToyyibPay(5f /* totalPrice */, org.collection_id_toyyibpay, uuid);
                    Response.Redirect(billUrlToyyibPay, false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                case "B":
                    string billUrlBillplz = paymentFPXBillplz(title, totalPrice, staff.name, staff.phone, "kcmacha0521@gmail.com"/*staff.email*/, org.collection_id_billplz, uuid);
                    Response.Redirect(billUrlBillplz, false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
                case "C":
                    string billUrlStripe = paymentStrip("Billing Payment-" + uuid.ToString(), totalPrice, uuid);
                    Response.Redirect(billUrlStripe, false);
                    Context.ApplicationInstance.CompleteRequest();
                    break;
               
                default:
                    break;
            }
        }

        void updatePaymentMethod(string paymentMethod, float paymentFee, Guid billingUUID, int orgId)
        {
            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = @"

                UPDATE organization_payment
                SET organization_payment.payment_method = @name, organization_payment.payment_fee= @price
                FROM organization_payment, billing
                WHERE billing.uuid = @uuid AND billing.organization_id = @orgId AND organization_payment.id = billing.organization_payment_id

            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@name", paymentMethod);
            cmd.Parameters.AddWithValue("@price", paymentFee);
            cmd.Parameters.AddWithValue("@uuid", billingUUID.ToString());
            cmd.Parameters.AddWithValue("@orgId", orgId);

            cmd.ExecuteNonQuery();

            con.Close();

        }

        async Task<string> paymentFPXToyyibPay(float priceAmount, string collectionId, Guid billingUUID)
        {

            var someData = new Dictionary<string, string>
            {
                { "userSecretKey", "q8bborp6-mxnp-xdec-q898-aysih5igempt" },
                { "categoryCode", collectionId }, // "bd09g0iu"
                { "billName", "Billing Payment" },
                { "billDescription", "Billing Payment for Event Magnet" },
                { "billPriceSetting", "1" },
                { "billPayorInfo", "1" },
                { "billAmount", (priceAmount*100).ToString() },
                { "billReturnUrl", "https://localhost:44325/admin/billing-payment-success.aspx?&billType=F&billingUUID=" + billingUUID.ToString() },
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
                { "billExpiryDate", DateTime.Now.AddDays(1).ToString() },
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

        string paymentFPXBillplz(string paymentTitle, float priceAmount, string userName, string userPhone, string userEmail, string collectionId, Guid billingUUID)
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
            string redirect_url = "https://localhost:44325/admin/billing-payment-success.aspx?billingUUID=" + billingUUID.ToString() + "&billType=B";
            string description = paymentTitle; // "Payment for Event Magnet Ticket"


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

        string paymentStrip(string paymentTitle, float priceAmount, Guid billingUUID)
        {

            // Set your secret key. Remember to switch to your live secret key in production.
            // See your keys here: https://dashboard.stripe.com/apikeys
            StripeConfiguration.ApiKey = "sk_test_51OQ9Y1KAaQ7pOSkfORhLw7ENdL6YGIqPwzNpa67daJrlfUQ0S855AKaDBsQFJJVsbw6wI3E7TcMksF5kPScvL80B00SuEu5N6X";


            var options = new PriceCreateOptions
            {
                Currency = "myr",
                UnitAmount = Convert.ToInt64(priceAmount * 100),
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
                SuccessUrl = YOUR_DOMAIN + "/admin/billing-payment-success.aspx?success=1&billType=C&billingUUID=" + billingUUID.ToString(),
                CancelUrl = YOUR_DOMAIN + "/admin/billing-payment-success.aspx?success=0&billType=C&billingUUID=" + billingUUID.ToString()
            };
            var servicePay = new SessionService();
            var checkoutSession = servicePay.Create(checkoutSessionOptions);
            return checkoutSession.Url;
        }






    }
}