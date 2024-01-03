using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using System.Data.SqlClient;
using Stripe;

namespace EventMagnet.admin
{
    public partial class newsletter_view : System.Web.UI.Page
    {
        string cs = Global.CS;

        string imageDestination = "~/admin/images/newsletter/";

        protected void Page_Load(object sender, EventArgs e)
        {
            model.newsletter newsRecord = new model.newsletter();

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["newsletterID"] != null)
                {
                    try
                    {
                        string newsId = Request.QueryString["newsletterID"].ToString();

                        string sql = "SELECT * FROM newsletter WHERE id = @newsID";

                        SqlConnection conn = new SqlConnection(cs);
                        SqlCommand cmd = new SqlCommand(sql,conn);
                        conn.Open();

                        cmd.Parameters.AddWithValue("@newsID", newsId);

                        SqlDataReader reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            newsRecord.id = Convert.ToInt32(reader["id"]);
                            newsRecord.title = Convert.ToString(reader["title"]);
                            newsRecord.body = Convert.ToString(reader["body"]);
                            newsRecord.img_src = Convert.ToString(reader["img_src"]);
                            newsRecord.status = Convert.ToByte(reader["status"]);
                            newsRecord.create_datetime = Convert.ToDateTime(reader["create_datetime"]);
                            newsRecord.organization_id = Convert.ToInt32(reader["organization_id"]);
                        }

                        conn.Close();

                        lblNewsId.Text = newsRecord.id.ToString();
                        lblNewsBody.Text = newsRecord.body;
                        lblNewsCreatedDT.Text = newsRecord.create_datetime.ToString();
                        lblNewsImgPath.Text = imageDestination + newsRecord.img_src;
                        lblNewsOrgId.Text = newsRecord.organization_id.ToString();
                        //lblNewsStatus.Text = newsRecord.status.ToString(); 
                        lblNewsTitle.Text = newsRecord.title;
                        imgNewsletter.ImageUrl= imageDestination + newsRecord.img_src;


                        //change the status to active
                        if (newsRecord.status == 1)
                        {
                            lblNewsStatus.Text = "Active";
                        }
                        else
                        {
                            lblNewsStatus.Text = "Inactive";
                        }

                    }
                    catch(SqlException ex)
                    {
                        Response.Redirect("../error-page.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("../error-page.aspx");
                    }
                }
            }
        }
    }
}