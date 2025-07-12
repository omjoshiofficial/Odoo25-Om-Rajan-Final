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

namespace StackIt.Pages
{
    public partial class AskQuestionPage : System.Web.UI.Page
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

        protected void btnSubmitQuestion_Click(object sender, EventArgs e)
        {
            try
            {
                mycon();
                cmd = new SqlCommand("insert into Questions (Title,Description,TagId,UserId) values (@title,@desc,@tagid,@userid);", cn);
                cmd.Parameters.AddWithValue("@title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@desc", "");
                cmd.Parameters.AddWithValue("@tagid", txtTags.SelectedItem.Value);
                cmd.Parameters.AddWithValue("@userid", 1);

                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {

            }
            finally
            {
                if (cn != null && cn.State == ConnectionState.Open)
                    cn.Close();
            }
        }
    }
}