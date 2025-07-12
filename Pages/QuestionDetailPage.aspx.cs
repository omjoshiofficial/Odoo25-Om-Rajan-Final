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
    public partial class QuestionDetailPage : System.Web.UI.Page
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


        void questionDetail()
        {
            mycon();

            if (Request.QueryString["qid"] != null)
            {
                cmd = new SqlCommand("select QuestionsId,Title,Description,TagId,UserId,Username from Questions join Users on Questions.UserId = Users.Id where QuestionsId=@qid", cn);
                cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    questiontxt.Text = ds.Tables[0].Rows[0]["Title"].ToString();
                    descriptiontxt.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                    usernametxt.InnerText = ds.Tables[0].Rows[0]["Username"].ToString();

                    cmd = new SqlCommand("select * from Answers join Users on Answers.UserId = Users.Id where QuestionId=@qid", cn);
                    cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());

                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);

                    rptAnswers.DataSource = ds;
                    rptAnswers.DataBind();

                }
            }

        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["qid"] != null)
            {
                questionDetail();

            }
        }

        protected void btnSubmitAnswer_Click(object sender, EventArgs e)
        {
            try
            {
                if (Request.Cookies["login"] != null)
                {
                    string uid = Request.Cookies["login"].Values["uid"].ToString();

                    mycon();
                    cmd = new SqlCommand("insert into Answers (QuestionId,UserId,Content) values (@qid,@uid,@content);", cn);
                    cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Convert.ToInt32(uid));
                    cmd.Parameters.AddWithValue("@content", answertxt.Text);

                    cmd.ExecuteNonQuery();

                    Response.Redirect(Request.Url.AbsoluteUri, false);
                }

            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}