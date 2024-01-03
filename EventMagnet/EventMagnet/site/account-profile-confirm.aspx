<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="account-profile-confirm.aspx.cs" Inherits="EventMagnet.site.create_customer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/create-profile.css" rel="stylesheet" />
    
    <div class="create-profile">
        <div class="card mb-4">
            <h5 class="card-header">New Customer Details</h5>
    
            <div class="card-body row">
                <div class="mb-3 col-md-4">
                    <asp:Label class="form-label" runat="server" Text="ID"></asp:Label>
                    <asp:TextBox ID="txtId" class="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                </div>
                <div class="mb-3 col-md-4">
                    <asp:Label class="form-label" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox ID="txtName" class="form-control" runat="server" placeholder="e.g. Edward" autofocus=""></asp:TextBox>
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
                    <asp:Label class="form-label" Text="Birth Date" runat="server"/>
                    <input ID="txtbirthDate" runat="server" type="date" class="form-control" />
                    <asp:RequiredFieldValidator ID="RFVBirth" runat="server" ErrorMessage="Please Select Birth Date" ControlToValidate="txtbirthDate" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="IC Number"></asp:Label>
                    <asp:TextBox ID="txtIc" class="form-control" runat="server" placeholder="e.g. 020515-07-0867" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVIC" runat="server" ErrorMessage="Please Enter IC Number" ControlToValidate="txtIc" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVIc" runat="server" ErrorMessage="This IC Number already exist! Try another one" ControlToValidate="txtIc" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVIc_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVIc" runat="server" ErrorMessage="Please enter IC in this format (010101-01-0101)" ControlToValidate="txtIc" ValidationGroup="REValidation" ValidationExpression="^\d{6}-\d{2}-\d{4}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Email Address"></asp:Label>
                    <asp:TextBox ID="txtEmail" class="form-control" runat="server" placeholder="e.g. john.doe@example.com" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ErrorMessage="Please Enter Email" ControlToValidate="txtEmail" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVEmail" runat="server" ErrorMessage="This Email already exist! Try another one" ControlToValidate="txtEmail" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVEmail_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter email using correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Phone Number"></asp:Label>
                    <asp:TextBox ID="txtPhone" class="form-control" runat="server" placeholder="e.g. +60147433600" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVPhone" runat="server" ErrorMessage="Please Enter Phone Number" ControlToValidate="txtPhone" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVPhone" runat="server" ErrorMessage="This Phone Number already exist! Try another one" ControlToValidate="txtPhone" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVPhone_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVPhone" runat="server" ErrorMessage="Please enter phone number in this format (+60111322132)" ControlToValidate="txtPhone" ValidationGroup="REValidation" ValidationExpression="^\+601\d{8,9}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Address Line 1"></asp:Label>
                    <asp:TextBox ID="txtAddress" class="form-control" runat="server" placeholder="e.g. Address Line 1" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVAddress1" runat="server" ErrorMessage="Please Enter Address" ControlToValidate="txtAddress" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Address Line 2 (Optional)"></asp:Label>
                    <asp:TextBox ID="txtAddress2" class="form-control" runat="server" placeholder="e.g. Address Line 2" autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Post Code"></asp:Label>
                    <asp:TextBox ID="txtPostCode" class="form-control" runat="server" placeholder="e.g. 11900" autofocus="" maxlength="5" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVPostcode" runat="server" ErrorMessage="Please Enter Post Code" ControlToValidate="txtPostCode" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="REVPostcode" runat="server" ErrorMessage="Please enter Post Code with 5 number!" ControlToValidate="txtPostCode" ValidationGroup="REValidation" ValidationExpression="^\d{5}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Post Code"></asp:Label>
                    <asp:TextBox ID="txtCity" class="form-control" runat="server" placeholder="e.g. GeorgeTown" autofocus="" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVCity" runat="server" ErrorMessage="Please Enter City" ControlToValidate="txtCity" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="State"></asp:Label>
                    <asp:TextBox ID="txtState" class="form-control" runat="server" placeholder="e.g. Pulau Pinang" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVState" runat="server" ErrorMessage="Please Enter State" ControlToValidate="txtState" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Country"></asp:Label>
                    <asp:TextBox ID="txtCountry" class="form-control" runat="server" placeholder="e.g. Malaysia" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVCountry" runat="server" ErrorMessage="Please Enter Country" ControlToValidate="txtCountry" ValidationGroup="REValidation" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div id="saveBtn">
                <asp:Button class="btn btn-primary me-2 mx-1" ID="addBtn" runat="server" Text="Complete Profile" OnClick="addBtn_Click" ValidationGroup="REValidation"/>
                <asp:Button class="btn btn-outline-secondary mx-1" ID="resetBtn" runat="server" Text="Reset" OnClick="resetBtn_Click" />
            </div>
        </div>
    </div>
</asp:Content>
