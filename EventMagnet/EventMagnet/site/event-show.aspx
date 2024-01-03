<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="event-show.aspx.cs" Inherits="EventMagnet.site.shows_events" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- ***** About Us Page ***** -->
    <div class="page-heading-shows-events">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Our Shows & Events</h2>
                    <span>Check out upcoming and past shows & events.</span>
                </div>
            </div>
        </div>
    </div>

    <div class="shows-events-tabs">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row" id="tabs">
                        <div class="col-lg-12">
                            <div class="heading-tabs">
                                <div class="row">
                                    <div class="col-lg-8">
                                        <ul>
                                          <li><a href='#tabs-1'>Upcoming</a></li>
                                          <li><a href='#tabs-2'>Past</a></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <section class='tabs-content'>
                                <article id='tabs-1'>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="heading"><h2>Upcoming</h2></div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="sidebar">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="heading-sidebar">
                                                            <h4>Sort The Upcoming Shows & Events By:</h4>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="month">
                                                            <h6>Month</h6>
                                                            <ul>
                                                                <li><a href="event-shows-val.aspx?month=1">January</a></li>
                                                                <li><a href="event-shows-val.aspx?month=2">February</a></li>
                                                                <li><a href="event-shows-val.aspx?month=3">March</a></li>
                                                                <li><a href="event-shows-val.aspx?month=4">April</a></li>
                                                                <li><a href="event-shows-val.aspx?month=5">May</a></li>
                                                                <li><a href="event-shows-val.aspx?month=6">Jun</a></li>
                                                                <li><a href="event-shows-val.aspx?month=7">July</a></li>
                                                                <li><a href="event-shows-val.aspx?month=8">August</a></li>
                                                                <li><a href="event-shows-val.aspx?month=9">September</a></li>
                                                                <li><a href="event-shows-val.aspx?month=10">October</a></li>
                                                                <li><a href="event-shows-val.aspx?month=11">November</a></li>
                                                                <li><a href="event-shows-val.aspx?month=12">December</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="category">
                                                            <h6>Category</h6>
                                                            <ul>
                                                                <li><a href="event-shows-val.aspx?category=Music">Music</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Visual Arts">Visual Arts</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Performing Arts">Performing Arts</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Film">Film</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Sport">Sport</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Business">Business</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Food & Drinks">Food & Drinks</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Festival & Fairs">Festival & Fairs</a></li>
                                                                <li><a href="event-shows-val.aspx?category=Lectures & Books">Lectures & Books</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="venues">
                                                            <h6>Venues</h6>
                                                            <ul>
                                                                <asp:Repeater runat="server" DataSourceID="venueGet">
                                                                    <ItemTemplate>
                                                                        <li><a href="event-shows-val.aspx?venueID=<%# Eval("id") %>"><%# Eval("name") %></a></li>
                                                                    </ItemTemplate>
                                                                </asp:Repeater>
                                                                <asp:SqlDataSource ID="venueGet" runat="server" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT * FROM [venue]" />
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-9">
                                            <div class="row">

                                                <asp:Repeater ID="upcomingRepeater" runat="server" DataSourceID="sqlUpcoming">
                                                    <ItemTemplate>

                                                        <div class="col-lg-12">
                                                            <div class="event-item">
                                                                <div class="row">
                                                                    <div class="col-lg-4">
                                                                        <div class="left-content">
                                                                            <h4><%# DataBinder.Eval(Container.DataItem, "name") %></h4>
                                                                            <div class="main-dark-button"><a href="ticket-detail.aspx?eventID=<%# Eval("event_id")%>&ticketRemain=<%# Eval("ticket_remain") %>">Discover More</a></div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-4">
                                                                        <div class="thumb">
                                                                            <img src="images/events/<%# Eval("img_src") %>" alt="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-4">
                                                                        <div class="right-content">
                                                                            <ul>
                                                                                <li>
                                                                                    <i class="fa fa-clock-o"></i>
                                                                                    <h6><%# ((DateTime)Eval("start_date")).ToString("MMM dd, yyyy") %><br><%# Eval("start_time", "{0:hh\\:mm}") %> - <%# Eval("end_time", "{0:hh\\:mm}") %></h6>
                                                                                </li>
                                                                                <li>
                                                                                    <i class="fa fa-map-marker"></i>
                                                                                    <span><%# Eval("venue_name") %></span>
                                                                                </li>
                                                                                <li>
                                                                                    <i class="fa fa-users"></i>
                                                                                    <span><%# Eval("participants_count") %> Total Guests Attending</span>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>    

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource ID="sqlUpcoming" runat="server" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, event.category_name, event.img_src, event.status AS event_status, event.create_datetime, event.organization_id AS event_organization_id, organization.email, organization.phone, admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain, COALESCE (order_item_summary.order_item_count, 0) AS participants_count FROM event INNER JOIN event_venue ON event.id = event_venue.event_id INNER JOIN venue ON event_venue.venue_id = venue.id INNER JOIN (SELECT event_id, SUM(total_qty) AS total_ticket_qty FROM ticket GROUP BY event_id) AS ticket_summary ON event.id = ticket_summary.event_id LEFT OUTER JOIN (SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count FROM ticket AS ticket_1 LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id GROUP BY ticket_1.event_id) AS order_item_summary ON event.id = order_item_summary.event_id INNER JOIN organization ON event.organization_id = organization.id INNER JOIN organization_admin ON organization.id = organization_admin.organization_id INNER JOIN admin ON organization_admin.admin_id = admin.id WHERE (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1) AND (event.start_date > GETDATE())" />


                                                <!-- UPcoming
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
                                                </div> -->


                                            </div>
                                        </div>
                                    </div>
                                </article>                            
                                <article id='tabs-2'>
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="heading"><h2>Upcoming</h2></div>
                                        </div>
                                        <div class="col-lg-3">
                                            <div class="sidebar">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="heading-sidebar">
                                                            <h4>Sort The Upcoming Shows & Events By:</h4>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="month">
                                                            <h6>Month</h6>
                                                            <ul>
                                                                <li><a href="#">July</a></li>
                                                                <li><a href="#">August</a></li>
                                                                <li><a href="#">September</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="category">
                                                            <h6>Category</h6>
                                                            <ul>
                                                                <li><a href="#">Pop Music</a></li>
                                                                <li><a href="#">Rock Music</a></li>
                                                                <li><a href="#">Hip Hop Music</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-lg-12">
                                                        <div class="venues">
                                                            <h6>Venues</h6>
                                                            <ul>
                                                                <li><a href="#">Radio City Musical Hall</a></li>
                                                                <li><a href="#">Madison Square Garden</a></li>
                                                                <li><a href="#">Royce Hall</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-9">
                                            <div class="row">


                                                <asp:Repeater ID="pastEvent" runat="server" DataSourceID="sqlPast">
                                                    <ItemTemplate>

                                                        <div class="col-lg-12">
                                                            <div class="event-item">
                                                                <div class="row">
                                                                    <div class="col-lg-4">
                                                                        <div class="left-content">
                                                                            <h4><%# DataBinder.Eval(Container.DataItem, "name") %></h4>
                                                                            <div class="main-dark-button"><a href="ticket-detail.aspx?eventID=<%# Eval("event_id")%>&ticketRemain=<%# Eval("ticket_remain") %>">Discover More</a></div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-4">
                                                                        <div class="thumb">
                                                                            <img src="images/events/<%# Eval("img_src") %>" alt="">
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-lg-4">
                                                                        <div class="right-content">
                                                                            <ul>
                                                                                <li>
                                                                                    <i class="fa fa-clock-o"></i>
                                                                                    <h6><%# ((DateTime)Eval("start_date")).ToString("MMM dd, yyyy") %><br><%# Eval("start_time", "{0:hh\\:mm}") %> - <%# Eval("end_time", "{0:hh\\:mm}") %></h6>
                                                                                </li>
                                                                                <li>
                                                                                    <i class="fa fa-map-marker"></i>
                                                                                    <span><%# Eval("venue_name") %></span>
                                                                                </li>
                                                                                <li>
                                                                                    <i class="fa fa-users"></i>
                                                                                    <span><%# Eval("participants_count") %> Total Guests Attending</span>
                                                                                </li>
                                                                            </ul>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>    

                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <asp:SqlDataSource ID="sqlPast" runat="server" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, event.category_name, event.img_src, event.status AS event_status, event.create_datetime, event.organization_id AS event_organization_id, organization.email, organization.phone, admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain, COALESCE (order_item_summary.order_item_count, 0) AS participants_count FROM event INNER JOIN event_venue ON event.id = event_venue.event_id INNER JOIN venue ON event_venue.venue_id = venue.id INNER JOIN (SELECT event_id, SUM(total_qty) AS total_ticket_qty FROM ticket GROUP BY event_id) AS ticket_summary ON event.id = ticket_summary.event_id LEFT OUTER JOIN (SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count FROM ticket AS ticket_1 LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id GROUP BY ticket_1.event_id) AS order_item_summary ON event.id = order_item_summary.event_id INNER JOIN organization ON event.organization_id = organization.id INNER JOIN organization_admin ON organization.id = organization_admin.organization_id INNER JOIN admin ON organization_admin.admin_id = admin.id WHERE (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1) AND (event.start_date < GETDATE())" />




                                                    <!--Passed 
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
                                                </div>-->
                                            </div>
                                        </div>
                                    </div>
                                </article>    
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
