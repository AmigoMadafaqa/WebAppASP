<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="payment-credit-card.aspx.cs" Inherits="EventMagnet.site.payment_credit_card" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <link href="css/payment-credit-card.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3 style="text-align: center; margin: 10px auto;">Credit/Debit Card Information</h3>
    <h5 style="text-align: center; font-weight: normal; margin: 10px auto;">Enter your credit/debit card information</h5>

    <div style="margin: 0px auto; max-width: 1200px; display: flex;">
        <div class="credit-card-sample container">
            <div class="card">
                <div class="card-inner">
                    <div class="front">
                        <img src="https://i.ibb.co/PYss3yv/map.png" class="map-img">
                        <div class="row">
                            <img src="https://i.ibb.co/G9pDnYJ/chip.png" width="60px">
                            <div>
                                <img src="https://upload.wikimedia.org/wikipedia/commons/a/a4/Mastercard_2019_logo.svg" width="60px">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png" width="60px">
                            </div>
                        </div>
                        <div class="row card-no">
                            <p>CARD NUMBER</p>
                            <div>
                                <asp:TextBox ID="TextBox1" placeholder="****" runat="server" Style="text-align: center;" Font-Size="20px" Width="100px" MaxLength="4" ToolTip="Enter card number"></asp:TextBox>
                                <asp:TextBox ID="TextBox2" placeholder="****" runat="server" Style="text-align: center;" Font-Size="20px" Width="100px" MaxLength="4" ToolTip="Enter card number"></asp:TextBox>
                                <asp:TextBox ID="TextBox3" placeholder="****" runat="server" Style="text-align: center;" Font-Size="20px" Width="100px" MaxLength="4" ToolTip="Enter card number"></asp:TextBox>
                                <asp:TextBox ID="TextBox4" placeholder="****" runat="server" Style="text-align: center;" Font-Size="20px" Width="100px" MaxLength="4" ToolTip="Enter card number"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row card-holder">
                            <p>CARD HOLDER</p>
                            <p>VALID THRU</p>
                        </div>
                        <div class="row name">
                            <p>
                                <asp:TextBox ID="TextBox6" placeholder="Enter Card Name" Style="padding:2px;" runat="server" Font-Size="15px" Width="300px" ToolTip="Enter card holder name"></asp:TextBox>
                            </p>
                            <p>
                                <asp:TextBox ID="TextBox5" placeholder="MM/YY" Style="text-align: center;" runat="server" Font-Size="15px" Width="80px" MaxLength="5" ToolTip="Enter card expiration"></asp:TextBox>
                            </p>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="credit-card-sample container">
            <div class="card">
                <div class="card-inner">

                    <div class="back">
                        <img src="https://i.ibb.co/PYss3yv/map.png" class="map-img">
                        <div class="bar"></div>
                        <div class="row card-cvv">
                            <div>
                                <img src="https://i.ibb.co/S6JG8px/pattern.png">
                            </div>
                            <p>
                                <asp:TextBox ID="TextBox7" placeholder="CVV" runat="server" Style="text-align: center;" Font-Size="15px" Width="50px" MaxLength="3" BorderStyle="None" ToolTip="Enter CVV number of card" Height="50px"></asp:TextBox>
                            </p>
                        </div>
                        <div class="row card-text">
                            <p></p>
                        </div>
                        <div class="row signature">
                            <p>CUSTOMER SIGNATURE</p>
                            <div>
                                <img src="https://upload.wikimedia.org/wikipedia/commons/a/a4/Mastercard_2019_logo.svg" width="60px">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png" width="80px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
        <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="btn btn-outline-danger mx-3" />
        <asp:Button ID="btnConfirm" runat="server" Text="Confirm" CssClass="btn btn-outline-success mx-3" OnClick="btnConfirm_Click" />
    </div>
</asp:Content>
