<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master"
AutoEventWireup="true" CodeBehind="event-venue-update.aspx.cs"
Inherits="EventMagnet.zDEl_admin.event_venue_update" %>
<asp:Content
  ID="Content1"
  ContentPlaceHolderID="head"
  runat="server"
></asp:Content>
<asp:Content
  ID="Content2"
  ContentPlaceHolderID="ContentPlaceHolder1"
  runat="server"
>
  <div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4">
      <span class="text-muted fw-light">Dashboard /</span> Edit Venue
    </h4>

    <div class="col-xxl">
      <div class="card mb-4">
        <div
          class="card-header d-flex align-items-center justify-content-between"
        >
          <h4 style="text-decoration: underline">Venue Details</h4>
        </div>
          
        <div class="card-body">
              <div >
                  Venue ID : 
                  <b><asp:Label ID="lblVenueId" Text="" runat="server" CssClass="read-only-text"/></b>
                  <br />
                  <br />
            </div>
            <div class="d-flex">
                <img src="<%= ViewState["imgSource"] %>"  alt="<%= ViewState["imgSource"]%>" id="selectedImageToDisplay" class="rounded border p-2 mb-2"/>
            </div>
          <br />
            <div class="mb-6 col-6">
                <asp:FileUpload ID="fuImgUpd" runat="server" onchange="displayImageandSelectedImage(this)" CssClass="form-control"/>
                <p class="font-weight-light m-0 ps-1 text-muted">Upload File For Update Image</p>
                    <!-- validation -->
                     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="⚠️ Only .JPG or .PNG File Accepted !" Display="Dynamic" ControlToValidate="fuImgUpd" CssClass="error" ValidationExpression=".+\.(jpg|png)"></asp:RegularExpressionValidator>
                    <!-- end of validation -->
            </div>
          <br />
          <div>
            Venue Name :
            <asp:TextBox
              ID="txtName"
              runat="server"
              Text=""
              CssClass="form-control"
            ></asp:TextBox>
            <!-- Validation -->
            <asp:RequiredFieldValidator
              ID="rfvVenueName"
              runat="server"
              ControlToValidate="txtName"
              ErrorMessage="⚠️ [VenueName] Cannot Be Empty !"
              Display="Dynamic"
              cssClass="error"
            ></asp:RequiredFieldValidator>
          </div>
          <br />
          <div>
            Venue Description :
            <asp:TextBox
              ID="txtDesc"
              runat="server"
              Text=""
              CssClass="form-control"
            ></asp:TextBox>
            <br />
          </div>
          <div>
            Venue Address :
            <asp:TextBox
              ID="txtAddr"
              runat="server"
              Text=""
              CssClass="form-control"
            ></asp:TextBox>
            <!-- Validation -->
            <asp:RequiredFieldValidator
              ID="rfvVenueAddress"
              runat="server"
              ErrorMessage="⚠️ [Venue Address] Cannot Be Empty !"
              CssClass="error"
              ControlToValidate="txtAddr"
              Display="Dynamic"
            ></asp:RequiredFieldValidator>
          </div>
          <br />
          <div>
            Phone No :
            <asp:TextBox
              ID="txtPhNo"
              runat="server"
              Text=""
              CssClass="form-control"
                 MaxLength="12"
            ></asp:TextBox>
            <!-- Validation -->
            <asp:RequiredFieldValidator
              ID="rfvPhNo"
              runat="server"
              ErrorMessage="⚠️ Please Insert [Phone Number] !"
              ControlToValidate="txtPhNo"
              CssClass="error"
              Display="Dynamic"
            ></asp:RequiredFieldValidator>
            <!-- Expression validator for phNo -->
            <asp:RegularExpressionValidator
              ID="revPhNo"
              runat="server"
              ControlToValidate="txtPhNo"
              ErrorMessage="⚠️ [Phone Number] Must Start With (+60)! The Length Must Be 11 Or 12 !"
              cssClass="error"
              ValidationExpression="^\+60\d{8,9}$"
              Display="Dynamic"
            ></asp:RegularExpressionValidator>
            <!-- end of expression validator -->
          </div>
          <br />
          <div>
            Email :
            <asp:TextBox
              ID="txtEmail"
              runat="server"
              Text=""
              pattern="[^ @]*@[^ @]*"
              CssClass="form-control"
            ></asp:TextBox>
            <!-- validation -->
            <asp:RequiredFieldValidator
              runat="server"
              ErrorMessage="⚠️ Please Enter [Email] With Correct Format !"
              ControlToValidate="txtEmail"
              Display="Dynamic"
              CssClass="error"
            ></asp:RequiredFieldValidator>
            <!-- Expression validator for email -->
            <asp:RegularExpressionValidator
              ID="EmailValidator"
              runat="server"
              ControlToValidate="txtEmail"
              ErrorMessage="⚠️ Invalid Email Address!"
              ValidationExpression="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
              Display="Dynamic"
              CssClass="error"
            ></asp:RegularExpressionValidator>
            <!-- end of expression validator -->
          </div>
            <div>
                <br />
                Status : <br />
                <asp:Label ID="lblStatus" Text="" runat="server" CssClass="form-label-lg text-capitalize" style="width:30%"/><asp:Button ID="btnChgStatus" runat="server" Text="Activate" CssClass="btn btn-dark" OnClick="btnChgStatus_Click" Visible=""/>
            </div>
          <br />
            <div>
          <asp:Button
            ID="btnUpd"
            runat="server"
            Text="Save Changes"
            CssClass="btn btn-primary" OnClick="btnUpd_Click" 
          />
          <asp:Button
            ID="btnCancel"
            runat="server"
            Text="Cancel"
            CssClass="btn btn-secondary"
            PostBackURL="~/admin/event-venue-index.aspx"
            CausesValidation="false"
          />
                </div>
            <br />
            <div>
                <asp:Label ID="lblComment" Text="" runat="server"  CssClass="form-label-lg"/>
            </div>
        </div>
      </div>
    </div>
  </div>

    <script>
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
    </script>
</asp:Content>
