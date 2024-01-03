<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="event-venue-view.aspx.cs" Inherits="EventMagnet.admin.event_venue_view" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Content -->
<div class="container-xxl flex-grow-1 container-p-y">
    <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Dashboard /</span> View Venue</h4>

   <div class="col-xxl">
      <div class="card mb-4" style="width:60%;margin-left:10%">
         <div class="card-header d-flex align-items-center justify-content-between">
            <h4 style="text-decoration:underline" class="text-uppercase">Venue Details</h4>
         </div>
         <div class="card-body" style="margin:auto 20px">
             
             <b>Venue Id : </b><asp:Label ID="lblVenueID" Text="" runat="server" CssClass="text-primary form-label-lg text-uppercase"/><br />
            <br />
             <!-- Image Display -->
             <asp:Image ID="ImgUpload" runat="server" CssClass="card-img card-img-center p-2 rounded border" AlternateText='<%#Eval("img_src") %>' ImageUrl="" style="width:400px; height:300px;margin-left:100px"/>
             <br />
             <br />
             <b>Image Path :</b> 
             <asp:Label ID="lblImgPath" Text="" runat="server" CssClass="form-label-lg text-uppercase" style="font-style:italic;"/>
            <br />
            <br />
            <b>Venue Name :</b>  
             <asp:Label ID="lblVenueName" runat="server" Text="" CssClass="form-control form-label-lg text-capitalize"></asp:Label>
            
            <br />
            <b>Venue Description :</b> 
             <asp:Label ID="lblVenueDesc" runat="server" Text="" CssClass="form-control form-label-lg text-capitalize"></asp:Label>
            
            <br />
            <b>Venue Address : </b>
             <asp:Label ID="lblVenueAddr" runat="server" Text="" CssClass="form-control form-label-lg text-capitalize"></asp:Label>
            
            <br />
            <b>Phone No :  </b>
             <asp:Label ID="lblPhNo" runat="server" Text="" CssClass="form-control form-label-lg text-uppercase"></asp:Label>
            
            <br />
            <b>Email :  </b>
             <asp:Label ID="lblEmail" runat="server" Text="" CssClass="form-control form-label-lg text-uppercase"></asp:Label>
            
            <br />
             <b>Status : </b>
             <asp:Label ID="lblStatus" Text="" runat="server" CssClass="form-label-lg text-uppercase text-primary form-control" BorderStyle="None"/>
            <br />
            <br />
             <a href="event-venue-index.aspx">
                <asp:Button ID="btnVenueIndex" runat="server" Text="Back to Venue List" CssClass="btn btn-primary" PostBackURL="~/admin/event-venue-index.aspx" />
             </a>
         </div>
      </div>
   </div>
</div>
<!-- / Content -->

</asp:Content>
