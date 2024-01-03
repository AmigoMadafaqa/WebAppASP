using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Diagnostics;
using modal = EventMagnet.modal;
using System.Net.NetworkInformation;
using EventMagnet.modal;
using Stripe;

namespace EventMagnet.controller
{
    public class event_venueDA
    {
        string cs = Global.CS;
        public event_venueDA() { }

        public int insertVenueIntoDatabase(modal.event_venue newEventVenue)
        {
            int result = 0;

            try
            {
                // SQL statement
                string sql = "INSERT INTO event_venue (book_date, status, venue_id, event_id) VALUES (@book_date, @status, @venue_id, @event_id)";

                using (SqlConnection conn = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    // Add parameters
                    cmd.Parameters.AddWithValue("@book_date", newEventVenue.book_date);
                    cmd.Parameters.AddWithValue("@status", newEventVenue.status);
                    cmd.Parameters.AddWithValue("@venue_id", newEventVenue.venue_id);
                    cmd.Parameters.AddWithValue("@event_id", newEventVenue.event_id);

                    // Open the connection
                    conn.Open();

                    // Execute the query
                    int rowAffected = cmd.ExecuteNonQuery();

                    // Check if the insertion was successful
                    if (rowAffected > 0)
                    {
                        result = 1;
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
            }

            return result;
        }

        public modal.event_venue getEventVenueById(int venueId)
        {
            if (venueId > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();

                try
                {
                    IQueryable<modal.event_venue> venueQuery = db.event_venue.AsQueryable().Where(x => x.id == venueId);

                    venueQuery = venueQuery.Take(1);

                    // Execute the query
                    modal.event_venue resultVenue = venueQuery.FirstOrDefault();

                    return resultVenue;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }

            return null;
        }

        public modal.event_venue getEventVenueByEventID(int eventID)
        {
            if (eventID > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();
                try
                {
                    IQueryable<modal.event_venue> eventVenueQuery = db.event_venue.AsQueryable().Where(x => x.event_id == eventID);

                    eventVenueQuery = eventVenueQuery.Take(1);

                    modal.event_venue resultEventVenue = eventVenueQuery.FirstOrDefault();

                    return resultEventVenue;

                }catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }

            return null;
        }

        public bool softDeleteEventVenueStatus(int eventVenueId)
        {
            bool success = false;
            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var existingEventVenue = db.event_venue.Find(eventVenueId);

                    if (existingEventVenue != null)
                    {
                        existingEventVenue.status = 0;
                        db.SaveChanges();

                        success = true;
                    }
                    else
                    {
                        Debug.WriteLine($"Event venue with ID {eventVenueId} not found.");
                    }
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }
            return success;
        }

        public event_venue findEventVenue(int venueID, int eventID)
        {
            event_venue found_ev = null;

            if(venueID > 0 && eventID > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();

                try
                {
                    found_ev = db.event_venue.Where(ev => ev.venue_id == venueID && ev.event_id == eventID && ev.status == 1).FirstOrDefault();

                }catch(Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
                finally
                {
                    db.Dispose();
                }
            }

            return found_ev; 
        }

        public bool updateEventVenueByID(modal.event_venue updatedEventVenue)
        {
            bool success = false;

            if (updatedEventVenue != null && updatedEventVenue.id > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();

                try
                {
                    modal.event_venue existingEventVenue = db.event_venue.Find(updatedEventVenue.id);

                    if (existingEventVenue != null)
                    {
                        existingEventVenue.book_date = updatedEventVenue.book_date;
                        existingEventVenue.status = updatedEventVenue.status;
                        existingEventVenue.venue_id = updatedEventVenue.venue_id;
                        existingEventVenue.event_id = updatedEventVenue.event_id;

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