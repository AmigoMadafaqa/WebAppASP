<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="payment-tng.aspx.cs" Inherits="EventMagnet.site.payment_tng" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #ticket-payment-title {
            margin-top: 50px;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div id="ticket-payment-title">
        <h3>Touch 'n Go Payment</h3>
        <br />
        <h4>Ticket Payment : RM <%= totalPrice.ToString("0.00") %></h4>
    </div>


    <div style="display: flex; justify-content: center; align-items: center; height: 450px">
        <div>
            <img src="images/tng-ewallet.jpg" style="width: 300px" />
        </div>
    </div>
    <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
        <asp:Button ID="btnCancel" runat="server" Text="Cancel Payment" CssClass="btn btn-outline-danger mx-3" OnClick="btnCancel_Click" OnClientClick="return confirm('Are You Sure To Cancel Payment ?');" />
        <asp:Button ID="btnConfirm" runat="server" Text="Confirm Payment" CssClass="btn btn-outline-success mx-3" OnClick="btnConfirm_Click" />
    </div>

</asp:Content>
