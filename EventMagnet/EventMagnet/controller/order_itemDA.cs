using model = EventMagnet.modal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Diagnostics;
using EventMagnet.modal;

namespace EventMagnet.controller
{
    public class order_itemDA
    {
        string cs = Global.CS;
        public order_itemDA() { }

        public List<model.order_item> retrieveOrderItemsByTicketIDs(List<int> ticketIDs)
        {
            List<model.order_item> orderItemLists = new List<model.order_item>();

            if(ticketIDs != null && ticketIDs.Any())
            {
                using (EventMagnetEntities db = new EventMagnetEntities())
                {
                    try
                    {
                        orderItemLists = db.order_item.Where(x => ticketIDs.Contains(x.ticket_id)).ToList();
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.Message);
                    }
                }
            }

            return orderItemLists;
        }

        public bool softDeleteOrderItemStatus(List<model.order_item> orderItems)
        {
            bool success = false;
            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    foreach (var orderItem in orderItems)
                    {
                        var existingOrderItem = db.order_item.Find(orderItem.id);

                        if (existingOrderItem != null)
                        {
                            existingOrderItem.status = 0;
                        }
                    }
                    db.SaveChanges();

                    success = true;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                }
            }
            return success;
        }

    }
}