using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.admin
{
    public partial class create_admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void resetBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("create-admin.aspx");
        }

        protected void addBtn_Click(object sender, EventArgs e)
        {
            Server.Transfer("index.aspx");
        }
    }
}