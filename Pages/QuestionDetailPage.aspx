<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="QuestionDetailPage.aspx.cs" Inherits="StackIt.Pages.QuestionDetailPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        .editor-container {
            min-height: 150px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Question Detail Page -->
    <div id="question" class="container py-4">
        <h3 class="mb-3">How to join 2 columns in a data set to make a separate column in SQL?</h3>
        <p>I do not know the code for it as I am a beginner. As an example, I want to join first and last name columns...</p>
        <small class="text-muted">Asked by UserName</small>

        <hr class="my-4">

        <h5 class="mb-3">Answers</h5>

        <!-- Answer 1 -->
        <div class="mb-3 border rounded p-3 shadow-sm bg-white">
            <p>The easiest way is using CONCAT function in SQL...</p>
            <div class="d-flex flex-wrap align-items-center gap-2">
                <button type="button" class="btn btn-outline-success btn-sm">Upvote</button>
                <button type="button" class="btn btn-outline-danger btn-sm">Downvote</button>
                <span class="ms-2">Votes: 5</span>
            </div>
        </div>

        <!-- Answer 2 -->
        <div class="mb-3 border rounded p-3 shadow-sm bg-white">
            <p>You can also use || operator if your database supports it.</p>
            <div class="d-flex flex-wrap align-items-center gap-2">
                <button type="button" class="btn btn-outline-success btn-sm">Upvote</button>
                <button type="button" class="btn btn-outline-danger btn-sm">Downvote</button>
                <span class="ms-2">Votes: 2</span>
            </div>
        </div>

        <h6 class="mt-4">Submit Your Answer</h6>
        <asp:Panel ID="pnlAnswer" runat="server">
            <div class="mb-3">
                <div id="answerEditor" class="editor-container bg-white border rounded p-2"></div>
            </div>
            <asp:Button ID="btnSubmitAnswer" runat="server" Text="Submit Answer" CssClass="btn btn-primary" />
        </asp:Panel>
    </div>

</asp:Content>
