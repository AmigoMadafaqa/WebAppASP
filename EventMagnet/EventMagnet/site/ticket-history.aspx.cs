using EventMagnet.modal;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EventMagnet.site
{
    public partial class customer_ticket : System.Web.UI.Page
    {
        private string cs = ConfigurationManager.ConnectionStrings["eventMagnetConnectionString"].ConnectionString;
        private List<TicketRecord> ticketArr = new List<TicketRecord>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cust"] != null)
            {
                ticketArr = getTicketRecord(((customer)Session["cust"]).id);
                renderPlaceHolderTicket();
            }
        }

        void renderPlaceHolderTicket()
        {
            placeHolderTicket.Controls.Clear();

            string statusText = "";
            Guid previousCustOrderUUID = new Guid();

            for (int i = 0; i < ticketArr.Count; i++)
            {
                TicketRecord record = ticketArr[i];
                statusText = (record.status == 1) ? "<i class=\"fa-solid fa-check\"></i>&nbsp;Paid" : "<i class=\"fa-solid fa-xmark\"></i>&nbsp;Failed";
        

                if (!previousCustOrderUUID.Equals(record.custOrderUUID))
                {
                    placeHolderTicket.Controls.Add(new LiteralControl(
                        @"<tr style=""
                            background-color: rgba(0,0,0,.03);
                        "">
                            <td colspan=""6"">Order ID : " + record.custOrderUUID.ToString() + @"</td>
                        </tr>"
                        ));

                    previousCustOrderUUID = record.custOrderUUID;
                }
               

                placeHolderTicket.Controls.Add(new LiteralControl(
                    @"
                 <tr>
                    <td>" + (i + 1).ToString() + @"</td>
                    <td>" + record.eventName + @"</td>
                    <td>" + record.ticketName + @" Ticket</td>

                    <td>" + record.createDatetime.ToString() + @"</td>
                    <td>
                "
                    ));

                Button btnQRCode = new Button();
                btnQRCode.ID = "btnQRCode_" + i.ToString();
                btnQRCode.Text = "Show QR Code";
                btnQRCode.Attributes.Add("runat", "server");
                btnQRCode.UseSubmitBehavior = false;
                btnQRCode.CssClass = "btn btn-outline-dark";
                btnQRCode.OnClientClick = "showQRCodeModal('" + record.ticketUUID.ToString() + "');return false;";

                if (record.status == 1)
                {
                    placeHolderTicket.Controls.Add(btnQRCode);
                }


                placeHolderTicket.Controls.Add(new LiteralControl(
                  @"
                    </td>
                    <td>" + statusText + @"</td>
                </tr>
                "
                  ));


            }
        }

        List<TicketRecord> getTicketRecord(int custId)
        {
            List<TicketRecord> ticketRecord = new List<TicketRecord>();

            SqlConnection con = new SqlConnection(cs);
            con.Open();

            // insert payment method record
            string query = @"
                
             SELECT co.uuid AS cust_order_uuid, e.name AS event_name, t.name AS ticket_name, co.create_datetime, oi.uuid AS ticket_uuid, co.status
             FROM customer c 
	            JOIN cust_order co ON c.id = co.customer_id 
		            AND c.id = @custId
		            AND co.status in (0,1,2)
	            JOIN order_item oi ON oi.cust_order_id = co.id
		            AND oi.status = 1
	            JOIN ticket t ON oi.ticket_id = t.id
		            AND t.status = 1
	            JOIN event e ON t.event_id = e.id
		            AND e.status = 1
            ORDER BY co.create_datetime desc, t.id
             
            ";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@custId", custId);

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                ticketRecord.Add(new TicketRecord(
                    Guid.Parse(Convert.ToString(dr["cust_order_uuid"])),
                    Convert.ToString(dr["event_name"]),
                    Convert.ToString(dr["ticket_name"]),
                    Convert.ToDateTime(dr["create_datetime"]),
                    Guid.Parse(Convert.ToString(dr["ticket_uuid"])),
                    Convert.ToInt32(dr["status"])
                ));
            }

            con.Close();

            return ticketRecord;
        }

        public class TicketRecord
        {
            public Guid custOrderUUID { get; set; }
            public string eventName { get; set; }
            public string ticketName { get; set; }
            public DateTime createDatetime { get; set; }
            public Guid ticketUUID { get; set; }
            public int status { get; set; }

            public TicketRecord(Guid custOrderUUID, string eventName, string ticketName, DateTime createDatetime, Guid ticketUUID, int status)
            {
                this.custOrderUUID = custOrderUUID;
                this.eventName = eventName;
                this.ticketName = ticketName;
                this.createDatetime = createDatetime;
                this.ticketUUID = ticketUUID;
                this.status = status;
            }
        }


    }
}