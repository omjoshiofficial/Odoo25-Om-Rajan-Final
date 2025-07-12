<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="StackIt.Pages.AdminDashboard" MaintainScrollPositionOnPostBack="true" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .summary-card {
            background: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 0.75rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: transform 0.2s;
        }

        .summary-card:hover {
            transform: translateY(-5px);
        }

        .section-header {
            margin-top: 2rem;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .btn-delete {
            color: #dc3545;
            border: 1px solid #dc3545;
            background-color: transparent;
            transition: all 0.2s;
        }

        .btn-delete:hover {
            background-color: #dc3545;
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container py-4">
            <h2 class="mb-4">Admin Dashboard</h2>

            <!-- Summary Cards -->
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="summary-card p-3 text-center">
                        <h5>Users</h5>
                        <h3><asp:Label ID="lblUsersCount" runat="server" /></h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="summary-card p-3 text-center">
                        <h5>Questions</h5>
                        <h3><asp:Label ID="lblQuestionsCount" runat="server" /></h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="summary-card p-3 text-center">
                        <h5>Answers</h5>
                        <h3><asp:Label ID="lblAnswersCount" runat="server" /></h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="summary-card p-3 text-center">
                        <h5>Votes</h5>
                        <h3><asp:Label ID="lblVotesCount" runat="server" /></h3>
                    </div>
                </div>
            </div>

            <!-- Filter Users -->
            <h4 class="section-header">Manage Users</h4>
            <div class="mb-2">
                <asp:TextBox ID="txtSearchUser" runat="server" CssClass="form-control" placeholder="Search by username or email"></asp:TextBox>
                <asp:Button ID="btnFilterUser" runat="server" Text="Filter" CssClass="btn btn-outline-secondary mt-2" OnClick="btnFilterUser_Click" />
                <asp:Button ID="btnClearUser" runat="server" Text="Clear" CssClass="btn btn-outline-dark mt-2 ms-2" OnClick="btnClearUser_Click" />
            </div>
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDeleteUser" runat="server" Text="Delete" CommandName="DeleteUser" CommandArgument='<%# Eval("Id") %>' CssClass="btn btn-delete btn-sm" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <!-- Filter Questions -->
            <h4 class="section-header">Manage Questions</h4>
            <div class="mb-2">
                <asp:TextBox ID="txtSearchQuestion" runat="server" CssClass="form-control" placeholder="Search by title or username"></asp:TextBox>
                <asp:Button ID="btnFilterQuestion" runat="server" Text="Filter" CssClass="btn btn-outline-secondary mt-2" OnClick="btnFilterQuestion_Click" />
                <asp:Button ID="btnClearQuestion" runat="server" Text="Clear" CssClass="btn btn-outline-dark mt-2 ms-2" OnClick="btnClearQuestion_Click" />
            </div>
            <asp:Repeater ID="rptQuestions" runat="server" OnItemCommand="rptQuestions_ItemCommand">
                <ItemTemplate>
                    <div class="border rounded p-3 mb-3 bg-white shadow-sm">
                        <h5><%# Eval("Title") %></h5>
                        <p><%# Eval("Description") %></p>
                        <small class="text-muted">Asked by <%# Eval("Username") %> on <%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></small>
                        <div class="mt-2">
                            <asp:Button ID="btnDeleteQ" runat="server" Text="Delete" CommandName="DeleteQ" CommandArgument='<%# Eval("QuestionsId") %>' CssClass="btn btn-delete btn-sm" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
