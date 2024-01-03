<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="reset-password.aspx.cs" Inherits="EventMagnet.site.reset_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/forget-password.css" rel="stylesheet" />

    <div id="RstPass">
        <h3>Reset Password 🔒</h3>
        <div method="POST" class="mb-3">
            <asp:Label class="form-label" runat="server" Text="Enter the OTP"></asp:Label>
            <asp:TextBox ID="txtOtp" class="form-control" runat="server" placeholder="" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFVOtp" runat="server" ErrorMessage="Please Enter the OTP!" forecolor="red" Display="Dynamic" ControlToValidate="txtOtp"></asp:RequiredFieldValidator>
            <asp:Label ID="lblErrorMessage" runat="server" Text="" forecolor="Red" Display="Dynamic"></asp:Label>
        </div>

        <div method="POST" class="mb-3">
            <div class="mb-3 form-password-toggle">
                <asp:Label class="form-label" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPassword" TextMode="Password" class="form-control" runat="server" placeholder="Enter your Password" aria-describedby="password" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVPass" runat="server" ErrorMessage="Please Enter the Password!" ControlToValidate="txtPassword" forecolor="red" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>
            <div class="mb-3 form-password-toggle">
                <asp:Label class="form-label" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="txtConfirmPassword" TextMode="Password" class="form-control" runat="server" placeholder="Re-Enter your password" aria-describedby="password" ></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RFVConPass" runat="server" ErrorMessage="Please Re-Enter the Password!" ControlToValidate="txtConfirmPassword" forecolor="red" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="ComparePass" runat="server" ErrorMessage="Password Not Matched" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" forecolor="red" Display="Dynamic"></asp:CompareValidator>
            </div>
        </div>

        <asp:Button ID="btnReset" runat="server" Text="Reset Password" class="btn btn-primary d-grid w-100" OnClick="btnReset_Click" />
    </div>
</asp:Content>
