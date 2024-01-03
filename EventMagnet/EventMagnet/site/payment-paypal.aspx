<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="payment-paypal.aspx.cs" Inherits="EventMagnet.site.payment_paypal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        #ticket-payment-title {
            margin-bottom: 50px;
            text-align: center;
        }

        #paypal-interface-div {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            margin: 50px 0px auto;
        }

        #paypal {
            width: 400px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div id="paypal-interface-div">

        <div id="ticket-payment-title">
            <h3>PayPal Payment</h3>
            <br />
            <h4>Ticket Payment : RM <%= totalPrice.ToString("0.00") %></h4>
        </div>

        <div id="paypal"></div>

        <div>
            <br />
            <a href="javascript:void(0)" onclick="paymentFailed();" class="text-secondary">Cancel Payment</a>
        </div>
    </div>


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://www.paypal.com/sdk/js?client-id=AYdmC9CcWkohiF-3GOwSlqQ4MxWDyVXyYe3dlrx2_sNt3OPSAWkpFFC1wILivPCTIsweby2qLz-M9q8M&currency=MYR" data-namespace="paypal_sdk"></script>

    <script>

        const amount = "<%= totalPrice.ToString() %>";
        $(document).ready(function () {
            if (amount <= 0) {
                alert("Ticket payment must more than zero");
                paymentFailed();
            }
        })

        paypal_sdk.Buttons({
            createOrder: function (data, actions) {
                return actions.order.create({
                    purchase_units: [
                        {
                            amount: {
                                value: amount,
                            },
                        },
                    ],
                })
            },
            onApprove: function (data, actions) {
                return actions.order.capture().then(function (details) {
                    paymentSuccess();
                })
            },
            onCancel: function (data, actions) {
                return actions.order.capture().then(function (details) {
                    alert("Errors occur during transaction123123");
                    paymentFailed();
                })
            },
            onError: function (data, actions) {
                return actions.order.capture().then(function (details) {
                    alert("Errors occur during transaction");
                    paymentFailed();
                })
            },
        }).render('#paypal')


        function paymentSuccess() {
            window.location.href = "<%= $"payment-success.aspx?billType=P&success=1&custOrderUUID={custOrderUUID.ToString()}" %>";
        }

        function paymentFailed() {
            if (confirm("Are You Sure To Cancel Payment ?"))
            {
                window.location.href = "<%= $"payment-success.aspx?billType=P&success=0&custOrderUUID={custOrderUUID.ToString()}" %>";
            }
        }

    </script>

</asp:Content>
