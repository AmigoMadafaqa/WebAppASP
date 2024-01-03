<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="organization-update.aspx.cs" Inherits="EventMagnet.admin.organization_update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Content -->
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Edit Organization</h4>
    <div class="row">
        <div class="col-md-12">
            <div class="card mb-4">
                <h5 class="card-header">Organization Details</h5>
                <!-- Organization Details -->
                

                <hr class="my-0" />
                <div class="card-body">
                    <div class="row">
                        <div class="mb-4 col-md-7">
                            <asp:Label for="OrganizationId" Text="ID" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtOrganizationId" runat="server" class="form-control" name="OrganizationId" ReadOnly="true"></asp:TextBox>
                        </div>
                        <!-- Name -->
                        <div class="mb-4 col-md-7">
                            <asp:Label for="OrganizationName" Text="Name" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtOrganizationName" runat="server" class="form-control" name="OrganizationName"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="txtOrganizationName" ErrorMessage="Please Enter Organization Name" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Description-->
                        <div class="mb-6 col-md-12">
                            <asp:Label ID="lblDescription" CssClass="form-label" runat="server" Text="Description"></asp:Label>
                            <asp:TextBox ID="orgDescription" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVDescp" runat="server" ControlToValidate="orgDescription" ErrorMessage="Please Enter Organization Description" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Website Link -->
                        <div class="mb-4 col-md-7">
                            <asp:Label for="WebsiteLink" Text="Website Link" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtWebsiteLink" runat="server" class="form-control" name="WebsiteLink"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVWeb" runat="server" ControlToValidate="txtWebsiteLink" ErrorMessage="Please Enter Organization Website" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Phone -->
                        <div class="mb-4 col-md-4">
                            <asp:Label for="Phone" Text="Phone" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtPhone" runat="server" class="form-control" name="Phone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Please Enter Contact Number" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CVPhone" runat="server" ErrorMessage="This Phone Number already exist! Try another one" ControlToValidate="txtPhone" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVPhone_ServerValidate" ></asp:CustomValidator>
                            <asp:RegularExpressionValidator ID="REVPhone" runat="server" ErrorMessage="Please enter phone number in this format (+60111322132)" ControlToValidate="txtPhone" ValidationGroup="REValidation" ValidationExpression="^\+601\d{8,9}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                        </div>
                        <!-- Email -->
                        <div class="mb-4 col-md-7">
                            <asp:Label for="Email" Text="Email" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtEmail" runat="server" class="form-control" name="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Email Address" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CVEmail" runat="server" ErrorMessage="This Email already exist! Try another one" ControlToValidate="txtEmail" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVEmail_ServerValidate" ></asp:CustomValidator>
                            <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter email using correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                        </div>
                        <hr class="my-0 mb-3" />
                        <!-- Address Line 1 -->
                        <div class="mb-4 col-md-7">
                            <asp:Label for="AddressOne" Text="Address Line 1" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtAddressOne" runat="server" class="form-control" name="AddressOne"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVAddress" runat="server" ControlToValidate="txtAddressOne" ErrorMessage="Please Enter Address Line One" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Address Line 2 -->
                        <div class="mb-4 col-md-7">
                            <asp:Label for="AddressTwo" Text="Address Line 2 (Optional)" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtAddressTwo" runat="server" class="form-control" name="AddressTwo"></asp:TextBox>
                        </div>
                        <!-- Postcode -->
                        <div class="mb-4 col-md-4">
                            <asp:Label for="Postcode" Text="Postcode" runat="server" class="form-label"/>
                            <asp:TextBox ID="txtPostcode" runat="server" class="form-control" name="Postcode" ></asp:TextBox>
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
                            <asp:TextBox ID="txtCountry" runat="server" class="form-control" name="Country" ></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RFVCountry" runat="server" ControlToValidate="txtCountry" ErrorMessage="Please Enter Country" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end">
                        <asp:Button ID="btnSaveChangesOrg" runat="server" Text="Save Changes" CssClass="btn btn-primary me-2" OnClick="btnSaveChangesOrg_Click" ValidationGroup="REValidation"/>
                        <asp:Button ID="btnResetOrg" runat="server" Text="Cancel" CssClass="btn btn-outline-secondary" OnClick="btnResetOrg_Click"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- / Content -->

</asp:Content>
