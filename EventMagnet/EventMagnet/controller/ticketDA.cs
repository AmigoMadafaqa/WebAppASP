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
using System.Linq.Expressions;

namespace EventMagnet.controller
{ 
    public class ticketDA
    {
        string cs = Global.CS;
        public ticketDA() { }

        public int SaveTicketToDatabase(modal.ticket newTicket)
        {
            int result = 0;
            try
            {
                // sql statement
                string sql = "INSERT INTO ticket(name, price, total_qty, status, event_id) VALUES(@name, @price, @total_qty, @status, @event_id)";

                using (SqlConnection conn = new SqlConnection(cs))
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@name", newTicket.name);
                    cmd.Parameters.AddWithValue("@price", newTicket.price);
                    cmd.Parameters.AddWithValue("@total_qty", newTicket.total_qty);
                    cmd.Parameters.AddWithValue("@status", newTicket.status);
                    cmd.Parameters.AddWithValue("@event_id", newTicket.event_id);

                    conn.Open();
                    int rowAffected = cmd.ExecuteNonQuery();

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

        public modal.ticket GetTicketInfoById(int ticketId)
        {
            if (ticketId > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();

                IQueryable<modal.ticket> ticketQuery = db.tickets.AsQueryable().Where(x => x.id == ticketId);

                ticketQuery = ticketQuery.Take(1);

                // Execute the query
                modal.ticket resultTicket = ticketQuery.FirstOrDefault();

                return resultTicket;
            }

            return null;
        }   

        public List<modal.ticket> retriveTicketInfoByEventID(int eventID)
        {
            List<modal.ticket> eventTicketList = new List<modal.ticket>();
            if(eventID > 0)
            {
                using (EventMagnetEntities db = new EventMagnetEntities())
                {
                    try
                    {
                        eventTicketList = db.tickets.Where(x => x.event_id == eventID).ToList();
                    }catch (Exception ex)
                    {
                        Debug.WriteLine(ex.Message, ex);
                    }
                }

            }
            return eventTicketList;
        }

        public bool softDeleteTickets(List<int> ticketIDs)
        {
            if (ticketIDs == null || ticketIDs.Count == 0)
            {
                return false;
            }

            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var existingTickets = db.tickets.Where(x => ticketIDs.Contains(x.id)).ToList();

                    if (existingTickets.Any())
                    {
                        foreach (var ticket in existingTickets)
                        {
                            ticket.status = 0;
                        }
                        db.SaveChanges();
                        return true;
                    }

                    // No tickets found
                    return false;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                    return false;
                }
            }
        }

        public bool updateTicketByID(ticket updatedTicket)
        {
            bool success = false;

            if(updatedTicket != null & updatedTicket.id > 0)
            {
                EventMagnetEntities db = new EventMagnetEntities();

                try
                {
                    //getting the previous version of ticket info 
                    ticket existingTicket = db.tickets.Find(updatedTicket.id);

                    if(existingTicket != null)
                    {
                        existingTicket.name = updatedTicket.name;
                        existingTicket.price = updatedTicket.price;
                        existingTicket.total_qty = updatedTicket.total_qty;
                        existingTicket.status = updatedTicket.status;
                        existingTicket.event_id = updatedTicket.event_id;

                        db.SaveChanges();

                        success = true;
                    }
                }catch(Exception ex)
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