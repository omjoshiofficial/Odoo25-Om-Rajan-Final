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
            mycon();

            if (Request.Cookies["login"] != null)
            {
                string uid = Request.Cookies["login"].Values["uid"].ToString();

                cmd = new SqlCommand("select * from Users where Id = @id", cn);
                cmd.Parameters.AddWithValue("@id", uid);

                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count>0)
                {
                    userlbl.InnerText = ds.Tables[0].Rows[0]["Username"].ToString();
                }

            }
            else
            {
                askbtn.Attributes["href"] = "#";
                askbtn.Attributes["class"] = "btn btn-secondary disabled"; // visually disabled
                askbtn.Attributes["style"] = "pointer-events: none; opacity: 0.6;";

                userlbl.InnerText = "Guest";
            }
        }
    }
}