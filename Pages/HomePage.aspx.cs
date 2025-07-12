using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using StackIt.Models;


namespace StackIt.Pages
{
    public partial class HomePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var questions = new List<Question>
                {
                    new Question 
                    { Title = "How to join 2 columns...", ShortDescription = "I do not know the code...", 
                        Author = "UserName", DetailUrl = "QuestionDetailPage.aspx"
                    },
                    new Question
                    { Title = "How to join 2 columns...", ShortDescription = "I do not know the code...",
                        Author = "UserName", DetailUrl = "QuestionDetailPage.aspx"
                    },
                    new Question
                    { Title = "How to join 2 columns...", ShortDescription = "I do not know the code...",
                        Author = "UserName", DetailUrl = "QuestionDetailPage.aspx"
                    },
                    new Question
                    { Title = "How to join 2 columns...", ShortDescription = "I do not know the code...",
                        Author = "UserName", DetailUrl = "QuestionDetailPage.aspx"
                    },
                    new Question 
                    { Title = "How to join 2 columns...", ShortDescription = "I do not know the code...", 
                        Author = "UserName", DetailUrl = "QuestionDetailPage.aspx"
                    },
                    // Add more questions here
                };
                rptQuestions.DataSource = questions;
                rptQuestions.DataBind();
            }
        }
    }
}