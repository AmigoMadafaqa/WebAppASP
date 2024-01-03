<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="event-details.aspx.cs" Inherits="EventMagnet.site.event_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- ***** About Us Page ***** -->
    <div class="page-heading-rent-venue">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Event Details</h2>
                    <span>Check out our latest Shows & Events and be part of us.</span>
                </div>
            </div>
        </div>
    </div>

    <div class="shows-events-schedule">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-heading">
                        <h2>Event Listing</h2>
                    </div>
                </div>
                <div class="col-lg-12">
                    <ul>
                        <!---
                        <li>
                            <div class="row">
                                <div class="col-lg-3">
                                    <div class="title">
                                        <h4>Sunny Hill Festival</h4>
                                        <span>140 Tickets Available</span>
                                    </div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="time"><span><i class="fa fa-clock-o"></i> Sep 16, 2021<br>18:00 to 22:00</span></div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="place"><span><i class="fa fa-map-marker"></i>Copacabana Beach, <br>Rio de Janeiro</span></div>
                                </div>
                                <div class="col-lg-3">
                                    <div class="main-dark-button">
                                        <a href="ticket-detail.aspx">Purchase Tickets</a>
                                    </div>
                                </div>
                            </div>
                        </li>
                            --->

                        <asp:Repeater ID="OnGoingEventlisting" runat="server" DataSourceID="OnGoingEventSQLSource">
                            <ItemTemplate>

                                <li>
                                    <div class="row">
                                        <div class="col-lg-5">
                                            <div class="title">
                                                <h4><%# DataBinder.Eval(Container.DataItem, "name") %></h4>
                                                <span><%# Eval("ticket_remain") %> Tickets Available</span>
                                            </div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="time">
                                                <span>
                                                    <i class="fa fa-clock-o"></i>
                                                    <%# ((DateTime)Eval("start_date")).ToString("MMM dd, yyyy") %><br>
                                                    <%# Eval("start_time", "{0:hh\\:mm}") %> to <%# Eval("end_time", "{0:hh\\:mm}") %>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-lg-2">
                                            <div class="place"><span><i class="fa fa-map-marker"></i><%# Eval("venue_name") %>, <br></span></div>
                                        </div>
                                        <div class="col-lg-2">
                                            <div class="main-dark-button">
                                                <a href="ticket-detail.aspx?eventID=<%# Eval("event_id")%>&ticketRemain=<%# Eval("ticket_remain") %>">View Events</a>
                                            </div>
                                        </div>
                                    </div>
                                </li>

                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:SqlDataSource runat="server" ID="OnGoingEventSQLSource" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, event.category_name, event.img_src, event.status AS event_status, event.create_datetime, event.organization_id AS event_organization_id, organization.email, organization.phone, admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain FROM event INNER JOIN event_venue ON event.id = event_venue.event_id INNER JOIN venue ON event_venue.venue_id = venue.id INNER JOIN (SELECT event_id, SUM(total_qty) AS total_ticket_qty FROM ticket GROUP BY event_id) AS ticket_summary ON event.id = ticket_summary.event_id LEFT OUTER JOIN (SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count FROM ticket AS ticket_1 LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id GROUP BY ticket_1.event_id) AS order_item_summary ON event.id = order_item_summary.event_id INNER JOIN organization ON event.organization_id = organization.id INNER JOIN organization_admin ON organization.id = organization_admin.organization_id INNER JOIN admin ON organization_admin.admin_id = admin.id WHERE (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1) AND (event.start_date < GETDATE()) AND (event.end_date > GETDATE()) OR (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1) AND (event.start_date = GETDATE()) AND (event.end_time >= CONVERT (time, GETDATE())) OR (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1) AND (event.start_date > GETDATE())" />
                        
                    </ul>
                </div>
                <!---
                <div class="col-lg-12">
                    <div class="pagination">
                        <ul>
                            <li><a href="#">Prev</a></li>
                            <li><a href="#">1</a></li>
                            <li class="active"><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">Next</a></li>
                        </ul>
                    </div>
                </div>
                    --->
            </div>
        </div>
    </div>
</asp:Content>
