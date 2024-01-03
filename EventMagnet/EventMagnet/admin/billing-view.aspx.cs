using EventMagnet.controller;
using Newtonsoft.Json;
using Stripe.Checkout;
using Stripe;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
using EventMagnet.modal;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Xml.Linq;

namespace EventMagnet.admin
{
    public partial class billing_view : System.Web.UI.Page
    {

        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;
        public Guid uuid = new Guid();
        public bool showPayBtn = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["isInnerAdmin"] != null && (bool)Session["isInnerAdmin"]
                && Session["currentOrgId"] != null
                && Session["billingUUID"] != null)
            {

                uuid = (Guid)Session["billingUUID"];

                showPayBtn = getBillingStatus(uuid, (int)Session["currentOrgId"]);


                if (Request.Params["update"] != null && Request.Params["update"] == "1")
                {
                    if (!Page.IsPostBack)
                    {
                        updateBilling(null, null);
                        
                    }
                }

            }
            else {
                PlaceHolderText.Controls.Clear();
                PlaceHolderText.Controls.Add(new LiteralControl(
                    @"
                        <div class=""container-xxl flex-grow-1 container-p-y"">
                            <span>The Billing ID is not found. Please return to <a href=""billing.aspx"">Billing Management</a> to choose a billing to view</span>
                        </div>"
                    ));

            }
            //FormViewBillDetail.DataBind();
        }

        void showErrorMsg()
        {
            PlaceHolderText.Controls.Clear();
            PlaceHolderText.Controls.Add(new LiteralControl(
                @"
                        <div class=""container-xxl flex-grow-1 container-p-y"">
                            <span>The Billing ID does not match with the organization. Please return to <a href=""billing.aspx"">Billing Management</a> to choose a billing to view</span>
                        </div>"
                ));
        }

        bool getBillingStatus(Guid uuid, int orgId)
        {
            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = @"
               SELECT status FROM billing WHERE uuid = @uuid AND organization_id = @orgId
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uuid", uuid.ToString());
            cmd.Parameters.AddWithValue("@orgId", orgId);
            SqlDataReader dr = cmd.ExecuteReader();

            int status = 0;
            while (dr.Read())
            {
                status = Convert.ToInt32(dr["status"]);
                break;
            }

            dr.Close();
            con.Close();

            return status == 2;
        }


        protected void updateBilling(object sender, EventArgs e)
        {
            Response.Redirect("billing-update.aspx");

            return;

                FormViewBillDetail.ChangeMode(FormViewMode.Edit);

            //saveBilling(sender, e);

            if (!Page.IsPostBack)
            {
                if (((TextBox)FormViewBillDetail.FindControl("txtNameInput")) != null &&
                    ((TextBox)FormViewBillDetail.FindControl("txtAmtInput")).Text != null)
                {
                    ViewState["txtNameInput"] = ((TextBox)FormViewBillDetail.FindControl("txtNameInput")).Text;
                    ViewState["txtAmtInput"] = float.Parse(((TextBox)FormViewBillDetail.FindControl("txtAmtInput")).Text);


                    //DateTime datetime = Convert.ToDateTime(ViewState["cldDateInput"]);  // ((Calendar)FormViewBillDetail.FindControl("cldDateInput")).SelectedDate;
                }
            }
        }


        protected void saveBilling(object sender, EventArgs e)
        {



        }

        protected void cancelUpdateButton(object sender, EventArgs e)
        {
            FormViewBillDetail.ChangeMode(FormViewMode.ReadOnly);
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

        protected void onChangeDate(object sender, EventArgs e)
        {
            TextBox txtIssueDate = ((TextBox)FormViewBillDetail.FindControl("txtIssueDate"));
            Calendar cldDate = ((Calendar)FormViewBillDetail.FindControl("cldDateInput"));

            DateTime date = cldDate.SelectedDate;

            txtIssueDate.Text = date.ToString();
        }

        protected void SqlDataSource2_Selected(object sender, SqlDataSourceStatusEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                showErrorMsg();
            }

        }

        protected void btnPay(object sender, EventArgs e)
        {
            string title = (((TextBox)FormViewBillDetail.FindControl("txtTitle")).Text);
            float price = float.Parse(((TextBox)FormViewBillDetail.FindControl("txtAmount")).Text);
            Guid uuid = Guid.Parse(((Label)FormViewBillDetail.FindControl("ID")).Text);

            Session["billingTitle"] = title;
            Session["billingPrice"] = price;
            Session["billingUUID"] = uuid;

            Response.Redirect("billing-payment.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

        }

        public TextBox txtNameInput;
        public TextBox txtAmtInput;
        public Calendar cldDateInput;

        protected void getServerControl(object sender, EventArgs e)
        {
            txtNameInput = ((TextBox)FormViewBillDetail.FindControl("txtNameInput"));
            txtAmtInput = ((TextBox)FormViewBillDetail.FindControl("txtAmtInput"));
            cldDateInput = ((Calendar)FormViewBillDetail.FindControl("cldDateInput"));
        }
        protected void hahaha(object sender, EventArgs e)
        {
            testtest.Text = "asd99999";
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = "aaa";
            float price = 10f;
            DateTime datetime = DateTime.Now;
            

            if (!Page.IsPostBack) {

                //saveBilling(sender, e);

                name = Convert.ToString(ViewState["txtNameInput"]); // ((TextBox)FormViewBillDetail.FindControl("txtNameInput")).Text;
                price = 9f;
                try
                {
                    price = (float)Convert.ToDouble(ViewState["txtAmtInput"]); // float.Parse(((TextBox)FormViewBillDetail.FindControl("txtAmtInput")).Text);
                }
                catch (Exception)
                {
                    price = 4f;
                }
                //DateTime datetime = Convert.ToDateTime(ViewState["cldDateInput"]);  // ((Calendar)FormViewBillDetail.FindControl("cldDateInput")).SelectedDate;
            
            }

            testtest.Text = "asd123<br/>" +
                            "123<br/>" +
                            Convert.ToString(ViewState["txtNameInput"]).ToString() + "<br/>" +
                            Convert.ToDouble(ViewState["txtAmtInput"]).ToString("0.00") + "<br/>";
            ;

            Guid uuid = (Guid)Session["billingUUID"];
            int orgId = (int)Session["currentOrgId"];

            SqlConnection con = new SqlConnection(cs);


            // insert payment method record
            string query = @"
               UPDATE billing
                SET name = @name, price=@price, create_datetime=@datetime
                WHERE uuid = @uuid AND organization_id = @orgId
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@price", price);
            //cmd.Parameters.AddWithValue("@datetime", datetime);
            cmd.Parameters.AddWithValue("@uuid", uuid.ToString());
            cmd.Parameters.AddWithValue("@orgId", orgId);

            //cmd.Parameters.AddWithValue("@name", "hahaha");
            //cmd.Parameters.AddWithValue("@price", 123);
            //cmd.Parameters.AddWithValue("@datetime", DateTime.Now.ToString());
            //cmd.Parameters.AddWithValue("@uuid", "67095150-62ae-4d15-9973-c90000bb1384");
            //cmd.Parameters.AddWithValue("@orgId", 11);

            con.Open();

            int result = cmd.ExecuteNonQuery();

            con.Close();


            //try { 
            //    FormViewBillDetail.UpdateItem(true);
            //    //MessageLabel.Text = "";
            //}
            //catch (HttpException ex)
            //{
            //    //MessageLabel.Text = "The FormView control must be in edit mode to update a record.";
            //}


            //Response.Redirect("billing-update.aspx");

            //Response.Redirect(Request.RawUrl);

        }
    } 
}