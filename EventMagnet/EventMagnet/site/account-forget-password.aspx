<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="account-forget-password.aspx.cs" Inherits="EventMagnet.site.forgetPass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/forget-password.css" rel="stylesheet" />
    
    <div id="RstPass">
        <h3>Forgot Password? 🔒</h3>
            <p>Enter your email address</p>
            <div id="rstForm" method="POST">
                <asp:Label class="form-label" runat="server" Text="Email Address"></asp:Label>
                <asp:TextBox ID="txtEmail" class="form-control" runat="server" placeholder="Enter your email" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ErrorMessage="Please Enter the Email!" Display="Dynamic" ForeColor="Red" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                <asp:Label ID="lblErrorMessage" runat="server" Text="" Display="Dynamic" ForeColor="red"></asp:Label>
            </div>
        <div id="linkDiv">
            <asp:Button ID="btnResetLink" runat="server" Text="Send OTP" class="btn btn-primary d-grid w-100" OnClick="btnResetLink_Click"/>
            <a href="account-login.aspx" class="">< Back to login</a>
        </div>
    </div>

</asp:Content>
