<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="StackIt.Pages.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>StackIt</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/quill/dist/quill.snow.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        .editor-container {
            height: 150px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light px-3">
            <a class="navbar-brand" href="#home">StackIt</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item me-2">
                        <a class="btn btn-primary" href="#ask">Ask New Question</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-secondary" href="#login">Login</a>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="btn btn-outline-dark" href="#">
                            <i class="bi bi-bell"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <!-- Home / Question List Page -->
        <div id="home" class="container mt-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-stretch mb-3 gap-3">
                <div class="d-flex">
                    <button type="button" class="btn btn-outline-secondary me-2 flex-fill">Newest</button>
                    <button type="button" class="btn btn-outline-secondary flex-fill">Unanswered</button>
                </div>
                <div class="input-group w-100 w-md-50">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                    <button type="button" class="btn btn-outline-primary">Search</button>
                </div>
            </div>

            <div class="list-group">
                <a href="#question" class="list-group-item list-group-item-action">
                    <h5>How to join 2 columns in a data set to make a separate column in SQL?</h5>
                    <p class="mb-1">I do not know the code for it as I am a beginner. As an example, I want to join first and last name columns...</p>
                    <small>Asked by UserName</small>
                </a>
                <!-- Additional question items can be added here -->
            </div>

            <nav class="mt-3">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                </ul>
            </nav>
        </div>

        <!-- Ask Question Page -->
        <div id="ask" class="container mt-5">
            <h3>Ask a Question</h3>
            <asp:Panel ID="pnlAsk" runat="server">
                <div class="mb-3">
                    <label for="txtTitle" class="form-label">Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="Enter a short, descriptive title"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <div id="editor" class="editor-container bg-white border"></div>
                </div>
                <div class="mb-3">
                    <label for="txtTags" class="form-label">Tags</label>
                    <asp:TextBox ID="txtTags" runat="server" CssClass="form-control" placeholder="e.g., SQL, C#, Entity Framework"></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmitQuestion" runat="server" Text="Submit" CssClass="btn btn-success" />
            </asp:Panel>
        </div>

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

    </form>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/quill/dist/quill.min.js"></script>
    <script>
        new Quill('#editor', { theme: 'snow' });
        new Quill('#answerEditor', { theme: 'snow' });
    </script>
</body>
</html>
