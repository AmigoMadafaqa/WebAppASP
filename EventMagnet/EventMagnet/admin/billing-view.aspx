<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true"  CodeBehind="billing-view.aspx.cs" Inherits="EventMagnet.admin.billing_view" EnableViewState="True" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .read-only-textbox {
            background-color: #fff !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    


    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT b.uuid AS &quot;ID&quot;, b.name AS &quot;Name&quot;, b.price AS &quot;Amount&quot;, 
CASE
    WHEN b.status = 2 THEN 'Pending'
    WHEN b.status = 1 THEN 'Paid'
    ELSE 'Deleted'
END AS &quot;Status&quot;,
b.create_datetime AS &quot;Issue Date&quot;
FROM billing b
WHERE b.uuid = @uuid AND b.organization_id = @orgId
/* @name @price @datetime*/" UpdateCommand="UPDATE billing
SET name = @name, price=@price
WHERE uuid = @uuid AND b.organization_id = @orgId" OnSelected="SqlDataSource2_Selected">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="00000000-0000-0000-0000-000000000000" Name="uuid" SessionField="billingUUID" />
            <asp:SessionParameter DefaultValue="0" Name="orgId" SessionField="currentOrgId" />
            <asp:ControlParameter ControlID="FormViewBillDetail" DefaultValue="default" Name="name" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="FormViewBillDetail" DefaultValue="0" Name="price" PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" />
            <asp:Parameter Name="price" />
            <asp:Parameter Name="uuid" />
            <asp:Parameter Name="orgId" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT b.uuid AS &quot;ID&quot;, b.name AS &quot;Name&quot;, b.price AS &quot;Amount&quot;, 
CASE
    WHEN b.status = 2 THEN 'Pending'
    WHEN b.status = 1 THEN 'Paid'
    ELSE 'Deleted'
END AS &quot;Status&quot;,
b.create_datetime AS &quot;Issue Date&quot;
FROM billing b
WHERE b.uuid = @uuid AND b.organization_id = @orgId" 
        UpdateCommand="UPDATE billing
