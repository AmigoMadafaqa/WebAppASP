using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace EventMagnet
{
    public class Global : System.Web.HttpApplication
    {
        //initialize connection string
        public const string CS = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\table.mdf;Integrated Security=True";
        protected void Application_Start(object sender, EventArgs e)
        {
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session.Timeout = 120;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            //    Application.Lock();
            //    Application["ErrorMsg"] += Server.GetLastError().Message;
            //    Response.Redirect("error-page.aspx");
            //    Application.UnLock();

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            Session.Clear();
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}