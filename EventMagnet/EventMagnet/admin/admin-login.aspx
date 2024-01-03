<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-login.aspx.cs" Inherits="EventMagnet.admin.admin_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"
  lang="en"
  class="light-style customizer-hide"
  dir="ltr"
  data-theme="theme-default">
<head runat="server">
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>EVEMNT - Login</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="images/icons/evemagnet_icon.png" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="css/pages/page-auth.css" />
    <!-- Helpers -->
    <script src="js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the  section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="js/config.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!-- Content -->

    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner ">
          <!-- Register -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center">
                <a href="#" class="app-brand-link gap-2">
                  <span class="app-brand-logo demo">
                      <img src="images/icons/evemagnet_icon.png" width="50"/>
                  </span>
                  <span class="app-brand-text demo text-body fw-bolder" style="font-weight:bolder;text-transform:uppercase;">EVEMNT</span>
                </a>
              </div>
              <!-- /Logo -->
              <h4 class="mb-4">Welcome to Our Management System! 👋</h4>
              <p class="mb-4">Please sign-in to your account and start the event</p>

                <!-- Login -->
                <div class="mb-3">
                  <label for="email" class="form-label">Email or Username</label>
                    <asp:TextBox ID="txtUsername" CssClass="form-control" runat="server" Text="" Placeholder="Enter your email or username"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RFVName" runat="server" ErrorMessage="Please Enter Username" Display="Dynamic" ForeColor="Red" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
                    <%--<input type="text" class="form-control" id="email" name="email-username" placeholder="Enter your email or username" autofocus />--%>
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="password">Password</label>
                    <a href="admin-forget-password.aspx">
                      <small>Forgot Password?</small>
                    </a>
                  </div>
                  <div class="input-group input-group-merge">
                      <asp:TextBox ID="txtPass" CssClass="form-control" Placeholder="Enter your password" TextMode="Password" runat="server" Text=""></asp:TextBox>
                      <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                  </div>
                    <asp:RequiredFieldValidator ID="RFVPass" runat="server" ErrorMessage="Please Enter Password" Display="Dynamic" ForeColor="Red" ControlToValidate="txtPass"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVLogin" runat="server" ErrorMessage="Incorrect UserName or Password! Please Enter again." Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                </div>
                <div class="mb-3">
                  <div class="form-check">
                      <asp:CheckBox ID="rmbme" runat="server" />
                      <asp:Label ID="lblRmbme" runat="server" class="form-check-label" Text="Remember Me"></asp:Label>
                  </div>
                </div>
                <div class="mb-3 mx-auto">
                    <asp:Button ID="btnSignIn" runat="server" Text="Sign in" CssClass="btn btn-primary d-grid w-100 mx-auto" OnClick="btnSignIn_Click"/>
                    <%--<button class="btn btn-primary d-grid w-100" type="submit">Sign in</button>--%>
                </div>
              <!--/ Login -->

              <p class="text-center">
                <span>New on our platform?</span>
                <a href="admin-register.aspx">
                  <span>Create an account</span>
                </a>
              </p>
               <p style="text-align:center;"><br /><a href="/site/index.aspx">Proceed to Public Website</a></p>
            </div>
          </div>
          <!-- /Register -->
        </div>
      </div>
    </div>

    <!-- / Content -->
        </div>
    </form>
<!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="libs/jquery/jquery.js"></script>
    <script src="libs/popper/popper.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>
</html>