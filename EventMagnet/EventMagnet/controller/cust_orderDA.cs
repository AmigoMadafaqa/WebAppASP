using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using model = EventMagnet.modal;
using EventMagnet.modal;
using System.Diagnostics;
using Stripe;
namespace EventMagnet.controller
{
    public class cust_orderDA
    {
        string cs = Global.CS;
        public cust_orderDA() { }

        public List<model.cust_order> getCustOrderByOrderItems(List<order_item> order_Items)
        {
            List<model.cust_order> custOrderList = new List<model.cust_order>();
            if(order_Items != null && order_Items.Any())
            {
                using (EventMagnetEntities db = new EventMagnetEntities())
                {
                    try
                    {
                        var distinctCustOrderIDs = order_Items.Select(item => item.cust_order_id).Distinct();

                        foreach (var custOrderID in distinctCustOrderIDs)
                        {
                            model.cust_order cust_Order = db.cust_order.FirstOrDefault(item => item.id == custOrderID);

                            if(cust_Order != null)
                            {
                                custOrderList.Add(cust_Order);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine(ex.ToString());
                    }
                }
            }
            return custOrderList;
        }

        public bool softDeleteCustOrder(List<order_item> orderItems)
        {
            if (orderItems == null || orderItems.Count == 0)
            {
                return false;
            }

            using (EventMagnetEntities db = new EventMagnetEntities())
            {
                try
                {
                    List<int> custOrderIDs = orderItems.Select(item => item.cust_order_id).Distinct().ToList();

                    if (custOrderIDs.Any())
                    {
                        var existingCustOrders = db.cust_order.Where(x => custOrderIDs.Contains(x.id)).ToList();
                        if (existingCustOrders.Any())
                        {
                            foreach (var custOrder in existingCustOrders)
                            {
                                custOrder.status = 0;
                            }
                            db.SaveChanges();
                            return true;
                        }
                    }

                    return false;
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(ex.Message);
                    return false;
                }
            }
        }


    }
}