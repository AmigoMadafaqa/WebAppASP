<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="organization-setting.aspx.cs" Inherits="EventMagnet.admin.organization_setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Organization Setting</h4>
        
        <asp:Button ID="btnCreate" runat="server" Text="Add Member" CssClass="btn btn-outline-primary" OnClick="btnShowAddSection" />

        <!-- Basic Bootstrap Table -->
        <div class="card" style="margin-top: 30px">
            <h5 class="card-header">All Customer</h5>
            <div class="table-responsive text-nowrap">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Ownership</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <asp:PlaceHolder ID="plcOrgAdmin" runat="server"></asp:PlaceHolder>
                  
                    </tbody>
                </table>
            </div>
        </div>
        <!--/ Basic Bootstrap Table -->
    </div>

    <% if (showAddSection)
        {  %>
    <div class="container-xxl flex-grow-1 container-p-y">
    <div class="card">
        <h3 style="text-align: center; margin: 10px auto;">Choose a user to add</h3>
        <div style="display: flex; justify-content: center; align-items: center; height: 150px">
            <div>
                <asp:DropDownList ID="ddlMemberList" runat="server" CssClass="form-select" DataSourceID="SqlDataSource1" DataTextField="name" DataValueField="id">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT ad.id, CONCAT('ID : ', ad.id, ' (', ad.name, ')' ) AS name
FROM admin ad
WHERE ad.id NOT IN (
	SELECT a.id
            FROM admin a, organization_admin oa, organization org
            WHERE a.id = oa.admin_id
                AND oa.organization_id = org.id
                AND a.status = 1
                AND oa.status = 1
                AND org.status = 1
                AND org.id = @orgId
)">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="orgId" SessionField="currentOrgId" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-outline-danger mx-3" OnClick="btnReturn"/>
            <asp:Button ID="btnConfirm" runat="server" Text="Confirm" CssClass="btn btn-outline-success mx-3" OnClick="btnConfirm_Click" />
        </div>
    </div>
</div>

    <% } %>
</asp:Content>


