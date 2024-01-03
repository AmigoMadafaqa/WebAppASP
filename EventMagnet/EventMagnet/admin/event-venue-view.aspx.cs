using EventMagnet.modal;
using Stripe.Terminal;
using System;
using System.Collections.Generic;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using model = EventMagnet.modal;
using System.Data.SqlClient;

namespace EventMagnet.admin
{
    public partial class event_venue_view : System.Web.UI.Page
    {

        string cs = Global.CS;
        string imageDestination = "~/admin/images/venues/";
        protected void Page_Load(object sender, EventArgs e)
        {
            model.venue venueRecord = new model.venue();
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["venueID"] != null)
                {
                    try
                    {
                        int venueId = int.Parse(Request.QueryString["venueID"]);
                        //lblVenueID.Text = venueId.ToString();
                        //RetrieveVenueFromDb(venueId);
                    
                            string sql = "SELECT * FROM venue WHERE id = @venueID";

                            SqlConnection conn = new SqlConnection(cs);
                            SqlCommand cmd = new SqlCommand(sql, conn);
                            conn.Open();

                            cmd.Parameters.AddWithValue("@venueID", venueId);
                            SqlDataReader read = cmd.ExecuteReader();

                            while (read.Read())
                            {
                                venueRecord.id = Convert.ToInt32(read["id"]);
                                venueRecord.name = Convert.ToString(read["name"]);
                                venueRecord.descp = Convert.ToString(read["descp"]);
                                venueRecord.address = Convert.ToString(read["address"]);
                                venueRecord.email_contact = Convert.ToString(read["email_contact"]);
                                venueRecord.phone_contact = Convert.ToString(read["phone_contact"]);
                                venueRecord.img_src = Convert.ToString(read["img_src"]);
                                venueRecord.status = Convert.ToByte(read["status"]);
                            }
                            conn.Close();
                        lblVenueID.Text = venueRecord.id.ToString();
                        lblVenueName.Text = venueRecord.name;
                        lblVenueDesc.Text = venueRecord.descp;
                        lblVenueAddr.Text = venueRecord.address;
                        lblPhNo.Text = venueRecord.phone_contact;
                        lblEmail.Text = venueRecord.email_contact;
                        lblImgPath.Text = imageDestination + venueRecord.img_src;
                        //lblStatus.Text = venueRecord.status.ToString();
                        //set the src of the image
                        ImgUpload.ImageUrl = lblImgPath.Text;

                        //change the status to active
                        if (venueRecord.status == 1)
                        {
                            lblStatus.Text = "Active";
                        }
                        else
                        {
                            lblStatus.Text = "Inactive";
                        }


                    }catch(SqlException ex)
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