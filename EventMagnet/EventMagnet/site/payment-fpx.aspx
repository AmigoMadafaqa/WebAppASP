<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="payment_fpx.aspx.cs" Inherits="EventMagnet.site.payment_fpx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h3 style="text-align: center; margin: 10px auto;">FPX Payment</h3>
    <div style="display: flex; justify-content: center; align-items: center; height: 150px">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Choose a Bank to make payment : "></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>CIMB Bank</asp:ListItem>
                <asp:ListItem>Hong Leong Bank</asp:ListItem>
                <asp:ListItem>Maybank</asp:ListItem>
                <asp:ListItem>Public Bank</asp:ListItem>
            </asp:DropDownList>
        </div>
    </div>
    <div style="margin: 40px auto 20px; display: flex; justify-content: center;">
        <asp:Button ID="Button1" runat="server" Text="Cancel Payment" CssClass="btn btn-outline-danger mx-3" />
        <asp:Button ID="btnConfirm" runat="server" Text="Confirm Payment" CssClass="btn btn-outline-success mx-3"  OnClick="btnConfirm_Click" />
    </div>

</asp:Content>
