<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-reset-password.aspx.cs" Inherits="EventMagnet.admin.admin_reset_password" %>

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

    <title>EVENNT - Reset Password</title>

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
        <div class="authentication-inner py-4">
          <!-- Forgot Password -->
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
              <h4 class="mb-2">Reset Password 🔒</h4>
                <!-- Start Forget Password-->
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
                
                <div class="mb-3 mx-auto">
                    <asp:Button ID="btnReset" runat="server" Text="Reset Password" class="btn btn-primary d-grid w-100 mx-auto" OnClick="btnReset_Click"/>
                </div>
                <!-- / End Forget Password-->

              <div class="text-center">
                <a href="admin-login.aspx" class="d-flex align-items-center justify-content-center">
                  <i class="bx bx-chevron-left scaleX-n1-rtl bx-sm"></i>
                  Back to login
                </a>
              </div>
            </div>
          </div>
          <!-- /Forgot Password -->
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