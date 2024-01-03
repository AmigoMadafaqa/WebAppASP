<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="organization-create.aspx.cs" Inherits="EventMagnet.admin.create_organization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/create-profile.css" rel="stylesheet" />

    <div class="create-profile container-xxl flex-grow-1 container-p-y">
         <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Create Organization</h4>
        <div class="row">
            <div class="col-2">
                <asp:Button ID="btnIndex" runat="server" Text="View All" CssClass="btn btn-lg btn-outline-primary" OnClick="btnIndex_Click" CausesValidation="False" />
            </div>
        </div>
        <div class="card mb-4 mt-3">
            <h5 class="card-header">New Organization Details</h5>

            
            <div class="card-body row">
                <!--image-->
                <div class="row mb-3">
                   <label class="col-sm-2 col-form-label" for="basic-default-company">Organization Logo</label>
                   <div class="col-sm-10">
                      <asp:FileUpload ID="img" runat="server" class="form-control" onchange="displaySelectedImage(this)"/>
                      <div class="form-text"> ** Only Upload In PNG Format <br />
                          ** Please Take Notes That The Image Is NOT Available To Change
                      </div>
                      <!-- validation -->
                      <asp:RequiredFieldValidator ID="RFVImg" runat="server" ErrorMessage="⚠️ [File Uploaded] Cannot Be Empty !" ControlToValidate="img" ValidationGroup="REValidation" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                      <asp:CustomValidator ID="CVImg" runat="server" Display="Dynamic" ControlToValidate="img" ErrorMessage="" CssClass="error" ValidationGroup="REValidation" OnServerValidate="cvImg_ServerValidate" ></asp:CustomValidator>
                       <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="⚠️ Only .JPG File Accepted !" ValidationGroup="REValidation" Display="Dynamic" ControlToValidate="img" CssClass="error" ValidationExpression=".+\.(jpg|png)"></asp:RegularExpressionValidator>
                      <!-- end of validation -->
                      <!-- display selected image -->
                      <img src="" style="width: 400px;" alt="Selected Image" class="d-none rounded border p-2" id="selectedImage" />
                      <!-- end display -->
                   </div>
                </div>

                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox ID="txtName" class="form-control" runat="server" placeholder="e.g. Google" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVName" runat="server" ControlToValidate="txtName" ErrorMessage="Please Enter Organization Name" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-6 col-md-12">
                    <asp:Label class="form-label" runat="server" Text="Description"></asp:Label>
                    <asp:TextBox ID="txtDesc" class="form-control" runat="server" placeholder="e.g. Organization Description " autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVDescp" runat="server" ControlToValidate="txtDesc" ErrorMessage="Please Enter Organization Description" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Website Link"></asp:Label>
                    <asp:TextBox ID="txtWeb" class="form-control" runat="server" placeholder="e.g. google.com " autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVWeb" runat="server" ControlToValidate="txtWeb" ErrorMessage="Please Enter Organization Website" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Organization Email"></asp:Label>
                    <asp:TextBox ID="txtEmail" class="form-control" runat="server" placeholder="e.g. google@gmail.org " autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter Organization Email" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVEmail" runat="server" ErrorMessage="This Email already exist! Try another one" ControlToValidate="txtEmail" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVEmail_ServerValidate" ></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="REVEmail" runat="server" ErrorMessage="Please enter Email in correct format!" ControlToValidate="txtEmail" ValidationGroup="REValidation" ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                <asp:Label class="form-label" runat="server" Text="Contact Number"></asp:Label>
                    <div class="input-group input-group-merge">
                        <asp:TextBox ID="txtPhone" class="form-control" runat="server" placeholder="e.g. +6014 555 0111" autofocus=""></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="RFVPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Please Enter Organization Contact Number" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVPhone" runat="server" ErrorMessage="This Phone Number already exist! Try another one" ControlToValidate="txtPhone" ValidationGroup="REValidation" display="Dynamic" ForeColor="Red" OnServerValidate="CVPhone_ServerValidate" ></asp:CustomValidator>   
                    <asp:RegularExpressionValidator ID="REVPhone" runat="server" ErrorMessage="Please enter phone number in this format (+60111322132)" ControlToValidate="txtPhone" ValidationGroup="REValidation" ValidationExpression="^\+601\d{8,9}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <hr class="my-0 mb-3" />
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Organization Address Line One"></asp:Label>
                    <asp:TextBox ID="txtAddress" class="form-control" runat="server" placeholder="e.g. Home Unit, Street " autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Please Enter Organization Address" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Organization Address Line Two (Optional)"></asp:Label>
                    <asp:TextBox ID="txtAddress2" class="form-control" runat="server" placeholder="e.g. Line two " autofocus=""></asp:TextBox>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Postcode"></asp:Label>
                    <asp:TextBox ID="txtPostcode" class="form-control" runat="server" placeholder="e.g. 11900" maxlength="5" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVPostCode" runat="server" ControlToValidate="txtPostcode" ErrorMessage="Please Enter Post Code" ValidationGroup="REValidation" forecolor="Red" display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="REVPostcode" runat="server" ErrorMessage="Please enter Post Code with 5 number!" ControlToValidate="txtPostcode" ValidationGroup="REValidation" ValidationExpression="^\d{5}$" display="Dynamic" forecolor="Red"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="City"></asp:Label>
                    <asp:TextBox ID="txtCity" class="form-control" runat="server" placeholder="e.g. City " autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVCity" runat="server" ControlToValidate="txtCity" ErrorMessage="Please Enter City" forecolor="Red" ValidationGroup="REValidation" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="State"></asp:Label>
                    <asp:TextBox ID="txtState" class="form-control" runat="server" placeholder="e.g. Pulau Pinang" autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVState" runat="server" ControlToValidate="txtState" ErrorMessage="Please Enter State" forecolor="Red" ValidationGroup="REValidation" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3 col-md-6">
                    <asp:Label class="form-label" runat="server" Text="Country"></asp:Label>
                    <asp:TextBox ID="txtCountry" class="form-control" runat="server" placeholder="e.g. Malaysia " autofocus=""></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RFVCountry" runat="server" ControlToValidate="txtCountry" ErrorMessage="Please Enter Country" forecolor="Red" ValidationGroup="REValidation" display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>

            <div id="saveBtn">
                <asp:Button class="btn btn-primary me-2" ID="addBtn" runat="server" Text="Add New Organization" OnClick="addBtn_Click" ValidationGroup="REValidation" />
                <asp:Button class="btn btn-outline-secondary" ID="resetBtn" runat="server" Text="Reset" OnClick="resetBtn_Click" />
            </div>
        </div>
    </div>
</asp:Content>
