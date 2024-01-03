﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-register.aspx.cs" Inherits="EventMagnet.admin.admin_register" %>

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

    <titleEVEMNT - Register</title>

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
        <div class="container-xxl flex-grow-1 container-p-y">
        <div class="row">
            <div class="col-md-12">
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
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
                            <h4 class="mb-2">Adventure starts here 🚀</h4>
                            <p class="mb-4">Make your app management easy and fun!</p>
                
                            <!-- Start Register -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="UserName" Text="Name" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtUsername" runat="server" class="form-control" name="UserName"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="txtUsername" ErrorMessage="Please Enter Your UserName!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Birthdate -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="Birthdate" Text="Birthdate" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtBirth" runat="server" class="form-control" name="birthdate" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVBirth" runat="server" ControlToValidate="txtBirth" ErrorMessage="Please Select Your Birth Date!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Phone -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="Phone" Text="Phone" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtPhone" runat="server" class="form-control" name="Phone"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Please Enter Your Phone Number!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CVPhone" runat="server" ErrorMessage="This Phone Number already exist! Try another one" ControlToValidate="txtPhone" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVPhone_ServerValidate" ></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="REVPhone" runat="server" ErrorMessage="Please enter phone number in this format (+60111322132)" ControlToValidate="txtPhone" ValidationGroup="REValidation" ValidationExpression="^\+601\d{8,9}$" display="Dynamic" CssClass="error"></asp:RegularExpressionValidator>
                            </div>
                            <!-- Identification Number -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="IdentificationNumber" Text="Identification Number" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtIdentificationNumber" runat="server" class="form-control" name="IdentificationNumber"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVIC" runat="server" ControlToValidate="txtIdentificationNumber" ErrorMessage="Please Enter Your Identification Number!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CVIc" runat="server" ErrorMessage="This IC Number already exist! Try another one" ControlToValidate="txtIdentificationNumber" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVIc_ServerValidate" ></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="REVIc" runat="server" ErrorMessage="Please enter IC in this format (010101-01-0101)" ControlToValidate="txtIdentificationNumber" ValidationGroup="REValidation" ValidationExpression="^\d{6}-\d{2}-\d{4}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                            </div>
                            <!-- Email -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="Email" Text="Email" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtEmail" runat="server" class="form-control" name="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Your Email!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CVEmail" runat="server" ErrorMessage="This email already exist. Try another one!" ControlToValidate="txtEmail" OnServerValidate="CVEmailMatch" ValidationGroup="REValidation" display="Dynamic" CssClass="error" ></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter email using correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" CssClass="error"></asp:RegularExpressionValidator>
                            </div>
                            <!-- Gender -->
                            <div class="mb-4 col-md-6">
                                <asp:Label Text="Gender" runat="server" class="form-label"/>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Select Gender" Value="" Enabled="False" Selected="True" />
                                    <asp:ListItem Text="Male" Value="M" />
                                    <asp:ListItem Text="Female" Value="F" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RFVGender" runat="server" ControlToValidate="ddlGender" ErrorMessage="Please Enter Your Gender!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Address Line 1 -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="AddressOne" Text="Address Line 1" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtAddressOne" runat="server" class="form-control" name="AddressOne"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVAddress" runat="server" ControlToValidate="txtAddressOne" ErrorMessage="Please Enter Your Address!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Address Line 2 -->
                            <div class="mb-4 col-md-6">
                                <asp:Label Text="Address Line 2 (Optional)" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtAddress2" runat="server" class="form-control" ></asp:TextBox>
                            </div>
                            <!-- Postcode -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="Postcode" Text="Postcode" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtPostcode" runat="server" class="form-control" name="Postcode"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVPostcode" runat="server" ControlToValidate="txtPostcode" ErrorMessage="Please Enter Post Code!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="REVPostcode" runat="server" ErrorMessage="Please enter Post Code with 5 number!" ControlToValidate="txtPostcode" ValidationGroup="REValidation" ValidationExpression="^\d{5}$" display="Dynamic" CssClass="error"></asp:RegularExpressionValidator>
                            </div>
                            <!-- City -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="City" Text="City" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtCity" runat="server" class="form-control" name="City"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVCity" runat="server" ControlToValidate="txtCity" ErrorMessage="Please Enter City!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- State -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="State" Text="State" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtState" runat="server" class="form-control" name="State"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVState" runat="server" ControlToValidate="txtState" ErrorMessage="Please Enter State!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Country -->
                            <div class="mb-4 col-md-6">
                                <asp:Label for="Country" Text="Country" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtCountry" runat="server" class="form-control" name="Country"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVCountry" runat="server" ControlToValidate="txtCountry" ErrorMessage="Please Enter Country!" ValidationGroup="REValidation" CssClass="error" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>

                            <div class="mb-3 form-password-toggle">
                                <asp:Label class="form-label" runat="server" Text="Password"></asp:Label>
                                <div class="input-group input-group-merge">
                                    <asp:TextBox ID="txtPass" class="form-control w-100" runat="server" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" ></asp:TextBox>
                                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                                </div>
                                <asp:RequiredFieldValidator ID="RFVPassword" runat="server" ControlToValidate="txtPass" ErrorMessage="Please Enter Your Password!" ValidationGroup="REValidation" CssClass="error" ></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label class="form-label" runat="server" Text="Confirm Password"></asp:Label>
                                <div class="input-group input-group-merge">
                                    <asp:TextBox ID="confirmPass" class="form-control w-100" runat="server" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" ></asp:TextBox>
                                    <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                                </div>
                                    <asp:RequiredFieldValidator ID="RFVConfirmPassword" runat="server" ControlToValidate="ConfirmPass" ErrorMessage="Please Re-Enter Your Password!" ValidationGroup="REValidation" display="Dynamic" CssClass="error" ></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="ComparePassword" runat="server" ControltoCompare="txtPass" ControlToValidate="ConfirmPass" ErrorMessage="Password does not match!" display="Dynamic" CssClass="error" ></asp:CompareValidator>
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                <asp:CheckBox ID="cbPrivacy" runat="server" />
                                <asp:Label class="form-check-label" runat="server" Text="I agree to "></asp:Label><a href="javascript:void(0);">privacy policy & terms</a>
                                </div>
                                <asp:CustomValidator ID="cbxRequired" runat="server" ErrorMessage="Please accept the privacy policay & terms!" onservervalidate="cbxCustomValidator" ValidationGroup="REValidation" CssClass="error" ></asp:CustomValidator>
                            </div>
                            <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="btn btn-primary d-grid w-100" OnClick="btnSignUp_Click" ValidationGroup="REValidation"/>
                            <!-- End  Register -->

                            <p class="text-center">
                            <span>Already have an account? </span>
                            <a href="admin-login.aspx">
                                <span>Sign in instead</span>
                            </a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </form>
    <!-- / Content -->

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