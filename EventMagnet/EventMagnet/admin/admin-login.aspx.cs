using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using model = EventMagnet.modal;

namespace EventMagnet.admin
{
    public partial class admin_login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.Params["logout"] != null)
            {
                string logout = Request.Params["logout"];

                if (logout == "1")
                {
                    Session.Remove("admin");
                    Session.Remove("currentOrgId");
                    Session.Remove("isInnerAdmin");

                    Response.Redirect("admin-login.aspx");
                }
            }

            // get the access when enter to login page
            string script = $@"if ('Notification' in window) {{
                Notification.requestPermission().then(permission => {{
                    if (permission === 'granted')
                    {{
                        // User has granted permission for notifications
                        console.log('Notification permission granted.');
                    }}
                    else if (permission === 'denied')
                    {{
                        // User has denied permission for notifications
                        console.warn('Notification permission denied.');
                    }}
                    else if (permission === 'default')
                    {{
                        // The user hasn't decided yet; the notification prompt is still pending
                        console.log('Notification permission prompt is pending.');
                    }}
                }});
            }} else
            {{
                // Browser does not support the Notification API
                console.error('This browser does not support notifications.');
            }}";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "TakeAccess", script, true);

            if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
            {
                txtUsername.Text = Request.Cookies["UserName"].Value;
                txtPass.Attributes["value"] = Request.Cookies["Password"].Value;
            }

            //if (Request.Cookies["UserName"] != null && Request.Cookies["Password"] != null)
            //{
            //    txtUsername.Text = Request.Cookies["UserName"].Value;

            //    // Retrieve the hashed password from the cookie
            //    string hashedPasswordFromCookie = Request.Cookies["Password"].Value;

            //    // Retrieve the hashed password from the database based on the email
            //    string hashedPasswordFromDatabase = GetHashedPasswordFromDatabase(txtUsername.Text);

            //    // Compare the hashed passwords using BCrypt
            //    if (!string.IsNullOrEmpty(hashedPasswordFromDatabase) && BCrypt.Net.BCrypt.Verify(hashedPasswordFromCookie, hashedPasswordFromDatabase))
            //    {
            //        // Passwords match, set the password value in the txtPass TextBox
            //        txtPass.Attributes["value"] = hashedPasswordFromCookie;
            //    }
            //    else
            //    {
            //        // Passwords don't match, handle accordingly (e.g., clear the password field)
            //        txtPass.Attributes["value"] = string.Empty;
            //    }
            //}
        }
        
        //private string GetHashedPasswordFromDatabase(string email)
        //{
        //    string hashedPassword = string.Empty;
        //    string cs = Global.CS;
        //    // Replace the following logic with your actual database query to retrieve the hashed password
        //    // Example: SELECT HashedPassword FROM Users WHERE Email = @Email

        //    using (SqlConnection con = new SqlConnection(cs))
        //    {
        //        con.Open();

        //        // Assume you have a Users table with columns Email and HashedPassword
        //        string sql = "SELECT password FROM admin WHERE email = @email";

        //        using (SqlCommand cmd = new SqlCommand(sql, con))
        //        {
        //            cmd.Parameters.AddWithValue("@email", email);

        //            using (SqlDataReader dr = cmd.ExecuteReader())
        //            {
        //                if (dr.Read())
        //                {
        //                    // Retrieve the hashed password from the database
        //                    hashedPassword = dr["password"].ToString();
        //                }
        //            }
        //        }

        //        con.Close();
        //    }

        //    return hashedPassword;
        //}

        protected void btnSignIn_Click(object sender, EventArgs e)
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

            Session.Remove("admin");
            Session.Remove("isInnerAdmin");
            Session.Remove("currentOrgId");

            model.EventMagnetEntities db = new model.EventMagnetEntities();
            IEnumerable<model.admin> adminDB = db.admins;
            IEnumerable<model.organization_admin> adminOrgDB = db.organization_admin;

            // get admin information
            foreach (model.admin admin in adminDB)
            {
                if (admin.email == email)
                {
                    if (BCrypt.Net.BCrypt.Verify(password, admin.password))
                    {
                        Session["admin"] = admin;
                    }
                    break;
                }
            }

            if (Session["admin"] != null)
            {
                Session["isInnerAdmin"] = false;
                Session["currentOrgId"] = 0;

                model.admin admin = (model.admin) Session["admin"];

                bool firstTime = true;
                bool recreateCurrentOrgCookie = true;

                if (Request.Cookies["currentOrgId"] != null)
                {
                    try
                    {
                        HttpCookie userCurrentOrgCookie = Request.Cookies["currentOrgId"];
                        int orgId = int.Parse(userCurrentOrgCookie.Value);
                        if (orgId == 0) {
                            Session["currentOrgId"] = orgId;
                            recreateCurrentOrgCookie = true;
                        }
                        else if (isValidOrgForAdminAndSetInnerAdmin(admin.id, orgId)) 
                        {
                            Session["currentOrgId"] = orgId;
                            recreateCurrentOrgCookie = false;
                        }

                    }
                    catch (Exception ex) { 
                    }
                    
                }

                if (recreateCurrentOrgCookie)
                {
                    // check if the admin is internal admin (AKA not client)
                    foreach (model.organization_admin adminOrg in adminOrgDB)
                    {
                        if (firstTime && adminOrg.admin_id == admin.id && adminOrg.status == 1)
                        {
                            Session["currentOrgId"] = adminOrg.organization_id;
                            firstTime = false;
                        }

                        // organization_id 11 is Event Magnet (personal organization)
                        if (adminOrg.admin_id == admin.id && adminOrg.organization_id == 11 && adminOrg.status == 1)
                        {
                            Session["isInnerAdmin"] = true;
                            break;
                        }
                    }
                    HttpCookie currentOrgCookie = new HttpCookie("currentOrgId");
                    currentOrgCookie.Value = ((int)Session["currentOrgId"]).ToString();
                    currentOrgCookie.Expires = DateTime.Now.AddDays(2);
                    currentOrgCookie.Secure = true;
                    Response.Cookies.Add(currentOrgCookie);
                }

                if (rmbme.Checked)
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
                
                //if (rmbme.Checked)
                //{
                //    Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(30);
                //    Response.Cookies["UserName"].Value = txtUsername.Text.Trim();
                    
                //    string hashedPass = BCrypt.Net.BCrypt.HashPassword(txtPass.Text.Trim(), 13);
                //    Response.Cookies["Password"].Value = hashedPass;
                //    Response.Cookies["Password"].Expires = DateTime.Now.AddDays(30);
                //}
                //else
                //{
                //    Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(-1);
                //    Response.Cookies["Password"].Expires = DateTime.Now.AddDays(-1);
                //}

                Response.Redirect("index.aspx");
            }
            else
            {
                txtUsername.Text = "";
                txtPass.Text = "";


                CVLogin.IsValid = false;

            }
        }

        bool isValidOrgForAdminAndSetInnerAdmin(int adminId, int orgId)
        {
            Session["isInnerAdmin"] = false;

            bool isValid = false;
            model.EventMagnetEntities db = new model.EventMagnetEntities();
            IEnumerable<model.organization_admin> adminOrgDB = db.organization_admin.Where(x => x.admin_id == adminId && x.status == 1);

            foreach (model.organization_admin adminOrg in adminOrgDB)
            {
                if (adminOrg.organization_id == orgId)
                {
                    isValid = true;
                }

                if (adminOrg.organization_id == 11)
                {
                    Session["isInnerAdmin"] = true;
                }
            }
            return isValid;
        }
    }
}