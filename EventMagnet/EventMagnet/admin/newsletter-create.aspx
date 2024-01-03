<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="newsletter-create.aspx.cs" Inherits="EventMagnet.zDEl_admin.newsletter_create" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <style>
        div{
            margin: 0px 50px 0px 20px;
        }
    </style>

        <!-- Basic Layout -->
     <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Create Newsletter</h4>

<div class="col-xxl">
  <div class="card mb-4">
    <div class="card-header d-flex align-items-center justify-content-between">
      <h5 class="mb-0">Create Newsletter</h5>
      <small class="text-muted float-end">
          <asp:Button ID="btnClose" runat="server" Text="" CssClass="btn btn-close" CausesValidation="false" OnClick="btnClose_Click" /></small>
    </div>
    <div class="card-body">
        <div class="row mb-3">
          <label class="col-sm-2 col-form-label" for="basic-default-name" >Newsletter Title</label>
          <div class="col-sm-10">
             <asp:TextBox ID="txtTitle" class="form-control" placeholder="Orientation Week" runat="server" MaxLength="100"></asp:TextBox>
              <!-- validation -->
              <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ErrorMessage="⚠️ [Title Name] Cannot Be Empty !" CssClass="error" Display="Dynamic" ControlToValidate="txtTitle"></asp:RequiredFieldValidator>
          </div>
        </div>
          <!-- end validation -->

        <div class="row mb-3">
          <label class="col-sm-2 col-form-label" for="basic-default-company">Newsletter Content</label>
          <div class="col-sm-10">
              <asp:TextBox ID="txtNewsContent" runat="server" CssClass="form-control" placeholder="This is a event for freshie who join TARUMT in June" MaxLength="2000"></asp:TextBox>
              <!-- validation -->
              <asp:RequiredFieldValidator ID="rfvNewsContent" runat="server" ErrorMessage="⚠️ [Newsletter Content] Cannot Be Empty !" ControlToValidate="txtNewsContent" Display="Dynamic" CssClass="error" ></asp:RequiredFieldValidator>
          </div>
        </div>
            <!-- end validation -->

        <div class="row mb-3">
          <label class="col-sm-2 col-form-label" for="basic-default-company">Newsletter Image</label>
          <div class="col-sm-10">
              <asp:FileUpload ID="fuNewsImg" runat="server" class="form-control" onchange="displaySelectedImage(this)"/>
              <div class="form-text">Only Upload In PNG Format</div>
              <!-- validation -->
              <asp:RequiredFieldValidator ID="rfvNewsImg" runat="server" ErrorMessage="⚠️ [Newsletter Image] Cannot Be Empty !" ControlToValidate="fuNewsImg" Display="Dynamic" CssClass="error"></asp:RequiredFieldValidator>
              <asp:CustomValidator ID="cvNewsImg" runat="server" Display="Dynamic" ControlToValidate="fuNewsImg" ErrorMessage="" CssClass="error" OnServerValidate="cvNewsImg_ServerValidate" ></asp:CustomValidator>
              <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="⚠️ Only .JPG or .PNG File Accepted !" Display="Dynamic" ControlToValidate="fuNewsImg" CssClass="error" ValidationExpression=".+\.(jpg|png)"></asp:RegularExpressionValidator>
              <img src="" style="width: 400px;" alt="Selected Image" class="d-none rounded border p-2" id="selectedImage" />
          </div>
        </div>        
            <!-- end validation -->

        <div class="row justify-content-lg-start">
          <div class="col-sm-10">
              <asp:Button ID="btnCreate" runat="server" Text="Create" class="btn btn-primary" OnClick="btnCreate_Click"/>
              <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-outline-secondary" OnClick="btnReset_Click" CausesValidation="false" />
          </div>
            <strong><asp:Label ID="lblMessage" Text="" runat="server"  CssClass="text-capitalize" style="margin-top:20px"/> </strong><br />
        </div>

    </div>
  </div>
</div>
        

</asp:Content>
