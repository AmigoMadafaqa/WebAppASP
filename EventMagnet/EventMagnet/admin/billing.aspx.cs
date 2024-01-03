using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using static EventMagnet.site.customer_ticket;
using Checkout.Sessions;
using System.Configuration;
using modal=EventMagnet.modal;
using EventMagnet.controller;
using System.Reflection;
using System.Security.Cryptography;

namespace EventMagnet.zDEl_admin
{
    public partial class billing : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;
        private List<modal.billing> billArr = new List<modal.billing>();

        string hello = "oioioioi";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentOrgId"] != null && Session["isInnerAdmin"] != null)
            {
                renderBillingSection((int)Session["currentOrgId"]);
            }
        }

        void renderBillingSection(int orgId)
        {
            billArr = getBillingRecord(orgId);

            placeHolderBilling.Controls.Clear();

            if (billArr.Count == 0) {
                placeHolderBilling.Controls.Add(new LiteralControl(
                    @"
                <tr>
                    <td colspan=""7"" style=""text-align:center"">
                        No Record Found
                    </td>
                </tr>
            "));

            }

            for (int i = 0; i < billArr.Count; i++)
            {
                modal.billing record = billArr[i];

                string statusText = record.status == 1 ? "<span class=\"badge bg-label-success me-1\">Paid</span>" : "<span class=\"badge bg-label-primary me-1\">Pending</span>";

                placeHolderBilling.Controls.Add(new LiteralControl(
                    @"
                <tr>
                    <td>" + (i+1).ToString() + @"</td>
                    <td>" + record.uuid.ToString() + @"</td>
                    <td>" + record.name + @"</td>
                    <td>" + record.price.ToString("0.00") + @"</td>
                    <td>" + record.create_datetime.ToString() + @"</td>
                    <td>" + statusText + @"</td>
                    <td style=""display:flex; flex-direction:column"">"
                ));

                Button btnDetail = new Button();
                btnDetail.ID = "btn_viewBillingDetail_" + i.ToString();
                btnDetail.Text = "View";
                btnDetail.CssClass = "btn btn-outline-info my-1";
                btnDetail.CommandArgument = record.uuid.ToString();
                btnDetail.Command += new CommandEventHandler(this.viewBillingDetail);
                btnDetail.Attributes.Add("runat", "server");

                placeHolderBilling.Controls.Add(btnDetail);

                if ((bool)Session["isInnerAdmin"]) {

                    Button btnUpdate = new Button();
                    btnUpdate.ID = "btn_updateBilling_" + i.ToString();
                    btnUpdate.Text = "Update";
                    btnUpdate.CssClass = "btn btn-outline-warning my-1";
                    btnUpdate.CommandArgument = record.uuid.ToString();
                    btnUpdate.Command += new CommandEventHandler(this.updateBilling);
                    btnUpdate.Attributes.Add("runat", "server");

                    placeHolderBilling.Controls.Add(btnUpdate);

                    Button btnDel = new Button();
                    btnDel.ID = "btn_deleteBilling_" + i.ToString();
                    btnDel.Text = "Delete";
                    btnDel.CssClass = "btn btn-outline-danger my-1";
                    btnDel.CommandArgument = record.uuid.ToString();
                    btnDel.Command += new CommandEventHandler(this.deleteBilling);
                    btnDel.Attributes.Add("runat", "server");
                    btnDel.OnClientClick = "return confirm('Are You Sure Want To Delete This Record ?');";
                    
                    placeHolderBilling.Controls.Add(btnDel);



                }

                placeHolderBilling.Controls.Add(new LiteralControl(
                    @"
                        </td>                    
                </tr>
                "

                   ));
            }


        }










        List<modal.billing> getBillingRecord(int orgId)
        {
            List<modal.billing> billRecord = new List<modal.billing>();

            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = @"
                
            SELECT uuid, name, price, status, create_datetime
            FROM billing
            WHERE status in (1,2)
                AND organization_id = @orgId
            ORDER BY create_datetime desc
             
            ";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                modal.billing bill = new modal.billing();
                bill.uuid = Guid.Parse(Convert.ToString(dr["uuid"]));
                bill.name = Convert.ToString(dr["name"]);
                bill.price = Convert.ToDecimal(dr["price"]);
                bill.status = Convert.ToByte(dr["status"]);
                bill.create_datetime = Convert.ToDateTime(dr["create_datetime"]);
                billRecord.Add(bill);
            }

            con.Close();
            
            dr.Close();

            return billRecord;
        }

        protected void updateBilling(object sender, CommandEventArgs e)
        {
            string uuid = e.CommandArgument.ToString();
            Guid billUUID = Guid.Parse(uuid);
            Session["billingUUID"] = billUUID;
            Response.Redirect("billing-update.aspx");
        }

        protected void deleteBilling(object sender, CommandEventArgs e)
        {
            string uuid = e.CommandArgument.ToString();
            Guid billUUID = Guid.Parse(uuid);
            deleteBillingRecord(billUUID);
            Response.Redirect(Request.RawUrl);
        }

        protected int deleteBillingRecord(Guid uuid)
        {
            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = @"
                UPDATE billing SET status = 0 WHERE uuid = @uuid 
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", uuid.ToString());

            int result = cmd.ExecuteNonQuery();

            con.Close();

            return result;
        }

        protected void viewBillingDetail (object sender, CommandEventArgs e)
        {
            string uuid = e.CommandArgument.ToString();
            Guid billUUID = Guid.Parse(uuid);
            Session["billingUUID"] = billUUID;
            Response.Redirect("billing-view.aspx");
        }


        protected void btnCreateBilling(object sender, EventArgs e)
        {
            Response.Redirect("billing-create.aspx");
        }
    }
}