<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-index.aspx.cs" Inherits="EventMagnet.zDEl_admin.eventManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-dialog {
            position: relative;
            margin: 10% auto;
            width: 80%;
            max-width: 600px;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
        }

        .modal-header, .modal-footer {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .modal-footer {
            text-align: right;
        }


    </style>
  <!-- Content -->
<div class="container-xxl flex-grow-1 container-p-y">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Event Main</h4>
    <div class="row">
        <div class="col-12">
            <asp:Button ID="btnCreate" runat="server" Text="Create Event +" CssClass="btn btn-lg btn-outline-primary" OnClick="btnCreate_Click"/>
        </div>
    </div>
  <!-- Basic Bootstrap Table -->
  <div class="card container-fluid" style="margin-top:30px;">
    <h5 class="card-header">All Event</h5>
    <div class="table-responsive text-nowrap">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>ID</th>
            <th>Event</th>
              <!---
            <th>Organization</th>--->
            <th>Venue</th>
            <th>Remain.Qty</th>
            <th>Status</th>
            <th>Details</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody class="table-border-bottom-0">
            <asp:Repeater ID="eventIndexRepeater" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("event_id") %></td>
                        <td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong><%# DataBinder.Eval(Container.DataItem, "name") %></strong></td>
                        <td><%# Eval("venue_name") %></td>
                        <td><%# Eval("ticket_remain") %></td>
                        <td>
                            <%# GetEventStatus(Eval("start_date"), Eval("end_date")) %>
                        </td>
                        <td>
                            <asp:Button ID="btn_ViewEvent" runat="server" Text="View" class="btn btn-outline-info" OnClick="btn_ViewEvent_Click"/>
                        </td>
                        <td>
                            <div class="dropdown">
                                <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                    <i class="bx bx-dots-vertical-rounded"></i>
                                </button>
                                <div class="dropdown-menu">
                                   <a class="dropdown-item" href="javascript:void(0);">
                                      <i class="bx bx-edit-alt me-1"></i>
                                      <asp:Button ID="btn_edit" runat="server" Text="Edit" BorderStyle="None" BackColor="White" cssclass="btn pe-5 pt-0 pb-0" OnClick="btn_edit_Click"/>
                                   </a>
                                   <a class="dropdown-item" href="javascript:void(0);">
                                      <i class="bx bx-trash me-1"></i>
                                      <asp:Button ID="btn_delete" runat="server" Text="Delete" BorderStyle="None" BackColor="White" cssclass="btn pe-5 pt-0 pb-0" OnClick="btn_delete_Click"/>
                                   </a>
                                </div>
                            </div>
                            <!-- Initialize Hidden Value  -->
                            <asp:HiddenField ID="hfEventID"        runat="server" Value='<%# Eval("event_id") %>' />
                            <asp:HiddenField ID="hfOrganizationID" runat="server" Value='<%# Eval("organization_id") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT event_venue.id, event_venue.book_date, event_venue.status, event_venue.venue_id, event_venue.event_id, venue.name AS venue_name, venue.email_contact, organization.id AS organization_id, organization.name AS organization_name, organization.website_link, ticket_summary.total_ticket_qty, event.id AS event_id, event.name, event.start_date, event.end_date, event.start_time, event.end_time, event.ticket_sale_start_datetime, event.ticket_sale_end_datetime, event.descp, event.keyword, event.category_name, event.img_src, event.status AS event_status, event.create_datetime, event.organization_id AS event_organization_id, organization.email, organization.phone, admin.name AS admin_name, organization_admin.is_owner, organization_admin.id AS organization_admin_id, venue.id AS venue_id, ticket_summary.total_ticket_qty - COALESCE (order_item_summary.order_item_count, 0) AS ticket_remain FROM event INNER JOIN event_venue ON event.id = event_venue.event_id INNER JOIN venue ON event_venue.venue_id = venue.id INNER JOIN (SELECT event_id, SUM(total_qty) AS total_ticket_qty FROM ticket GROUP BY event_id) AS ticket_summary ON event.id = ticket_summary.event_id LEFT OUTER JOIN (SELECT ticket_1.event_id, COUNT(DISTINCT order_item.id) AS order_item_count FROM ticket AS ticket_1 LEFT OUTER JOIN order_item ON ticket_1.id = order_item.ticket_id GROUP BY ticket_1.event_id) AS order_item_summary ON event.id = order_item_summary.event_id INNER JOIN organization ON event.organization_id = organization.id INNER JOIN organization_admin ON organization.id = organization_admin.organization_id INNER JOIN admin ON organization_admin.admin_id = admin.id WHERE (organization_admin.is_owner = 1) AND (event.status = 1) AND (organization.status = 1)"></asp:SqlDataSource>
            
        </tbody>
      </table>
    </div>
  </div>
  <!--/ Basic Bootstrap Table -->
</div>
<!-- / Content -->




<!-- Modal Prompter -->
<div id="eventPrompter" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><%=ViewState["eventModal_header"] %></h5>
                <button type="button" class="btn-close" aria-label="Close" id="closeButton"></button>
            </div>
            <div class="modal-body">
                <%=ViewState["eventModal_promtperMsg"]%>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnConfirmDelete" CssClass="btn btn-danger" Text="Confirm" runat="server" OnClick="btnConfirmDelete_Click"/>
                <button type="button" class="btn btn-success" id="cancelButton">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Prompter -->
<div id="eventSuccessPrompter" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successHeaderLabel"><%=ViewState["success_eventModal_header"] %></h5>
                <button type="button" class="btn-close" aria-label="Close" id="successCloseButton"></button>
            </div>
            <div class="modal-body">
                <%=ViewState["success_eventModal_promtperMsg"]%>
            </div>
            <div class="modal-footer">
                <asp:Button ID="successConfirmationBtn" CssClass="btn btn-danger" Text="Confirm" runat="server" OnClick="successConfirmationBtn_Click"/>
                <button type="button" class="btn btn-success" id="successCancelButton">Cancel</button>
            </div>
        </div>
    </div>
</div>


<!--/ Modal Prompter -->

        <%  bool confirmation = false ;
            bool success_Confirmation = false;
      
            if(ViewState["eventModal_confirmation"] != null)
            {
                confirmation = (bool)ViewState["eventModal_confirmation"];
            }

            if (ViewState["success_eventModal_confirmation"] != null)
            {
                success_Confirmation = (bool)ViewState["success_eventModal_confirmation"];
            }
       %>
    <script>
        var eventModal = document.getElementById('eventPrompter');
        var confirmButton = document.getElementById('<%= btnConfirmDelete.ClientID %>');
        var cancelButton = document.getElementById('cancelButton');
        var closeButton = document.getElementById('closeButton');

        var success_eventModal = document.getElementById('eventSuccessPrompter');
        var success_confirmButton = document.getElementById('<%= successConfirmationBtn.ClientID %>');
        var success_cancelButton = document.getElementById('successCancelButton');
        var success_closeButton = document.getElementById('successCloseButton');

        // Show the modal
        function showModal() {
            eventModal.style.display = 'block';
        }
        function successEventModal() {
            success_eventModal.style.display = 'block';
        }

        // Hide the modal
        function hideModal() {
            eventModal.style.display = 'none';
        }
        function successModalHide() {
            success_eventModal.style.display = 'none';
        }

        // Event listeners for buttons
        confirmButton.addEventListener('click', function () {
            hideModal();
        });
        success_confirmButton.addEventListener('click', function () {
            successModalHide();
        });

        cancelButton.addEventListener('click', function () {
            hideModal();
        });
        success_cancelButton.addEventListener('click', function () {
            successModalHide();
        });

        closeButton.addEventListener('click', function () {
            hideModal();
        });
        success_closeButton.addEventListener('click', function () {
            successModalHide();
        });

        // Open the modal if needed
        var confirmation = <%=confirmation.ToString().ToLower() %>;
        if (confirmation) {
            showModal();
        }

        var modalSuccessModal_confirmation = <%=success_Confirmation.ToString().ToLower()%>;
        if (modalSuccessModal_confirmation) {
            successEventModal();
        }

    </script>
</asp:Content>
