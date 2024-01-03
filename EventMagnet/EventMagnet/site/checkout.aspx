<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="EventMagnet.site.checkout" %>
<%@ Import Namespace="EventMagnet.modal" %>  

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%--    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <srcpt src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></srcpt>--%>
    <%--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>--%>
    <%--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">--%>



    <link href="css/checkout.css" rel="stylesheet" />


</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-container">
        <div class="stepper-wrapper">
            <div class="stepper-item completed">
                <div class="step-counter">1</div>
                <div class="step-name">Confirm your ticket</div>
            </div>
            <div class="stepper-item active">
                <div class="step-counter">2</div>
                <div class="step-name">Select your payment method</div>
            </div>
        </div>

        <div class="card">
            <div class="row">
                <div class="col-md-8 cart">
                    <div class="title">
                        <div class="row">
                            <div class="col">
                                <h4><b>Tickets in Cart&nbsp;</b><i class="fa-solid fa-cart-shopping"></i></h4>
                            </div>
                            <div class="col align-self-center text-right text-muted"><asp:Literal ID="ltlTicketTypeQty" runat="server"></asp:Literal> item(s)</div>
                        </div>
                    </div>
                    <asp:PlaceHolder ID="checkoutSection" runat="server"></asp:PlaceHolder>
                   

                    <%--<div class="row border-bottom">
                        <div class="row main align-items-center">
                            <div class="col-2">
                                <img class="img-fluid" src="images/show-events-03.jpg">
                            </div>
                            <div class="col">
                                <div class="row text-muted">Gala Rock Festival</div>
                                <div class="row">Children Ticket</div>
                            </div>
                            <div class="col" style="text-align: center;">

                                <asp:Button ID="Button1" runat="server" Text="-" CssClass="btn-add-minus" UseSubmitBehavior="False" />
                                <asp:Label ID="Label1" runat="server" Text="1"></asp:Label>
                                <asp:Button ID="Button2" runat="server" Text="+" CssClass="btn-add-minus" UseSubmitBehavior="False" />

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

                                <asp:Button ID="btnMinus3" runat="server" Text="-" CssClass="btn-add-minus" UseSubmitBehavior="False" />
                                <asp:Label ID="Label3" runat="server" Text="3"></asp:Label>
                                <asp:Button ID="btnAdd3" runat="server" Text="+" CssClass="btn-add-minus" UseSubmitBehavior="False" />

                            </div>
                            <div class="col">RM 300.00 <span class="close">&#10005;</span></div>
                        </div>
                    </div>--%>
                    <div class="back-to-shop"><a href="index.aspx">&leftarrow;&nbsp;<span class="text-muted">Back to home</span></a></div>
                </div>
                <div class="col-md-4 summary">
                    <div>
                        <h5><b>Summary</b></h5>
                    </div>
                    <hr>
                    <asp:PlaceHolder ID="subPriceSection" runat="server"></asp:PlaceHolder>
                    <%--<div class="row">
                        <div class="col" style="padding-left: 0;">ITEMS 3</div>
                        <div class="col text-right">RM 444.00</div>
                    </div>
                    <div class="row">
                        <div class="col" style="padding-left: 0;">ITEMS 3</div>
                        <div class="col text-right">RM 444.00</div>
                    </div>
                    <div class="row">
                        <div class="col" style="padding-left: 0;">ITEMS 3</div>
                        <div class="col text-right">RM 444.00</div>

                    </div>--%>
                    <asp:Button ID="btnCheckout" runat="server" CssClass="btn" Text="CHECKOUT" UseSubmitBehavior="true" OnClick="btnCheckout_Click" />

                </div>
            </div>
        </div>
    </div>
</asp:Content>
