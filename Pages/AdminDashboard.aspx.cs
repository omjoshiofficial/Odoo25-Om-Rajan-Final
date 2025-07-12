using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace StackIt.Pages
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCounts();
                LoadUsers();
                LoadQuestions();
            }
        }

        void LoadCounts()
        {
            cn.Open();

            SqlCommand cmdUsers = new SqlCommand("SELECT COUNT(*) FROM Users", cn);
            lblUsersCount.Text = cmdUsers.ExecuteScalar().ToString();

            SqlCommand cmdQuestions = new SqlCommand("SELECT COUNT(*) FROM Questions", cn);
            lblQuestionsCount.Text = cmdQuestions.ExecuteScalar().ToString();

            SqlCommand cmdAnswers = new SqlCommand("SELECT COUNT(*) FROM Answers", cn);
            lblAnswersCount.Text = cmdAnswers.ExecuteScalar().ToString();

            SqlCommand cmdVotes = new SqlCommand("SELECT COUNT(*) FROM Votes", cn);
            lblVotesCount.Text = cmdVotes.ExecuteScalar().ToString();

            cn.Close();
        }

        void LoadUsers(string search = "")
        {
            string query = "SELECT Id, Username, Email, Role FROM Users";

            if (!string.IsNullOrEmpty(search))
            {
                query += " WHERE Username LIKE @search OR Email LIKE @search";
            }

            SqlDataAdapter da = new SqlDataAdapter(query, cn);

            if (!string.IsNullOrEmpty(search))
            {
                da.SelectCommand.Parameters.AddWithValue("@search", "%" + search + "%");
            }

            DataTable dt = new DataTable();
            da.Fill(dt);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        void LoadQuestions(string search = "")
        {
            string query = "SELECT QuestionsId, Title, Description, CreatedAt, Username FROM Questions JOIN Users ON Questions.UserId = Users.Id";

            if (!string.IsNullOrEmpty(search))
            {
                query += " WHERE Title LIKE @search OR Username LIKE @search";
            }

            query += " ORDER BY CreatedAt DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, cn);

            if (!string.IsNullOrEmpty(search))
            {
                da.SelectCommand.Parameters.AddWithValue("@search", "%" + search + "%");
            }

            DataTable dt = new DataTable();
            da.Fill(dt);
            rptQuestions.DataSource = dt;
            rptQuestions.DataBind();
        }

        protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteUser")
            {
                int userId = Convert.ToInt32(e.CommandArgument);
                cn.Open();

                SqlCommand cmd1 = new SqlCommand("DELETE FROM Votes WHERE UserId=@uid", cn);
                cmd1.Parameters.AddWithValue("@uid", userId);
                cmd1.ExecuteNonQuery();

                SqlCommand cmd2 = new SqlCommand("DELETE FROM Answers WHERE UserId=@uid", cn);
                cmd2.Parameters.AddWithValue("@uid", userId);
                cmd2.ExecuteNonQuery();

                SqlCommand cmd3 = new SqlCommand("DELETE FROM Questions WHERE UserId=@uid", cn);
                cmd3.Parameters.AddWithValue("@uid", userId);
                cmd3.ExecuteNonQuery();

                SqlCommand cmd4 = new SqlCommand("DELETE FROM Users WHERE Id=@uid", cn);
                cmd4.Parameters.AddWithValue("@uid", userId);
                cmd4.ExecuteNonQuery();

                cn.Close();
                LoadCounts();
                LoadUsers();
                LoadQuestions();
            }
        }

        protected void rptQuestions_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQ")
            {
                int qid = Convert.ToInt32(e.CommandArgument);
                cn.Open();

                SqlCommand cmd1 = new SqlCommand("DELETE FROM Votes WHERE AnswerId IN (SELECT Id FROM Answers WHERE QuestionId=@qid)", cn);
                cmd1.Parameters.AddWithValue("@qid", qid);
                cmd1.ExecuteNonQuery();

                SqlCommand cmd2 = new SqlCommand("DELETE FROM Answers WHERE QuestionId=@qid", cn);
                cmd2.Parameters.AddWithValue("@qid", qid);
                cmd2.ExecuteNonQuery();

                SqlCommand cmd3 = new SqlCommand("DELETE FROM Questions WHERE QuestionsId=@qid", cn);
                cmd3.Parameters.AddWithValue("@qid", qid);
                cmd3.ExecuteNonQuery();

                cn.Close();
                LoadCounts();
                LoadQuestions();
            }
        }

        protected void btnFilterUser_Click(object sender, EventArgs e)
        {
            LoadUsers(txtSearchUser.Text.Trim());
        }

        protected void btnClearUser_Click(object sender, EventArgs e)
        {
            txtSearchUser.Text = "";
            LoadUsers();
        }

        protected void btnFilterQuestion_Click(object sender, EventArgs e)
        {
            LoadQuestions(txtSearchQuestion.Text.Trim());
        }

        protected void btnClearQuestion_Click(object sender, EventArgs e)
        {
            txtSearchQuestion.Text = "";
            LoadQuestions();
        }
    }
}
