using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.site
{
    public partial class payment_paypal : System.Web.UI.Page
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
    }
}