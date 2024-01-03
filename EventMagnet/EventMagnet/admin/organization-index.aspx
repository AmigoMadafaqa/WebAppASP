<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="organization-index.aspx.cs" Inherits="EventMagnet.admin.organization_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <!-- Content -->
<div class="container-xxl flex-grow-1 container-p-y">
  <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Organization Main</h4>
    
    <% if ((bool)Session["isInnerAdmin"])
        {  %>
    <div class="row">
        <div class="col-2">
            <asp:Button ID="btnCreate" runat="server" Text="Create Organization +" CssClass="btn btn-lg btn-outline-primary" OnClick="btnCreate_Click"/>
        </div>
    </div>
    <% } %>

  <!-- Basic Bootstrap Table -->
  <div class="card" style="margin-top:30px">
    <h5 class="card-header">All Organizations</h5>
    <div class="table-responsive text-nowrap">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Website</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Details</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody class="table-border-bottom-0">
            <asp:Repeater ID="custListRepeater" runat="server" DataSourceID="SqlDataSource1" >
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("id") %></td>
                        <td><i class="fab fa-angular fa-lg text-danger me-3"></i> <strong><%# DataBinder.Eval(Container.DataItem, "name") %></strong></td>
                        <td><%# Eval("website_link") %></td>
                        <td><%# Eval("phone") %></td>
                        <td><%# Eval("email") %></td>
                        <td><asp:Button ID="btn_ViewOrg" runat="server" Text="View" class="btn btn-outline-info" OnClick="viewButton1_Click"/></td>
                        <td>
                            <div class="dropdown">
                                <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                    <i class="bx bx-dots-vertical-rounded"></i>
                                </button>
                                <div class="dropdown-menu">
                                   <a class="dropdown-item" href="javascript:void(0);">
                                      <i class="bx bx-edit-alt me-1"></i>
                                      <asp:Button ID="btn_edit" runat="server" Text="Edit" BorderStyle="None" BackColor="White" cssclass="btn pe-5 pt-0 pb-0" OnClick="btn_edit_org_Click"/>
                                   </a>
                                   <a class="dropdown-item" href="javascript:void(0);">
                                      <i class="bx bx-trash me-1"></i>
                                      <asp:Button ID="btn_delete" runat="server" Text="Delete" BorderStyle="None" BackColor="White" cssclass="btn pe-5 pt-0 pb-0" OnClick="btn_delete_org_Click"  OnClientClick="return confirm('Are you sure you want to delete this customer?');" />
                                   </a>
                                </div>
                            </div>

                            <asp:HiddenField ID="hfOrgID" runat="server" Value='<%# Eval("id") %>' />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:eventMagnetConnectionString %>'
                SelectCommand="SELECT [id], [name], [website_link], [phone], [email], [country] FROM [organization] WHERE [status] = @status">
                <SelectParameters>
                    <asp:Parameter Name="status" Type="Int32" DefaultValue="1" />
                </SelectParameters>
            </asp:SqlDataSource>

        </tbody>
      </table>
    </div>
  </div>
  <!--/ Basic Bootstrap Table -->
</div>
<!-- / Content -->

</asp:Content>
