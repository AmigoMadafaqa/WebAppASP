<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" Async="true" AsyncTimeout="3000"  CodeBehind="payment.aspx.cs" Inherits="EventMagnet.site.payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<%--    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <srcpt src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></srcpt>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">--%>


    <link href="css/checkout.css" rel="stylesheet" />
    <style>
        #errMsgPrompter {
            background-color: rgba(0,0,0,0.5);
            position: fixed;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-container">
        <div class="stepper-wrapper">
            <div class="stepper-item active">
                <div class="step-counter">1</div>
                <div class="step-name">Confirm your ticket</div>
            </div>
            <div class="stepper-item completed">
                <div class="step-counter">2</div>
                <div class="step-name">Select your payment method</div>
            </div>
        </div>
        <asp:Literal ID="testtest" runat="server"></asp:Literal>
        <div class="card">
            <div class="row">
                <div class="col-md-8 cart">
                    <div class="title">
                        <div class="row">
                            <div class="col">
                                <h4><b>Payment Confirmation</b></h4>
                            </div>
                            <div class="col align-self-center text-right text-muted"><asp:Literal ID="ltlTicketTypeQty" runat="server"></asp:Literal> item(s)</div>
                        </div>
                    </div>

                    <asp:PlaceHolder ID="paymentSection" runat="server"></asp:PlaceHolder>

                <%--    <div class="row border-top border-bottom">
                        <div class="row main align-items-center">
                            <div class="col-2">
                                <img class="img-fluid" src="images/ticket-details.jpg">
                            </div>
                            <div class="col">
                                <div class="row text-muted">Sunny Hill Festival</div>
                                <div class="row">Adult Ticket</div>
                            </div>
                            <div class="col" style="text-align: center;">

                                <asp:Label ID="Label2" runat="server" Text="2"></asp:Label>

                            </div>
                            <div class="col">RM 100.00 <span class="close">&#10005;</span></div>
                        </div>
                    </div>
                    <div class="row border-bottom">
                        <div class="row main align-items-center">
                            <div class="col-2">
                                <img class="img-fluid" src="images/show-events-03.jpg">
                            </div>
                            <div class="col">
                                <div class="row text-muted">Gala Rock Festival</div>
                                <div class="row">Children Ticket</div>
                            </div>
                            <div class="col" style="text-align: center;">

                                <asp:Label ID="Label1" runat="server" Text="1"></asp:Label>

                            </div>
                            <div class="col">RM 44.00 <span class="close">&#10005;</span></div>
                        </div>
                    </div>
                    <div class="row border-bottom">
                        <div class="row main align-items-center">
                            <div class="col-2">
                                <img class="img-fluid" src="images/show-events-01.jpg">
                            </div>
                            <div class="col">
                                <div class="row text-muted">Hip Hop Farm</div>
                                <div class="row">Adult Ticket</div>
                            </div>
                            <div class="col" style="text-align: center;">

                                <asp:Label ID="Label3" runat="server" Text="3"></asp:Label>

                            </div>
                            <div class="col">RM 300.00 <span class="close">&#10005;</span></div>
                        </div>
                    </div>--%>
                    <div class="back-to-shop"><a href="checkout.aspx">&leftarrow;&nbsp;<span class="text-muted">Back to checkout</span></a></div>
                </div>
                <div class="col-md-4 summary">
                    <div>
                        <h5><b>Summary</b></h5>
                    </div>
                    <hr>
                    
                    <div class="row">
                        <div class="col" style="padding-left: 0;">Ticket Price</div>
                        <div class="col text-right">RM <asp:Literal ID="ltlTicketPrice" runat="server" Text="0.00"></asp:Literal></div>
                    </div>

                    <p style="margin-top: 20px;">SELECT PAYMENT METHOD</p>

                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Selected="True" Value="F">🏦 FPX</asp:ListItem>
                        <asp:ListItem Value="B">🏦 Billplz</asp:ListItem>
                        <asp:ListItem Value="C">💳 Credit/Debit Card</asp:ListItem>
                        <asp:ListItem Value="P">🅿️ PayPal</asp:ListItem>
                        <asp:ListItem Value="T">📱 Touch &#39;n Go eWallet</asp:ListItem>
                    </asp:DropDownList>


                    <div class="row">
                        <div class="col" style="padding-left: 0;">PROCESSING FEE</div>
                        <div class="col text-right">RM <asp:Literal ID="ltlProcessingFee" runat="server"></asp:Literal></div>
                    </div>

                    <div class="row" style="margin-top: 10px; border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">

                        <div class="col">TOTAL PRICE</div>
                        <div class="col text-right">RM <asp:Literal ID="ltlTotalPrice" runat="server"></asp:Literal></div>
                    </div>
                    <asp:Button ID="btnConfirm" runat="server" CssClass="btn" Text="CONFIRM" OnClick="btnConfirm_Click" />
                </div>
            </div>

        </div>
    </div>

    <!-- Modal Prompter -->
    <div id="errMsgPrompter" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="display:block;">                    
                    <div style="display:flex;justify-content:center;flex-direction:column;">
                        <h4 style="text-align:center;">Ticket Payment Error</h4>           
                    </div>
                </div>
                <div class="modal-body" style="display:flex;flex-direction: column;align-items: center;">
                    <p>There is an error in creating ticket order. Please try again</p>
                    <asp:Label ID="lblTicketError" runat="server" Text=""></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="successCancelButton" onclick="hideTicketErrorMsg()">Close</button>
                </div>
            </div>
        </div>
    </div>

 

    <script>

        const errMsgPrompter = document.getElementById("errMsgPrompter");

        function showTicketErrorMsg() {
            errMsgPrompter.style.display = "block";

        }

        function hideTicketErrorMsg() {
            errMsgPrompter.style.display = "none";
            window.location.href = "checkout.aspx";
        }

    </script>


</asp:Content>
