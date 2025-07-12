using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace Stack_IT
{
    public class MailSender
    {
        public void mailsend(string tomail, string subjecttxt, string bodytxt)
        {


            // Email details
            string toEmail = tomail; // Replace with recipient's email address
            string subject = subjecttxt;
            string body = bodytxt;

            // Gmail SMTP settings
            string smtpServer = "smtp.gmail.com";
            int smtpPort = 587;
            string smtpUsername = "rajanupadhyaydeveloper@gmail.com"; // Replace with your Gmail address
            string smtpPassword = "zqge awja bazr qwgf";   // Replace with your Gmail password

            // Create an SMTP client
            using (SmtpClient smtpClient = new SmtpClient(smtpServer, smtpPort))
            {
                smtpClient.EnableSsl = true;// Enable SSL/TLS
                smtpClient.UseDefaultCredentials = false;
                smtpClient.Credentials = new NetworkCredential(smtpUsername, smtpPassword);

                // Create an email message
                using (MailMessage mailMessage = new MailMessage(smtpUsername, toEmail, subject, body))
                {
                    mailMessage.IsBodyHtml = true;

                    try
                    {
                        // Send the email
                        smtpClient.Send(mailMessage);

                        //HttpContext.Current.Response.Write("<script>alert('OTP sent successfully.')</script>");
                        //return 1;
                    }
                    catch (Exception ex)
                    {
                        HttpContext.Current.Response.Write("<script>alert('Error!')</script>");
                        //return 0;
                    }
                }
            }
        }
    }
}