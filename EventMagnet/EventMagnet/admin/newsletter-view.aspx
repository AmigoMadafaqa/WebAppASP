<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="newsletter-view.aspx.cs" Inherits="EventMagnet.admin.newsletter_view" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
    div{
        margin: 0px 10px 0px 10px;
    }
    </style>
<h4 class="fw-bold py-3 mb-4" style="margin-left:10%"><span class="text-muted fw-light">Dashboard /</span> View Newsletter</h4>

   <div class="col-xxl">
      <div class="card mb-4" style="width:70%; margin-left:10%">
         <div class="card-header d-flex align-items-center justify-content-between">
            <h4 style="text-decoration:underline">Newsletter Details</h4>
         </div>
         <div class="card-body" style="margin:auto 20px">

             <!--Testing purpose
             <div>
                 <asp:Label ID="lbltest" Text="" runat="server" /><br />
             </div>
             <!--end of Testing purpose-->
             Newsletter ID : 
             <asp:Label ID="lblNewsId" Text="" runat="server" CssClass="text-primary text-uppercase form-label-lg"/><br />
             <br />
             Newsletter Image :<br />
             <asp:Image ID="imgNewsletter" ImageUrl="" runat="server" AlternateText='<%#Eval("img_src") %>' style="height:400px; width:500px;margin-left:100px" CssClass="card-img card-img-center p-2 rounded border"/>
            <br /> <br />
             Image Path : <asp:Label ID="lblNewsImgPath" runat="server" Text="" CssClass="form-label-lg text-uppercase " style="margin-left:20px; font-style:italic" /><br />
            <br />
            Newsletter Title :  
             <asp:Label ID="lblNewsTitle" runat="server" Text="" CssClass="form-control" />
            <br />
            Newsletter Description : 
             <asp:Label ID="lblNewsBody" runat="server" Text="" CssClass="form-control text-capitalize form-label-lg" />
            <br />
             Status : 
             <asp:Label ID="lblNewsStatus" runat="server" Text="" CssClass=" text-primary form-label-lg text-uppercase form-control" BorderStyle="None"/><br />
            <br />
             Organization ID : 
             <asp:Label ID="lblNewsOrgId" runat="server" Text="" CssClass="form-control text-primary form-label-lg" BorderStyle="None"/><br />
            <br />
            Newsletter Created At : <br />
             <asp:Label ID="lblNewsCreatedDT" Text="" runat="server" CssClass="form-control form-label-lg form-label-lg" /><br />
             <br />

            <a href="newsletter-index.aspx">
                <asp:Button ID="btnNewsletter" runat="server" Text="Back to Newsletter List" PostBackURL="~/admin/newsletter-index.aspx" CssClass="btn btn-primary"/>
            </a>
         </div>
      </div>
   </div>

</asp:Content>
