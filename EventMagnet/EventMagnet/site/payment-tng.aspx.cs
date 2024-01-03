using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.site
{
    public partial class payment_tng : System.Web.UI.Page
    {
        public float totalPrice = 0f;
        public Guid custOrderUUID = new Guid();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["paymentAmount"] != null && Session["custOrderUUID"] != null)
            {
                totalPrice = (float)Session["paymentAmount"];
                custOrderUUID = (Guid)Session["custOrderUUID"];
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string isSuccess = totalPrice > 0f ? "1" : "0";
            Response.Redirect($"payment-success.aspx?billType=T&success={isSuccess}&custOrderUUID={custOrderUUID.ToString()}");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect($"payment-success.aspx?billType=T&success=0&custOrderUUID={custOrderUUID.ToString()}");
        }
    }
}