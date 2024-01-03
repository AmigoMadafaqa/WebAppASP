using EventMagnet.controller;
using EventMagnet.modal;
using Stripe.Issuing;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using model = EventMagnet.modal;

namespace EventMagnet.site
{
    public partial class rent_venue : System.Web.UI.Page
    {
        string cs = Global.CS;
        //model.EventMagnetEntities db = new model.EventMagnetEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ddlVenue.SelectedValue = "1";
                ddlVenue_SelectedIndexChanged(sender, e);
            }
        }

        protected void ddlVenue_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindVenueDetails();
        }

        private void BindVenueDetails()
        {
            // Get the selected venue ID from the DropDownList
            string selectedVenueId = ddlVenue.SelectedValue;

            // Use the selected venue ID to fetch corresponding data from the database
            using (var db = new model.EventMagnetEntities())
            {
                if (int.TryParse(selectedVenueId, out int venueId))
                {
                    var venue = db.venues.Find(venueId);

                    // Bind the data to the Repeater
                    rptVenue.DataSource = new List<venue> { venue };
                    rptVenue.DataBind();
                }
            }
        }

        protected void btnVenue_Click(object sender, EventArgs e)
        {
            string id = ddlVenue.SelectedValue;
            try
            {
                if (id != null)
                {
                    //string selectedVenue = ddlVenue.SelectedItem.ToString();

                    string sql = "SELECT * FROM venue WHERE id=@id";

                    SqlConnection conn = new SqlConnection(cs);
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    conn.Open();
                    cmd.Parameters.AddWithValue("@id", id);

                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                            string name = reader["name"].ToString();
                            string desc = reader["descp"].ToString();
                            string addr = reader["address"].ToString();
                            string img_src = reader["img_src"].ToString();
                            string email = reader["email_contact"].ToString();
                            string phone = reader["phone_contact"].ToString();
                    
                    }
                    conn.Close();

                }
            }catch (Exception ex)
            {
                Response.Redirect("../error-page.aspx");
            }



        }
    }
}