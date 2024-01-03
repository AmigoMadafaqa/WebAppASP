<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="account-profile.aspx.cs" Inherits="EventMagnet.site.customer_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
         <link href="css/profile-update.css" rel="stylesheet" />
    <style>
        .read-only-textbox {
            background-color: #fff !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


 <div class="editProfile">
 <h4 class="fw-bold py-3 mb-4 text-muted">Customer Account Settings</h4>

     <div class="card mb-4">
         <h5 class="card-header">Customer Profile Details</h5>
     
         <div class="card-body row">
             <div class="d-flex">
                 <asp:Image ID="ImgUpload" runat="server" style="width: 400px; height: 400px" class="card-img card-img-center p-2 rounded border" AlternateText='<%#Eval("img_src") %>' />
             </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Name"></asp:Label>
                 <asp:TextBox ID="txtName" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
             </div>

             <div class="mb-3 col-md-6">
                <asp:Label class="form-label" runat="server" Text="Gender"></asp:Label>
                <asp:TextBox ID="txtGender" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
            </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Birth Date"></asp:Label>
                 <asp:TextBox ID="txtBirth" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
             </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="IC Number"></asp:Label>
                 <asp:TextBox ID="txtIc" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
             </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Email Address"></asp:Label>
                 <asp:TextBox ID="txtEmail" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
             </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Phone Number"></asp:Label>
                 <asp:TextBox ID="txtPhone" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
             </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Address Line 1"></asp:Label>
                 <asp:TextBox ID="txtAddress" class="form-control read-only-textbox" runat="server"  autofocus="" ReadOnly="True"></asp:TextBox>
             </div>
             <div class="mb-3 col-md-6">
                <asp:Label class="form-label" runat="server" Text="Address Line 2"></asp:Label>
                <asp:TextBox ID="txtAddress2" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
            </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Post Code"></asp:Label>
                 <asp:TextBox ID="txtPostCode" class="form-control read-only-textbox" runat="server" autofocus="" maxlength="5" ReadOnly="True" ></asp:TextBox>
             </div>
            <div class="mb-3 col-md-6">
                <asp:Label class="form-label" runat="server" Text="City"></asp:Label>
                <asp:TextBox ID="txtCity" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
            </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="State"></asp:Label>
                 <asp:TextBox ID="txtState" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
             </div>
             <div class="mb-3 col-md-6">
                 <asp:Label class="form-label" runat="server" Text="Country"></asp:Label>
                 <asp:TextBox ID="txtCountry" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
             </div>
         </div>

         <div class="saveDiv">
             <asp:Button class="btn btn-primary me-2" type="submit" ID="btnEditDetail" runat="server" Text="Edit Details" OnClick="btnEditDetail_Click1" />
         </div>
         
     </div>
      <div class="saveDiv">
        <asp:Button class="btn btn-danger me-2" type="submit" ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
    </div>

     <%--<div class="card">
         <h5 class="card-header">Delete Account</h5>
         <div class="card-body">
             <div class="mb-3 col-12 mb-0">
                 <div class="alert alert-warning">
                     <h6 class="alert-heading fw-bold mb-1">Are you sure you want to delete your account?</h6>
                     <p class="mb-0">Once you delete your account, there is no going back.</p>
                 </div>
             </div>
             <div id="formAccountDeactivation" >
                 <asp:Button ID="deleteBtn" class="btn btn-danger deactivate-account" runat="server" Text="Delete Account" OnClick="deleteBtn_Click" />
             </div>
         </div>
     </div>--%>
 </div>

</asp:Content>
