using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Web;
using EventMagnet.modal;
using Newtonsoft.Json;
using System.Text;

namespace EventMagnet.controller
{
    public class Account
    {
        public Account()
        {
        }

        public static organization GetOrgInfo(int orgId) 
        {
            if (orgId > 0) {
                EventMagnetEntities db = new EventMagnetEntities();
                // IEnumerable<organization> orgsDB = db.organizations;

                IQueryable<organization> orgDB = db.organizations.AsQueryable()
                                   .Where(x => x.id == orgId);

                orgDB = orgDB.Take(1);

                foreach (organization org in orgDB)
                {
                    if (org.id == orgId)
                    {
                        return org;                      
                    }
                }
            }
            return null;
        }


        // change only the receipient email and receipient name
        // try send to personal or school email account, do not send to anonymous email account
        // do not use \n \t , ... in all the paramenter
        // do not use @" ...
        //               ...
        //               ... "  as it causes error

        // SAMPLE
         /* Account.sendEmail(
                        "tan06030521@gmail.com",
                        "Account Verification Code",
                        "<p>" +
                            "<b>Event Magnet</b><br/>" +
                            "<span>Your Account Verification Code is 937623</span>" +
                            "<br/><a href='https://www.google.com'>You can click here to verify your account</a>" +
                        "</p>");
         */
        public static void sendEmail(string receipientEmail, string subject, string content)
        {
            string senderEmail = "kcmacha@eventmagnet.org";
            string senderName = "Event Magnet Admin";
            string receipientName = "User";

            HttpClient client = new HttpClient();

            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Post, "https://api.mailjet.com/v3/send");

            request.Headers.Add("Authorization", "Basic " + Convert.ToBase64String(System.Text.ASCIIEncoding.ASCII.GetBytes("fd426cbaf9c53aa3b0703323d2533279:a28535ea079b42f55eb5f70bc1983b2a")));

            //request.Content = new StringContent("{\n      \"FromEmail\":\"kcmacha@eventmagnet.org\",\n      \"FromName\":\"Your Mailjet Pilot\",\n      \"Recipients\":[\n        {\n          \"Email\":\"kcmacha0521@gmail.com\",\n          \"Name\":\"Passenger 1\"\n        }\n      ],\n      \"Subject\":\"Your email flight plan!\",\n      \"Text-part\":\"Dear passenger, welcome to Mailjet! May the delivery force be with you!\",\n      \"Html-part\":\"<h3>Dear passenger, welcome to Mailjet!</h3><br />May the delivery force be with you!\"\n\t}");
            request.Content = new StringContent("{\"FromEmail\":\"" + senderEmail + "\", \"FromName\":\"" + senderName + "\",\"Recipients\":[{\"Email\":\"" + receipientEmail + "\",\"Name\":\"" + receipientName + "\"}],\"Subject\":\"" + subject + "\",\"Html-part\":\"" + content + "\"}");
            request.Content.Headers.ContentType = new MediaTypeHeaderValue("application/json");

            client.SendAsync(request);
            //HttpResponseMessage response = await client.SendAsync(request);
            //response.EnsureSuccessStatusCode();
            //string responseBody = await response.Content.ReadAsStringAsync();

        }


        // character such as \n \t, ... can be used
        // HTML language is not supported

        // SAMPLE
        // Account.sendSMS("+60184700496", "Event Maget : Hi, Your OTP verification code is 567092");
        public static void sendSMS(string phoneNumber, string smsContent)
        {
            var settings = new
            {
                url = "https://api.d7networks.com/messages/v1/send",
                method = "POST",
                timeout = 0,
                headers = new
                {
                    Content_Type = "application/json",
                    Accept = "application/json",
                    Authorization = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoLWJhY2tlbmQ6YXBwIiwic3ViIjoiZjAzY2Y1MzAtM2RlNC00ZTFjLThmYzctYjNjY2Q3ZjQyYmNkIn0.SkwKTEtb7PwAhhGQ6zyy1lyDtnjb0a0bXDdef6BeZMI"
                },
                data = JsonConvert.SerializeObject(new
                {
                    messages = new[]
         {
            new
            {
                channel = "sms",
                recipients = new[] { phoneNumber }, 
                content = smsContent, 
                msg_type = "text",
                data_coding = "text"
            }
        },
                    message_globals = new
                    {
                        originator = "SignOTP",
                        report_url = "https://www.eventmagnet.org"
                    }
                })
            };

            var client = new HttpClient();
            var request = new HttpRequestMessage
            {
                RequestUri = new Uri(settings.url),
                Method = HttpMethod.Post,
                Content = new StringContent(settings.data, Encoding.UTF8, "application/json")
            };

            foreach (var header in settings.headers.GetType().GetProperties())
            {
                request.Headers.Add(header.Name, header.GetValue(settings.headers, null).ToString());
            }

            var response = client.SendAsync(request).Result;
            var responseContent = response.Content.ReadAsStringAsync().Result;
            Console.WriteLine(responseContent);
        }


    }
}