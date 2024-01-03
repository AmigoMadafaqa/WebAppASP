<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="billing-update.aspx.cs" Inherits="EventMagnet.admin.billing_update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <asp:PlaceHolder ID="PlaceHolderText" runat="server"></asp:PlaceHolder>
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
                                           <asp:Label ID="lblUUID" runat="server" Text=''></asp:Label>
                                       </p>
                                   </div>
                               </div>


                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblTitle" class="card-title" runat="server" Text="Title" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtNameInput" runat="server" class="form-control read-only-textbox" name='Title' Text='' ReadOnly="false" ></asp:TextBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidatorTxtTitle" runat="server" ErrorMessage="Please Enter Billing Title" ControlToValidate="txtNameInput" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                                       </p>
                                   </div>
                               </div>


                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblAmount" class="card-title" runat="server" Text="Amount (RM)" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtAmtInput" runat="server" class="form-control read-only-textbox" name="Amount" Text='' ReadOnly="false"></asp:TextBox>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidatorTxtAmount" runat="server" ErrorMessage="Please Enter Billing Amount" ControlToValidate="txtAmtInput" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="RangeValidatorTxtAmount" runat="server" ErrorMessage="The Billing Amount Must Between 1 To 1000000" ControlToValidate="txtAmtInput" Type="Double" MinimumValue="1" MaximumValue="1000000" CssClass="text-danger" Display="Dynamic"></asp:RangeValidator>
                                       </p>
                                   </div>
                               </div>

                               <div class="row mt-4">
                                   <div class="col-sm-5 col-6">
                                       <h6 class="card-title fw-bold">
                                           <asp:Label ID="lblStatus" class="card-title" runat="server" Text="Status" Font-Size="15px"></asp:Label>
                                       </h6>
                                       <p class="card-text">
                                           <asp:TextBox ID="txtStatus" runat="server" class="form-control read-only-textbox" name="Status" Text='' ReadOnly="true"></asp:TextBox>
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
                                           <asp:Calendar ID="cldDateInput" runat="server"  SelectedDate='' OnSelectionChanged="onChangeDate"></asp:Calendar>
                                       </p>
                                   </div>
                               </div>


                               <div class="d-flex justify-content-center">
                                   <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-primary me-2" UseSubmitBehavior="True" OnClick="btnSave_Click" />
                                   <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary me-2" OnClick="cancelUpdateButton" CausesValidation="False" />
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