SET name = @Name, price=@Amount
WHERE uuid = @uuid AND b.organization_id = @orgId
">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="00000000-0000-0000-0000-000000000000" Name="uuid" SessionField="billingUUID" />
            <asp:SessionParameter DefaultValue="0" Name="orgId" SessionField="currentOrgId" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter Name="Name" ControlId="FormViewBillDetail$txtTitle22" PropertyName="Text"/>
            <asp:ControlParameter Name="Amount" ControlId="FormViewBillDetail$txtAmount" PropertyName="Text"/>
            <asp:SessionParameter DefaultValue="00000000-0000-0000-0000-000000000000" Name="uuid" SessionField="billingUUID" />
            <asp:SessionParameter DefaultValue="0" Name="orgId" SessionField="currentOrgId" />
        
        </UpdateParameters>
    </asp:SqlDataSource>
    --%>
    <asp:PlaceHolder ID="PlaceHolderText" runat="server"></asp:PlaceHolder>
    
    <asp:FormView ID="FormViewBillDetail" runat="server" DataKeyNames="ID" DataSourceID="SqlDataSource2" OnPreRender="getServerControl" OnDataBinding="getServerControl" OnDataBound="getServerControl" >
        <ItemTemplate>

            <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
                <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Billing Detail</h4>
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
                                                    <asp:Label ID="lblID" class="card-title" runat="server" Text="ID" Font-Size="18px"></asp:Label>
                                                </h6>
                                                <p class="card-text">
                                                    <asp:Label ID="ID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                                </p>
                                            </div>
                                        </div>


                                        <div class="row mt-4">
                                            <div class="col-sm-5 col-6">
                                                <h6 class="card-title fw-bold">
                                                    <asp:Label ID="lblTitle" class="card-title" runat="server" Text="Title" Font-Size="15px"></asp:Label>
                                                </h6>
                                                <p class="card-text">
                                                    <asp:TextBox ID="txtTitle" runat="server" class="form-control read-only-textbox" name='Title' Text='<%# Bind("Name") %>' ReadOnly="true"></asp:TextBox>
                                                </p>
                                            </div>
                                        </div>


                                        <div class="row mt-4">
                                            <div class="col-sm-5 col-6">
                                                <h6 class="card-title fw-bold">
                                                    <asp:Label ID="lblAmount" class="card-title" runat="server" Text="Amount (RM)" Font-Size="15px"></asp:Label>
                                                </h6>
                                                <p class="card-text">
                                                    <asp:TextBox ID="txtAmount" runat="server" class="form-control read-only-textbox" name="Amount" Text='<%# Bind("Amount") %>' ReadOnly="true"></asp:TextBox>
                                                </p>
                                            </div>
                                        </div>

                                      <%--  <div class="row mt-4">
                                            <div class="col-sm-5 col-6">
                                                <h6 class="card-title fw-bold">
                                                    <asp:Label ID="lblTax" class="card-title" runat="server" Text="Tax (RM)" Font-Size="15px"></asp:Label>
                                                </h6>
                                                <p class="card-text">
                                                    <asp:TextBox ID="txtTax" runat="server" class="form-control read-only-textbox" name="Tax" Text='<%# Bind("Tax") %>' ReadOnly="true"></asp:TextBox>
                                                </p>
                                            </div>
                                        </div>--%>


                                        <div class="row mt-4">
                                            <div class="col-sm-5 col-6">
                                                <h6 class="card-title fw-bold">
                                                    <asp:Label ID="lblStatus" class="card-title" runat="server" Text="Status" Font-Size="15px"></asp:Label>
                                                </h6>
                                                <p class="card-text">
                                                    <asp:TextBox ID="txtStatus" runat="server" class="form-control read-only-textbox" name="Status" Text='<%# Bind("Status") %>' ReadOnly="true"></asp:TextBox>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="row mt-4">
                                            <div class="col-sm-5 col-6">
                                                <h6 class="card-title fw-bold">
                                                    <asp:Label ID="ticketingStartDate" class="card-title" runat="server" Text="Issue Date" Font-Size="15px"></asp:Label>
                                                </h6>
                                                <p class="card-text">
                                                    <asp:TextBox ID="txtTicketStartDate" runat="server" class="form-control read-only-textbox" name="Issue Date" Text='<%# Bind("[Issue Date]") %>' ReadOnly="true"></asp:TextBox>
                                                </p>
                                            </div>
                                        </div>
                                        
                                        <% if (showPayBtn)
                                            {  %>
                                        <div class="d-flex justify-content-center mt-5">
                                            <asp:Button ID="btnPay" runat="server" Text="Pay" CssClass="btn btn-primary mx-2" OnClick="btnPay" />
                                        </div>
                                        <% } %>

                                        <% if ((bool)Session["isInnerAdmin"])
                                            {  %>
                                          <div style="display:flex; justify-content:center;margin-top:40px">
                                              <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-outline-warning mx-2" OnClick="updateBilling" />
                                              <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-outline-danger mx-2" CommandName="uuid.ToString()" OnCommand="updateBilling"/>
                                          </div>
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- / Content -->



        </ItemTemplate>
        <EditItemTemplate>
        

               <!-- Content -->
   <div class="container-xxl flex-grow-1 container-p-y">
       <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> Update Billing</h4>
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
                                           <asp:Label ID="lblID" class="card-title" runat="server" Text="ID" Font-Size="18px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:Label ID="ID" runat="server" Text='<%# Eval("ID") %>'></asp:Label>
                                       </p>
                                   </div>
                               </div>


                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblTitle" class="card-title" runat="server" Text="Title" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtNameInput" runat="server" class="form-control read-only-textbox" name='Title' Text='<%# Bind("Name") %>' ReadOnly="false" ></asp:TextBox>
                                       </p>
                                   </div>
                               </div>


                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblAmount" class="card-title" runat="server" Text="Amount (RM)" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtAmtInput" runat="server" class="form-control read-only-textbox" name="Amount" Text='<%# Bind("Amount") %>' ReadOnly="false"></asp:TextBox>
                                       </p>
                                   </div>
                               </div>

<%--                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblTax" class="card-title" runat="server" Text="Tax (RM)" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtTax" runat="server" class="form-control read-only-textbox" name="Tax" Text='<%# Bind("Tax") %>' ReadOnly="true"></asp:TextBox>
                                       </p>
                                   </div>
                               </div>--%>


                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblStatus" class="card-title" runat="server" Text="Status" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtStatus" runat="server" class="form-control read-only-textbox" name="Status" Text='<%# Bind("Status") %>' ReadOnly="true"></asp:TextBox>
                                       </p>
                                   </div>
                               </div>

                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="ticketingStartDate" class="card-title" runat="server" Text="Issue Date" Font-Size="15px"></asp:Label>
                                          </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtIssueDate" runat="server" class="form-control read-only-textbox" name="Issue Date" Text='<%# Bind("[Issue Date]") %>' ReadOnly="true"></asp:TextBox>
                                           <asp:Calendar ID="cldDateInput" runat="server"  SelectedDate='<%# Bind("[Issue Date]") %>' OnSelectionChanged="onChangeDate"></asp:Calendar>
                                       </p>
                                   </div>
                               </div>


                               <div class="d-flex justify-content-center">
                                   <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary me-2" UseSubmitBehavior="True" OnClick="btnSave_Click" />
                                   <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary me-2" OnClick="cancelUpdateButton"/>
                               </div>

                           </div>
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </div>
   <!-- / Content -->
            
            </EditItemTemplate>
    </asp:FormView>
    <asp:Literal ID="testtest" runat="server" Text="asdasdasdasdasd"></asp:Literal>

</asp:Content>

