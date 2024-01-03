<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="ticket-detail.aspx.cs" Inherits="EventMagnet.site.ticket_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

   <!-- ***** About Us Page ***** -->
   <div class="page-heading-shows-events">
      <div class="container">
         <div class="row">
            <div class="col-lg-12">
               <h2>Tickets On Sale Now!</h2>
               <span>Check out upcoming and past shows & events and grab your ticket right now.</span>
            </div>
         </div>
      </div>
   </div>
   <div class="ticket-details-page">
      <div class="container">
         <div class="row">
            <div class="col-lg-7">
               <div class="left-image">
                   <%string imgsrc = ViewState["img_src"].ToString();  %>
                  <img src="images/events/<%=imgsrc%>" alt="EventImages" style="width: 700px; height: 650px;">
               </div>
            </div>
            <div class="col-lg-5">
               <div class="right-content">
                  <h4>
                     <asp:Literal ID="eventNametxt" Text="" runat="server" />
                  </h4>
                  <span>
                     <asp:Literal ID="ticketRemainTxt" Text="" runat="server" />
                  </span>
                  <span style="margin-bottom:10px">
                     <asp:Literal ID="eventDescriptionTxt" Text="" runat="server" />
                  </span>
                  <ul>
                     <li>
                        <i class="fa fa-clock-o"></i>
                        <asp:Literal ID="dateTimeTxt" Text="" runat="server" />
                     </li>
                     <li>
                        <i class="fa fa-map-marker"></i>
                        <asp:Literal ID="locationTxt" Text="" runat="server" />
                     </li>
                  </ul>
                  <div class="quantity-content">
                     <div class="row">
                        <asp:PlaceHolder ID="quantityticketContent" runat="server"></asp:PlaceHolder>
                       
                     </div>
                  </div>
                  <div class="total">
                     <h4>Total: 
                         <asp:Literal ID="litTotalAmount" Text="RM 0.00" runat="server" />
                     </h4>
                     <div class="main-dark-button">
                         <asp:Button ID="btnPurchaseTickets" CssClass="btn btn-dark" runat="server" Text="Purchase Tickets" OnClick="btnPurchaseTickets_Click"/>
                     </div>
                  </div>
                  <div class="warn">
                     <p>*You Can Only Buy 10 Tickets For This Show</p>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <!-- Modal Prompter -->
<div class="modal fade" id="eventPrompter" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"><%=ViewState["eventModal_header"] %></h5>
              <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
         </div>
         <div class="modal-body">
            <%=ViewState["eventModal_promtperMsg"]%>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" id="confirmButton" data-bs-dismiss="modal">Cancel</button>
             <asp:Button ID="createSession" Text="Confirm" CssClass="btn btn-outline-primary" runat="server" OnClick="createSession_Click"/>
         </div>
      </div>
   </div>
</div>

    
<% bool confirmation = false;
   if(ViewState["eventModal_confirmation"] != null)
   {
       confirmation = (bool)ViewState["eventModal_confirmation"];
   }
   %>

    <script>
        //Modal Prompter
        var event_modal = new bootstrap.Modal(document.getElementById('eventPrompter'));
        var event_confirmation = <%=confirmation.ToString().ToLower() %>;
        var event_condition = event_confirmation;

        // Open the modal if the condition is true
        if (event_condition) {
            event_modal.show();
        }
    </script>
</asp:Content>