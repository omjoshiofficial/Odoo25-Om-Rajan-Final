using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace StackIt.Pages
{
    public partial class AskQuestionPage : System.Web.UI.Page
    {
        SqlCommand cmd;
        SqlConnection cn;

        void mycon()
        {
            string conStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            cn = new SqlConnection(conStr);
            cn.Open();
        }

        void TagDrop()
        {
            cmd = new SqlCommand("SELECT * FROM Tags", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            txtTags.DataSource = dt;
            txtTags.DataTextField = "Name";   // Display text
            txtTags.DataValueField = "Id";    // Actual value
            txtTags.DataBind();

            txtTags.Items.Insert(0, new ListItem("--select tag--", ""));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mycon();
                TagDrop();
                cn.Close();
            }
        }

        protected void btnSubmitQuestion_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.Cookies["login"] != null)
                {
                    // Check if tag is selected
                    if (string.IsNullOrEmpty(txtTags.SelectedItem.Value))
                    {
                        // Show alert if no tag selected
                        Response.Write("<script>alert('Please select a tag');</script>");
                        return;
                    }

                    string uid = Request.Cookies["login"].Values["uid"].ToString();

                    mycon();
                    cmd = new SqlCommand("INSERT INTO Questions (Title, Description, TagId, UserId) VALUES (@title, @desc, @tagid, @userid);", cn);
                    cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                    cmd.Parameters.AddWithValue("@desc", editor.Text.Trim());
                    cmd.Parameters.AddWithValue("@tagid", Convert.ToInt32(txtTags.SelectedItem.Value));
                    cmd.Parameters.AddWithValue("@userid", Convert.ToInt32(uid));

                    cmd.ExecuteNonQuery();

                    Response.Redirect("homepage.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Please log in first');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                if (cn != null && cn.State == ConnectionState.Open)
                    cn.Close();
            }
        }
    }
}
