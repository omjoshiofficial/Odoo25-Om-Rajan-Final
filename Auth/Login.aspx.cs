using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace StackIt.Auth
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

        protected void loginbtn_Click(object sender, EventArgs e)
        {
            try
            {
                if (emailtxt.Text == "admin@gmail.com" && passwordtxt.Text == "admin@123")
                {
                    Response.Redirect("Admin_dashboard.aspx");
                }

                cmd = new SqlCommand("select * from Users where Email = @email and PasswordHash = @pass", cn);
                cmd.Parameters.AddWithValue("@email", emailtxt.Text);
                cmd.Parameters.AddWithValue("@pass", passwordtxt.Text);

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    HttpCookie loginck = new HttpCookie("login");

                    loginck.Values.Add("uid", ds.Tables[0].Rows[0]["Id"].ToString());
                    Response.Cookies.Add(loginck);

                    Response.Redirect("~/Pages/HomePage.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Email & Password not exists !!')</script>");
                }
            }
            catch (Exception ex)
            {
            }
        }
    }
}