using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace StackIt.Pages
{
    public partial class StackItMasterPage : System.Web.UI.MasterPage
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
            if (!IsPostBack)
            {
                mycon();

                if (Request.Cookies["login"] != null)
                {
                    string uid = Request.Cookies["login"].Values["uid"].ToString();

                    cmd = new SqlCommand("SELECT * FROM Users WHERE Id = @id", cn);
                    cmd.Parameters.AddWithValue("@id", uid);

                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        userlbl.InnerText = ds.Tables[0].Rows[0]["Username"].ToString();
                    }

                    authBtn.Text = "Logout";
                    authBtn.CssClass = "btn btn-outline-danger";
                }
                else
                {
                    askbtn.Attributes["href"] = "#";
                    askbtn.Attributes["class"] = "btn btn-secondary disabled";
                    askbtn.Attributes["style"] = "pointer-events: none; opacity: 0.6;";

                    userlbl.InnerText = "Guest";

                    authBtn.Text = "Login";
                    authBtn.CssClass = "btn btn-outline-secondary";
                }

                cn.Close();

                LoadNotifications();
            }
        }

        protected void authBtn_Click(object sender, EventArgs e)
        {
            if (authBtn.Text == "Logout")
            {
                if (Request.Cookies["login"] != null)
                {
                    Response.Cookies["login"].Expires = DateTime.Now.AddDays(-1);
                }
                Response.Redirect("../Auth/Login.aspx");
            }
            else
            {
                Response.Redirect("../Auth/Login.aspx");
            }
        }

        protected void LoadNotifications()
        {
            if (Request.Cookies["login"] != null)
            {
                string uid = Request.Cookies["login"].Values["uid"].ToString();

                mycon();

                cmd = new SqlCommand("SELECT TOP 5 Id, Message, RedirectUrl FROM Notifications WHERE UserId=@uid AND IsRead=0 ORDER BY CreatedAt DESC", cn);
                cmd.Parameters.AddWithValue("@uid", uid);

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                rptNotifications.DataSource = ds;
                rptNotifications.DataBind();

                int count = ds.Tables[0].Rows.Count;
                notifCount.InnerText = count > 0 ? count.ToString() : "";

                cn.Close();
            }
        }

        protected void rptNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenNotif")
            {
                int notifId = Convert.ToInt32(e.CommandArgument);

                mycon();

                cmd = new SqlCommand("SELECT RedirectUrl FROM Notifications WHERE Id=@nid", cn);
                cmd.Parameters.AddWithValue("@nid", notifId);

                object result = cmd.ExecuteScalar();
                string url = "";

                if (result != null && result != DBNull.Value)
                {
                    url = result.ToString();
                }
                else
                {
                    url = "../Pages/NotificationsPage.aspx"; // fallback page if no URL
                }

                // Mark notification as read
                cmd = new SqlCommand("UPDATE Notifications SET IsRead = 1 WHERE Id=@nid", cn);
                cmd.Parameters.AddWithValue("@nid", notifId);
                cmd.ExecuteNonQuery();

                cn.Close();

                Response.Redirect(url);

            }
        }
    }
}
