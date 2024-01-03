<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="customer-view.aspx.cs" Inherits="EventMagnet.admin.customer_view" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
    .read-only-textbox {
        background-color: #fff !important;
    }
    </style>

    <!-- Content -->
    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> View Customer</h4>
        <div class="row mb-5">
            <div class="col-md">
                <div class="card mb-3">
                    <div class="row g-0">
                        <!-- Image Display -->
                        <div class="col-md-12 text-center mt-3">
                            <div class="rounded mx-auto d-block">
                                 <asp:Image ID="ImgUpload" runat="server" style="width: 400px; height: 400px" class="card-img card-img-center p-2 rounded border" AlternateText='<%#Eval("img_src") %>' />
                                <!--<img style="width: 600px;" class="card-img card-img-center" src="images/illustration/girl-doing-yoga-light.png" alt="Customer image" />-->
                            </div>
                        </div>
                        <div id="informationSection" class="col-md-12 mx-auto mt-5">
                            <div class="card-body">
                                <!-- Customer Details -->
                                <h3 class="card-title fw-bold col-sm-6">
                                    <asp:Label ID="lblCustName" class="card-title mb-1" runat="server" Text="Customer Name" Font-Size="20px"></asp:Label>
                                    <asp:TextBox ID="txtCustName" runat="server" CssClass="form-control read-only-textbox mt-3" ReadOnly="true"></asp:TextBox>
                                </h3>
                                <!-- Customer Information -->
                                <div class="row mt-4">
                                    <div class="col-sm-1">
                                        <asp:Label ID="lblCustomerId" runat="server" Text="ID" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtCustomerId" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblIC" runat="server" Text="IC Number" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtIC" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label class="form-label" runat="server" Text="Gender"></asp:Label>
                                        <asp:TextBox ID="txtGender" class="form-control read-only-textbox" runat="server" autofocus="" ReadOnly="True"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblBirth" runat="server" Text="Birth Date" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtBirth" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblPhone" runat="server" Text="Phone" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblEmail" runat="server" Text="Email" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblAddressOne" runat="server" Text="Address One" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtAddressOne" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblAddressTwo" runat="server" Text="Address Two" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtAddressTwo" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblPostcode" runat="server" Text="Postcode" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtPostcode" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblCity" runat="server" Text="City" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblState" runat="server" Text="State" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblCountry" runat="server" Text="Country" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-end">
                                    <asp:Button ID="btnBackCust" runat="server" Text="BACK" CssClass="btn btn-primary me-2" OnClick="btnBackCust_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
