<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="StackIt.Pages.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Important for mobile -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Home / Question List Page -->
    <div id="home" class="container py-4">
        <div class="row g-2 mb-3">
            <!-- Buttons -->
            <div class="col-12 col-md-6 d-flex flex-wrap gap-2">
                <asp:Button ID="btnNewest" runat="server" Text="Newest" CssClass="btn btn-outline-secondary flex-fill" />
                <asp:Button ID="btnUnanswered" runat="server" Text="Unanswered" CssClass="btn btn-outline-secondary flex-fill" />
            </div>
            <!-- Search -->
            <div class="col-12 col-md-6">
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary" />
                </div>
            </div>
        </div>

        <!-- Questions List -->
        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <a href='<%# Eval("DetailUrl") %>' class="list-group-item list-group-item-action mb-2 shadow-sm rounded">
                    <h5 class="mb-1"><%# Eval("Title") %></h5>
                    <p class="mb-1 text-muted"><%# Eval("ShortDescription") %></p>
                    <small class="text-secondary">Asked by <%# Eval("Author") %></small>
                </a>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Pagination -->
        <nav class="mt-4">
            <ul class="pagination justify-content-center flex-wrap">
                <li class="page-item">
                    <asp:LinkButton ID="lnkPage1" runat="server" CssClass="page-link">1</asp:LinkButton>
                </li>
                <li class="page-item">
                    <asp:LinkButton ID="lnkPage2" runat="server" CssClass="page-link">2</asp:LinkButton>
                </li>
                <li class="page-item">
                    <asp:LinkButton ID="lnkPage3" runat="server" CssClass="page-link">3</asp:LinkButton>
                </li>
            </ul>
        </nav>
    </div>

</asp:Content>
