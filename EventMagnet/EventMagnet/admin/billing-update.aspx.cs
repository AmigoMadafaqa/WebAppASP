using EventMagnet.modal;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace EventMagnet.admin
{
    public partial class billing_update : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;

        public billing bill = new billing();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["currentOrgId"] != null && Session["billingUUID"] != null)
                {
                    bill = fetchData((Guid)Session["billingUUID"], (int)Session["currentOrgId"]);
                    if (bill != null)
                    {
                        lblUUID.Text = bill.uuid.ToString();
                        txtNameInput.Text = bill.name;
                        txtAmtInput.Text = bill.price.ToString("0.00");
                        txtStatus.Text = statusName(bill.status);
                        txtIssueDate.Text = bill.create_datetime.ToString();
                        cldDateInput.SelectedDate = (DateTime)bill.create_datetime;

                                               
                    }
                    else
                    {
                        showOrgErrorMsg(); 
                        txtNameInput.ReadOnly = true;
                        txtAmtInput.ReadOnly = true;
                    }                
                }
                else {
                    showBillIdNotFoundError();
                    txtNameInput.ReadOnly = true;
                    txtAmtInput.ReadOnly = true;
                } 
            }
        }

        public string statusName(int status) 
        {
            string statusName = "N/A";   
            
            switch(status)
            {
                case 0:
                    statusName = "Unpaid";
                    break;
                case 1:
                    statusName = "Paid";
                    break;
                case 2:
                    statusName = "Pending";
                    break;
                default:
                    break;
            }

            return statusName;
        }

        billing fetchData(Guid billUUID, int orgId)
        {

            billing billRecord = null;

            EventMagnetEntities db = new EventMagnetEntities();

            IQueryable<billing> billingDB = db.billings.AsQueryable()
                               .Where(x => x.uuid.ToString() == billUUID.ToString() && x.organization_id == orgId);

            billingDB = billingDB.Take(1);

            foreach (billing billItem in billingDB)
            {
                billRecord = billItem;
            }

            return billRecord;

        }

        public int saveData(billing billItem) {

            SqlConnection con = new SqlConnection(cs);


            // insert payment method record
            string query = @"
               UPDATE billing
                SET name = @name, price=@price, create_datetime=@datetime
                WHERE uuid = @uuid AND organization_id = @orgId
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@name", billItem.name);
            cmd.Parameters.AddWithValue("@price", billItem.price);
            cmd.Parameters.AddWithValue("@datetime", billItem.create_datetime.ToString());
            cmd.Parameters.AddWithValue("@uuid", billItem.uuid.ToString());
            cmd.Parameters.AddWithValue("@orgId", billItem.organization_id);

            con.Open();

            int result = cmd.ExecuteNonQuery();

            con.Close();

            return result;
        }

        protected void onChangeDate(object sender, EventArgs e)
        {
            DateTime date = cldDateInput.SelectedDate;            
            txtIssueDate.Text = date.ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Session["billingUUID"] != null)
            {
                billing billItem = new billing();
                billItem.uuid = (Guid)Session["billingUUID"];
                billItem.name = txtNameInput.Text;
                billItem.price = Convert.ToDecimal(txtAmtInput.Text);
                billItem.create_datetime = cldDateInput.SelectedDate;
                billItem.organization_id = (int)Session["currentOrgId"];

                saveData(billItem);

            }

            Response.Redirect(Request.RawUrl);
        }

        protected void cancelUpdateButton(object sender, EventArgs e)
        {
            Response.Redirect("billing.aspx");
        }

        void showOrgErrorMsg()
        {
            PlaceHolderText.Controls.Clear();
            PlaceHolderText.Controls.Add(new LiteralControl(
                @"
                        <div class=""container-xxl flex-grow-1 container-p-y"">
                            <span>The Billing ID does not match with the organization. Please return to <a href=""billing.aspx"">Billing Management</a> to choose a billing to update</span>
                        </div>"
                ));
        }

        void showBillIdNotFoundError() 
        {
            PlaceHolderText.Controls.Clear();
            PlaceHolderText.Controls.Add(new LiteralControl(
                @"
                        <div class=""container-xxl flex-grow-1 container-p-y"">
                            <span>The Billing ID is not found. Please return to <a href=""billing.aspx"">Billing Management</a> to choose a billing to update</span>
                        </div>"
                ));

        }
    }
}