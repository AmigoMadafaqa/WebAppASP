<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-create.aspx.cs" Inherits="EventMagnet.zDEl_admin.event_create" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- Content -->
<div class="container-xxl flex-grow-1 container-p-y">
   <h4 class="fw-bold py-3 mb-4">
      <span class="text-muted fw-light">Dashboard /</span> Create Event
   </h4>
   <!-- Create Events Section -->
   <div class="row">
      <div class="col-md-12">
         <div class="card mb-6">
            <h5 class="card-header">Create Events</h5>
            <!-- Event Details -->
            <div class="card-body">
               <!-- Display Selected Image (Initially Hidden) -->
               <div class="d-flex justify-content-center align-items-center">
                  <img src="" style="width: 400px;" alt="Selected Image" class="d-none rounded border p-2" id="selectedImage" />
               </div>
               <!-- Images Insert -->
               <div class="row d-flex align-items-start align-items-sm-center gap-4">
                  <div class="mb-6 col-6">
                     <!-- File Input for Image Upload -->
                     <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" onchange="displaySelectedImage(this)" />
                      <asp:CustomValidator ID="cvfileUpload" runat="server" Display="Dynamic" ControlToValidate="fileUpload" ErrorMessage="⚠️ Please select a valid image file" CssClass="error" OnServerValidate="cvfileUpload_ServerValidate"></asp:CustomValidator>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidatorFile" runat="server" ControlToValidate="fileUpload" Display="Dynamic" ErrorMessage="⚠️ Please select a file" ForeColor="Red"></asp:RequiredFieldValidator>
                  </div>
               </div>
            </div>
            <hr class="my-0" />
            <div class="card-body">
               <div class="row">
                  <!-- Name -->
                  <div class="mb-4 col-md-7">
                     <asp:Label for="EventName" Text="Name" runat="server" class="form-label"/>
                     <asp:TextBox ID="txtEventName" runat="server" class="form-control" name="EventName" Placeholder="Enter Event Name"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfv_txtEventName" runat="server" ErrorMessage="⚠️ Please Enter Your [Event Name]" ControlToValidate="txtEventName" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator ID="rev_txtEventName" runat="server" ControlToValidate="txtEventName" ErrorMessage="⚠️ Only alphanumeric characters are allowed." Display="Dynamic" CssClass="text-danger" ValidationExpression="^[a-zA-Z0-9\s]+$" />
                  </div>
                  <!-- Keywords -->
                  <div class="mb-4 col-md-4">
                     <asp:Label for="keywords" Text="Keywords" runat="server" class="form-label"/>
                     <asp:TextBox ID="keyWords" runat="server" class="form-control" name="Keywords" Placeholder="Eg. #Concert #World"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfv_keyWords" runat="server" ErrorMessage="⚠️ Please Enter Your [Keyword]" ControlToValidate="keyWords" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                  </div>
               </div>
               <!-- Categories -->
               <div class="row">
                  <div class="mb-4 col-md-4">
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
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ErrorMessage="⚠️ Please Select Your [Category]" ControlToValidate="categoryListDll" Display="Dynamic" CssClass="text-danger" InitialValue=""></asp:RequiredFieldValidator>
                  </div>
               </div>
               <!-- Venue Selection-->
               <div class="mb-2 col-md-4">
                  <asp:Label for="Venue" Text="Venue" runat="server" class="form-label"/>
                  <asp:SqlDataSource runat="server" ID="sqlVenueSelection" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>' SelectCommand="SELECT * FROM [venue]" />
                  <asp:DropDownList ID="ddlVenue" runat="server" CssClass="select2 form-select" DataSourceID="sqlVenueSelection" DataTextField="name" DataValueField="id">
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="⚠️ Please Select Your [Venue]" ControlToValidate="ddlVenue" Display="Dynamic" CssClass="text-danger" InitialValue=""></asp:RequiredFieldValidator>
               </div>
               <!-- Start Date Selection -->
               <div class="row">
                  <div class="mb-3 col-md-4">
                     <asp:Label for="StartDate" Text="Start Date" runat="server" class="form-label"/>
                     <input ID="startDatePicker" runat="server" type="date" class="form-control" name="Start Date"/>
                     <asp:RequiredFieldValidator ID="RFVstartDatePicker" runat="server" ErrorMessage="⚠️ Please Select [Start Date]" ControlToValidate="startDatePicker" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                  </div>
                  <!-- End Date Selection -->
                  <div class="mb-3 col-md-4">
                     <asp:Label for="EndDate" Text="End Date" runat="server" class="form-label"/>
                     <input ID="endDatePicker" runat="server" type="date" class="form-control" name="End Date">
                     <asp:RequiredFieldValidator ID="RFVendDatePicker" runat="server" ErrorMessage="⚠️ Please Select [End Date]" ControlToValidate="endDatePicker" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                     <asp:CompareValidator ID="StartEnddateCompareValidator" runat="server" ControlToValidate="endDatePicker" ControlToCompare="startDatePicker" Operator="GreaterThanEqual" Type="Date" ErrorMessage="⚠️ End Date must be equal or later than Start Date" Display="Dynamic" CssClass="text-danger"></asp:CompareValidator>
                  </div>
               </div>
               <div class="row">
                  <!-- Start Time Selection -->
                  <div class="mb-3 col-md-4">
                     <asp:Label for="starTime" Text="Start Time" runat="server" class="form-label"/>
                     <input type="time" ID="startTime" name="startTime" class="form-control" runat="server">
                     <asp:RequiredFieldValidator ID="RFVstartTime" runat="server" ErrorMessage="⚠️ Please Select [Start Time]" ControlToValidate="startTime" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                  </div>
                  <!-- End Time Selection -->
                  <div class="mb-3 col-md-4">
                     <asp:Label for="endTime" Text="End Time" runat="server" class="form-label"/>
                     <input type="time" ID="endTime" name="endTime" class="form-control" runat="server">
                     <asp:RequiredFieldValidator ID="RFVendTime" runat="server" ErrorMessage="⚠️ Please Select [End Time]" ControlToValidate="endTime" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                     <asp:CompareValidator ID="CompVstarTimeEndTime" runat="server" ControlToValidate="endTime" ControlToCompare="startTime" Operator="GreaterThan" Type="String" DataType="Time" ErrorMessage="⚠️ End Time must be later than Start Time" Display="Dynamic" CssClass="text-danger"></asp:CompareValidator>
                  </div>
               </div>
               <!-- Description-->
               <div class="mb-6 col-md-12">
                  <asp:Label ID="lblDescription" CssClass="form-label" runat="server" Text="Description"></asp:Label>
                  <asp:TextBox ID="eventDescription" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="3" Placeholder="Enter Your Event Description or Getting Help From AI by letting know what event you want."></asp:TextBox>
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="⚠️ Please Enter [Event Description]" ControlToValidate="eventDescription" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
               </div>

                <div class="mb-6 col-md-12">
                    <asp:Button ID="btnDescriptionGenerator" runat="server" Text="Description Generator" CssClass="btn btn-outline-secondary me-2 mt-3" OnClientClick="generateDescription(); return false;" CausesValidation="false" />

                </div>
            </div>
         </div>
      </div>
   </div>
   <!-- Create Ticket Section -->
   <div class="row" id="ticketSections" style="margin-top:20px">
      <div class="col-md-12">
         <div class="card mt-3" >
            <h5 class="card-header">Create Ticket</h5>
            <div class="card-body" ID="createTicketInfo" runat="server">

                <asp:PlaceHolder ID="ticketSection" runat="server"></asp:PlaceHolder>
                <asp:Button ID="btn_ticketGenerate" Text="Add Another Ticket" CssClass="btn btn-outline-secondary mb-3" runat="server" OnClick="btn_ticketGenerate_Click" CausesValidation="false" />

               <div class="row">
                  <!-- Ticketing Start Time Selection -->
                  <div class="mb-3 col-md-4">
                     <asp:Label for="ticketStartTime" Text="Ticket Start Date & Time" runat="server" class="form-label" Font-Bold="True" />
                     <input type="datetime-local" ID="ticketStartTime" name="startTime" class="form-control" runat="server">
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="⚠️ Please Select Ticket [Start Time]" ControlToValidate="ticketStartTime" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                  </div>
                  <!-- Ticketing End Time Selection -->
                  <div class="mb-3 col-md-4">
                     <asp:Label for="ticketEndTime" Text="Ticket End Date & Time" runat="server" class="form-label" Font-Bold="True" />
                     <input type="datetime-local" ID="ticketEndTime" name="endTime" class="form-control" runat="server">
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="⚠️ Please Select Ticket [End Time]" ControlToValidate="ticketEndTime" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                     <asp:CustomValidator ID="cvTicketEndTime" runat="server" ControlToValidate="ticketEndTime" ClientValidationFunction="validateTicketEndTime" ErrorMessage="⚠️ Ticket End Time must be equal to or later than Ticket Start Time" Display="Dynamic" CssClass="text-danger" />
                  </div>
               </div>

            </div>
         </div>
      </div>
      <!-- Generate Another Ticket
         <div class="row">
             <div class="col-md-12 d-flex">
                 <asp:Button ID="btnAddTicket" runat="server" Text="Create Another Ticket" CssClass="btn btn-primary btn-outline-secondary" OnClientClick="addTicketSection(); return false;" />
             </div>
         </div>-->
   </div>
   <!-- Buttons Section -->
   <div class="col-md-12">
      <div class="card-body d-flex justify-content-end">
         <div class="">
            <asp:Button ID="btnCreateEventTicket" runat="server" Text="Create Event & Tickets" CssClass="btn btn-primary me-2" OnClick="btnCreateEventTicket_Click"/>
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" CausesValidation="false"/>
         </div>
      </div>
   </div>
