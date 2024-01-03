using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using BCrypt.Net;
using System.Data.SqlClient;
using EventMagnet.modal;

namespace EventMagnet.site
{
    public partial class login : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
            {
                txtUsername.Text = Request.Cookies["UserName"].Value;
                txtPass.Attributes["value"] = Request.Cookies["Password"].Value;
            }
        }

        protected void regBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("account-register.aspx");
        }

        protected void cancelBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void logBtn_Click(object sender, EventArgs e)
        {
            string email = txtUsername.Text;
            string password = txtPass.Text;

            if (email == "" || password == "")
            {
                txtUsername.Text = "";
                txtPass.Text = "";
                // prompt error message to fill in both input

                return;
            }

            Session.Remove("cust");

            EventMagnetEntities db = new EventMagnetEntities();
            IEnumerable<customer> custDB = db.customers;

            foreach (customer customer in custDB)
            {
                if (customer.email == email)
                {
                    if (BCrypt.Net.BCrypt.Verify(password, customer.password))
                    {
                        Session["cust"] = customer;
                    }
                    break;
                }
            }

            if (Session["cust"] != null)
            {
                Response.Redirect("index.aspx");
            }
            else
            {
                txtUsername.Text = "";
                txtPass.Text = "";

                CVLogin.IsValid = false;

            }

            if (cbRemember.Checked)
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);
                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
            }
            else
            {
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Cookies["UserName"].Value = txtUsername.Text.Trim();
            Response.Cookies["Password"].Value = txtPass.Text.Trim();
        }
    }
}