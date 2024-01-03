<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="event-shows-val.aspx.cs" Inherits="EventMagnet.site.event_shows_val" %>
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
                                          <li></li>
                                          <li></li>
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
                                            <div class="heading"><h2><asp:Literal ID="filterOption" Text="" runat="server" /></h2></div>
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

                                                <%
                                                    if (ViewState["dataOrNot"] != null)
                                                    {
                                                        bool dataOrNot = (bool)ViewState["dataOrNot"];
                                                        
                                                        if(dataOrNot == false)
                                                        {
                                                        %>
                                                            <div class="col-lg-12">
                                                                <div class="event-item">
                                                                    <div class="row">
                                                                        <div class="col-lg-12 d-flex justify-content-center">
                                                                            <p class="fs-1 fw-bolde" style="font-size:25px">Sorry, No Data Found.</p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>  
                                                        <%
                                                        }
                                                    }%>


                                                <asp:Repeater ID="upcomingRepeater" runat="server">
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
                                 
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
