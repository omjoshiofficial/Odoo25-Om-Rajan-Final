<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="QuestionDetailPage.aspx.cs" Inherits="StackIt.Pages.QuestionDetailPage" %>
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
        <h3 class="mb-3">
            <asp:Label ID="questiontxt" runat="server" />
        </h3>
        <p>
            <asp:Label ID="descriptiontxt" runat="server" />
        </p>
        <small class="text-muted">Asked by <span id="usernametxt" runat="server"></span></small>

        <hr class="my-4">

        <h5 class="mb-3">Answers</h5>

        <!-- Answer List -->
        <asp:Repeater ID="rptAnswers" runat="server" OnItemCommand="rptAnswers_ItemCommand">
        <ItemTemplate>
            <div class="mb-3 border rounded p-3 shadow-sm bg-white">
                <p><%#Eval("Content")%></p>
                <small class="text-muted">Answered by <%#Eval("Username") %></small>
                <div class="d-flex flex-wrap align-items-center gap-2">
                    <asp:Button Text="Upvote" CommandName="Upvote" CommandArgument='<%#Eval("Id") %>' class="btn btn-outline-success btn-sm" runat="server" />
                    <asp:Button Text="Downvote" CommandName="Downvote" CommandArgument='<%#Eval("Id") %>' class="btn btn-outline-danger btn-sm" runat="server" />
                    <span class="ms-2">Votes: <%#Eval("VoteCount") %></span>
                </div>
            </div>
        </ItemTemplate>
        </asp:Repeater>


        <h6 class="mt-4">Submit Your Answer</h6>
        <asp:Panel ID="pnlAnswer" runat="server">
            <div class="mb-3">
                <asp:TextBox CssClass="form-control" TextMode="MultiLine" ID="answertxt" runat="server" />
            </div>
            <asp:Button ID="btnSubmitAnswer" runat="server" Text="Submit Answer" CssClass="btn btn-primary" OnClick="btnSubmitAnswer_Click" />
        </asp:Panel>
    </div>

</asp:Content>
