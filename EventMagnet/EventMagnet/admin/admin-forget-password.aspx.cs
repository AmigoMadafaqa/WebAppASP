using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EventMagnet.controller;

namespace EventMagnet.admin
{
    public partial class admin_forget_password : System.Web.UI.Page
    {
        string cs = Global.CS;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnResetLink_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;

            // Check if the email exists in the database
            if (IsEmailExists(email))
            {
                // Generate and send OTP to the user's email
                string otp = GenerateAndSendOtp(email);

                // Store the OTP in the session for verification on the next page
                Session["OTP"] = otp;
                Session["ResetEmail"] = email;

                // Redirect to the OTP verification page
                Response.Redirect("admin-reset-password.aspx");
            }
            else
            {
                // Email does not exist, show error message or handle accordingly
                lblErrorMessage.Text = "Email not found. Please enter a valid email address.";
            }
        }

        private bool IsEmailExists(string email)
        {
            // Check if the email exists in the database
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string sql = "SELECT COUNT(*) FROM admin WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private string GenerateAndSendOtp(string email)
        {
            // Generate a random OTP
            Random random = new Random();
            int myRandom = random.Next(100000, 999999);
            string otp = myRandom.ToString();

            // Send OTP to the user's email
            SendEmail(email, otp);

            return otp;
        }

        private void SendEmail(string email, string otp)
        {
            // Replace with your email subject and content
            string subject = "Password Reset OTP";
            string content = $"Your OTP for password reset is: {otp}";

            // Log for debugging
            Console.WriteLine($"Sending email to {email} with OTP: {otp}");

            // Use the provided sendEmail function to send the email
            Account.sendEmail(email, subject, content);
        }
    }
}