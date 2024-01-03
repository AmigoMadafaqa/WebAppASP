<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EventMagnet.site.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- ***** Main Banner Area Start ***** -->
    <div class="main-banner">

        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="main-content">
                        <div class="next-show">
                            
                        </div>
                        <h6>Opening on Thursday, March 31st</h6>
                        <h2>The Sunny Hill Festival 2022</h2>
                        <div class="main-white-button">
                            <a href="event-show.aspx">View Events</a>
                        </div>
                    </div>
                </div>
            </div>
         </div>
      </div>
   </div>
   <!-- ***** Main Banner Area End ***** -->
   <!-- *** Owl Carousel Items ***-->
   <div class="show-events-carousel">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="owl-show-events owl-carousel">
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-01.jpg" alt=""></a>
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-02.jpg" alt=""></a> 
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-03.jpg" alt=""></a> 
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-04.jpg" alt=""></a> 
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-01.jpg" alt=""></a> 
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-02.jpg" alt=""></a> 
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-03.jpg" alt=""></a> 
                  </div>
                  <div class="item">
                     <a href="event-detail.aspx"><img src="images/show-events-04.jpg" alt=""></a> 
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- *** Advertising *** -->
   <div class="amazing-advertising">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <div class="section-heading">
                  <h2 >Newsletter</h2>
               </div>
            </div>
            <div>
               <!-- datalist -->
               <asp:ListView ID="lvNewsletter" runat="server" DataKeyNames="id" 
                  DataSourceID="sdsNews" InsertItemPosition="none" 
                  >
                  <ItemTemplate>
                     <div style="border: 1px solid #ccc; padding: 10px; margin: 10px; width: 430px; height:320px;display: inline-block;text-align:center; border-radius:10px; width:100%;">
                        <a href="event-detail.aspx">
                           <asp:Image ID="imgAds" runat="server" Height="300px" Width="400px" CssClass="auto-style2" ImageAlign="Left" style="border-radius:10px" ImageUrl='<%# "~/admin/images/newsletter/" +Eval("img_src") %>' AlternateText='<%# "~/admin/images/newsletter/" +Eval("img_src") %>'/>
                        </a>
                        <hr />
                        <h4><%# Eval("title") %>  </h4>
                        <br />
                        <h6 style="text-decoration:underline;">Event Content :</h6>
                        <p><%# Eval("body") %></p>
                        <hr />
                     </div>
                  </ItemTemplate>
                  <EmptyDataTemplate>
                     <p>No data available.</p>
                  </EmptyDataTemplate>
                  <LayoutTemplate>
                     <div id="itemPlaceholderContainer" runat="server" style="display: inline-block; width:100%">
                        <span runat="server" id="itemPlaceholder" />
                     </div>
                     <div style="clear: both;"></div>
                     <asp:DataPager ID="dpNews" runat="server" PagedControlID="lvNewsletter" PageSize="1" ButtonCssClass="btn btn-outline-dark" >
                        <Fields>
                           <asp:NextPreviousPagerField ButtonType="Button" ShowNextPageButton="True" ShowPreviousPageButton="True" />
                        </Fields>
                     </asp:DataPager>
                  </LayoutTemplate>
               </asp:ListView>
               <asp:SqlDataSource ID="sdsNews" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT [id], [body], [title], [img_src] FROM [newsletter] WHERE ([status] = @status)">
                  <SelectParameters>
                     <asp:Parameter DefaultValue="1" Name="status" Type="Byte" />
                  </SelectParameters>
               </asp:SqlDataSource>
               <!-- end of datalist -->
            </div>
         </div>
      </div>
   </div>
   <!-- *** End of Advertising *** -->
   <!-- *** Amazing Venus ***-->
   <div class="amazing-venues">
      <div class="container">
         <div class="row">
            <div class="col-lg-9">
               <div class="left-content">
                  <h4>Amazing Venue for events</h4>
                  <p>Event Magnet is a website which allow client(event organizer) to publish their events to let the users join on their event.
                     Users can also buy the ticket of the event which they feel interested through this website to join the event.<br />
                     <br />
                     There are several webpages for this website, which are <a href="index.aspx">Homepage</a>, <a href="about.aspx">About</a>, 
                     <a href="venue-rent.aspx">Rent a venue</a>, <a href="event-show.aspx">shows &amp; events</a>, 
                     <a href="event-detail.aspx">event details</a>, <a href="ticket.aspx">tickets</a>, and <a href="ticket-detail.aspx">ticket details</a>. <br />
                     <br />
                     Having any problem while using the website? Feel free to <a href="mailto:tarumt@tarc.edu.my">Contact Us</a>.
                  </p>
                  <br />
               </div>
            </div>
            <div class="col-lg-3">
               <div class="right-content">
                  <h5><i class="fa fa-map-marker"></i> Visit Us</h5>
                  <span> 77, Lorong Lembah Permai 3, <br>11200 Tanjung Bungah, <br />Pulau Pinang, <br>Malaysia</span>
                  <div class="text-button"><a href="https://www.google.com/maps/place/TAR+UMT+Penang+Branch/@5.4532105,100.2800089,17z/data=!3m1!4b1!4m6!3m5!1s0x304ac2c0305a5483:0xfeb1c7560c785259!8m2!3d5.4532052!4d100.2848745!16s%2Fg%2F1tjvtncs?entry=ttu">Need Directions? <i class="fa fa-arrow-right"></i></a></div>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- *** Map ***-->
   <div class="map-image" style="display:flex;justify-content:center;">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3971.760984528147!2d100.28229957498445!3d5.45320519452633!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304ac2c0305a5483%3A0xfeb1c7560c785259!2sTAR%20UMT%20Penang%20Branch!5e0!3m2!1sen!2smy!4v1702815964940!5m2!1sen!2smy" width="2000" height="400" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
      <%--<img src="venues/TARUMT-location-index.png" alt="Event Location"/>--%>
   </div>
   <!-- *** Venues & Tickets ***-->
   <div class="venue-tickets">
      <div class="container-fluid">
          <!---
         <div class="row">
            <div class="col-lg-12">
               <div class="section-heading">
                  <h2>Our Events & Tickets</h2>
               </div>
            </div>
            <div class="col-lg-4">
               <div class="venue-item">
                  <div class="thumb">
                     <img src="images/venue-01.jpg" alt="">
                  </div>
                  <div class="down-content">
                     <div class="left-content">
                        <div class="main-white-button">
                           <a href="ticket-detail.aspx?">Purchase Tickets</a>
                        </div>
                     </div>
                     <div class="right-content">
                        <h4>RhythmReverie Rock Revolution</h4>
                        <p>National Arena Stadium</p>
                        <ul>
                           <li><i class="fa fa-sitemap"></i>250</li>
                           <li><i class="fa fa-user"></i>500</li>
                        </ul>
                        <div class="price">
                           <span>1 ticket<br>from <em>RM45</em></span>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-lg-4">
               <div class="venue-item">
                  <div class="thumb">
                     <img src="images/venue-02.jpg" alt="">
                  </div>
                  <div class="down-content">
                     <div class="left-content">
                        <div class="main-white-button">
                           <a href="ticket-detail.aspx">Purchase Tickets</a>
                        </div>
                     </div>
                     <div class="right-content">
                        <h4>Madison Square Garden</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur vinzi iscing elit, sed doers kontra.</p>
                        <ul>
                           <li><i class="fa fa-sitemap"></i>450</li>
                           <li><i class="fa fa-user"></i>650</li>
                        </ul>
                        <div class="price">
                           <span>1 ticket<br>from <em>RM55</em></span>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-lg-4">
               <div class="venue-item">
                  <div class="thumb">
                     <img src="images/venue-03.jpg" alt="">
                  </div>
                  <div class="down-content">
                     <div class="left-content">
                        <div class="main-white-button">
                           <a href="ticket-detail.aspx">Purchase Tickets</a>
                        </div>
                     </div>
                     <div class="right-content">
                        <h4>Royce Hall</h4>
                        <p>Lorem ipsum dolor sit amet, consectetur vinzi iscing elit, sed doers kontra.</p>
                        <ul>
                           <li><i class="fa fa-sitemap"></i>450</li>
                           <li><i class="fa fa-user"></i>750</li>
                        </ul>
                        <div class="price">
                           <span>1 ticket<br>from <em>RM65</em></span>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
              --->
      </div>
   </div>
   <!-- *** Coming Events ***-->
   <div class="coming-events">
      <div class="left-button">
         <div class="main-white-button">
            <a href="event-show.aspx">Discover More</a>
         </div>
      </div>
      <div class="container">
         <div class="row">
            <div class="col-lg-4">
               <div class="event-item">
                  <div class="thumb">
                     <a href="event-detail.aspx"><img src="images/event-01.jpg" alt=""></a>
                  </div>
                  <div class="down-content">
                     <a href="event-detail.aspx">
                        <h4>Radio City Musical Hall</h4>
                     </a>
                     <ul>
                        <li><i class="fa fa-clock-o"></i> Tuesday: 15:30-19:30</li>
                        <li><i class="fa fa-map-marker"></i> Copacabana Beach, Rio de Janeiro</li>
                     </ul>
                  </div>
               </div>
            </div>
            <div class="col-lg-4">
               <div class="event-item">
                  <div class="thumb">
                     <a href="event-detail.aspx"><img src="images/event-02.jpg" alt=""></a>
                  </div>
                  <div class="down-content">
                     <a href="event-detail.aspx">
                        <h4>Madison Square Garden</h4>
                     </a>
                     <ul>
                        <li><i class="fa fa-clock-o"></i> Wednesday: 08:00-14:00</li>
                        <li><i class="fa fa-map-marker"></i> Copacabana Beach, Rio de Janeiro</li>
                     </ul>
                  </div>
               </div>
            </div>
            <div class="col-lg-4">
               <div class="event-item">
                  <div class="thumb">
                     <a href="event-detail.aspx"><img src="images/event-03.jpg" alt=""></a>
                  </div>
                  <div class="down-content">
                     <a href="event-detail.aspx">
                        <h4>Royce Hall</h4>
                     </a>
                     <ul>
                        <li><i class="fa fa-clock-o"></i> Thursday: 09:00-23:00</li>
                        <li><i class="fa fa-map-marker"></i> Copacabana Beach, Rio de Janeiro</li>
                     </ul>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</asp:Content>