using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Configuration;

namespace Stack_IT
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlCommand cmd;
        SqlConnection cn;
        SqlDataAdapter da;
        DataSet ds;

        void mycon()
        {
            string conStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            cn = new SqlConnection(conStr);
            cn.Open();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            mycon();
        }

        protected void submitbtn_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["OTP"] == null || otptxt.Text.Trim() != Session["OTP"].ToString())
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "otpInvalid", "alert('❌ Invalid OTP. Please enter the correct OTP sent to your email.');", true);
                    return; // Stop registration if OTP is invalid
                }

                mycon();

                cmd = new SqlCommand("INSERT INTO Users VALUES (@uname , @email , @pass , @role)", cn);
                cmd.Parameters.AddWithValue("@uname", usernametxt.Text);
                cmd.Parameters.AddWithValue("@email", emailtxt.Text);
                cmd.Parameters.AddWithValue("@pass", passwordtxt.Value);
                cmd.Parameters.AddWithValue("@role", roleDropdown.SelectedValue);

                cmd.ExecuteNonQuery();
                cn.Close();

                usernametxt.Text = "";
                emailtxt.Text = "";
                passwordtxt.Value = "";
                roleDropdown.SelectedIndex = 0;
                otptxt.Text = "";

                Session.Remove("OTP");

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('✅ Registration successful!');", true);

                Response.Redirect("Login.aspx");

            }
            catch (Exception ex)
            {

            }
        }

        [WebMethod]
        public static bool CheckUsername(string username)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username = @Username", con);
                cmd.Parameters.AddWithValue("@Username", username);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0; // true means username exists
            }
        }


        [WebMethod]
        public static bool CheckEmail(string email)
        {
            string conStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", con);
                cmd.Parameters.AddWithValue("@Email", email);
                con.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0; // true means email exists
            }
        }

        [System.Web.Services.WebMethod]
        public static string SendOTP(string email)
        {
            try
            {
                // Generate a 6-digit OTP
                Random rand = new Random();
                int otp = rand.Next(100000, 999999);

                // Store OTP in session
                HttpContext.Current.Session["OTP"] = otp;

                // Compose the message
                string subject = "StackIt - Your OTP Code";
                string body = $"Your OTP is <b>{otp}</b>. Please use it to verify your email.";

                // Send mail using your MailSender class
                Stack_IT.MailSender senderMail = new Stack_IT.MailSender();
                senderMail.mailsend(email, subject, body);

                return "success";
            }
            catch (Exception ex)
            {
                return "error";
            }
        }

    }
}