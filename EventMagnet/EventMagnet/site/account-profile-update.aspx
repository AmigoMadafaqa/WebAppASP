<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="account-profile-update.aspx.cs" Inherits="EventMagnet.site.editProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/profile-update.css" rel="stylesheet" />

    <div class="editProfile">
    <h4 class="fw-bold py-3 mb-4 text-muted">Customer Account Settings</h4>

        <div class="card mb-4">
            <h5 class="card-header">Customer Profile Details</h5>
            <br />
        
            <!-- Image Display -->
            <div class="d-flex align-items-center align-items-sm-center gap-4 mx-auto" >
                <asp:Image ID="ImgUpload" runat="server" style="width: 400px; height: 400px" class="card-img card-img-center p-2 rounded border mx-2" AlternateText='<%#Eval("img_src") %>' />
            </div>
            <div class="card-body row">
                <div class="mb-3 col-md-4">
                    <asp:Label class="form-label" runat="server" Text="ID"></asp:Label>
                    <asp:TextBox ID="txtId" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="mb-3 col-md-4">
                    <asp:Label class="form-label" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox ID="txtName" class="form-control" runat="server" value="Edward" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVName" runat="server" ErrorMessage="Please Enter Name" ControlToValidate="txtName" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-4">
                    <asp:Label class="form-label" runat="server" Text="Gender"></asp:Label>
                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                        <asp:ListItem Value="M">Male</asp:ListItem>
                        <asp:ListItem Value="F">Female</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Birth Date"></asp:Label>
                    <asp:TextBox ID="txtBirth" runat="server" class="form-control" name="birthdate" TextMode="Date"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVBirth" runat="server" ErrorMessage="Please Select Birth Date" ControlToValidate="txtBirth" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="IC Number"></asp:Label>
                    <asp:TextBox ID="txtIc" class="form-control" runat="server" value="020515-07-0867" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVIC" runat="server" ErrorMessage="Please Enter IC Number" ControlToValidate="txtIc" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVIc" runat="server" ErrorMessage="This IC Number already exist! Try another one" ControlToValidate="txtIc" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVIc_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVIc" runat="server" ErrorMessage="Please enter IC in this format (010101-01-0101)" ControlToValidate="txtIc" ValidationGroup="REValidation" ValidationExpression="^\d{6}-\d{2}-\d{4}$" display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Email Address"></asp:Label>
                    <asp:TextBox ID="txtEmail" class="form-control" runat="server" value="john.doe@example.com" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ErrorMessage="Please Enter Email" ControlToValidate="txtEmail" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVEmail" runat="server" ErrorMessage="This Email already exist! Try another one" ControlToValidate="txtEmail" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVEmail_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter email using correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Phone Number"></asp:Label>
                    <asp:TextBox ID="txtPhone" class="form-control" runat="server" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVPhone" runat="server" ErrorMessage="Please Enter Phone Number" ControlToValidate="txtPhone" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVPhone" runat="server" ErrorMessage="This Phone Number already exist! Try another one" ControlToValidate="txtPhone" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVPhone_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVPhone" runat="server" ErrorMessage="Please enter phone number in this format (+60111322132)" ControlToValidate="txtPhone" ValidationGroup="REValidation" ValidationExpression="^\+601\d{8,9}$" display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Address Line 1"></asp:Label>
                    <asp:TextBox ID="txtAddress" class="form-control" runat="server" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVAddress1" runat="server" ErrorMessage="Please Enter Address Line 1" ControlToValidate="txtAddress" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Address Line 2"></asp:Label>
                    <asp:TextBox ID="txtAddress2" class="form-control" runat="server" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Post Code"></asp:Label>
                    <asp:TextBox ID="txtPostCode" class="form-control" runat="server" autofocus="" maxlength="5" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVPostCode" runat="server" ErrorMessage="Please Enter Post Code" ControlToValidate="txtPostCode" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="REVPostcode" runat="server" ErrorMessage="Please enter Post Code with 5 number!" ControlToValidate="txtPostCode" ValidationGroup="REValidation" ValidationExpression="^\d{5}$" display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="City"></asp:Label>
                    <asp:TextBox ID="txtCity" class="form-control" runat="server" autofocus="" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVCity" runat="server" ErrorMessage="Please Enter City" ControlToValidate="txtCity" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="State"></asp:Label>
                    <asp:TextBox ID="txtState" class="form-control" runat="server" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVState" runat="server" ErrorMessage="Please Enter State" ControlToValidate="txtState" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Country"></asp:Label>
                    <asp:TextBox ID="txtCountry" class="form-control" runat="server" value="Malaysia" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVCountry" runat="server" ErrorMessage="Please Enter Country" ControlToValidate="txtCountry" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div class="saveDiv">
                <asp:Button class="btn btn-primary me-2 mx-1" type="submit" ID="savebtn" runat="server" Text="Save Changes" OnClick="savebtn_Click" ValidationGroup="REValidation"/>
                <asp:Button class="btn btn-outline-secondary mx-1" type="reset" ID="resetBtn" runat="server" Text="Reset" OnClick="resetBtn_Click" />
            </div>
        </div>

        <!--
        <div class="card">
            <h5 class="card-header">Delete Account</h5>
            <div class="card-body">
                <div class="mb-3 col-12 mb-0">
                    <div class="alert alert-warning">
                        <h6 class="alert-heading fw-bold mb-1">Are you sure you want to delete your account?</h6>
                        <p class="mb-0">Once you delete your account, there is no going back.</p>
                    </div>
                </div>
                <div id="formAccountDeactivation" style="display:flex;justify-content:center;">
                    <asp:Button ID="deleteBtn" class="btn btn-danger deactivate-account" runat="server" Text="Delete Account" OnClick="deleteBtn_Click" />
                </div>
            </div>
        </div>
        -->
    </div>
</asp:Content>
