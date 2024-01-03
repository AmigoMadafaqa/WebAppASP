<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="venue-rent.aspx.cs" Inherits="EventMagnet.site.rent_venue" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 279px;
        }
        .auto-style2 {
            width: 313px;
        }
        img{
            height:100px;
            width:100px;
            transition:transform .2s;
        }
        img.venue-map:hover {
            position: relative;
            transform: scale(8);
            z-index: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- ***** About Us Page ***** -->
    <div class="page-heading-rent-venue">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <h2>Are You Looking For Location Of The Venue?</h2>
                    <span>Check out our venue location, pick your choice and check the details.</span>
                </div>
            </div>
        </div>
    </div>

    <div class="rent-venue-tabs">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row" id="tabs">
                        <div class="col-lg-12">
                            <div class="heading-tabs">
                                <div class="row">
                                    <div class="col-lg-8">
                                        <!--<ul>
                                          <li><a href='#tabs-1'><%# Eval("name") %></a></li>
                                        </ul>-->
                                        <asp:DropDownList ID="ddlVenue" runat="server" DataSourceID="SdsVenue" DataTextField="name" DataValueField="id" OnSelectedIndexChanged="ddlVenue_SelectedIndexChanged" CssClass="form-control" style="width:30%">
                                        </asp:DropDownList>
                                        <asp:Button ID="btnVenue" runat="server" Text="Display" onclick="btnVenue_Click" CssClass="btn btn-outline-info"/>
                                        <asp:Literal ID="litErrMsg" runat="server" Visible="false"></asp:Literal>
                                        <asp:SqlDataSource ID="SdsVenue" runat="server" ConnectionString="<%$ ConnectionStrings:eventMagnetConnectionString %>" SelectCommand="SELECT * FROM [venue] WHERE ([status] = @status)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="1" Name="status" Type="Byte" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <asp:Repeater ID="rptVenue" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-12">
                                    <section class='tabs-content'>
                                        <article id='<%# "tabs-" + Eval("id") %>'>
                                            <div class="row">
                                                <div class="col-lg-9">
                                                    <div class="right-content">
                                                        <h4>
                                                            <%# Eval("name") %>
                                                        </h4>
                                                        <br />
                                                        <br />
                                                        <h6>Description for Venue : <br /></h6>
                                                        <p style="font-size:16pt;padding-top:5px"> <%# Eval("descp") %></p>
                                                        <br />
                                                        
                                                        <h6 class="form-label text-capitalize">Address Of <b><%#Eval("name") %> : </b></h6>
                                                        <p class="text-info" style="font-size:14pt"><%# Eval("address") %></p>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3">
                                                    <div>
                                                        <asp:Image ImageUrl='<%# "~/admin/images/venues/" + Eval("img_src") %>' runat="server" ID="imgVPhoto" Width="300px" Height="250px" AlternateText='<%# "~/admin/images/venues/" + Eval("img_src") %>'/>
                                                        <h5>Any Question?</h5>
                                                        <p>Feel free to contact us by using email or phone call.<br />
                                                            <span>
                                                                <a href='<%# "mailto:" + Eval("email_contact") %>'>Send Email</a>
                                                                <br />
                                                                Contact Number: <%# Eval("phone_contact") %><br />
                                                                <a href='<%# "tel:" + Eval("phone_contact") %>'>Phone Call</a>
                                                            </span>
                                                        </p>
                                                    </div>
                                                </div>   
                                            </div> 
                                            <hr />
                                            <iframe
                                              width="1000"
                                              height="300"
                                              frameborder="0"
                                              style="border: 0"
                                              src='https://www.google.com/maps/embed/v1/place?q=<%#Eval("address") %>&key=AIzaSyC9ry4AYKPmMG4fDPy3YsFAN7YYb2KTcUk'
                                              allowfullscreen
                                            ></iframe>
                                        </article>
                                    </section>
                                    <hr />
                                </div>
                                <!-- initialize hidden value(for passing the id)-->
                                <asp:HiddenField ID="hfVenueID" runat="server" Value='<%# Eval("id") %>' />
                            </ItemTemplate>
                        </asp:Repeater>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>
