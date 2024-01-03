using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;

using model = EventMagnet.modal;
using System.Xml.Linq;
using System.Collections;
using System.Security.Policy;
using System.Web.Configuration;
using EventMagnet.modal;
namespace EventMagnet.controller
{
    public class eventDA
    {
        string cs = Global.CS;
        public eventDA() { }

        public int SaveEventToDatabase(modal.@event newEvent)
        {
            int result = 0;

            try
            {
                modal.@event event_value = newEvent;

                //SQL 
                string sql = "INSERT INTO event (name, start_date, end_date, start_time, end_time, ticket_sale_start_datetime, ticket_sale_end_datetime, descp, keyword, category_name, img_src, status, create_datetime, organization_id) VALUES (@name, @start_date, @end_date, @start_time, @end_time, @ticket_sale_start_datetime, @ticket_sale_end_datetime, @descp, @keyword, @category_name, @img_src, @status, @create_datetime, @organization_id)";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@name", event_value.name);
                cmd.Parameters.AddWithValue("@start_date", event_value.start_date);
                cmd.Parameters.AddWithValue("@end_date", event_value.end_date);
                cmd.Parameters.AddWithValue("@start_time", event_value.start_time);
                cmd.Parameters.AddWithValue("@end_time", event_value.end_time);
                cmd.Parameters.AddWithValue("@ticket_sale_start_datetime", event_value.ticket_sale_start_datetime);
                cmd.Parameters.AddWithValue("@ticket_sale_end_datetime", event_value.ticket_sale_end_datetime);
                cmd.Parameters.AddWithValue("@descp", event_value.descp);
                cmd.Parameters.AddWithValue("@keyword", event_value.keyword);
                cmd.Parameters.AddWithValue("@category_name", event_value.category_name);
                cmd.Parameters.AddWithValue("@img_src", event_value.img_src);
                cmd.Parameters.AddWithValue("@status", event_value.status);
                cmd.Parameters.AddWithValue("@create_datetime", event_value.create_datetime);
                cmd.Parameters.AddWithValue("@organization_id", event_value.organization_id);

                conn.Open();
                int rowAffected = cmd.ExecuteNonQuery();
                conn.Close();

                if (rowAffected > 0)
                {
                    result = 1;
                }

            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return result;

        }

        public List<modal.@event> retrieveEventFromDatabase()
        {
            List<modal.@event> eventList = new List<model.@event> ();
            try
            {
                string sql = "SELECT * FROM event WHERE status = 1";
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    modal.@event eventItem = new modal.@event();

                    eventItem.id = Convert.ToInt32(reader["id"]);
                    eventItem.name = Convert.ToString(reader["name"]);
                    eventItem.start_date = Convert.ToDateTime(reader["start_date"]);
                    eventItem.end_date = Convert.ToDateTime(reader["end_date"]);
                    eventItem.start_time = TimeSpan.Parse(reader["start_time"].ToString());
                    eventItem.end_time = TimeSpan.Parse(reader["end_time"].ToString());
                    eventItem.ticket_sale_start_datetime = Convert.ToDateTime(reader["ticket_sale_start_datetime"]);
                    eventItem.ticket_sale_end_datetime = Convert.ToDateTime(reader["ticket_sale_end_datetime"]);
                    eventItem.descp = Convert.ToString(reader["descp"]);
                    eventItem.keyword = Convert.ToString(reader["keyword"]);
                    eventItem.category_name = Convert.ToString(reader["category_name"]);
                    eventItem.img_src = Convert.ToString(reader["img_src"]);
                    eventItem.status = Convert.ToByte(reader["status"]);
                    eventItem.create_datetime = reader["create_datetime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["create_datetime"]);
                    eventItem.organization_id = Convert.ToInt32(reader["organization_id"]);

                    eventList.Add(eventItem);
                }
            }
            catch(Exception ex)
            {
                string debuggerMsg = ex.Message;
            }
            return eventList;
        }

        public modal.@event retrieveEventByEventName(string eventName)
        {
            modal.@event event_value = new model.@event();
            try
            {
                // Ensure that the status column represents the status correctly
                // and is of type byte in the database.
                string sql = "SELECT * FROM event WHERE status = 1 AND name = @eventName";
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();

                cmd.Parameters.AddWithValue("@eventName", eventName);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {

                    event_value.id = Convert.ToInt32(reader["id"]);
                    event_value.name = Convert.ToString(reader["name"]);
                    event_value.start_date = Convert.ToDateTime(reader["start_date"]);
                    event_value.end_date = Convert.ToDateTime(reader["end_date"]);
                    event_value.start_time = TimeSpan.Parse(reader["start_time"].ToString());
                    event_value.end_time = TimeSpan.Parse(reader["end_time"].ToString());
                    event_value.ticket_sale_start_datetime = Convert.ToDateTime(reader["ticket_sale_start_datetime"]);
                    event_value.ticket_sale_end_datetime = Convert.ToDateTime(reader["ticket_sale_end_datetime"]);
                    event_value.descp = Convert.ToString(reader["descp"]);
                    event_value.keyword = Convert.ToString(reader["keyword"]);
                    event_value.category_name = Convert.ToString(reader["category_name"]);
                    event_value.img_src = Convert.ToString(reader["img_src"]);
                    event_value.status = Convert.ToByte(reader["status"]);
                    event_value.create_datetime = reader["create_datetime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["create_datetime"]);
                    event_value.organization_id = Convert.ToInt32(reader["organization_id"]);
                }
            }
            catch (Exception ex)
            {
                string debuggerMsg = ex.Message;
                // Consider logging the exception for further analysis.
            }
            return event_value;
        }

        public modal.@event getEventByEventNameOrganizationCategories(string eventName, int orgId, string category_name)
        {
            modal.@event event_value = new model.@event();
            try
            {
                string sql = "SELECT * FROM event WHERE status = 1 AND organization_id = @organization_id AND name = @eventName AND category_name = @category_name";

                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();

                cmd.Parameters.AddWithValue("@organization_id", orgId);
                cmd.Parameters.AddWithValue("@eventName", eventName);
                cmd.Parameters.AddWithValue("@category_name", category_name);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    event_value.id = Convert.ToInt32(reader["id"]);
                    event_value.name = Convert.ToString(reader["name"]);
                    event_value.start_date = Convert.ToDateTime(reader["start_date"]);
                    event_value.end_date = Convert.ToDateTime(reader["end_date"]);
                    event_value.start_time = TimeSpan.Parse(reader["start_time"].ToString());
                    event_value.end_time = TimeSpan.Parse(reader["end_time"].ToString());
                    event_value.ticket_sale_start_datetime = Convert.ToDateTime(reader["ticket_sale_start_datetime"]);
                    event_value.ticket_sale_end_datetime = Convert.ToDateTime(reader["ticket_sale_end_datetime"]);
                    event_value.descp = Convert.ToString(reader["descp"]);
                    event_value.keyword = Convert.ToString(reader["keyword"]);
                    event_value.category_name = Convert.ToString(reader["category_name"]);
                    event_value.img_src = Convert.ToString(reader["img_src"]);
                    event_value.status = Convert.ToByte(reader["status"]);
                    event_value.create_datetime = reader["create_datetime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["create_datetime"]);
                    event_value.organization_id = Convert.ToInt32(reader["organization_id"]);
                }

            }
            catch(Exception ex)
            {
                string debugMsg = ex.Message;
            }

            return event_value;
        }

        public modal.@event retrieveEventByEventId(int id)
        {
            modal.@event event_value = new modal.@event();
            try
            {
                string sql = "SELECT * FROM event WHERE id = @id AND status = 1";
                SqlConnection conn = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();

                cmd.Parameters.AddWithValue("@id", id);  

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    event_value.id = Convert.ToInt32(reader["id"]);
                    event_value.name = Convert.ToString(reader["name"]);
                    event_value.start_date = Convert.ToDateTime(reader["start_date"]);
                    event_value.end_date = Convert.ToDateTime(reader["end_date"]);
                    event_value.start_time = TimeSpan.Parse(reader["start_time"].ToString());
                    event_value.end_time = TimeSpan.Parse(reader["end_time"].ToString());
                    event_value.ticket_sale_start_datetime = Convert.ToDateTime(reader["ticket_sale_start_datetime"]);
                    event_value.ticket_sale_end_datetime = Convert.ToDateTime(reader["ticket_sale_end_datetime"]);
                    event_value.descp = Convert.ToString(reader["descp"]);
                    event_value.keyword = Convert.ToString(reader["keyword"]);
                    event_value.category_name = Convert.ToString(reader["category_name"]);
                    event_value.img_src = Convert.ToString(reader["img_src"]);
                    event_value.status = Convert.ToByte(reader["status"]);
                    event_value.create_datetime = reader["create_datetime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(reader["create_datetime"]);
                    event_value.organization_id = Convert.ToInt32(reader["organization_id"]);
                }
            }
            catch(Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }
            return event_value;
        }

        public bool softDeleteEvent(int eventId)
        {
            bool success = false;
            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var existingEvent = db.events.Find(eventId);

                    if (existingEvent != null)
                    {
                        existingEvent.status = 0;
                        db.SaveChanges();

                        success = true;
                    }
                    else
                    {
                        Debug.WriteLine($"Event with ID {eventId} not found.");
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }

            return success;
        }

        public bool updateEventByID(model.@event updatedEvent)
        {
            bool success = false;

            if (updatedEvent != null && updatedEvent.id > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();

                try
                {
                    // Retrieve the previous version of the event
                    modal.@event existingEvent = db.events.Find(updatedEvent.id);

                    if (existingEvent != null)
                    {
                        existingEvent.name = updatedEvent.name;
                        existingEvent.start_date = updatedEvent.start_date;
                        existingEvent.end_date = updatedEvent.end_date;
                        existingEvent.start_time = updatedEvent.start_time;
                        existingEvent.end_time = updatedEvent.end_time;
                        existingEvent.ticket_sale_start_datetime = updatedEvent.ticket_sale_start_datetime;
                        existingEvent.ticket_sale_end_datetime = updatedEvent.ticket_sale_end_datetime;
                        existingEvent.descp = updatedEvent.descp;
                        existingEvent.keyword = updatedEvent.keyword;
                        existingEvent.category_name = updatedEvent.category_name;
                        existingEvent.img_src = updatedEvent.img_src;
                        existingEvent.status = updatedEvent.status;

                        db.SaveChanges();

                        success = true;
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
                finally
                {
                    db.Dispose();
                }
            }

            return success;
        }


    }
}