using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.admin
{
    public partial class create_customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void resetBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("account-profile-confirm.aspx");
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("customer-list.aspx");
        }
    }
}