<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="customer-list.aspx.cs" Inherits="EventMagnet.admin.customer_list" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-xxl flex-grow-1 container-p-y">
      <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Customer Main</h4>
        
      <!-- Basic Bootstrap Table -->
      <div class="card" style="margin-top:30px">
        <h5 class="card-header">All Customer</h5>
        <div class="table-responsive text-nowrap">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>ID</th>
                <th>Name</th>
                <th>IC Number</th>
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
                            <td><%# Eval("ic_no") %></td>
                            <td><%# Eval("phone") %></td>
                            <td><%# Eval("email") %></td>
                            <td>
                                <asp:Button ID="btn_ViewCust" runat="server" Text="View" class="btn btn-outline-info" OnClick="viewBtn_Click"/>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                                        <i class="bx bx-dots-vertical-rounded"></i>
                                    </button>
                                    <div class="dropdown-menu">
                                       <a class="dropdown-item" href="javascript:void(0);">
                                          <i class="bx bx-edit-alt me-1"></i>
                                          <asp:Button ID="btn_edit" runat="server" Text="Edit" BorderStyle="None" BackColor="White" cssclass="btn pe-5 pt-0 pb-0" OnClick="btn_edit_cust_Click"/>
                                       </a>
                                       <a class="dropdown-item" href="javascript:void(0);">
                                          <i class="bx bx-trash me-1"></i>
                                         <asp:Button ID="btn_delete" runat="server" Text="Delete" BorderStyle="None" BackColor="White" CssClass="btn pe-5 pt-0 pb-0" OnClick="btn_delete_cust_Click" OnClientClick="return confirm('Are you sure you want to delete this customer?');" />
                                       </a>
                                    </div>
                                </div>

                                 <asp:HiddenField ID="hfCustID" runat="server" Value='<%# Eval("id") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT [id], [name], [ic_no], [phone], [email] FROM [customer] WHERE [status] = @status">
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
        
</asp:Content>
