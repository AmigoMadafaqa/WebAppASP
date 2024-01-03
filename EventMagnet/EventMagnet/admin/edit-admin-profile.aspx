<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="edit-admin-profile.aspx.cs" Inherits="EventMagnet.admin.edit_admin_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Edit Profile</h4>
        <div class="row">
            <div class="col-md-12">
                <div class="card mb-4">
                    <h5 class="card-header">Profile Details</h5>
                    <div class="card-body">
                        <!-- Images Insert -->
                        <div class="d-flex align-items-start align-items-sm-center gap-4">
                            <asp:Image ID="ImgUpload" runat="server" style="width: 400px; height: 400px" class="card-img card-img-center p-2 rounded border" AlternateText='<%#Eval("img_src") %>' />
                        </div>
                    </div>
                    <hr class="my-0" />
                    <div class="card-body">
                        <div class="row">
                            <!-- ID 
                            <div class="mb-4 col-md-4">
                                <asp:Label for="UserID" Text="ID" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtUserID" runat="server" class="form-control" name="UserID" ReadOnly="true"></asp:TextBox>
                            </div>-->
                            <!-- Name -->
                            <div class="mb-4 col-md-4">
                                <asp:Label for="UserName" Text="Name" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtUserName" runat="server" class="form-control" name="UserName"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="txtUserName" ErrorMessage="Please Enter Name" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Birthdate -->
                            <div class="mb-4 col-md-4">
                                <asp:Label for="Birthdate" Text="Birthdate" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtBirth" runat="server" class="form-control" name="birthdate" TextMode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVBirth" runat="server" ControlToValidate="txtBirth" ErrorMessage="Please Select Birth Date" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Gender -->
                            <div class="mb-4 col-md-4">
                                <asp:Label Text="Gender" runat="server" class="form-label"/>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Male" Value="M" />
                                    <asp:ListItem Text="Female" Value="F" />
                                </asp:DropDownList>
                            </div> 
                            <!-- Phone -->
                            <div class="mb-4 col-md-3">
                                <asp:Label for="Phone" Text="Phone" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtPhone" runat="server" class="form-control" name="Phone"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Please Enter Phone Number" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CVPhone" runat="server" ErrorMessage="This Phone Number already exist! Try another one" ControlToValidate="txtPhone" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVPhone_ServerValidate" ></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="REVPhone" runat="server" ErrorMessage="Please enter phone number in this format (+60111322132)" ControlToValidate="txtPhone" ValidationGroup="REValidation" ValidationExpression="^\+601\d{8,9}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                            </div>
                            <!-- Identification Number -->
                            <div class="mb-4 col-md-4">
                                <asp:Label for="IdentificationNumber" Text="Identification Number" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtIdentificationNumber" runat="server" class="form-control" name="IdentificationNumber"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVIC" runat="server" ControlToValidate="txtIdentificationNumber" ErrorMessage="Please Enter IC Number" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CVIc" runat="server" ErrorMessage="This IC Number already exist! Try another one" ControlToValidate="txtIdentificationNumber" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVIc_ServerValidate" ></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="REVIc" runat="server" ErrorMessage="Please enter IC in this format (010101-01-0101)" ControlToValidate="txtIdentificationNumber" ValidationGroup="REValidation" ValidationExpression="^\d{6}-\d{2}-\d{4}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                            </div>
                            <!-- Email -->
                            <div class="mb-4 col-md-5">
                                <asp:Label for="Email" Text="Email" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtEmail" runat="server" class="form-control" name="Email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Email" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CVEmail" runat="server" ErrorMessage="This Email already exist! Try another one" ControlToValidate="txtEmail" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVEmail_ServerValidate" ></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter email using correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                            </div>
                            <hr class="my-0 mb-3" />
                            <!-- Address Line 1 -->
                            <div class="mb-4 col-md-7">
                                <asp:Label for="AddressOne" Text="Address Line 1" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtAddressOne" runat="server" class="form-control" name="AddressOne"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVAddress" runat="server" ControlToValidate="txtAddressOne" ErrorMessage="Please Enter Address" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Address Line 2 -->
                            <div class="mb-4 col-md-7">
                                <asp:Label for="AddressTwo" Text="Address Line 2 (Optional)" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtAddressTwo" runat="server" class="form-control" name="AddressTwo"></asp:TextBox>
                            </div>
                            <!-- Postcode -->
                            <div class="mb-4 col-md-4">
                                <asp:Label for="Postcode" Text="Postcode" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtPostcode" runat="server" class="form-control" name="Postcode"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVPostcode" runat="server" ControlToValidate="txtPostcode" ErrorMessage="Please Enter Post Code" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="REVPostcode" runat="server" ErrorMessage="Please enter Post Code with 5 number!" ControlToValidate="txtPostcode" ValidationGroup="REValidation" ValidationExpression="^\d{5}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                            </div>
                            <!-- City -->
                            <div class="mb-4 col-md-7">
                                <asp:Label for="City" Text="City" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtCity" runat="server" class="form-control" name="City"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVCity" runat="server" ControlToValidate="txtCity" ErrorMessage="Please Enter City" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- State -->
                            <div class="mb-4 col-md-4">
                                <asp:Label for="State" Text="State" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtState" runat="server" class="form-control" name="State"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVState" runat="server" ControlToValidate="txtState" ErrorMessage="Please Enter State" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Country -->
                            <div class="mb-4 col-md-4">
                                <asp:Label for="Country" Text="Country" runat="server" class="form-label"/>
                                <asp:TextBox ID="txtCountry" runat="server" class="form-control" name="Country"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVCountry" runat="server" ControlToValidate="txtCountry" ErrorMessage="Please Enter Country" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <!-- Save and Cancel Buttons -->
                            <div class="d-flex justify-content-end">
                                <asp:Button ID="btnSaveProfile" runat="server" Text="Save Changes" CssClass="btn btn-primary me-2" OnClick="btnSaveProfile_Click" ValidationGroup="REValidation"/>
                                <asp:Button ID="btnCancel" runat="server" Text="Back" CssClass="btn btn-outline-secondary" OnClick="btnCancel_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>         
    </div>
</asp:Content>
