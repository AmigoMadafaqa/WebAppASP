<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="organization-view.aspx.cs" Inherits="EventMagnet.admin.organization_view" %>
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
        <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> View Organization</h4>
        <div class="row mb-5">
            <div class="col-md">
                <div class="card mb-3">
                    <div class="row g-0">
                        <!-- Logo Display -->
                        <div class="col-md-12 text-center mt-3">
                            <div class="rounded mx-auto d-block">
                                <!--image-->
                                <asp:Image ID="ImgUpload" runat="server" style="width: 400px; height: 400px" class="card-img card-img-center p-2 rounded border" AlternateText='<%#Eval("img_src") %>' />
                                <!--<img style="width: 600px;" class="card-img card-img-center" src="images/illustration/girl-doing-yoga-light.png" alt="Organization Logo" />-->
                            </div>
                        </div>
                            
                        <div id="informationSection" class="col-md-12 mx-auto mt-5">
                            <div class="card-body">
                                <!-- Organization Details -->
                                <h3 class="card-title fw-bold col-sm-6">
                                    <asp:Label ID="lblOrganizationName" runat="server" class="card-title mb-1" Text="Organization Name" Font-Size="20px"></asp:Label>
                                    <asp:TextBox ID="txtOrganizationName" runat="server" CssClass="form-control read-only-textbox mt-3" ReadOnly="true"></asp:TextBox>
                                </h3>
                                <!-- Organization Information -->
                                <div class="row mt-4">
                                    <div class="col-sm-1">
                                        <asp:Label ID="lblOrganizationId" runat="server" Text="ID" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtOrganizationId" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-11">
                                        <asp:Label ID="lblDescription" runat="server" Text="Description" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-sm-6">
                                        <asp:Label ID="lblWebsiteLink" runat="server" Text="Website Link" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtWebsiteLink" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
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
                                    <div class="col-sm-4">
                                        <asp:Label ID="lblCity" runat="server" Text="City" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label ID="lblState" runat="server" Text="State" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtState" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                    <div class="col-sm-4">
                                        <asp:Label ID="lblCountry" runat="server" Text="Country" CssClass="fw-bold me-2"></asp:Label>
                                        <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control read-only-textbox" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <br />
                                <br />

                                <div class="d-flex justify-content-end">
                                    <asp:Button ID="btnBackOrg" runat="server" Text="BACK" CssClass="btn btn-primary me-2" OnClick="btnBackOrg_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- / Content -->
</asp:Content>


