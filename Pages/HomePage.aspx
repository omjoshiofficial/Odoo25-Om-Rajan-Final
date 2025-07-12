<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="StackIt.Pages.HomePage" MaintainScrollPositionOnPostBack="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Important for mobile -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Home / Question List Page -->
    <div id="home" class="container py-4">
        <div class="row g-2 mb-3">
            <!-- Buttons -->
            <div class="col-12 col-md-6 d-flex flex-wrap gap-2">
                <asp:Button ID="btnNewest" runat="server" Text="Newest" CssClass="btn btn-outline-secondary flex-fill" OnClick="btnNewest_Click" />
                <asp:Button ID="btnUnanswered" runat="server" Text="Unanswered" CssClass="btn btn-outline-secondary flex-fill" OnClick="btnUnanswered_Click" />

            </div>
            <!-- Search -->
            <div class="col-12 col-md-6">
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search Your Question Here..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>

        <!-- Questions List -->
        <asp:Repeater ID="rptQuestions" runat="server">
    <ItemTemplate>
        <a href='QuestionDetailPage.aspx?qid=<%#Eval("QuestionsId") %>' 
           class="list-group-item list-group-item-action mb-2 shadow-sm rounded">
           
            <div class="d-flex justify-content-between align-items-start">
                <div class="pe-3">
                    <h5 class="mb-1"><%# Eval("Title") %></h5>
                    <p class="mb-1 text-muted"><%# Eval("Description") %></p>
                    <small class="text-secondary">Asked by <%# Eval("Username") %></small>
                </div>
                <div class="text-end">
                    <span class="badge bg-secondary mb-1"><%# Eval("TagName") %></span><br />
                    <span class="badge bg-info text-dark"><%# Eval("AnswerCount") %> Answers</span>
                </div>
            </div>

        </a>
    </ItemTemplate>
</asp:Repeater>


        <nav class="mt-4">
    <ul class="pagination justify-content-center flex-wrap">
        <li class="page-item">
            <asp:LinkButton ID="lnkPagePrev" runat="server" CssClass="page-link" OnClick="lnkPagePrev_Click">Previous</asp:LinkButton>
        </li>
        <li class="page-item">
            <asp:LinkButton ID="lnkPageNext" runat="server" CssClass="page-link" OnClick="lnkPageNext_Click">Next</asp:LinkButton>
        </li>
    </ul>
</nav>
    </div>

</asp:Content>
