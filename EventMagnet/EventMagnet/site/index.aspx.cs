using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;

namespace EventMagnet.site
{
    public partial class index : System.Web.UI.Page
    {
        public static string cs = Global.CS;
 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
            }
        }
    }
}


