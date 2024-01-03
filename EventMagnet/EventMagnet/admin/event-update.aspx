<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-update.aspx.cs" Inherits="EventMagnet.zDEl_admin.event_details" EnableViewState="true" %>
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
      <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Edit Event</h4>
      <div class="row">
         <div class="col-md-12">
            <div class="card mb-4">
               <h5 class="card-header">Event Details</h5>
               <!-- Event Details -->

<div class="card-body">
   <!-- Display Selected Image (Initially Hidden) -->
   <div class="d-flex">
      <img src="images/events/<%= ViewState["imgSource"] %>" alt="<%= ViewState["imgSource"] %>" class="rounded border p-2 mb-2" id="selectedImageToDisplay" />
   </div>
   <!-- Images Insert -->
   <div class="row d-flex align-items-start align-items-sm-center gap-4">
      <div class="mb-6 col-6">
         <!-- File Input for Image Upload -->
          <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" onchange="displayImageandSelectedImage(this)" EnableViewState="true" />
          <p class="font-weight-light m-0 ps-1 text-muted">Upload Images File To Update Your Images.</p>
          
      </div>
   </div>
</div>
               <hr class="my-0" />
               <div class="card-body">
                  <div class="row">
                     <!-- Name -->
                     <div class="mb-4 col-md-7">
                        <asp:Label for="EventName" Text="Name" runat="server" class="form-label"/>
                        <asp:TextBox ID="txtEventName" runat="server" class="form-control" name="EventName" value=""></asp:TextBox>
                         <!-- checking if the field is empty -->
                        <asp:RequiredFieldValidator ID="rfvEventName" runat="server" ControlToValidate="txtEventName" ErrorMessage="⚠️ Event Name is required." Display="Dynamic" CssClass="text-danger" />
                        <!-- allowing only alphanumeric characters -->
                        <asp:RegularExpressionValidator ID="revEventName" runat="server" ControlToValidate="txtEventName" ErrorMessage="⚠️ Only alphanumeric characters are allowed." Display="Dynamic" CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9\s]+$" />
                     </div>
                     <!-- Keywords -->
                     <div class="mb-4 col-md-4">
                        <asp:Label for="keywords" Text="Keywords" runat="server" class="form-label"/>
                        <asp:TextBox ID="keyWords" runat="server" class="form-control" name="Keywords" value=""></asp:TextBox>
                         <!-- checking if the field is empty -->
                        <asp:RequiredFieldValidator ID="rfvKeyWords" runat="server" ControlToValidate="keyWords" ErrorMessage="⚠️ Keywords is required." Display="Dynamic" CssClass="text-danger" />
                     </div>
                      
                     <!-- Venue Selection-->
                     <div class="mb-2 col-md-4">
                        <asp:Label for="Venue" Text="Venue" runat="server" class="form-label"/>
                        <asp:SqlDataSource runat="server" ID="sqlVenueSelection" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT * FROM [venue]" />
                        <asp:DropDownList ID="ddlVenue" runat="server" CssClass="select2 form-select" DataSourceID="sqlVenueSelection" DataTextField="name" DataValueField="id">
                        </asp:DropDownList>
                     </div>

                      <div class="mb-2 col-md-2">
                           <asp:Label Text="Category" runat="server" CssClass="form-label"/>
                           <asp:DropDownList ID="categoryListDll" runat="server" CssClass="form-select">
                               <asp:ListItem Selected="True" Value="">-- Choose Category --</asp:ListItem>
                               <asp:ListItem Value="Music">Music</asp:ListItem>
                               <asp:ListItem Value="Visual Arts">Visual Arts</asp:ListItem>
                               <asp:ListItem Value="Performing Arts">Performing Arts</asp:ListItem>
                               <asp:ListItem Value="Film">Film</asp:ListItem>
                               <asp:ListItem Value="Sport">Sport</asp:ListItem>
                               <asp:ListItem Value="Business">Business</asp:ListItem>
                               <asp:ListItem Value="Food & Drinks">Food &amp; Drinks</asp:ListItem>
                               <asp:ListItem Value="Festival & Fairs">Festival &amp; Fairs</asp:ListItem>
                               <asp:ListItem Value="Lectures & Books">Lectures &amp; Books</asp:ListItem>
                               <asp:ListItem Value="Film">Film</asp:ListItem>
                           </asp:DropDownList>
                          <asp:RequiredFieldValidator ID="rfv_categoryListDll" runat="server" ErrorMessage="⚠️ Please Select Your [Category]" ControlToValidate="categoryListDll" Display="Dynamic" CssClass="text-danger" InitialValue=""></asp:RequiredFieldValidator>
                        </div>
                     <!-- Start Date Selection -->
                     <div class="row">
                        <div class="mb-3 col-md-4">
                           <asp:Label for="StartDate" Text="Start Date" runat="server" class="form-label"/>
                           <input ID="startDatePicker" runat="server" type="date" class="form-control" name="Start Date"/>
                            <!-- RequiredFieldValidator for Start Date -->
                            <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ControlToValidate="startDatePicker" ErrorMessage="⚠️ Start Date is required." Display="Dynamic" CssClass="text-danger" />
                        </div>
                        <!-- End Date Selection -->
                        <div class="mb-3 col-md-4">
                           <asp:Label for="EndDate" Text="End Date" runat="server" class="form-label"/>
                           <input ID="endDatePicker" runat="server" type="date" class="form-control" name="End Date">
                           <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ControlToValidate="endDatePicker" ErrorMessage="⚠️ End Date is required." Display="Dynamic" CssClass="text-danger" />
                            <!-- CompareValidator for Date Comparison -->
                           <asp:CompareValidator ID="cvDateComparison" runat="server" ControlToValidate="endDatePicker" ControlToCompare="startDatePicker" Operator="GreaterThanEqual" Type="Date" ErrorMessage="⚠️ End Date must be equal to or later than Start Date." Display="Dynamic" CssClass="text-danger" />
                        </div>
                     </div>
                     <div class="row">
                        <!-- Start Time Selection -->
                        <div class="mb-3 col-md-4">
                           <asp:Label for="starTime" Text="Start Time" runat="server" class="form-label"/>
                           <input type="time" ID="startTime" name="startTime" class="form-control" runat="server">
                            <!-- StartTime RFV --> 
                            <asp:RequiredFieldValidator ID="rfvStartTime" runat="server" ControlToValidate="startTime" ErrorMessage="⚠️ Start Time is required." Display="Dynamic" CssClass="text-danger" />
                        </div>
                        <!-- Start Time Selection -->
                        <div class="mb-3 col-md-4">
                           <asp:Label for="endTime" Text="End Time" runat="server" class="form-label"/>
                           <input type="time" ID="endTime" name="endTime" class="form-control" runat="server">
                            <!-- End Time -->
                            <asp:RequiredFieldValidator ID="rfvEndTime" runat="server" ControlToValidate="endTime" ErrorMessage="⚠️ End Time is required." Display="Dynamic" CssClass="text-danger" />
                            <!-- Time Comparison -->
                            <asp:CustomValidator ID="cvTimeComparison" runat="server" ControlToValidate="endTime" ClientValidationFunction="validateEndTime" ErrorMessage="⚠️ End Time must be later than Start Time." Display="Dynamic" CssClass="text-danger" />
                        </div>
                     </div>
                     <!-- Description-->
                     <div class="mb-6 col-md-12">
                        <asp:Label ID="lblDescription" CssClass="form-label" runat="server" Text="Description"></asp:Label>
                        <asp:TextBox ID="eventDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="4"></asp:TextBox>
                         <!-- RequiredFieldValidator for Description -->
                         <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="eventDescription" ErrorMessage="⚠️ Description is required." Display="Dynamic" CssClass="text-danger" />
                     </div>
                     <br />
                     <h5 class="card-header mt-4">Ticket Details</h5>
                     <div class="col-md-12">

                        <!--
                        <div class="row">
                           <div class="mb-3 col-md-5">
                              <label for="ticketName" class="form-label">Ticket Name</label>
                              <asp:DropDownList ID="TicketNameDDL" runat="server" CssClass="form-select">
                                  <asp:ListItem Value="Standard">Standard</asp:ListItem>
                                  <asp:ListItem Value="Silver">Silver</asp:ListItem>
                                  <asp:ListItem Value="Gold">Gold</asp:ListItem>
                                  <asp:ListItem Value="VVIP">VVIP</asp:ListItem>
                                  <asp:ListItem Value="Premium VIP">Premium VIP</asp:ListItem>
                                  <asp:ListItem Value="Elderly">Elderly</asp:ListItem>
                                  <asp:ListItem Value="Adult">Adult</asp:ListItem>
                                  <asp:ListItem Value="Children">Children</asp:ListItem>
                              </asp:DropDownList>
                               <asp:RequiredFieldValidator ID="rfvTicketNameDDL" runat="server" ControlToValidate="TicketNameDDL" ErrorMessage="⚠️ Ticket Name is required." InitialValue="" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                           </div>
                           <div class="mb-3 col-md-3">
                              <label for="ticketPrice" class="form-label">Ticket Price</label>
                              <div class="input-group input-group-merge">
                                 <span class="input-group-text">RM</span>
                                 <asp:TextBox ID="ticketPrice" runat="server" CssClass="form-control" Type="number" Required="true" value=""></asp:TextBox>
                                  <asp:RequiredFieldValidator ID="rfvTicketPrice" runat="server" ControlToValidate="ticketPrice" ErrorMessage="Ticket Price is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                              </div>
                           </div>
                           <div class="mb-3 col-md-2">
                              <label for="totalQuantity" class="form-label">Total Quantity</label>
                              <asp:TextBox ID="totalQuantity" runat="server" CssClass="form-control" Type="number" Min="1" Required="true" value=""></asp:TextBox>
                               <asp:RequiredFieldValidator ID="rfvTotalQuantity" runat="server" ControlToValidate="totalQuantity" ErrorMessage="Total Quantity is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                           </div>
                        </div>

                         -->

                         <!-- Ticket Section PlaceHolder -->
                         <asp:PlaceHolder ID="ticketSectionPlaceHolder" runat="server"></asp:PlaceHolder>

                        <div class="row">
                           <!-- Ticketing Start Time Selection -->
                           <div class="mb-2 col-md-4">
                              <asp:Label for="ticketStartTime" Text="Ticket Start Date & Time" runat="server" class="form-label" Font-Bold="True" />
                              <input type="datetime-local" ID="ticketStartTime" name="startTime" class="form-control" runat="server">
                           </div>
                           <!-- Ticketing End Time Selection -->
                           <div class="mb-2 col-md-4">
                              <asp:Label for="ticketEndTime" Text="Ticket End Date & Time" runat="server" class="form-label" Font-Bold="True" />
                              <input type="datetime-local" ID="ticketEndTime" name="endTime" class="form-control" runat="server">

                              <!-- CustomValidator for Ticket End Time -->
                               <asp:CustomValidator ID="cvTicketEndTime" runat="server" ControlToValidate="ticketEndTime" ClientValidationFunction="validateTicketEndTime" ErrorMessage="⚠️ Ticket End Time must be equal to or later than Ticket Start Time" Display="Dynamic" CssClass="text-danger" />
                             
                           </div>
                        </div>

                     </div>
                     <div class="d-flex justify-content-end">
                        <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-primary me-2" OnClick="btnSaveChanges_Click"/>
                        <asp:Button ID="btnReset" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click"/>
                     </div>
                  </div>
                  <!-- /Account -->
               </div>
               <!--
                  <div class="card">
                     <h5 class="card-header">Delete Account Account</h5>
                     <div class="card-body">
                        <div class="mb-3 col-12 mb-0">
                           <div class="alert alert-warning">
                              <h6 class="alert-heading fw-bold mb-1">Are you sure you want to delete your account?</h6>
                              <p class="mb-0">Once you delete your account, there is no going back. Please be certain.</p>
                           </div>
                        </div>
                        <form id="formAccountDeactivation" onsubmit="return false">
                           <div class="form-check mb-3">
                              <input
                                 class="form-check-input"
                                 type="checkbox"
                                 name="accountActivation"
                                 id="accountActivation"
                                 />
                              <label class="form-check-label" for="accountActivation"
                                 >I confirm my account deactivation</label
                                 >
                           </div>
                           <button type="submit" class="btn btn-danger deactivate-account">Deactivate Account</button>
                        </form>
                     </div>
                  </div>-->
            </div>
         </div>
      </div>
   </div>