</div>
<!-- / Content -->
<!-- Modal Prompter -->
<div class="modal fade" id="eventPrompter" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel"><%=ViewState["eventModal_header"] %></h5>
         </div>
         <div class="modal-body">
            <%=ViewState["eventModal_promtperMsg"]%>
         </div>
         <div class="modal-footer">
            <button type="button" class="btn btn-danger" id="confirmButton" data-bs-dismiss="modal">Confirm</button>
         </div>
      </div>
   </div>
</div>
<!--/ Modal Prompter -->
<% bool confirmation = true;
   if(ViewState["eventModal_confirmation"] != null)
   {
       confirmation = (bool)ViewState["eventModal_confirmation"];
   }
   %>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript">
    var modal = new bootstrap.Modal(document.getElementById('eventPrompter'));
    var confirmation = <%=confirmation.ToString().ToLower() %>;

    var condition = confirmation;

    // Open the modal if the condition is true
    if (condition) {
        modal.show();
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

    document.getElementById('confirmButton').addEventListener('click', function () {
        window.location.href = 'event-index.aspx';
    });

    function generateDescription() {
        var userInput = $('#<%= eventDescription.ClientID %>').val();

        const API_KEY = '<%=ViewState["api_key"] %>';
        const apiUrl = '<%=ViewState["api_url"] %>';
        const requestData = {
            contents: [
                {
                    role: 'user',
                    parts: [
                        {
                            text: userInput + '. Generate within One Paragraph with approximately 50 words.',
                        },
                    ],
                },
            ],
        };
        $.ajax({
            type: 'POST',
            url: `${apiUrl}?key=${API_KEY}`,
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function (response) {
                $('#<%= eventDescription.ClientID %>').val(response['candidates'][0]['content']['parts'][0]['text']);
            },
            error: function (error) {
                console.error('Error:', error.responseText || error.statusText);
            }
        });
    }
</script>
    
</asp:Content>
