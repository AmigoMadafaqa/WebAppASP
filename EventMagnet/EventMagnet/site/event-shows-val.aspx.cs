using EventMagnet.controller;
using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.site
{
    public partial class event_shows_val : System.Web.UI.Page
    {
        venueDA venue_DA = new venueDA();
        protected void Page_Load(object sender, EventArgs e)
        {
            bool dataOrNot = false;
            if (!IsPostBack)
            {
                if (Request.QueryString["month"] != null)
                {
                    int month = int.Parse(Request.QueryString["month"]);
                    filterOption.Text = GetMonthName(month);

                    dataOrNot = BindEventDataByMonth(month);
                }
                if (Request.QueryString["category"] != null)
                {
                    string category = Request.QueryString["category"];
                    filterOption.Text = category;

                    dataOrNot = BindEventDataByCategory(category);
                }
                if (Request.QueryString["venueID"] != null)
                {
                    int venueID = int.Parse(Request.QueryString["venueID"]);
                    venue venue = venue_DA.GetVenueByVenueId(venueID);
                    filterOption.Text = venue.name;
                    
                    dataOrNot = BindEventDataByVenueID(venueID);
                }

                if (dataOrNot == false)
                {
                    ViewState["dataOrNot"] = dataOrNot;
                }

            }
        }

        private void BindEventData()
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ToString();
            string sqlQuery = "SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, event.category_name, event.img_src, event.status AS event_status, event.create_datetime, event.organization_id AS event_organization_id, organization.email, organization.phone, admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain, COALESCE (order_item_summary.order_item_count, 0) AS participants_count FROM event INNER JOIN event_venue ON event.id = event_venue.event_id INNER JOIN venue ON event_venue.venue_id = venue.id INNER JOIN (SELECT event_id, SUM(total_qty) AS total_ticket_qty FROM ticket GROUP BY event_id) AS ticket_summary ON event.id = ticket_summary.event_id LEFT OUTER JOIN (SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count FROM ticket AS ticket_1 LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id GROUP BY ticket_1.event_id) AS order_item_summary ON event.id = order_item_summary.event_id INNER JOIN organization ON event.organization_id = organization.id INNER JOIN organization_admin ON organization.id = organization_admin.organization_id INNER JOIN admin ON organization_admin.admin_id = admin.id WHERE (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1) AND (event.start_date > GETDATE())"; 

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();
                    upcomingRepeater.DataSource = reader;
                    upcomingRepeater.DataBind();
                    reader.Close();
                    connection.Close();
                }
            }
        }

        private bool BindEventDataByMonth(int month)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ToString();

            // Use parameterized query to prevent SQL injection
            string sqlQuery = @"SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, 
                        venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, 
                        organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, 
                        event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, 
                        event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, 
                        event.category_name, event.img_src, event.status AS event_status, event.create_datetime, 
                        event.organization_id AS event_organization_id, organization.email, organization.phone, 
                        admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, 
                        venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain, 
                        COALESCE (order_item_summary.order_item_count, 0) AS participants_count 
                  FROM event 
                  INNER JOIN event_venue ON event.id = event_venue.event_id 
                  INNER JOIN venue ON event_venue.venue_id = venue.id 
                  INNER JOIN (
                        SELECT event_id, SUM(total_qty) AS total_ticket_qty 
                        FROM ticket 
                        GROUP BY event_id
                  ) AS ticket_summary ON event.id = ticket_summary.event_id 
                  LEFT OUTER JOIN (
                        SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count 
                        FROM ticket AS ticket_1 
                        LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id 
                        GROUP BY ticket_1.event_id
                  ) AS order_item_summary ON event.id = order_item_summary.event_id 
                  INNER JOIN organization ON event.organization_id = organization.id 
                  INNER JOIN organization_admin ON organization.id = organization_admin.organization_id 
                  INNER JOIN admin ON organization_admin.admin_id = admin.id 
                  WHERE (organization_admin.is_owner = 1) 
                        AND (event.status = 1) 
                        AND (organization.status = 1) 
                        AND MONTH(event.start_date) = @Month";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    // Add a parameter for the month
                    command.Parameters.AddWithValue("@Month", month);

                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    // Check if there are rows in the result set
                    bool hasData = reader.HasRows;

                    upcomingRepeater.DataSource = reader;
                    upcomingRepeater.DataBind();
                    reader.Close();
                    connection.Close();

                    return hasData;
                }
            }
        }

        private bool BindEventDataByCategory(string category)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ToString();

            string sqlQuery = @"SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, 
                        venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, 
                        organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, 
                        event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, 
                        event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, 
                        event.category_name, event.img_src, event.status AS event_status, event.create_datetime, 
                        event.organization_id AS event_organization_id, organization.email, organization.phone, 
                        admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, 
                        venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain, 
                        COALESCE (order_item_summary.order_item_count, 0) AS participants_count 
                  FROM event 
                  INNER JOIN event_venue ON event.id = event_venue.event_id 
                  INNER JOIN venue ON event_venue.venue_id = venue.id 
                  INNER JOIN (
                        SELECT event_id, SUM(total_qty) AS total_ticket_qty 
                        FROM ticket 
                        GROUP BY event_id
                  ) AS ticket_summary ON event.id = ticket_summary.event_id 
                  LEFT OUTER JOIN (
                        SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count 
                        FROM ticket AS ticket_1 
                        LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id 
                        GROUP BY ticket_1.event_id
                  ) AS order_item_summary ON event.id = order_item_summary.event_id 
                  INNER JOIN organization ON event.organization_id = organization.id 
                  INNER JOIN organization_admin ON organization.id = organization_admin.organization_id 
                  INNER JOIN admin ON organization_admin.admin_id = admin.id 
                  WHERE (organization_admin.is_owner = 1) 
                        AND (event.status = 1) 
                        AND (organization.status = 1) 
                        AND event.category_name = @Category";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    // Add a parameter for the category
                    command.Parameters.AddWithValue("@Category", category);

                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    // Check if there are rows in the result set
                    bool hasData = reader.HasRows;

                    upcomingRepeater.DataSource = reader;
                    upcomingRepeater.DataBind();
                    reader.Close();
                    connection.Close();

                    return hasData;
                }
            }
        }

        private bool BindEventDataByVenueID(int venueID)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ToString();

            string sqlQuery = @"SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, 
                        venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, 
                        organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, 
                        event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, 
                        event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, 
                        event.category_name, event.img_src, event.status AS event_status, event.create_datetime, 
                        event.organization_id AS event_organization_id, organization.email, organization.phone, 
                        admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, 
                        venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain, 
                        COALESCE (order_item_summary.order_item_count, 0) AS participants_count 
                  FROM event 
                  INNER JOIN event_venue ON event.id = event_venue.event_id 
                  INNER JOIN venue ON event_venue.venue_id = venue.id 
                  INNER JOIN (
                        SELECT event_id, SUM(total_qty) AS total_ticket_qty 
                        FROM ticket 
                        GROUP BY event_id
                  ) AS ticket_summary ON event.id = ticket_summary.event_id 
                  LEFT OUTER JOIN (
                        SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count 
                        FROM ticket AS ticket_1 
                        LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id 
                        GROUP BY ticket_1.event_id
                  ) AS order_item_summary ON event.id = order_item_summary.event_id 
                  INNER JOIN organization ON event.organization_id = organization.id 
                  INNER JOIN organization_admin ON organization.id = organization_admin.organization_id 
                  INNER JOIN admin ON organization_admin.admin_id = admin.id 
                  WHERE (organization_admin.is_owner = 1) 
                        AND (event.status = 1) 
                        AND (organization.status = 1) 
                        AND venue.id = @VenueID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    // Add a parameter for the venue ID
                    command.Parameters.AddWithValue("@VenueID", venueID);

                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    // Check if there are rows in the result set
                    bool hasData = reader.HasRows;

                    upcomingRepeater.DataSource = reader;
                    upcomingRepeater.DataBind();
                    reader.Close();
                    connection.Close();

                    return hasData;
                }
            }
        }

        public static string GetMonthName(int monthNumber)
        {
            if (monthNumber < 1 || monthNumber > 12)
            {
                throw new ArgumentException("Month number must be between 1 and 12.", nameof(monthNumber));
            }

            DateTimeFormatInfo dtfi = new DateTimeFormatInfo();
            return dtfi.GetMonthName(monthNumber);
        }

    }
}