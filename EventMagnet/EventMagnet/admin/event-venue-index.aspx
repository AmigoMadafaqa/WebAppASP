<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-venue-index.aspx.cs" Inherits="EventMagnet.zDEl_admin.event_venue_index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .litTest{
            margin-left:30px
        }
    </style>

    <!-- Bootstrap Table with Header - Light -->
   <div class="container-xxl flex-grow-1 container-p-y">
      <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Venue List</h4>
      <asp:Button Text="Create New Venue" runat="server" cssClass="btn btn-outline-primary" PostBackURL="~/admin/event-venue-create.aspx" />
      <br />
      <br />
      <div class="card">
         <h5 class="card-header">Venue List</h5>
         <b><asp:Label ID="lblTotalCount" Text="" runat="server" style="margin-left:50px"/></b>
         <div class="table-responsive text-nowrap" style="text-align: left;">
            <!-- Table in Repeater form -->
            <asp:Repeater ID="rVenue" runat="server">
               <HeaderTemplate >
                  <table border="0" borderStyle="none" class="table" style="width:95%; margin-left:2.5%">
                     <thead CssClass="table-light">
                        <tr>
                           <th>ID</th>
                           <th>Venue</th>
                            <th>Email</th>
                            <th>Contact Number</th>
                           <th>Status</th>
                           <th></th>
                           <!-- Add more header columns as needed -->
                        </tr>
                     </thead>
               </HeaderTemplate>
               <ItemTemplate>
               <tbody CssClass="table-border-bottom-0">
                   <tr>
                       <td><%# Eval("id") %></td>
                       <td><%# Eval("name") %></td>
                       <td><%# Eval("email_contact") %></td>
                       <td><%# Eval("phone_contact") %></td>
                       <td> <span class="badge bg-label-primary me-1"><%# Eval("status_text") %></span></td>
                       <td>
                           <div class="dropdown" style="width:fit-content">
                               <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown" ><i class="bx bx-dots-vertical-rounded"></i></button>

                               <div class="dropdown-menu p-0">
                                   <a class="dropdown-item" href="event-venue-view.aspx">
                                   <i class="bx bx-search-alt me-1"></i>
                                   <asp:Button ID="btnView" runat="server" Text="View" BorderStyle="None" CssClass="btn p-0" OnClick="btnView_Click" style="width:150px;text-align:left"/></a>

                                   <a class="dropdown-item" href="event-venue-update.aspx">
                                   <i class="bx bx-edit-alt me-1"></i>
                                   <asp:Button ID="btnEditVenue" runat="server" Text="Edit" BorderStyle="None" CssClass="btn p-0" OnClick="btnEditVenue_Click" style="width:150px;text-align:left"/>
                                   </a>

                                   <a class="dropdown-item">
                                   <i class="bx bx-trash me-1"></i>
                                   <asp:Button ID="btnDltVenue" runat="server" Text="Delete" BorderStyle="None" CssClass="btn p-0" style="width:150px;text-align:left" CausesValidation="False" OnClick="btnDltVenue_Click" UniqueID="" OnClientClick='return confirm("Are You Sure Want To Delete This Record ? ");' />
                                   </a>
                               </div>
                           </div>
                       </td>
               </tr>
               </tbody>
                   <!-- initialize hidden value(for passing the id)-->
                   <asp:HiddenField ID="hfVenueID" runat="server" Value='<%# Eval("id") %>' />
               </ItemTemplate>
               <FooterTemplate>
               </table>
               </FooterTemplate>
            </asp:Repeater>
            <br />
         </div>
      </div>
   </div>
   <!-- Bootstrap Table with Header - Light -->
</asp:Content>