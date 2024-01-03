<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="billing-payment-success.aspx.cs" Inherits="EventMagnet.admin.billing_payment_success" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/billing-payment-success.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <% if (isSuccessPayment)
        {  %>
    <div class="payment-success">
        <div class="card">
            <div style="border-radius: 200px; height: 200px; width: 200px; background: #F8FAF5; margin: 0 auto;">
                <i class="checkmark">
                    <svg width="100" height="100" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M43 11L16.875 37L5 25.1818" stroke="#88B04B" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    </svg></i>
            </div>
            <h1>Payment Received</h1>
            <p>Your transaction is successful</p>
            <% }
                else
                { %>

            <div class="payment-success">
                <div class="card">
                    <div style="border-radius: 200px; height: 200px; width: 200px; background: #faf5f5; margin: 0 auto;">
                        <i class="checkmark" style="color: #b04b4b">
                            <svg width="100" height="100" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M8 8L40 40" stroke="#b04b4b" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
                                <path d="M8 40L40 8" stroke="#b04b4b" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>

                        </i>
                    </div>
                    <h1 style="color: #b04b4b;">Payment Unsuccessful</h1>

                    <p>Your transaction is unsuccessful</p>
                    <% } %>


                    <br />
                    <br />
                    <p style="text-align: center;">
                        <u>Payment Details</u>
                    </p>
                    <p style="text-align: left;">
                        Amount : RM <%= priceAmount.ToString("0.00") %><br />
                        Payment Method : <%= paymentMethod %><br />
                    </p>
                    <br />
                    <hr />
                    <br />
                    <p>
                        Transaction reference: <%= billingUUID %><br />
                        Order date: <%= bill.create_datetime == null ? "N/A" : bill.create_datetime.ToString() %><br />
                    </p>


                    <% if (!isSuccessPayment)
                        {  %>
                    <br />
                    <br />
                    <p>
                        Please try again or contact our customer support for further assistance
                    </p>
                    <% } %>
                </div>
            </div>

            <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
                <asp:Button ID="btnHome" runat="server" Text="Back to Home" CssClass="btn btn-outline-secondary mx-3" OnClick="btnHome_Click" />
                <asp:Button ID="btnBillingPage" runat="server" Text="Go to Billing Page" CssClass="btn btn-outline-dark mx-3" OnClick="btnBillingPage_Click" />
            </div>
</asp:Content>
