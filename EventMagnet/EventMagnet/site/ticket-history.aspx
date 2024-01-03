<%@ Page Title="" Language="C#" MasterPageFile="~/site/site.Master" AutoEventWireup="true" CodeBehind="ticket-history.aspx.cs" Inherits="EventMagnet.site.customer_ticket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #qrCodePrompter {
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
    <div style="display: flex; justify-content: center;">
        <div style="width: 70vw;">
            <!-- Content -->
            <div class="container-xxl flex-grow-1 container-p-y">
                <h4 class="fw-bold py-3 mb-4"><span class="text-muted fw-light">Ticket History</span></h4>

                <!-- Basic Bootstrap Table -->
                <div class="card">
                    <h5 class="card-header">Ticket</h5>
                    <div class="table-responsive text-nowrap">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Event Name</th>
                                    <th>Ticket Type</th>
                                    <th>Purchase Date</th>
                                    <th>QR Code</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody class="table-border-bottom-0">
                                <asp:PlaceHolder ID="placeHolderTicket" runat="server"></asp:PlaceHolder>
                                <%--<tr>
                                    <td>1</td>
                                    <td>RhythmReverie Rock Revolution</td>
                                    <td>Gold Ticket</td>

                                    <td>2023-12-11 1:23 PM</td>
                                    <td><i class="fa-solid fa-check"></i>&nbsp;Paid</td>
                                    <td>
                                        <asp:Button ID="btnQRCode" runat="server" Text="Show QR Code" CssClass="btn btn-outline-dark" OnClientClick="showQRCodeModal('118ecd31-f058-41ac-8931-febb8a1131a2');return false;" /></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>MelodyMania Pop Palooza</td>
                                    <td>Adult Ticket</td>
                                    <td>1</td>
                                    <td>2023-12-03 4:33 PM</td>
                                    <td><i class="fa-solid fa-check"></i>&nbsp;Paid</td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>SonicSpectacle Electronic Extravaganza</td>
                                    <td>Children Ticket</td>
                                    <td>1</td>
                                    <td>2023-11-25 8:43 AM</td>
                                    <td><i class="fa-solid fa-check"></i>&nbsp;Paid</td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>BeatBash Hip-Hop Showcase</td>
                                    <td>VVIP Ticket</td>
                                    <td>3</td>
                                    <td>2023-11-23 9:55 PM</td>
                                    <td><i class="fa-solid fa-check"></i>&nbsp;Paid</td>
                                </tr>--%>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!--/ Basic Bootstrap Table -->
            </div>
            <!-- / Content -->
        </div>
    </div>

    <!-- Modal Prompter -->
    <div id="qrCodePrompter" class="modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="display:block;">                    
                    <div style="display:flex;justify-content:center;flex-direction:column;">
                        <h4 style="text-align:center;">Ticket QR Image</h4>
                        <h5 class="modal-title" style="text-align:center;" id="successHeaderLabel"></h5>                
                    </div>
                </div>
                <div class="modal-body" style="display:flex;justify-content:center">
                    <img id="qrCodeImg" src="" alt="QR Code Image" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="successCancelButton" onclick="hideQRCodeModal()">Close</button>
                </div>
            </div>
        </div>
    </div>

 

    <script>

        const qrCodePrompter = document.getElementById("qrCodePrompter");

        function showQRCodeModal(uuid) {
            qrCodePrompter.style.display = "block";
            document.getElementById("successHeaderLabel").innerText = uuid;
            document.getElementById("qrCodeImg").src = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" + uuid;
        }

        function hideQRCodeModal() {
            qrCodePrompter.style.display = "none";
        }
    </script>

</asp:Content>
