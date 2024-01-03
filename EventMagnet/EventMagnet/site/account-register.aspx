<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="account-register.aspx.cs" Inherits="EventMagnet.site.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/register.css" rel="stylesheet" />
    
    <div id="registerPage">
        <div id="registerForm" class="mb-3" action="index.aspx" method="POST">
            <h2>REGISTER</h2>
            <br />
            <br />
            
            <div>
                <asp:Label class="form-label" runat="server" Text="Username"></asp:Label>
                &nbsp;<asp:TextBox ID="txtUsername" class="form-control" runat="server" placeholder="Enter your username" autofocus="" ></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="txtUsername" ErrorMessage="Please Enter Your Username!" ValidationGroup="REValidation" CssClass="error" ></asp:RequiredFieldValidator>
                <br />
            <div class="mb-3">
                <asp:Label class="form-label" runat="server" Text="Email Address"></asp:Label>
                &nbsp;<asp:TextBox ID="txtEmail" class="form-control" runat="server" placeholder="Enter your email address" autofocus=""></asp:TextBox>
                <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Your Email!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="This email already exist. Try another one!" ControlToValidate="txtEmail" OnServerValidate="CustomValidator1_ServerValidate" ValidationGroup="REValidation" display="Dynamic" CssClass="error" ></asp:CustomValidator>
                <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter email using correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
            </div>
            <div class="mb-3 form-password-toggle">
                <asp:Label class="form-label" runat="server" Text="Password"></asp:Label>
                &nbsp;<div class="input-group input-group-merge">
                    <asp:TextBox ID="txtPass" class="form-control w-100" runat="server" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" ></asp:TextBox>
                </div><asp:RequiredFieldValidator ID="RFVPassword" runat="server" ControlToValidate="txtPass" ErrorMessage="Please Enter Your Password!" ValidationGroup="REValidation" CssClass="error" ></asp:RequiredFieldValidator>
                <br />
                <asp:Label class="form-label" runat="server" Text="Confirm Password"></asp:Label>
                &nbsp;<div class="input-group input-group-merge">
                    <asp:TextBox ID="confirmPass" class="form-control w-100" runat="server" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVConfirmPassword" runat="server" ControlToValidate="ConfirmPass" ErrorMessage="Please Re-Enter Your Password!" ValidationGroup="REValidation" display="Dynamic" CssClass="error" ></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="ComparePassword" runat="server" ControltoCompare="txtPass" ControlToValidate="ConfirmPass" ErrorMessage="Password does not match!" display="Dynamic" CssClass="error" ></asp:CompareValidator>
                </div>
            </div>
        </div>

        <div class="checkbox">
            <br />
            <asp:CheckBox ID="cbPrivacy" runat="server"/>
            <asp:Label class="form-check-label" runat="server" Text="I agree to "></asp:Label><a href="javascript:void(0);">privacy policy & terms</a>
            <br />
            <asp:CustomValidator ID="CVcheckbox" runat="server" ErrorMessage="Please accept the privacy policy & terms!" CssClass="error" OnServerValidate="cbPrivacy_ServerValidate" ValidationGroup="REValidation" Display="Dynamic" SetFocusOnError="true" />
        </div>
        
        <br />
        <div class="recaptcha">
            <asp:Image ID="captchaImg" runat="server" Height="50px" Width="200px" imageurl="captcha.aspx"/><br /><br />
            <asp:TextBox class="form-control w-50" ID="captchaCode" runat="server" placeholder="Enter Captcha Code!"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RFVCaptcha" runat="server" ControlToValidate="captchaCode" ErrorMessage="Please Enter Captcha Code!"  CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Captcha Code is incorrect!" ControlToValidate="captchaCode" display="Dynamic" CssClass="error" OnServerValidate="CustomValidator2_ServerValidate" ></asp:CustomValidator>
        </div>

        <br />
        <br />
        <asp:Button class="regBtn" ID="regBtn" runat="server" Text="Sign up" OnClick="regBtn_Click" ValidationGroup="REValidation"/>
        <p class="loginLink">
            <span>Already have an account?<a href="account-login.aspx">Login</a></span>
        </p>
    </div>

</asp:Content>
