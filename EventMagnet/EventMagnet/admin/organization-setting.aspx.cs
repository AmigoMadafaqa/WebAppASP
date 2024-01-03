using Stripe.Climate;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static EventMagnet.admin.organization_setting;

namespace EventMagnet.admin
{
    public partial class organization_setting : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;
        
        public int orgId = 0;
        public bool isOwner = false;
        public int adminId = 0;
        public List<OrgAdmin> orgAdmin = new List<OrgAdmin>();
        public bool showAddSection = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["currentOrgId"] != null && Session["admin"] != null) {
                orgId = (int)Session["currentOrgId"];
                adminId = ((modal.admin)Session["admin"]).id;
                orgAdmin = getOrganizationAdmin(orgId);
                renderOrganizationAdmin();
            }
        }

        List<OrgAdmin> getOrganizationAdmin(int orgId)
        {
            List<OrgAdmin> record = new List<OrgAdmin>();

            SqlConnection con = new SqlConnection(cs);
          
            // insert payment method record
            string query = @"
                
            SELECT oa.id AS org_admin_id, a.id, a.name, a.email, a.phone, oa.is_owner
            FROM admin a, organization_admin oa, organization org
            WHERE a.id = oa.admin_id
                AND oa.organization_id = org.id
                AND a.status = 1
                AND oa.status = 1
                AND org.status = 1
                AND org.id = @orgId
            ORDER BY oa.is_owner DESC, oa.create_datetime
             
            ";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@orgId", orgId);
            
            con.Open();
            
            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                OrgAdmin item = new OrgAdmin();
                item.org_admin_id = Convert.ToInt32(dr["org_admin_id"]);
                item.id = Convert.ToInt32(dr["id"]);
                item.name = Convert.ToString(dr["name"]);
                item.email = Convert.ToString(dr["email"]);
                item.phone = Convert.ToString(dr["phone"]);
                item.isOwner = Convert.ToInt32(dr["is_owner"]);

                record.Add(item);
            }

            con.Close();

            dr.Close();

            return record;
        }

        void renderOrganizationAdmin()
        {
            
            plcOrgAdmin.Controls.Clear();
            for (int i = 0; i < orgAdmin.Count; i++)
            {

                plcOrgAdmin.Controls.Add(new LiteralControl(
                @" 
                <tr>
                    <td>" + orgAdmin[i].id + @"</td>
                    <td><i class=""fab fa-angular fa-lg text-danger me-3""></i><strong>" + orgAdmin[i].name + @"</strong></td>
                                    
                    <td>" + orgAdmin[i].email + @"</td>
                    <td>" + orgAdmin[i].phone + @"</td>
                    <td>" + (orgAdmin[i].isOwner == 1 ? "Owner" : "Member") + @"</td>
                    <td>"));

                if (orgAdmin[i].isOwner != 1 &&
                    (bool)Session["isInnerAdmin"] &&
                    orgAdmin[i].id != adminId)
                {

                    Button btnDelete = new Button();
                    btnDelete.ID = "btn_delete_" + i.ToString();
                    btnDelete.Text = "Delete";
                    btnDelete.CssClass = "btn btn-outline-info";
                    btnDelete.CommandName = orgAdmin[i].id.ToString();
                    btnDelete.CommandArgument = orgId.ToString();
                    btnDelete.Command += new CommandEventHandler(this.btn_deleteEnrollment_Click);
                    btnDelete.Attributes.Add("runat", "server");
                    btnDelete.OnClientClick = "return confirm('Are You Sure Want To Delete This Record ?');";

                    plcOrgAdmin.Controls.Add(btnDelete);
                }

                    plcOrgAdmin.Controls.Add(new LiteralControl(@"</td>                                    
                </tr>
                "
                ));
            }

        }


        protected void btnShowAddSection(object sender, EventArgs e)
        {
            showAddSection = true;
        }

        protected void btn_deleteEnrollment_Click(object sender, CommandEventArgs e)
        {
            deleteOrganizationAdmin(Convert.ToInt32(e.CommandName), Convert.ToInt32(e.CommandArgument));
            
            Response.Redirect(Request.RawUrl);
            
        }

        protected void btnReturn(object sender, EventArgs e)
        {
            showAddSection = false;
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
           addOrganizationAdmin(int.Parse(ddlMemberList.SelectedItem.Value), (int)Session["currentOrgId"]);
           
           Response.Redirect(Request.RawUrl);
            
        }

        int deleteOrganizationAdmin(int adminId, int orgId)
        {
            SqlConnection con = new SqlConnection(cs);

            // insert payment method record
            string query = @"
               
            UPDATE organization_admin 
            SET status = 0 
            WHERE admin_id = @admin_id 
                AND organization_id = @organization_id
             
            ";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@admin_id", adminId);
            cmd.Parameters.AddWithValue("@organization_id", orgId);

            con.Open();

            int result = cmd.ExecuteNonQuery();
           
            con.Close();

            return result;

        }

        int addOrganizationAdmin(int adminId, int orgId)
        {
            SqlConnection con = new SqlConnection(cs);

            string query = @"
               
            insert into organization_admin 
            (is_owner, create_datetime, status, admin_id, organization_id) values 
            (@is_owner, @create_datetime, @status, @admin_id, @organization_id)
            
            ";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@is_owner", 0);
            cmd.Parameters.AddWithValue("@create_datetime", DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@status", 1);
            cmd.Parameters.AddWithValue("@admin_id", adminId);
            cmd.Parameters.AddWithValue("organization_id", orgId);

            con.Open();

            int result = cmd.ExecuteNonQuery();

            con.Close();

            return result;
        }


        public class OrgAdmin
        {
            public int org_admin_id;
            public int id;
            public string name;
            public string email;
            public string phone;
            public int isOwner;
        }


    }
}