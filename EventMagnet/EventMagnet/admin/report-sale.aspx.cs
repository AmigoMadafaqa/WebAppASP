using EventMagnet.controller;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.admin
{
    public partial class report_sale : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //if (Session["currentOrgId"] != null && Session["billingUUID"] != null)
                //{
                //    bill = fetchData((Guid)Session["billingUUID"], (int)Session["currentOrgId"]);
                //    if (bill != null)
                //    {
                //        lblUUID.Text = bill.uuid.ToString();
                //        txtNameInput.Text = bill.name;
                //        txtAmtInput.Text = bill.price.ToString("0.00");
                //        txtStatus.Text = statusName(bill.status);
                //        txtIssueDate.Text = bill.create_datetime.ToString();
                //        cldDateInput.SelectedDate = (DateTime)bill.create_datetime;
                //    }
                //    else
                //    {
                //        showOrgErrorMsg();
                //    }
                //}
                //else
                //{
                //    showBillIdNotFoundError();
                //}
            }

        }

        void getTotalPayment(int orgId) 
        { 

        }
    }
}