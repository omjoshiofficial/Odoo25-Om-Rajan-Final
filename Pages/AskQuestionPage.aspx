<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/StackItMasterPage.Master" AutoEventWireup="true" CodeBehind="AskQuestionPage.aspx.cs" Inherits="StackIt.Pages.AskQuestionPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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
                <%--<div id="editor" class="editor-container bg-white border"></div>--%>
                <asp:TextBox ID="editor" TextMode="MultiLine" CssClass="form-control" runat="server" />

            </div>
            <div class="mb-3">
                <%--<label for="txtTags" class="form-label">Tags</label>--%>
                <%--<asp:TextBox ID="txtTags" runat="server" CssClass="form-control" placeholder="e.g., SQL, C#, Entity Framework"></asp:TextBox>--%>
                <asp:DropDownList ID="txtTags" CssClass="form-control" runat="server">
</asp:DropDownList>

            </div>
            <asp:Button ID="btnSubmitQuestion" runat="server" Text="Submit" CssClass="btn btn-success" OnClick="btnSubmitQuestion_Click" />
        </asp:Panel>
    </div>

</asp:Content>
