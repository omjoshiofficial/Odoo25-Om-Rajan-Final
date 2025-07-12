<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="StackIt.Pages.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Home / Question List Page -->
    <div id="home" class="container mt-4">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-stretch mb-3 gap-3">
            <div class="d-flex">
                <asp:Button ID="btnNewest" runat="server" Text="Newest" CssClass="btn btn-outline-secondary me-2 flex-fill" />
                <asp:Button ID="btnUnanswered" runat="server" Text="Unanswered" CssClass="btn btn-outline-secondary flex-fill" />
            </div>
            <div class="input-group w-100 w-md-50">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary" />
            </div>
        </div>

        <asp:Repeater ID="rptQuestions" runat="server">
            <ItemTemplate>
                <a href='<%# Eval("DetailUrl") %>' class="list-group-item list-group-item-action">
                    <h5><%# Eval("Title") %></h5>
                    <p class="mb-1"><%# Eval("ShortDescription") %></p>
                    <small>Asked by <%# Eval("Author") %></small>
                </a>
            </ItemTemplate>
        </asp:Repeater>


        <nav class="mt-3">
            <ul class="pagination justify-content-center">
                <li class="page-item">
                    <asp:LinkButton ID="lnkPage1" runat="server" CssClass="page-link">1</asp:LinkButton></li>
                <li class="page-item">
                    <asp:LinkButton ID="lnkPage2" runat="server" CssClass="page-link">2</asp:LinkButton></li>
                <li class="page-item">
                    <asp:LinkButton ID="lnkPage3" runat="server" CssClass="page-link">3</asp:LinkButton></li>
            </ul>
        </nav>
    </div>

</asp:Content>
