<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="StackIt.Pages.HomePage" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #2980b9;
            --light-gray: #f8f9fa;
            --dark-gray: #343a40;
            --text-color: #2c3e50;
            --border-radius: 4px;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-color);
        }
        
        .question-card {
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
            margin-bottom: 16px;
            background: white;
        }
        
        .question-card:hover {
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
            border-left: 4px solid var(--accent-color);
        }
        
        .question-card a {
            text-decoration: none;
            color: inherit;
            display: block;
            padding: 20px;
        }
        
        .question-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .question-desc {
            color: #555;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .question-meta {
            font-size: 0.85rem;
            color: #6c757d;
        }
        
        .question-stats {
            text-align: right;
        }
        
        .badge-tag {
            background-color: #e1f0fa;
            color: var(--accent-color);
            font-weight: 500;
            padding: 5px 10px;
            border-radius: var(--border-radius);
        }
        
        .badge-answer {
            background-color: #e8f5e9;
            color: #2e7d32;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: var(--border-radius);
        }
        
        .btn-filter {
            border: 1px solid #ddd;
            color: var(--text-color);
            font-weight: 500;
        }
        
        .btn-filter.active, .btn-filter:hover {
            background-color: var(--secondary-color);
            color: white;
            border-color: var(--secondary-color);
        }
        
        .search-box {
            border-radius: var(--border-radius);
            border: 1px solid #ddd;
        }
        
        .search-btn {
            background-color: var(--secondary-color);
            color: white;
            font-weight: 500;
        }
        
        .search-btn:hover {
            background-color: var(--accent-color);
        }
        
        .pagination .page-item .page-link {
            color: var(--secondary-color);
            border: 1px solid #ddd;
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        
        .pagination .page-item:hover .page-link {
            background-color: #f8f9fa;
        }
        
        @media (max-width: 768px) {
            .question-stats {
                text-align: left;
                margin-top: 10px;
            }
            
            .btn-filter, .search-box, .search-btn {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Home / Question List Page -->
    <div id="home" class="container py-4">
        <div class="row mb-4">
            <div class="col-12">
                <h2 class="mb-3" style="color: var(--primary-color);">Questions</h2>
                
                <!-- Filter and Search Section -->
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                    <div class="d-flex flex-wrap gap-2">
                        <asp:Button ID="btnNewest" runat="server" Text="Newest" 
                            CssClass="btn btn-filter flex-grow-1" OnClick="btnNewest_Click" />
                        <asp:Button ID="btnUnanswered" runat="server" Text="Unanswered" 
                            CssClass="btn btn-filter flex-grow-1" OnClick="btnUnanswered_Click" />
                    </div>
                    
                    <div class="flex-grow-1" style="min-width: 250px;">
                        <div class="input-group">
                            <asp:TextBox ID="txtSearch" runat="server" 
                                CssClass="form-control search-box" 
                                placeholder="Search questions..."></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" 
                                CssClass="btn search-btn" OnClick="btnSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Questions List -->
        <div class="row">
            <div class="col-12">
                <asp:Repeater ID="rptQuestions" runat="server">
                    <ItemTemplate>
                        <div class="question-card">
                            <a href='QuestionDetailPage.aspx?qid=<%#Eval("QuestionsId") %>'>
                                <div class="row">
                                    <div class="col-md-9">
                                        <h5 class="question-title"><%# Eval("Title") %></h5>
                                        <p class="question-desc"><%# Eval("Description") %></p>
                                        <div class="question-meta">
                                            Asked by <span class="fw-semibold"><%# Eval("Username") %></span>
                                        </div>
                                    </div>
                                    <div class="col-md-3 question-stats">
                                        <div class="d-flex flex-md-column justify-content-between h-100">
                                            <span class="badge-tag mb-2"><%# Eval("TagName") %></span>
                                            <span class="badge-answer"><%# Eval("AnswerCount") %> Answers</span>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Pagination -->
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Question pagination">
                    <ul class="pagination justify-content-center">
                        <li class="page-item">
                            <asp:LinkButton ID="lnkPagePrev" runat="server" CssClass="page-link" OnClick="lnkPagePrev_Click">
                                <span aria-hidden="true">&laquo;</span> Previous
                            </asp:LinkButton>
                        </li>
                        <li class="page-item">
                            <asp:LinkButton ID="lnkPageNext" runat="server" CssClass="page-link" OnClick="lnkPageNext_Click">
                                Next <span aria-hidden="true">&raquo;</span>
                            </asp:LinkButton>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</asp:Content>