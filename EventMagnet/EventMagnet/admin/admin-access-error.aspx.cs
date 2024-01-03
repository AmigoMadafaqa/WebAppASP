using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.admin
{
    public partial class admin_access_error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRedirectLoginpage_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin-login.aspx");
        }
    }
}