using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using model = EventMagnet.modal;
using EventMagnet.modal;
using System.Data.Entity.Migrations.Sql;
using static EventMagnet.zDEl_admin.event_venue_index;

namespace EventMagnet.zDEl_admin
{
    public partial class newsletter_index : System.Web.UI.Page
    {
        string cs = Global.CS;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                lblComment.Visible= false;
                using (var db = new model.EventMagnetEntities())
                {
                    //store newsletter records into dataList
                    List<newsletter> dataList = db.newsletters.AsQueryable().Where(x => x.status == 1).ToList();

                    rNewsletter.DataSource = addStatusText(dataList);
                    rNewsletter.DataBind();

                    lblTotalCount.Text = "Total Newsletter Records : " + dataList.Count.ToString();
                }

            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnView.NamingContainer;
            HiddenField hfNewsId = (HiddenField)item.FindControl("hfNewsId");

            if (hfNewsId != null)
            {
                string newsID = hfNewsId.Value.ToString();

                Response.Redirect($"newsletter-view.aspx?NewsletterID={newsID}");
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnEdit.NamingContainer;
            HiddenField hfNewsId = (HiddenField)item.FindControl("hfNewsId");

            if (hfNewsId != null)
            {
                string newsID = hfNewsId.Value.ToString();

                Response.Redirect($"newsletter-update.aspx?NewsletterID={newsID}");
            }
        }

        protected void btnDlt_Click(object sender, EventArgs e)
        {
            Button btnDlt = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnDlt.NamingContainer;
            HiddenField hfNewsId = (HiddenField)item.FindControl("hfNewsId");

                if (hfNewsId != null)
                {
                    string msg = "";
                    string newsID = hfNewsId.Value.ToString();
                    model.newsletter newsRecord = new model.newsletter();

                    //retrive specific record
                    string sql = "SELECT * FROM newsletter WHERE id=@id";

                    SqlConnection conn = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    cmd.Parameters.AddWithValue("@id", newsID);
                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
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
                    if (newsRecord.status == 1)
                    {
                        if (DltRecordFromDb(newsRecord) == 1)
                        {
                            Response.Redirect("newsletter-index.aspx");
                            //lblComment.CssClass = "text-success";
                            // msg= $"Record ID : {newsRecord.id} Is Not Available Now !";
                        }
                        else
                        {
                            //Response.Redirect("newsletter-index.aspx");
                            lblComment.CssClass = "text-danger";
                             msg= $"Record ID : {newsRecord.id} Is Still Available !";
                        }
                    }
                    else
                    {
                        //Response.Redirect("newsletter-index.aspx");
                        lblComment.CssClass = "text-danger";
                         msg = $"Record Title :  {newsRecord.title} <br/> With ID : {newsRecord.id} <br/> Is Not Able To Delete !<br/>" + $"{newsRecord.title} Is Already Not Available !";
                    }

                    lblComment.Text = msg;
                    lblComment.Visible = true;
                }


        }

        public int DltRecordFromDb(model.newsletter newsRecord)
        {
            int result = 0;
            model.newsletter dltNews = newsRecord;

            string dltSql = "UPDATE newsletter SET status=@status WHERE id=@id";

            SqlConnection conn = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(dltSql, conn);

            cmd.Parameters.AddWithValue("@status", 0);
            cmd.Parameters.AddWithValue("@id", dltNews.id);

            conn.Open();

            int rowAffected = cmd.ExecuteNonQuery();

            if (rowAffected > 0)
            {
                result = 1;
            }
            else
            {
                result = 0;
            }
            conn.Close();

            return result;
        }

        public List<NewsletterRecord> addStatusText(List<newsletter> newsList)
        {
            List<NewsletterRecord> newsRecordList = new List<NewsletterRecord>();
            NewsletterRecord record = new NewsletterRecord();

            for (int i = 0; i < newsList.Count; i++)
            {
                record = new NewsletterRecord();

                record.id = newsList[i].id;
                record.title = newsList[i].title;
                record.body = newsList[i].body;
                record.img_src = newsList[i].img_src;
                record.status = newsList[i].status;
                record.status_text = newsList[i].status == 1 ? "ACTIVE" : "INACTIVE";
                record.create_datetime = newsList[i].create_datetime;
                record.organization_id = newsList[i].organization_id;

                newsRecordList.Add(record);
            }

            return newsRecordList;
        }


        public class NewsletterRecord {
            public NewsletterRecord()
            {

            }

            public int id { get; set; }
            public string title { get; set; }
            public string body { get; set; }
            public string img_src { get; set; }
            public byte status { get; set; }
            public string status_text { get; set; }
            public Nullable<System.DateTime> create_datetime { get; set; }
            public int organization_id { get; set; }
        }
    }
}