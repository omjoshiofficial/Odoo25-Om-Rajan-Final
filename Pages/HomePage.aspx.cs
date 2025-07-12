using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StackIt.Models;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace StackIt.Pages
{
    public partial class HomePage : System.Web.UI.Page
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

            //cmd = new SqlCommand("select * from Questions q join Users u on q.UserId = u.Id", cn);

            cmd = new SqlCommand(@"
    SELECT 
        q.QuestionsId,
        q.Title,
        q.Description,
        u.Username,
        t.Name AS TagName,
        COUNT(a.Id) AS AnswerCount
    FROM Questions q
    JOIN Users u ON q.UserId = u.Id
    LEFT JOIN Tags t ON q.TagId = t.Id
    LEFT JOIN Answers a ON q.QuestionsId = a.QuestionId
    GROUP BY q.QuestionsId, q.Title, q.Description, u.Username, t.Name
", cn);
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                rptQuestions.DataSource = ds;
                rptQuestions.DataBind();
            }
        }
    }
}