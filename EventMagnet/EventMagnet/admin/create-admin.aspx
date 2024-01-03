<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="create-admin.aspx.cs" Inherits="EventMagnet.admin.create_admin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="css/create-profile.css" rel="stylesheet" />

    <div class="create-profile">
        <div class="card mb-4">
            <h5 class="card-header">New Admin Details</h5>

            <div class="card-body row">
                <div class="mb-3 col-md-6">
                <label for="ID" class="form-label">ID</label>
                <input class="form-control" type="text" id="ID" name="ID" value="1002" disabled />
                </div>
                <div class="mb-3 col-md-6">
                <label for="Name" class="form-label">Name</label>
                <input class="form-control" type="text" name="name" id="name" placeholder="e.g. Edward"  autofocus />
                </div>
                <div class="mb-3 col-md-6">
                <label for="DOB" class="form-label">Birth Date</label>
                <input class="form-control" type="text" name="DOB" id="DOB" placeholder="e.g. 15-05-2002"  autofocus />
                </div>
                <div class="mb-3 col-md-6">
                <label for="IC" class="form-label">IC Number</label>
                <input class="form-control" type="text" name="IC" id="IC" placeholder="e.g. 020515-07-0867"  autofocus />
                </div>
                <div class="mb-3 col-md-6">
                <label for="email" class="form-label">E-mail</label>
                <input class="form-control" type="text" id="email" name="email" placeholder="e.g. john.doe@example.com" />
                </div>
                <div class="mb-3 col-md-6">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                    <div class="input-group input-group-merge">
                        <span class="input-group-text">MY (+60)</span>
                        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" placeholder="e.g. 14 555 0111" />
                    </div>
                </div>
                <div class="mb-3 col-md-6">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" id="address" name="address" placeholder="e.g. Address" />
                </div>
                <div class="mb-3 col-md-6">
                <label for="state" class="form-label">State</label>
                <input class="form-control" type="text" id="state" name="state" placeholder="e.g. Pulau Pinang" />
                </div>
                <div class="mb-3 col-md-6">
                <label for="zipCode" class="form-label">Post Code</label>
                <input type="text" class="form-control" id="postCode" name="postCode" placeholder="e.g. 11900" maxlength="5" />
                </div>
                <div class="mb-3 col-md-6">
                <label class="form-label" for="country">Country</label>
                <input type="text" class="form-control" id="country" name="country" placeholder="e.g. Malaysia" />
                </div>
            </div>

            <div id="saveBtn">
                <asp:Button class="btn btn-primary me-2" ID="addBtn" runat="server" Text="Add New Admin" OnClick="addBtn_Click" />
                <asp:Button class="btn btn-outline-secondary" ID="resetBtn" runat="server" Text="Reset" OnClick="resetBtn_Click" />
            </div>
        </div>
    </div>
</asp:Content>
