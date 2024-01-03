<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="report-sale.aspx.cs" Inherits="EventMagnet.admin.report_sale" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    <!-- Content -->
    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3"><span class="text-muted fw-light">Dashboard /</span> Billing</h4>
        <asp:Button ID="btnCreate" runat="server" Text="Create Billing" CssClass="btn btn-outline-primary mb-4" OnClick="btnCreateBilling" />
        <!-- Basic Bootstrap Table -->
        <div class="card">
            <h5 class="card-header">Billing List</h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Amount (RM)</th>
                            <th>Issue Date</th>
                            <th>Status</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <asp:PlaceHolder ID="placeHolderBilling" runat="server"></asp:PlaceHolder>
                       <%-- <tr>
                            <td>1</td>
                            <td>xxx-xxx-xxx</td>
                            <td>Monthly License Renewal</td>
                            <td>20.00</td>
                            <td>2023-12-01</td>
                            <td><span class="badge bg-label-primary me-1">Pending</span></td>
                            <td>
                                <asp:Button ID="btn_viewBillingDetail1" runat="server" Text="View" class="btn btn-outline-info" OnClick="btn_viewBillingDetail1_Click" /></td>
                            <td>
                                <div class="dropdown">
                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                        <i class="bx bx-dots-vertical-rounded"></i>
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="billing-update.aspx">
                                            <i class="bx bx-edit-alt me-1"></i>
                                            <asp:Button ID="btnEditVenue" runat="server" Text="Edit" BorderStyle="None" CssClass="btn p-0" PostBackUrl="~/admin/billing-update.aspx" />

                                        </a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Monthly License Renewal</td>
                            <td>20.00</td>
                            <td>2023-11-01</td>
                            <td><span class="badge bg-label-primary me-1">Pending</span></td>
                            <td>
                                <asp:Button ID="btn_viewBillingDetail2" runat="server" Text="View" class="btn btn-outline-info" OnClick="btn_viewBillingDetail2_Click" /></td>
                            <td>
                                <div class="dropdown">
                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                        <i class="bx bx-dots-vertical-rounded"></i>
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="billing-update.aspx">
                                            <i class="bx bx-edit-alt me-1"></i>
                                            <asp:Button ID="Button1" runat="server" Text="Edit" BorderStyle="None" CssClass="btn p-0" PostBackUrl="~/admin/billing-update.aspx" />

                                        </a>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Monthly License Renewal</td>
                            <td>20.00</td>
                            <td>2023-10-01</td>
                            <!-- Status -->
                            <td><span class="badge bg-label-success me-1">Paid</span></td>
                            <td>
                                <asp:Button ID="btn_viewBillingDetail3" runat="server" Text="View" class="btn btn-outline-info" OnClick="btn_viewBillingDetail3_Click" /></td>
                            <td>
                                <div class="dropdown">
                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                        <i class="bx bx-dots-vertical-rounded"></i>
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="billing-update.aspx">
                                            <i class="bx bx-edit-alt me-1"></i>
                                            <asp:Button ID="Button2" runat="server" Text="Edit" BorderStyle="None" CssClass="btn p-0" PostBackUrl="~/admin/billing-update.aspx" />

                                        </a>
                                    </div>
                                </div>
                            </td>
                        </tr>--%>
                    </tbody>
                </table>
            </div>
        </div>
        <!--/ Basic Bootstrap Table -->
    </div>
    <!-- / Content -->



</asp:Content>
