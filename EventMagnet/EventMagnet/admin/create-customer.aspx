<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="account-profile-confirm.aspx.cs" Inherits="EventMagnet.admin.create_customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/create-profile.css" rel="stylesheet" />

    <div class="create-profile">
        <div class="card mb-4">
            <h5 class="card-header">New Customer Details</h5>

            <div class="card-body row">
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="ID"></asp:Label>
                    <asp:TextBox ID="txtId" class="form-control" runat="server" value="1002" disabled=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox ID="txtName" class="form-control" runat="server" placeholder="e.g. Edward" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" Text="Birth Date" runat="server"/>
                    <input ID="birthDate" runat="server" type="date" class="form-control" />
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="IC Number"></asp:Label>
                    <asp:TextBox ID="txtIc" class="form-control" runat="server" placeholder="e.g. 020515-07-0867" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Email Address"></asp:Label>
                    <asp:TextBox ID="txtEmail" class="form-control" runat="server" placeholder="e.g. john.doe@example.com" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Phone Number"></asp:Label>
                    <asp:TextBox ID="txtPhone" class="form-control" runat="server" placeholder="e.g. 014 743 3600" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Address"></asp:Label>
                    <asp:TextBox ID="txtAddress" class="form-control" runat="server" placeholder="e.g. Address" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="State"></asp:Label>
                    <asp:TextBox ID="txtState" class="form-control" runat="server" placeholder="e.g. Pulau Pinang" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Post Code"></asp:Label>
                    <asp:TextBox ID="txtPostCode" class="form-control" runat="server" placeholder="e.g. 11900" autofocus="" maxlength="5" ></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Country"></asp:Label>
                    <asp:TextBox ID="txtCountry" class="form-control" runat="server" placeholder="e.g. Malaysia" autofocus=""></asp:TextBox>
                </div>
            </div>

            <div id="saveBtn">
                <asp:Button class="btn btn-primary me-2" ID="addBtn" runat="server" Text="Add New Customer" OnClick="addBtn_Click" />
                <asp:Button class="btn btn-outline-secondary" ID="resetBtn" runat="server" Text="Reset" OnClick="resetBtn_Click" />
            </div>
        </div>
    </div>
</asp:Content>
