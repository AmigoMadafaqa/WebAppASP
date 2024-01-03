using EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace EventMagnet.controller
{
    
    public class venueDA
    {
        string cs = Global.CS;
        public venueDA() { }

        public venue GetVenueByEventId(int eventID)
        {
            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var venue_model = db.event_venue.Where(ev => ev.event_id == eventID).Select(ev => ev.venue).FirstOrDefault();

                    return venue_model;
                }catch(Exception ex)
                {
                    Debug.WriteLine(ex.ToString());
                    return null;
                }
            }
        }

        public venue GetVenueByVenueId(int venueID)
        {
            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    var venue_model = db.event_venue.Where(ev => ev.id == venueID).Include(ev => ev.venue).Select(ev => ev.venue).FirstOrDefault();

                    return venue_model;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"Error in GetVenueByVenueId: {ex}");

                    throw;
                }
            }
        }


    }
}