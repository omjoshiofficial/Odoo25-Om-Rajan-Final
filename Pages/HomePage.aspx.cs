using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace StackIt.Pages
{
    public partial class HomePage : System.Web.UI.Page
    {
        SqlCommand cmd;
        SqlConnection cn;
        SqlDataAdapter da;
        DataSet ds;

        static int PageSize = 5; // You can adjust this

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
                ViewState["FilterType"] = "";
                ViewState["SearchKeyword"] = "";
                ViewState["PageNumber"] = 0;
                BindQuestions();
            }
        }

        private void BindQuestions()
        {
            mycon();

            string filterType = ViewState["FilterType"].ToString();
            string searchKeyword = ViewState["SearchKeyword"].ToString();

            string query = @"
                SELECT 
                    q.QuestionsId,
                    q.Title,
                    q.Description,
                    u.Username,
                    t.Name AS TagName,
                    q.CreatedAt,
                    ISNULL(ac.AnswerCount, 0) AS AnswerCount
                FROM Questions q
                JOIN Users u ON q.UserId = u.Id
                LEFT JOIN Tags t ON q.TagId = t.Id
                OUTER APPLY (
                    SELECT COUNT(*) AS AnswerCount 
                    FROM Answers a 
                    WHERE a.QuestionId = q.QuestionsId
                ) ac
            ";

            if (filterType == "UNANSWERED")
            {
                query += " WHERE NOT EXISTS (SELECT 1 FROM Answers a2 WHERE a2.QuestionId = q.QuestionsId) ";
            }
            else if (filterType == "SEARCH" && !string.IsNullOrEmpty(searchKeyword))
            {
                query += " WHERE q.Title LIKE @search OR q.Description LIKE @search ";
            }

            if (filterType == "NEWEST")
            {
                query += " ORDER BY q.CreatedAt DESC ";
            }

            cmd = new SqlCommand(query, cn);

            if (filterType == "SEARCH" && !string.IsNullOrEmpty(searchKeyword))
            {
                cmd.Parameters.AddWithValue("@search", "%" + searchKeyword + "%");
            }

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            cn.Close();

            PagedDataSource pagedData = new PagedDataSource();
            pagedData.DataSource = ds.Tables[0].DefaultView;
            pagedData.AllowPaging = true;
            pagedData.PageSize = PageSize;
            pagedData.CurrentPageIndex = Convert.ToInt32(ViewState["PageNumber"]);

            rptQuestions.DataSource = pagedData;
            rptQuestions.DataBind();

            // Enable/Disable page links
            lnkPagePrev.Enabled = !pagedData.IsFirstPage;
            lnkPageNext.Enabled = !pagedData.IsLastPage;
        }

        protected void btnNewest_Click(object sender, EventArgs e)
        {
            ViewState["FilterType"] = "NEWEST";
            ViewState["SearchKeyword"] = "";
            ViewState["PageNumber"] = 0;
            BindQuestions();
        }

        protected void btnUnanswered_Click(object sender, EventArgs e)
        {
            ViewState["FilterType"] = "UNANSWERED";
            ViewState["SearchKeyword"] = "";
            ViewState["PageNumber"] = 0;
            BindQuestions();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ViewState["FilterType"] = "SEARCH";
            ViewState["SearchKeyword"] = txtSearch.Text.Trim();
            ViewState["PageNumber"] = 0;
            BindQuestions();
        }

        protected void lnkPagePrev_Click(object sender, EventArgs e)
        {
            int pageNumber = Convert.ToInt32(ViewState["PageNumber"]);
            if (pageNumber > 0)
            {
                ViewState["PageNumber"] = pageNumber - 1;
                BindQuestions();
            }
        }

        protected void lnkPageNext_Click(object sender, EventArgs e)
        {
            int pageNumber = Convert.ToInt32(ViewState["PageNumber"]);
            ViewState["PageNumber"] = pageNumber + 1;
            BindQuestions();
        }
    }
}