<!-- Modal Prompter -->
<div id="eventPrompter" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><%=ViewState["eventModal_header"] %></h5>
                <button type="button" class="btn-close" aria-label="Close" id="eventCloseButton"></button>
            </div>
            <div class="modal-body">
                <%=ViewState["eventModal_promtperMsg"]%>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnConfirmUpdate" CssClass="btn btn-danger" Text="Confirm" runat="server" OnClick="btnConfirmUpdate_Click" />
                <button type="button" class="btn btn-success" id="eventCancelButton">Cancel</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal Prompter -->
<div id="successEventPrompter" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="successLabel"><%=ViewState["success_eventModal_header"] %></h5>
                <button type="button" class="btn-close" aria-label="Close" id="successCloseButton"></button>
            </div>
            <div class="modal-body">
                <%=ViewState["success_eventModal_promtperMsg"]%>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnConfirmSuccess" CssClass="btn btn-danger" Text="Confirm" runat="server" OnClick="btn_confirmSuccess_Click" />
                <button type="button" class="btn btn-success" id="successCancelButton">Cancel</button>
            </div>
        </div>
    </div>
</div>

<% bool confirmation = false;
   bool success_confirmation = false;
   if(ViewState["eventModal_confirmation"] != null)
   {
       confirmation = (bool)ViewState["eventModal_confirmation"];
   }

   if (ViewState["success_eventModal_confirmation"] != null)
   {
        success_confirmation = (bool)ViewState["success_eventModal_confirmation"];
   }
   %>
   <!-- / Content -->
    <script src="js/bootstrap.js"></script>
    <script>

        var eventModal = document.getElementById('eventPrompter');
        var eventConfirmButton = document.getElementById('<%= btnConfirmUpdate.ClientID %>');
        var eventCancelButton = document.getElementById('eventCancelButton');
        var eventCloseButton = document.getElementById('eventCloseButton');

        var successEventModal = document.getElementById('successEventPrompter');
        var successConfirmButton = document.getElementById('<%= btnConfirmSuccess.ClientID %>');
        var successCancelButton = document.getElementById('successCancelButton');
        var successCloseButton = document.getElementById('successCloseButton');

        // Show the modal
        function showModal(modal) {
            modal.style.display = 'block';
        }

        // Hide the modal
        function hideModal(modal) {
            modal.style.display = 'none';
        }

        // Event listeners for buttons
        eventConfirmButton.addEventListener('click', function () {
            hideModal(eventModal);
        });

        eventCancelButton.addEventListener('click', function () {
            hideModal(eventModal);
        });

        eventCloseButton.addEventListener('click', function () {
            hideModal(eventModal);
        });

        successConfirmButton.addEventListener('click', function () {
            hideModal(successEventModal);
        });

        successCancelButton.addEventListener('click', function () {
            hideModal(successEventModal);
        });

        successCloseButton.addEventListener('click', function () {
            hideModal(successEventModal);
        });

        // Open the modal if needed
        var confirmation = <%= confirmation.ToString().ToLower() %>;
        if (confirmation) {
            showModal(eventModal);
        }

        var successConfirmation = <%= success_confirmation.ToString().ToLower() %>;
        if (successConfirmation) {
            showModal(successEventModal);
        }

        function displayImageandSelectedImage(input) {
            var selectedImage = document.getElementById('selectedImageToDisplay');

            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    selectedImage.src = e.target.result;
                    selectedImage.classList.remove('d-none'); // Display the image
                    selectedImage.classList.add('rounded', 'border', 'p-2'); // Add border and padding
                };

                reader.readAsDataURL(input.files[0]);
            } else {
                selectedImage.src = '';
                selectedImage.classList.add('d-none'); // Hide the image
                selectedImage.classList.remove('rounded', 'border', 'p-2'); // Remove border and padding
            }
        }

        function validateEndTime(sender, args) {
            var startTime = document.getElementById('<%= startTime.ClientID %>').value;
            var endTime = args.Value;

            if (startTime !== "" && endTime !== "") {
                if (startTime >= endTime) {
                    args.IsValid = false;
                } else {
                    args.IsValid = true;
                }
            } else {
                args.IsValid = false;
            }
        }

        function validateTicketEndTime(source, args) {
            var ticketStartTime = document.getElementById('<%= ticketStartTime.ClientID %>').value;
            var ticketEndTime = document.getElementById('<%= ticketEndTime.ClientID %>').value;

            if (new Date(ticketEndTime) >= new Date(ticketStartTime)) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }
    </script>
</asp:Content>
