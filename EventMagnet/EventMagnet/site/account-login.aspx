<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="EventMagnet.site.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/login.css" rel="stylesheet" />
    
<!-- 
            <br />
            <div class="container">
                <label><b>Username</b></label>
                <input type="text" placeholder="Enter Username" name="uname">

                <label><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="pas">

                <br />
                <br />
                <button id="logBtn" style="border-radius:25px;width:50%;color:black;margin:0 auto;display:block">Login</button>
                <br />
                <label>
                <input type="checkbox" checked="checked" name="remember"> Remember me
                </label>
            </div>
            <div id="btnDiv">
                <button type="button" class="cancelbtn" onclick="document.location='index.aspx'">Cancel</button>
                <span class="psw"><a href="account-forget-password.aspx">Forgot password?</a></span>
            </div>
        </div>
    </div>
-->   


    <div id="loginPage">
        <div id="loginForm">
            <h2>Login to your Account</h2>
            <br />
            <br />
        
            <div id="" method="POST" class="mb-3">
                <div>
                    <asp:Label class="form-label" runat="server" Text="Username"></asp:Label>
                    <asp:Panel Id="panelUsername" runat="server" DefaultButton="logBtn">
                        <asp:TextBox ID="txtUsername" class="form-control" runat="server" placeholder="Enter your username" autofocus=""></asp:TextBox>
                    </asp:Panel>
                    <asp:RequiredFieldValidator ID="RFVName" runat="server" ErrorMessage="Please Enter A Username!" ControlToValidate="txtUsername"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div><br />
                <div class="mb-3 form-password-toggle">
                    <asp:Label class="form-label" runat="server" Text="Password"></asp:Label>
                    <asp:Panel Id="panelPassword" runat="server" DefaultButton="logBtn">
                        <asp:TextBox ID="txtPass" TextMode="Password" class="form-control" runat="server" placeholder="Enter your password" aria-describedby="password" ></asp:TextBox>
                    </asp:Panel>
                    <asp:RequiredFieldValidator ID="RFVPass" runat="server" ErrorMessage="Please Enter Password!" ControlToValidate="txtPass"  Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVLogin" runat="server" ErrorMessage="Incorrect UserName or Password! Please Enter again." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                </div>
            </div>
            
            <br />
            <asp:Button ID="logBtn" runat="server" Text="Login" OnClick="logBtn_Click" CssClass="processBtn" />
            <div class="checkbox">
                <asp:CheckBox ID="cbRemember" runat="server" />
                <asp:Label class="form-check-label" runat="server" Text="Remember Me"></asp:Label>
            </div>

            <br />
            <asp:Button ID="cancelBtn" runat="server" Text="Cancel" OnClick="cancelBtn_Click" CssClass="cancelbtn" CausesValidation="False" />
            <a href="account-forget-password.aspx" id="forgetPassLink">Forgot password?</a>
        </div>

        <div id="registerForm">
            <div id="regcontent">
                <h2>New Here?</h2>
                <p>Sign up now and make your event management easy and fun!</p>
                <br />
                <br />
                <asp:Button ID="regBtn" runat="server" Text="Register" OnClick="regBtn_Click" CssClass="processBtn" CausesValidation="False" />
            </div>
        </div>
    </div>
    
    <div style="text-align:center;"><a href="/admin/admin-login.aspx">Proceed to Admin Website</a></div>

</asp:Content>
