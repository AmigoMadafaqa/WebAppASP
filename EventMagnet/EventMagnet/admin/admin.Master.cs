using EventMagnet.controller;
using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using model = EventMagnet.modal;

namespace EventMagnet.admin
{
    public partial class admin : System.Web.UI.MasterPage
    {
        string webPageName = "";

        public string username = "";
        public string position = "";
        //public string organizationName = "";

        string cs = Global.CS;
        string imageDestination = "~/admin/images/avatars/";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null || Session["currentOrgId"] == null || Session["isInnerAdmin"] == null)
            {
                Response.Redirect("admin-login.aspx");
                return;
            }

            model.admin admin = (model.admin)Session["admin"];
            int currentOrg = (int)Session["currentOrgId"];
            bool isValidOrgAdmin = isValidOrgForAdminAndSetInnerAdmin(admin.id, currentOrg);
            bool isInnerAdmin = (bool)Session["isInnerAdmin"];

            webPageName = Path.GetFileName(Request.Path);

            //admin profile pic retrieve
            if (admin != null)
            {
                // Your database query to fetch additional data based on the id
                string sql = "SELECT * FROM admin WHERE id = @id";

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, con);
                con.Open();

                cmd.Parameters.AddWithValue("@id", admin.id);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Session["imgSource"] = imageDestination + Convert.ToString(dr["img_src"]);
                    ImgUpload.ImageUrl = Session["imgSource"].ToString();
                    ImgUpload.AlternateText = Convert.ToString(dr["img_src"]);
                    ddlImage.ImageUrl = Session["imgSource"].ToString();
                    ddlImage.AlternateText = Convert.ToString(dr["img_src"]);
                }
                con.Close();
            }


            // Access Control List

            if (currentOrg == 0 || !isValidOrgAdmin)
            {
                // if the client does not join any organization
                // and if the client is removed from the org that he is currently using
                // always redirect the client to an error page to alert him
                Response.Redirect("admin-access-error.aspx");
            }
            else if (!isInnerAdmin)
            {
                // client access control list
                // it lists the page that client cannot access
                if (
                    webPageName == "billing-create.aspx" ||
                    webPageName == "billing-update.aspx" ||
                    webPageName == "organization-create.aspx" ||
                    webPageName == "edit-admin-profile.aspx"||
                    webPageName == "event-venue-create.aspx"
                    )
                {
                    Response.Redirect("index.aspx");
                }
            }
            else if (isInnerAdmin)
            {
                // admin access control list
                // it lists the page that admin cannot access
                if (
                    webPageName == "edit-customer-profile.aspx"
                    )
                {
                    Response.Redirect("index.aspx");
                }

            }


            username = ((model.admin)Session["admin"]).name;

            position = isInnerAdmin ? "Admin" : "Client";


            organization org = Account.GetOrgInfo(currentOrg);
            //if (org != null)
            //{
            //    organizationName = org.name + " (ID : " + org.id + ")";
            //}
            //else
            //{
            //    organizationName = "Organization Not Selected (ID : 0)";
            //}

            hfCustId.Value = admin.id.ToString();

            if (!Page.IsPostBack)
            {
                ddlOrgSelection.DataBind();
                if (ddlOrgSelection.Items.FindByValue(org.id.ToString()) != null) { 
                    ddlOrgSelection.Items.FindByValue(org.id.ToString()).Selected = true;
                }
            }
           
        }

        protected void ddlOrgSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                int orgId = 0;
                try
                {
                    orgId = int.Parse(ddlOrgSelection.SelectedItem.Value);
                }
                catch (Exception ex)
                {

                }

                if (Account.GetOrgInfo(orgId) != null)
                {
                    Session["currentOrgId"] = orgId;
                    
                    //if (orgId == 11)
                    //{
                    //    // if it is event magnet, give role as admin
                    //    Session["isInnerAdmin"] = true;
                    //}
                    //else {
                    //    // if it is NOT event magnet, give role as client
                    //    Session["isInnerAdmin"] = false;
                    //}

                    HttpCookie currentOrgCookie = new HttpCookie("currentOrgId");
                    currentOrgCookie.Value = ((int)Session["currentOrgId"]).ToString();
                    currentOrgCookie.Expires = DateTime.Now.AddDays(2);
                    currentOrgCookie.Secure = true;
                    Response.Cookies.Add(currentOrgCookie);

                    // refresh the page
                    Response.Redirect(Request.RawUrl);
                }

            }
        }


        bool isValidOrgForAdminAndSetInnerAdmin(int adminId, int orgId)
        {
            Session["isInnerAdmin"] = false;

            bool isValid = false;
            model.EventMagnetEntities db = new model.EventMagnetEntities();
            IEnumerable<model.organization_admin> adminOrgDB = db.organization_admin.Where(x => x.admin_id == adminId && x.status == 1) ;
            
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