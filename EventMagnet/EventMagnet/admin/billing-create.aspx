<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="billing-create.aspx.cs" Inherits="EventMagnet.admin.billing_create" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Billing /</span> Create Billing</h4>
        <div class="row mb-5">
            <div class="col-md">
                <div class="card mb-3">
                    <div class="row g-0">

                        <div id="informationSection" class="col-md-12 mx-auto mt-5">
                            <div class="card-body" style="margin-left: 150px">

                                <h3 class="card-title fw-bold">
                                    <asp:Label ID="lblBillingTitle" class="card-title" runat="server" Text="Billing" Font-Size="30px"></asp:Label>
                                </h3>

                                <div class="row mt-4">
                                    <div class="col-sm-5 col-6">
                                        <h6 class="card-title fw-bold">
                                            <asp:Label ID="lblTitle" class="card-title" runat="server" Text="Title" Font-Size="15px"></asp:Label>
                                        </h6>
                                        <p class="card-text">
                                            <asp:TextBox ID="txtTitle" runat="server" class="form-control read-only-textbox" name='Title' Placeholder="Enter the title of billing" ReadOnly="false"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTxtTitle" runat="server" ErrorMessage="Please Enter Billing Title" ControlToValidate="txtTitle" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                                        </p>
                                    </div>
                                </div>


                                <div class="row mt-4">
                                    <div class="col-sm-5 col-6">
                                        <h6 class="card-title fw-bold">
                                            <asp:Label ID="lblAmount" class="card-title" runat="server" Text="Amount (RM)" Font-Size="15px"></asp:Label>
                                        </h6>
                                        <p class="card-text">
                                            <asp:TextBox ID="txtAmount" runat="server" class="form-control read-only-textbox" name="Amount" Placeholder="Enter the amount of billing" ReadOnly="false"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorTxtAmount" runat="server" ErrorMessage="Please Enter Billing Amount" ControlToValidate="txtAmount" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidatorTxtAmount" runat="server" ErrorMessage="The Billing Amount Must Between 1 To 1000000" ControlToValidate="txtAmount" Type="Double" MinimumValue="1" MaximumValue="1000000" CssClass="text-danger" Display="Dynamic"></asp:RangeValidator>
                                        </p>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-sm-5 col-6">
                                        <h6 class="card-title fw-bold">
                                            <asp:Label ID="lblOrganization" class="card-title" runat="server" Text="Organization To Issue" Font-Size="15px"></asp:Label>
                                        </h6>
                                        <p class="card-text">
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT [id], [name] FROM [organization] WHERE status=1 ORDER BY [name]"></asp:SqlDataSource>
                                            
                                            <asp:DropDownList ID="ddlOrganization" CssClass="form-select" runat="server" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id"></asp:DropDownList>
                                        </p>
                                    </div>
                                </div>

                                <div class="row mt-4">
                                    <div class="col-sm-5 col-6">
                                        <h6 class="card-title fw-bold">
                                            <asp:Label ID="ticketingStartDate" class="card-title" runat="server" Text="Issue Date" Font-Size="15px"></asp:Label>
                                           </h6>
                                        <p class="card-text">
                                            <asp:TextBox ID="txtIssueDate" runat="server" class="form-control read-only-textbox" name="Issue Date" Text='' ReadOnly="true"></asp:TextBox>
                                            <asp:Calendar ID="cldDate" runat="server" SelectedDate='' OnClientClick="return false;" OnSelectionChanged="onChangeDate" ></asp:Calendar>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorCldDate" runat="server" ErrorMessage="Please Select A Date" ControlToValidate="txtIssueDate" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </p>
                                    </div>
                                </div>


                                <div class="d-flex justify-content-center">
                                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary me-2" OnClick="saveBilling" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary me-2" OnClick="cancelButton" CausesValidation="False" />
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
