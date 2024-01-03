using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace EventMagnet.admin
{
    public partial class admin_reset_password : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string enteredOtp = txtOtp.Text;

            // Check if the entered OTP matches the one stored in the session
            if (IsOtpMatched(enteredOtp))
            {
                // OTP is correct, allow the user to reset the password
                // Retrieve the email from the session
                string email = Session["ResetEmail"] as string;

                // Implement your password reset logic here
                // For example, retrieve the user's password and update it in the database
                string password = txtPassword.Text; // Replace with the actual new password
                UpdatePasswordInDatabase(email, password);

                // Redirect to a success page or login page
                Response.Redirect("admin-login.aspx");
            }
            else
            {
                // Incorrect OTP, show error message or handle accordingly
                lblErrorMessage.Text = "Incorrect OTP. Please enter the correct OTP.";
            }
        }

        private bool IsOtpMatched(string enteredOtp)
        {
            // Check if the entered OTP matches the one stored in the session
            string storedOtp = Session["OTP"] as string;
            return !string.IsNullOrEmpty(storedOtp) && storedOtp.Equals(enteredOtp);
        }

        private void UpdatePasswordInDatabase(string email, string password)
        {
            // Replace with your database connection string
            string cs = Global.CS;

            // Replace with your SQL query to update the password
            string updateSql = "UPDATE admin SET password = @password WHERE email = @email";

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand(updateSql, con))
                {
                    cmd.Parameters.AddWithValue("@password", BCrypt.Net.BCrypt.HashPassword(password, 13));
                    cmd.Parameters.AddWithValue("@email", email);

                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}