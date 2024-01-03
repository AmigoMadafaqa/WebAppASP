<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-access-error.aspx.cs" Inherits="EventMagnet.admin.admin_access_error" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="images/icons/evemagnet_icon.png" />
    <title>Event Magnet</title>

    <link href="/site/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        * {
            transition: all 0.6s;
        }

        html {
            height: 100%;
        }

        body {
            font-family: 'Lato', sans-serif;
            color: #888;
            margin: 0;
        }

        #main {
            display: table;
            width: 100%;
            height: 70vh;
            text-align: center;
        }

        .fof {
            display: table-cell;
            vertical-align: middle;
        }

            .fof h1 {
                font-size: 50px;
                display: inline-block;
                padding-right: 12px;
                animation: type .5s alternate infinite;
            }

        @keyframes type {
            from {
                box-shadow: inset -3px 0px 0px #888;
            }

            to {
                box-shadow: inset -3px 0px 0px transparent;
            }
        }


        .company-logo-div {
            display: flex;
            justify-content: center;
        }


        .company-logo {
            width: 150px;
            height: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div id="main">
                <div class="fof">

                    <?xml version="1.0" encoding="UTF-8" ?>
                    <svg width="200" height="200" viewBox="0 0 48 48" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M26 6H9C7.34315 6 6 7.34315 6 9V31C6 32.6569 7.34315 34 9 34H39C40.6569 34 42 32.6569 42 31V23" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                        <path d="M24 34V42" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                        <path d="M34 7L42 15" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                        <path d="M42 7L34 15" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                        <path d="M14 42L34 42" stroke="#333" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                    <br />
                    <h2>Admin Organization Access Control Error</h2>
                    <p style="margin:30px auto;width:60vw;text-align: left;">
                        This issue happens when :
                        <br />
                        - You are newly registered user, and does not have access to any of the organization<br />
                        - You are removed from the organization<br />
                        <br />

                        Solution :
                        <br />
                        - Try login again if you still have access to other organization<br />
                        - Contact your organization owner or technical support if you do not have access to any of the organization<br />
                    </p>
                    <br />

                    <asp:Button ID="btnRedirectLoginpage" runat="server" Text="Go To Login Page" CssClass="btn btn-secondary" UseSubmitBehavior="False" OnClick="btnRedirectLoginpage_Click" />
                    <br />


                </div>


            </div>
            <div class="company-logo-div">
                <img class="company-logo" src="/site/images/icons/evemagnet_icon.png" />
            </div>
        </div>
    </form>
</body>
</html>
