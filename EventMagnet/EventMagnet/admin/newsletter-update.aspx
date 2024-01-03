<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="newsletter-update.aspx.cs" Inherits="EventMagnet.zDEl_admin.newsletter_update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <style>
        div{
            margin: 0px 10px 0px 10px;
        }
    </style>
<h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Edit Newsletter</h4>

   <div class="col-xxl">
      <div class="card mb-4">
         <div class="card-header d-flex align-items-center justify-content-between">
            <h4 style="text-decoration:underline">Newsletter Details</h4>
         </div>
         <div class="card-body">
             Newsletter ID : <asp:Label ID="lblNewsID" Text="" runat="server" CssCLass="text-primary"/><br />
             <br />
             Newsletter Image :<br />
             <br />
                <img src="images/events/<%= ViewState["imgSource"] %>" alt="<%= ViewState["imgSource"] %>" class="rounded border p-2 mb-2" id="selectedImageToDisplay" />
             <br />
               <!-- File Input for Image Upload -->
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" onchange="displayImageandSelectedImage(this)" EnableViewState="true" />
                <p class="font-weight-light m-0 ps-1 text-muted">Upload Images File To Update Your Images.</p>
             <!-- validation -->
             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="⚠️ Only .JPG or .PNG File Accepted !" Display="Dynamic" ControlToValidate="fileUpload" CssClass="error" ValidationExpression=".+\.(jpg|png)"></asp:RegularExpressionValidator>
            <!-- end of validation -->
             <br />
            <br />
            Newsletter Title :  
            <asp:TextBox ID="txtNewsTitle" runat="server" Text="" CssClass="form-control" MaxLength="100" ></asp:TextBox>
             <!--validation -->
             <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ErrorMessage="⚠️ [Newsletter Title] Cannot Be Empty !" ControlToValidate="txtNewsTitle" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
            <br />
            Newsletter Content : 
            <asp:TextBox ID="txtNewsContent" runat="server" Text="" CssClass="form-control" MaxLength="2000" Height="50"></asp:TextBox>
             <!--validation -->
            <asp:RequiredFieldValidator ID="rfvContent" runat="server" ErrorMessage="⚠️ [Newsletter Content] Cannot Be Empty !" ControlToValidate="txtNewsContent" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
             <br />
             Status : <asp:Label ID="lblStatus" runat="server" Text="" CssClass="form-control" style="width:20%"></asp:Label><asp:Button ID="btnActivate" runat="server" Text="Activate" OnClick="btnActivate_Click" CssClass="btn btn-dark" Visible=""/>
             <br />
             Created Date Time : <asp:Label ID="lblCreateDT" Text="" runat="server"  CssClass="form-label-lg"/><br />
             <br />
             Organization ID : <asp:Label ID="lblOrgId" Text="" runat="server" CssCLass="form-label-lg text-primary"/> 
             <br />
             <br />

            <asp:Button ID="btnUpd" runat="server" Text="Save Changes"  CssClass="btn btn-primary" OnClick="btnUpd_Click"/>
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" PostBackURL="~/admin/newsletter-index.aspx" CausesValidation="false"/><br />
             <br />
             
             <div>
                 <asp:Label ID="lblComment" Text="" runat="server" CssClass="form-label-lg "/>
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
