<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Stack_IT.Registration" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>StackIt - Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- ✅ Important for mobile -->
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
            <!-- Image column -->
            <div class="col-lg-6 d-none d-lg-block text-center">
                <asp:Image ImageUrl="~/Assets/Images/QA_Image.png" alt="Register Illustration" CssClass="illustration" runat="server" />
            </div>
            
            <!-- Form column -->
            <div class="col-12 col-sm-10 col-md-8 col-lg-5">
                <div class="card shadow p-4">
                    <h3 class="text-center mb-3">Create Your Account ✨</h3>
                    <p class="text-center text-muted">Join the StackIt community today!</p>
                    <form id="form1" runat="server">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username</label>
                            <asp:TextBox ID="usernametxt" required="required" CssClass="form-control" placeholder="Choose a username" runat="server" onkeyup="checkUsername()" />
                            <span id="usernameValidation" class="text-danger"></span>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email address</label>
                            <asp:TextBox ID="emailtxt" required="required" CssClass="form-control" placeholder="you@example.com" runat="server" onkeyup="checkEmail()" />
                            <span id="emailValidation" class="text-danger"></span>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" class="form-control" required="required" id="passwordtxt" runat="server" placeholder="Enter a password" onkeyup="checkPasswordLength()" />
                            <span id="passwordValidation" class="text-danger"></span>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <asp:DropDownList ID="roleDropdown" required="required" CssClass="form-select" runat="server">
                                <asp:ListItem Text="User" Value="User" />
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label for="otp" class="form-label">OTP Verification</label>
                            <div class="input-group">
                                <asp:TextBox ID="otptxt" runat="server" CssClass="form-control" placeholder="Enter OTP" />
                                <button type="button" class="btn btn-outline-secondary" onclick="sendOTP()">Send OTP</button>
                            </div>
                            <small class="text-muted">Click "Send OTP" to receive it via email</small>
                        </div>
                        <div class="d-grid">
                            <asp:Button Text="Register" ID="submitbtn" CssClass="btn btn-success" OnClick="submitbtn_Click" runat="server" />
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <small>Already have an account? <a href="Login.aspx">Login</a></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function isValidEmailFormat(email) {
            const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return regex.test(email);
        }

        function checkPasswordLength() {
            var password = document.getElementById("passwordtxt").value;
            var submitBtn = document.getElementById("submitbtn");
            if (password.length < 8) {
                document.getElementById("passwordValidation").innerText = "❌ Password must be at least 8 characters.";
                submitBtn.disabled = true;
            } else {
                document.getElementById("passwordValidation").innerText = "✅ Strong password.";
                submitBtn.disabled = false;
            }
        }

        function checkUsername() {
            var username = document.getElementById("usernametxt").value;
            var submitBtn = document.getElementById("submitbtn");

            if (username.length < 3) {
                document.getElementById("usernameValidation").innerText = "❌ Username must be at least 3 characters.";
                submitBtn.disabled = true;
                return;
            }

            $.ajax({
                type: "POST",
                url: "Registration.aspx/CheckUsername",
                data: JSON.stringify({ username: username }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d === true) {
                        document.getElementById("usernameValidation").innerText = "❌ Username already taken!";
                        submitBtn.disabled = true;
                    } else {
                        document.getElementById("usernameValidation").innerText = "✅ Username is available!";
                        submitBtn.disabled = false;
                    }
                },
                error: function () {
                    document.getElementById("usernameValidation").innerText = "⚠️ Error checking username.";
                    submitBtn.disabled = true;
                }
            });
        }

        function checkEmail() {
            var email = document.getElementById("emailtxt").value;
            var submitBtn = document.getElementById("submitbtn");

            if (!isValidEmailFormat(email)) {
                document.getElementById("emailValidation").innerText = "❌ Invalid email format!";
                submitBtn.disabled = true;
                return;
            }

            document.getElementById("emailValidation").innerText = "";

            $.ajax({
                type: "POST",
                url: "Registration.aspx/CheckEmail",
                data: JSON.stringify({ email: email }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d === true) {
                        document.getElementById("emailValidation").innerText = "❌ Email already exists!";
                        submitBtn.disabled = true;
                    } else {
                        document.getElementById("emailValidation").innerText = "✅ Email is available!";
                        submitBtn.disabled = false;
                    }
                },
                error: function () {
                    document.getElementById("emailValidation").innerText = "⚠️ Error checking email.";
                    submitBtn.disabled = true;
                }
            });
        }

        function sendOTP() {
            const email = document.getElementById("emailtxt").value;

            if (!isValidEmailFormat(email)) {
                alert("❌ Please enter a valid email before sending OTP.");
                return;
            }

            $.ajax({
                type: "POST",
                url: "Registration.aspx/SendOTP",
                data: JSON.stringify({ email: email }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d === "success") {
                        alert("✅ OTP sent successfully to your email.");
                    } else {
                        alert("❌ Error sending OTP. Please try again.");
                    }
                },
                error: function () {
                    alert("⚠️ Something went wrong while sending OTP.");
                }
            });
        }
    </script>
</body>
</html>
