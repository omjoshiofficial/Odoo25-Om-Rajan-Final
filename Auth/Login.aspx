<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="StackIt.Auth.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <title>StackIt - Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .illustration {
            max-width: 100%;
            height: auto;
        }

        .card {
            border-radius: 1rem;
        }
    </style>
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="row justify-content-center align-items-center g-4">
            <!-- Image -->
            <div class="col-12 col-md-6 text-center">
                <asp:Image ImageUrl="~/Assets/Images/QA_Image.png" alt="Login Illustration" CssClass="illustration" runat="server" />
            </div>
            <!-- Login form -->
            <div class="col-12 col-md-6">
                <div class="card shadow p-4">
                    <h3 class="text-center mb-3">Welcome Back 👋</h3>
                    <p class="text-center text-muted">Log in to ask and answer questions</p>
                    <form id="form1" runat="server">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <asp:TextBox type="email" CssClass="form-control" ID="emailtxt" placeholder="you@example.com" runat="server" />
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <asp:TextBox type="password" CssClass="form-control" ID="passwordtxt" placeholder="Enter your password" runat="server" />
                        </div>
                        <div class="d-grid">
                            <asp:Button Text="Login" ID="loginbtn" OnClick="loginbtn_Click" class="btn btn-primary" runat="server" />
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <small>Don't have an account? <a href="Registration.aspx">Register</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
