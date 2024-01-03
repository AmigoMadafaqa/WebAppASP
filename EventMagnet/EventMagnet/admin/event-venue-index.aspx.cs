using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using model = EventMagnet.modal;
using EventMagnet.modal;
using System.Runtime.Remoting.Messaging;

namespace EventMagnet.zDEl_admin
{

    public partial class event_venue_index : System.Web.UI.Page
    {
        string cs = Global.CS;
        //model.EventMagnetEntities db = new model.EventMagnetEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                using (var db = new model.EventMagnetEntities())
                {
                    //venues represents your database entity
                    List<venue> dataList = db.venues.ToList();

                    rVenue.DataSource = addStatusText(dataList);
                    rVenue.DataBind();

                    lblTotalCount.Text = "Total Venue Record : " + dataList.Count.ToString() + "<br/>" + "</br/>";
                }
            }
        }

        protected void btnEditVenue_Click(object sender, EventArgs e)
        {
            Button btnEditVenue = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnEditVenue.NamingContainer;
            HiddenField hfVenueID = (HiddenField)item.FindControl("hfVenueID");

            if (hfVenueID != null)
            {
                string venueID = hfVenueID.Value.ToString();
                Response.Redirect($"event-venue-update.aspx?VenueID={venueID}");
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnView.NamingContainer;
            HiddenField hfVenueID = (HiddenField)item.FindControl("hfVenueID");

            if (hfVenueID != null)
            {
                string venueID = hfVenueID.Value.ToString();
                Response.Redirect($"event-venue-view.aspx?VenueID={venueID}");
            }

        }

        protected void btnDltVenue_Click(object sender, EventArgs e)
        {
            Button btnDltVenue = (Button)sender;
            RepeaterItem item = (RepeaterItem)btnDltVenue.NamingContainer;
            HiddenField hfVenueID = (HiddenField)item.FindControl("hfVenueID");

                if (hfVenueID != null)
                {
                    model.venue venueRecord = new model.venue();
                    string venueID = hfVenueID.Value.ToString();

                    //prepare sql statement
                    string sql = "SELECT * FROM venue WHERE id=@venueID";

                    SqlConnection conn = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, conn);

                    conn.Open();
                    cmd.Parameters.AddWithValue("@venueID", venueID);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        //store the record into varaible
                        venueRecord.id = int.Parse(reader["id"].ToString());
                        venueRecord.name = reader["name"].ToString();
                        venueRecord.descp = reader["descp"].ToString();
                        venueRecord.address = reader["address"].ToString();
                        venueRecord.phone_contact = reader["phone_contact"].ToString();
                        venueRecord.email_contact = reader["email_contact"].ToString();
                        venueRecord.status = Byte.Parse(reader["status"].ToString());
                        venueRecord.img_src = reader["img_src"].ToString();

                        DltRecordFromDb(venueRecord);

                        Response.Redirect("event-venue-index.aspx");
                    }
                }
            
        }

        public List<VenueRecord> addStatusText(List<venue> venueList) {
            List <VenueRecord> venueRecordList = new List<VenueRecord>();
            VenueRecord record = new VenueRecord();

            for (int i = 0; i < venueList.Count; i++)
            {
                record = new VenueRecord();
                
                record.id = venueList[i].id;
                record.name = venueList[i].name;
                record.descp = venueList[i].descp;
                record.address = venueList[i].address;
                record.phone_contact = venueList[i].phone_contact;
                record.email_contact = venueList[i].email_contact;
                record.img_src = venueList[i].img_src;
                record.status = venueList[i].status;
                record.status_text = venueList[i].status == 1 ? "ACTIVE" : "INACTIVE";

                venueRecordList.Add(record);
            }

            return venueRecordList;
        }

        public int DltRecordFromDb(model.venue venueRecord)
        {
            int result = 0;
            model.venue dltRecord = venueRecord;

            string sql = "UPDATE venue SET status = @status WHERE id = @id";

            SqlConnection conn = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(sql, conn);

            conn.Open();
            cmd.Parameters.AddWithValue("id", dltRecord.id);
            cmd.Parameters.AddWithValue("status", 0);

            int rowAffected = cmd.ExecuteNonQuery();

            if (rowAffected > 0)
            {
                result = 1;
            }

            return result;
        }

        public class VenueRecord
        {
            public VenueRecord()
            {
            }

            public int id { get; set; }
            public string name { get; set; }
            public string descp { get; set; }
            public string address { get; set; }
            public string phone_contact { get; set; }
            public string email_contact { get; set; }
            public string img_src { get; set; }
            public byte status { get; set; }
            public string status_text { get; set; }

        }
    }
}