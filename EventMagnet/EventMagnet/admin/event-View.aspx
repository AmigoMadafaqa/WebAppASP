<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-view.aspx.cs" Inherits="EventMagnet.zDEl_admin.event_view" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <% List<EventMagnet.modal.ticket> ticketList = Session["ticketList"] as List<EventMagnet.modal.ticket>;
     string imgSource = ViewState["imgSource"].ToString();
     %>
    <style>
        .read-only-textbox {
            background-color: #fff !important;
        }
    </style>
<!-- Content -->
<div class="container-xxl flex-grow-1 container-p-y">
   <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> View Event</h4>
   <div class="row mb-5">
      <div class="col-md">
         <div class="card mb-3">
            <div class="row g-0">
               <!-- Images Display -->
               <div class="col-md-12 text-center pt-5">
                  <div class="rounded mx-auto d-block">
                     <img style="width: 480px;" class="card-img card-img-center" src="images/events/<%=imgSource %>" alt="Event Image"/>
                  </div>
               </div>
               <div id="informationSection" class="col-md-12 mx-auto mt-5 card">
                  <div class="card-body" style="padding-left:50px; padding-right:50px">
                     <!-- Event Details -->
                      <br />
                     <h3 class="card-title fw-bold">
                        <asp:Label ID="lbleventName" class="card-title" runat="server" Text="Event Title" Font-Size="30px"></asp:Label>
                        <!-- Event Title -->
                     </h3>
                     <!-- Event Information-->
                     <div class="row">
                        <p class="card-text">
                           <asp:Label ID="lblEventDescription" runat="server" Text=""></asp:Label>
                        </p>
                     </div>
                     <div class="row mt-4">
                        <div class="col-sm-5 col-6">
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="lblOrganization" class="card-title" runat="server" Text="Organization" Font-Size="18px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:Label ID="lblOrganizationName" runat="server" Text=""></asp:Label>
                           </p>
                        </div>
                        <div class="col-sm-5 col-6">
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="lblVenueLocation" class="card-title" runat="server" Text="Venue" Font-Size="18px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:Label ID="lblVenue" runat="server" Text=""></asp:Label>
                           </p>
                        </div>
                     </div>
                     <!-- Another Div-->
                     <div class="row mt-4">
                        <div class="col-sm-5 col-6">
                           <!-- Start Date -->
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="startDate" class="card-title" runat="server" Text="Start Date" Font-Size="15px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:TextBox ID="txtStartDate" runat="server" class="form-control read-only-textbox" name="Start Date" value="11-10-2023" ReadOnly="true"></asp:TextBox>
                           </p>
                        </div>
                        <div class="col-sm-5 col-6">
                           <!-- End Date-->
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="endDate" class="card-title" runat="server" Text="End Date" Font-Size="15px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:TextBox ID="txtEndDate" runat="server" class="form-control read-only-textbox" name="End Date" value="" ReadOnly="true"></asp:TextBox>
                           </p>
                        </div>
                     </div>
                     <!-- Start Date End Time-->
                     <div class="row mt-4">
                        <div class="col-sm-5 col-6">
                           <!-- Start Time -->
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="startTime" class="card-title" runat="server" Text="Start Time" Font-Size="15px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:TextBox ID="txtstartTime" runat="server" class="form-control read-only-textbox" name="Start Time" value="" ReadOnly="true"></asp:TextBox>
                           </p>
                        </div>
                        <div class="col-sm-5 col-6">
                           <!-- End Time -->
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="endTime" class="card-title" runat="server" Text="End Time" Font-Size="15px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:TextBox ID="txtEndTime" runat="server" class="form-control read-only-textbox" name="End Time" value="" ReadOnly="true"></asp:TextBox>
                           </p>
                        </div>
                     </div>
                     <!-- End Date End Time-->
                     <div class="row mt-4">
                        <div class="col-sm-5 col-6">
                           <!-- End Date -->
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="ticketingStartDate" class="card-title" runat="server" Text="TICKET START DATE" Font-Size="15px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:TextBox ID="txtTicketStartDate" runat="server" class="form-control read-only-textbox" name="Start Time" value="15-9-2023" ReadOnly="true"></asp:TextBox>
                           </p>
                        </div>
                        <div class="col-sm-5 col-6">
                           <!-- End Time -->
                           <h6 class="card-title fw-bold">
                              <asp:Label ID="ticketingEndDate" class="card-title" runat="server" Text="TICKET END DATE" Font-Size="15px"></asp:Label>
                              <!-- Event Title -->
                           </h6>
                           <p class="card-text">
                              <asp:TextBox ID="txtTicketEndDate" runat="server" class="form-control read-only-textbox" name="End Time" value="30-9-2023" ReadOnly="true"></asp:TextBox>
                           </p>
                        </div>
                     </div>
                     <!-- Ticket Information Section -->
                     <div class="row mt-4">
                        <div class="col-sd-12">
                           <h5 class="card-title fw-bold">Ticket Information</h5>
                        </div>

                         


                         
                    <% 
                        if(ticketList != null)
                        {
                         for(int i = 0; i < ticketList.Count(); i++) {
                            ticketName.Text = ticketList[i].name;
                            ticketPrice.Text = ticketList[i].price.ToString();
                            txtTotalQuantity.Text = ticketList[i].total_qty.ToString();
                            txtSoldTicket.Text = calculateTotalSoldInEachTicket(ticketList[i].id).ToString();

                    %> 
                            <div class="row">
                               <div class="mb-3 col-md-4">
                                  <label for="ticketName" class="form-label">Ticket Name</label>
                                  <asp:TextBox ID="ticketName" runat="server" CssClass="form-control read-only-textbox" Required="true" Text="" ReadOnly="true"></asp:TextBox>
                               </div>
                               <div class="mb-1 col-md-2">
                                  <label for="ticketPrice" class="form-label">Ticket Price</label>
                                  <div class="input-group input-group-merge">
                                     <span class="input-group-text">RM</span>
                                     <asp:TextBox ID="ticketPrice" runat="server" CssClass="form-control read-only-textbox" Type="number" Required="true" Text="" ReadOnly="true"></asp:TextBox>
                                  </div>
                               </div>
                                <div class="mb-2 col-md-2">
                                   <label for="totalQuantity" class="form-label">Total Quantity</label>
                                   <asp:TextBox ID="txtTotalQuantity" runat="server" CssClass="form-control read-only-textbox" Text="" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="mb-2 col-md-2">
                                   <label for="totalSold" class="form-label">Total Sold</label>
                                   <asp:TextBox ID="txtSoldTicket" runat="server" CssClass="form-control read-only-textbox" Text="" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                      <% }
                        } %>

                        <div class="row">
                           <div class="mb-3 col-md-2">
                              <label for="totalQuantity" class="form-label">Remain Total Tickets</label>
                              <asp:TextBox ID="remainQty" runat="server" CssClass="form-control read-only-textbox" Type="number" Min="1" Required="true" Text="" ReadOnly="true"></asp:TextBox>
                           </div>
                        </div>
                     </div>
                     <div class="d-flex justify-content-end">
                        <asp:Button ID="btnBack" runat="server" Text="BACK" CssClass="btn btn-primary me-2" OnClick="btnBack_Click"/>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
    <asp:Literal ID="debug" Text="" runat="server" />
<!-- / Content -->
</asp:Content>
