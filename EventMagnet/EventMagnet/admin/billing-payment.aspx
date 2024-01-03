<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true"  Async="true" AsyncTimeout="3000" CodeBehind="billing-payment.aspx.cs" Inherits="EventMagnet.admin.billing_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="card">
            <h3 style="text-align: center; margin: 10px auto;">Select a Payment Method</h3>
            <div style="display: flex; justify-content: center; align-items: center; height: 150px">
                <div>
                    <div>Payment Amount : RM <asp:Label ID="lblPrice" runat="server" Text=""></asp:Label></div>
                    
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Selected="True" Value="F">🏦 FPX</asp:ListItem>
                        <asp:ListItem Value="B">🏦 Billplz</asp:ListItem>
                        <asp:ListItem Value="C">💳 Credit/Debit Card</asp:ListItem>
                     <%--   <asp:ListItem Value="P">🅿️ PayPal</asp:ListItem>
                        <asp:ListItem Value="T">📱 Touch &#39;n Go eWallet</asp:ListItem>--%>
                    </asp:DropDownList>
                </div>
            </div>
            <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
                <div class="col text-right">Processing Fee : RM <asp:Literal ID="ltlProcessingFee" runat="server"></asp:Literal></div>
            </div>

            <div class="row" style="margin: 40px auto 20px; display: flex; justify-content: center;">
             
                <div class="col text-right">Total Payment : RM <asp:Literal ID="ltlTotalPrice" runat="server"></asp:Literal></div>
            </div>
            <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
                <asp:Button ID="btnCancel" runat="server" Text="Cancel Payment" CssClass="btn btn-outline-danger mx-3" OnClick="btnReturn"/>
                <asp:Button ID="btnConfirm" runat="server" Text="Confirm Payment" CssClass="btn btn-outline-success mx-3" OnClick="btnConfirm_Click" />
            </div>
        </div>
    </div>
</asp:Content>
