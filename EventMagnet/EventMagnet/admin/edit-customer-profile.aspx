<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="edit-customer-profile.aspx.cs" Inherits="EventMagnet.admin.edit_customer_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/edit-profile.css" rel="stylesheet" />

    <div class="editProfile">
    <h2 class="fw-bold py-3 mb-4 text-muted"><strong>Customer Account Settings</strong></h2>

        <div class="card mb-4">
            <h4 class="card-header"><strong>Customer Profile Details</strong></h4>
    
            <div class="card-body row">
                <div class="mb-3 col-md-6">
                <label for="ID" class="form-label">ID</label>
                <input class="form-control" type="text" id="ID" name="ID" value="1001" disabled />
                </div>
                <div class="mb-3 col-md-6">
                <label for="Name" class="form-label">Name</label>
                <input class="form-control" type="text" name="name" id="name" value="Edward"  autofocus />
                </div>
                <div class="mb-3 col-md-6">
                <label for="DOB" class="form-label">Birth Date</label>
                <input class="form-control" type="text" name="DOB" id="DOB" value="15-05-2002"  autofocus />
                </div>
                <div class="mb-3 col-md-6">
                <label for="IC" class="form-label">IC Number</label>
                <input class="form-control" type="text" name="IC" id="IC" value="020515-07-0867"  autofocus />
                </div>
                <div class="mb-3 col-md-6">
                <label for="email" class="form-label">E-mail</label>
                <input class="form-control" type="text" id="email" name="email" value="john.doe@example.com" placeholder="john.doe@example.com" />
                </div>
                <div class="mb-3 col-md-6">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text">MY (+60)</span>
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="14 555 0111" />
                    </div>
                </div>
                <div class="mb-3 col-md-6">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" id="address" name="address" value="Address" />
                </div>
                <div class="mb-3 col-md-6">
                <label for="state" class="form-label">State</label>
                <input class="form-control" type="text" id="state" name="state" value="Pulau Pinang" />
                </div>
                <div class="mb-3 col-md-6">
                <label for="zipCode" class="form-label">Post Code</label>
                <input type="text" class="form-control" id="postCode" name="postCode" value="11900" maxlength="5" />
                </div>
                <div class="mb-3 col-md-6">
                <label class="form-label" for="country">Country</label>
                <input type="text" class="form-control" id="country" name="country" value="Malaysia" />
                </div>
            </div>

            <div id="buttonDiv">
                <asp:Button class="btn btn-primary me-2" ID="saveBtn" runat="server" Text="Save changes" OnClick="deleteBtn_Click" />
                <asp:Button class="btn btn-outline-secondary" ID="resetBtn" runat="server" Text="Reset" />
            </div>
        </div>

        <div class="card">
            <h5 class="card-header">Delete Account</h5>
            <div class="card-body">
                <div class="mb-3 col-12 mb-0">
                    <div class="alert alert-warning">
                        <h6 class="alert-heading fw-bold mb-1">Are you sure you want to delete this user's account?</h6>
                        <p class="mb-0">Once you delete this account, there is no going back.</p>
                    </div>
                </div>
                <div id="formAccountDeactivation" onclick="document.location='customer-list.aspx'">
                    <asp:Button ID="deleteBtn" class="btn btn-danger deactivate-account" runat="server" Text="Delete Account" OnClick="deleteBtn_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
