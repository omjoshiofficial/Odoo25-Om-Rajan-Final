<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="QuestionDetailPage.aspx.cs" Inherits="StackIt.Pages.QuestionDetailPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Question Detail Page -->
        <div id="question" class="container mt-5">
            <h3>How to join 2 columns in a data set to make a separate column in SQL?</h3>
            <p>I do not know the code for it as I am a beginner. As an example, I want to join first and last name columns...</p>
            <small>Asked by UserName</small>

            <hr>
            <h5>Answers</h5>
            <div class="mb-3 border p-3">
                <p>The easiest way is using CONCAT function in SQL...</p>
                <button type="button" class="btn btn-outline-success btn-sm">Upvote</button>
                <button type="button" class="btn btn-outline-danger btn-sm">Downvote</button>
                <span class="ms-2">Votes: 5</span>
            </div>
            <div class="mb-3 border p-3">
                <p>You can also use || operator if your database supports it.</p>
                <button type="button" class="btn btn-outline-success btn-sm">Upvote</button>
                <button type="button" class="btn btn-outline-danger btn-sm">Downvote</button>
                <span class="ms-2">Votes: 2</span>
            </div>

            <h6>Submit Your Answer</h6>
            <asp:Panel ID="pnlAnswer" runat="server">
                <div class="mb-3">
                    <div id="answerEditor" class="editor-container bg-white border"></div>
                </div>
                <asp:Button ID="btnSubmitAnswer" runat="server" Text="Submit Answer" CssClass="btn btn-primary" />
            </asp:Panel>
        </div>

</asp:Content>
