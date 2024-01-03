<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-venue-create.aspx.cs" Inherits="EventMagnet.admin.event_venue_create"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <style>
      .rent-venue-application {
      margin: 0px 10px;
      padding: 30px 0px
      }
   </style>
   <!-- Basic Layout -->
   <div class="container-xxl flex-grow-1 container-p-y">
      <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Create Venue</h4>
      <div class="col-xxl">
         <div class="card mb-4">
            <div class="card-header d-flex align-items-center justify-content-between">
               <h5 class="mb-0">Add New Venue</h5>
               <small class="text-muted float-end">
                  <asp:Button ID="btnClose" runat="server" Text="" CssClass="btn btn-close" OnClick="btnClose_Click" CausesValidation="false" />
               </small>
            </div>
            <div class="card-body">
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="basic-default-name">Venue Name</label>
                  <div class="col-sm-10">
                     <asp:TextBox ID="txtVName" CssClass="form-control" runat="server" placeholder="TARUMT-CA"></asp:TextBox>
                     <!-- Validation -->
                     <asp:RequiredFieldValidator ID="rfvVenueName" runat="server" ControlToValidate="txtVName" ErrorMessage="⚠️ [VenueName] Cannot Be Empty !" Display="Dynamic" cssClass="error" ></asp:RequiredFieldValidator>
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="basic-default-company">Venue Description</label>
                  <div class="col-sm-10">
                     <asp:TextBox ID="txtVDesc" runat="server" CssClass="form-control" placeholder="Central Audithorium" ></asp:TextBox>
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="basic-default-message">Venue Address</label>
                  <div class="col-sm-10">
                     <asp:TextBox ID="txtVAddr" runat="server" CssClass="form-control" placeholder="77, Lorong Lembah Permai 3, 11200 Tanjung Bungah, Pulau Pinang"></asp:TextBox>
                     <!-- Validation -->
                     <asp:RequiredFieldValidator ID="rfvVenueAddress" runat="server" ErrorMessage="⚠️ [Venue Address] Cannot Be Empty !" CssClass="error" ControlToValidate="txtVAddr" Display="Dynamic"></asp:RequiredFieldValidator>
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="basic-default-phone">Phone No</label>
                  <div class="col-sm-10">
                     <asp:TextBox ID="txtPhNo" runat="server" CssClass="form-control phone-mask" placeholder="+6012112345"></asp:TextBox>
                     <!-- Validation -->
                     <asp:RequiredFieldValidator ID="rfvPhNo" runat="server" ErrorMessage="⚠️ Please Insert [Phone Number] !" ControlToValidate="txtPhNo" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                     <!-- Expression validator for phNo -->
                     <asp:RegularExpressionValidator ID="revPhNo" runat="server" ControlToValidate="txtPhNo" ErrorMessage="⚠️ [Phone Number] Must Start With +60 !" cssClass="error" ValidationExpression="^\+60\d{8,9}$" Display="Dynamic"></asp:RegularExpressionValidator>
                     <!-- end of expression validator -->
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="basic-default-email">Email</label>
                  <div class="col-sm-10">
                     <div class="input-group input-group-merge">
                        <asp:TextBox ID="txtEmail" runat="server" CssClass ="form-control" placeholder="tarumt@gmail.com" ></asp:TextBox>
                     </div>
                     <div class="form-text">You can use letters, numbers & periods</div>
                     <!-- validation --> 
                     <asp:RequiredFieldValidator runat="server" ErrorMessage="⚠️ Please Enter [Email] With Correct Format !" ControlToValidate="txtEmail" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
                     <!-- Expression validator for email -->
                     <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="txtEmail" ErrorMessage="⚠️ Invalid Email Address!" ValidationExpression="^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$" Display="Dynamic" CssClass="error" ></asp:RegularExpressionValidator>
                     <!-- end of expression validator -->
                  </div>
               </div>
               <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="basic-default-company">Venue Photo</label>
                  <div class="col-sm-10">
                     <asp:FileUpload ID="fuVenueImg" runat="server" class="form-control" onchange="displaySelectedImage(this)"/>
                     <div class="form-text"> ** Only Upload In PNG Format <br />
                         ** Please Take Notes That The Image Is NOT Available To Change
                     </div>
                     <!-- validation -->
                     <asp:RequiredFieldValidator ID="rfvVenueImg" runat="server" ErrorMessage="⚠️ [File Uploaded] Cannot Be Empty !" ControlToValidate="fuVenueImg" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                     <asp:CustomValidator ID="cvVenueImg" runat="server" Display="Dynamic" ControlToValidate="fuVenueImg" ErrorMessage="" CssClass="error" OnServerValidate="cvVenueImg_ServerValidate" ></asp:CustomValidator>
                      <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="⚠️ Only .JPG or .PNG File Accepted !" Display="Dynamic" ControlToValidate="fuVenueImg" CssClass="error" ValidationExpression=".+\.(jpg|png)"></asp:RegularExpressionValidator>
                     <!-- end of validation -->
                     <!-- display selected image -->
                     <img src="" style="width: 400px;" alt="Selected Image" class="d-none rounded border p-2" id="selectedImage" />
                     <!-- end display -->
                  </div>
               </div>
               <div class="row justify-content-end">
                  <div class="col-sm-10">
                     <asp:Button ID="btnCreate" runat="server" Text="Create" class="btn btn-primary" OnClick="btnCreate_Click" ClientIDMode="Static"/>
                     <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" CausesValidation="false" />
                     <br />
                     <!-- testing 
                     <asp:Literal ID="littest" runat="server" Text=""></asp:Literal>
                     <!-- end testing -->

                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</asp:Content>