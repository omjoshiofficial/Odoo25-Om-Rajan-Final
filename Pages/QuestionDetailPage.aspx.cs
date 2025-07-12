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
                cmd = new SqlCommand("SELECT QuestionsId,Title,Description,TagId,Users.Username FROM Questions JOIN Users ON Questions.UserId = Users.Id WHERE QuestionsId=@qid", cn);
                cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    questiontxt.Text = ds.Tables[0].Rows[0]["Title"].ToString();
                    descriptiontxt.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                    usernametxt.InnerText = ds.Tables[0].Rows[0]["Username"].ToString();

                    // Get Answers along with vote count
                    cmd = new SqlCommand(@"SELECT 
                       Answers.Id,
                       Answers.Content,
                       Answers.QuestionId,
                       Answers.UserId,
                       Answers.CreatedAt,
                       Users.Username,
                       ISNULL(SUM(Votes.VoteType), 0) AS VoteCount 
                       FROM Answers 
                       JOIN Users ON Answers.UserId = Users.Id 
                       LEFT JOIN Votes ON Answers.Id = Votes.AnswerId 
                       WHERE Answers.QuestionId = @qid 
                       GROUP BY 
                       Answers.Id, Answers.Content, Answers.QuestionId, Answers.UserId, Answers.CreatedAt, Users.Username", cn);

                    cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());

                    da = new SqlDataAdapter(cmd);
                    ds = new DataSet();
                    da.Fill(ds);

                    rptAnswers.DataSource = ds;
                    rptAnswers.DataBind();
                }
            }

            cn.Close();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["qid"] != null)
                {
                    questionDetail();
                }
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

                    // Insert answer
                    cmd = new SqlCommand("insert into Answers (QuestionId,UserId,Content) values (@qid,@uid,@content);", cn);
                    cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Convert.ToInt32(uid));
                    cmd.Parameters.AddWithValue("@content", answertxt.Text);
                    cmd.ExecuteNonQuery();

                    // Get question owner to send notification
                    cmd = new SqlCommand("SELECT UserId FROM Questions WHERE QuestionsId = @qid", cn);
                    cmd.Parameters.AddWithValue("@qid", Request.QueryString["qid"].ToString());
                    object ownerIdObj = cmd.ExecuteScalar();

                    if (ownerIdObj != null && ownerIdObj != DBNull.Value)
                    {
                        int ownerId = Convert.ToInt32(ownerIdObj);

                        if (ownerId != Convert.ToInt32(uid)) // do not notify yourself
                        {
                            string message = "Your question has a new answer.";
                            string redirectUrl = "../Pages/QuestionDetailPage.aspx?qid=" + Request.QueryString["qid"].ToString();

                            cmd = new SqlCommand("INSERT INTO Notifications (UserId, Message, IsRead, CreatedAt, RedirectUrl) VALUES (@userId, @message, 0, GETDATE(), @url)", cn);
                            cmd.Parameters.AddWithValue("@userId", ownerId);
                            cmd.Parameters.AddWithValue("@message", message);
                            cmd.Parameters.AddWithValue("@url", redirectUrl);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    cn.Close();
                    Response.Redirect(Request.Url.AbsoluteUri, false);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }



        protected void rptAnswers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Request.Cookies["login"] != null)
            {
                string uid = Request.Cookies["login"].Values["uid"].ToString();
                int userId = Convert.ToInt32(uid);
                int answerId = Convert.ToInt32(e.CommandArgument);

                mycon();

                // Check if user already voted
                cmd = new SqlCommand("SELECT COUNT(*) FROM Votes WHERE AnswerId=@aid AND UserId=@uid", cn);
                cmd.Parameters.AddWithValue("@aid", answerId);
                cmd.Parameters.AddWithValue("@uid", userId);
                int count = (int)cmd.ExecuteScalar();

                int voteType = (e.CommandName == "Upvote") ? 1 : -1;

                if (count > 0)
                {
                    // Update vote
                    cmd = new SqlCommand("UPDATE Votes SET VoteType=@vtype WHERE AnswerId=@aid AND UserId=@uid", cn);
                }
                else
                {
                    // Insert new vote
                    cmd = new SqlCommand("INSERT INTO Votes (AnswerId, UserId, VoteType) VALUES (@aid, @uid, @vtype)", cn);
                }

                cmd.Parameters.AddWithValue("@vtype", voteType);
                cmd.Parameters.AddWithValue("@aid", answerId);
                cmd.Parameters.AddWithValue("@uid", userId);

                cmd.ExecuteNonQuery();

                cn.Close();

                questionDetail(); // Refresh answers and votes
            }
            else
            {
                // Not logged in
                Response.Write("<script>alert('Please login to vote!');</script>");
            }
        }

    }
}