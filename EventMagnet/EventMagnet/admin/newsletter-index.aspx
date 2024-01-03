<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="newsletter-index.aspx.cs" Inherits="EventMagnet.zDEl_admin.newsletter_index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
   div{
   margin: 5px 10px 0px 10px;
   }
</style>
<!-- Bootstrap Table with Header - Light -->
<div>
   <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Newsletter List</h4>
    <asp:Button Text="Create Newsletter" runat="server" class="btn btn-outline-primary" PostBackURL="~/admin/newsletter-create.aspx" Style="margin-left:20px"/><br />
    <br />
    <div class="card" style="width:90%;margin-left:50px">
    <h5 class="card-header">Newsletter List</h5>
        <strong><asp:Label ID="lblTotalCount" Text="" runat="server" CssClass="form-label-lg text-uppercase" style="margin-left : 30px"/></strong> 

        <asp:Label ID="lblComment" Text="" runat="server" CssClass="form-label-lg" style="margin-left:30px" />
        
    <!-- Table in repeater format -->
    <asp:Repeater ID="rNewsletter" runat="server">
         <HeaderTemplate>
                 <div class="card-body">
                     <div class="table-responsive text-nowrap">
                         <table class="table table-bordered">
                             <thead>
                                 <tr>
                                     <th>ID</th>
                                     <th>Title</th>
                                     <th>Status</th>
                                     <th>Organization_ID</th>
                                     <th></th>
                                 </tr>
                             </thead>
                             <tbody>
         </HeaderTemplate>
 
         <ItemTemplate>
             <tr>
                 <td>
                     <i class="fab fa-angular fa-lg text-danger me-3"></i>
                     <asp:Literal runat="server" Text='<%# Eval("id") %>'></asp:Literal>
                 </td>
                 <td><asp:Literal runat="server" Text='<%# Eval("title") %>'></asp:Literal></td>
                 <td>
                     <span class="badge bg-label-primary me-1">
                         <asp:Literal runat="server" Text='<%# Eval("status") %>'></asp:Literal>
                     </span>
                 </td>
                 <td><asp:Literal runat="server" Text='<%# Eval("organization_id") %>'></asp:Literal></td>
                 <td>
                     <div class="dropdown">
                         <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                             <i class="bx bx-dots-vertical-rounded"></i>
                         </button>
                         <div class="dropdown-menu">
                             <a class="dropdown-item" href="newsletter-view.aspx">
                                 <i class="bx bx-search-alt me-1"></i> 
                                 <asp:Button ID="btnView" Text="View" runat="server" class="btn p-0" style="width:150px;text-align:left" OnClick="btnView_Click"/>
                             </a>
                             <a class="dropdown-item" href="newsletter-update.aspx">
                                 <i class="bx bx-edit-alt me-1"></i>
                                 <asp:Button ID="btnEdit" Text="Edit" runat="server" CssClass="btn p-0" style="width:150px;text-align:left" OnClick="btnEdit_Click"/>
                             </a>
                             <a class="dropdown-item">
                                 <i class="bx bx-trash me-1"></i> 
                                 <asp:Button ID="btnDlt" runat="server" Text="Delete" CssClass="btn p-0" OnClientClick='return confirm("Are You Sure Want To Delete This Record ?");' style="width:150px;text-align:left" OnClick="btnDlt_Click" />
                             </a>
                         </div>
                     </div>
                 </td>
             </tr>
             <!-- initialize hidden field for passing the id to another page -->
             <asp:HiddenField ID="hfNewsId" runat="server" Value='<%# Eval("id") %>'/>
         </ItemTemplate>
 
         <FooterTemplate>
                             </tbody>
                         </table>
                         <br />
                     </div>
                 </div>
         </FooterTemplate>
     </asp:Repeater>
    <!-- end of repeater -->
</div>
    </div>
<!-- Bootstrap Table with Header - Light -->

</asp:Content>
