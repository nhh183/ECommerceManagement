<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #ff6200, #ffc107);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .login-container {
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            width: 800px;
            height: 500px;
            display: flex;
            overflow: hidden;
            animation: slide-in 0.8s ease;
        }

        @keyframes slide-in {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-left {
            flex: 1;
            background: #f0f0f0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-left img {
            width: 220px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        .login-right {
            flex: 1;
            padding: 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-right h2 {
            margin-bottom: 25px;
            color: #333;
            font-size: 26px;
            font-weight: 600;
        }

        .form-section {
            display: none;
        }

        .form-section.active {
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group input {
            width: 100%;
            padding: 10px 10px;
            border: 1px solid #ddd;
            border-radius: 25px;
            outline: none;
            font-size: 14px;
            background-color: #f9f9f9;
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            border-color: #ff9800;
            background-color: #fff;
            box-shadow: 0 0 5px rgba(255, 152, 0, 0.4);
        }

        .btn-submit {
            background-color: green;
            color: #fff;
            padding: 12px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            width: 100%;
            transition: 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #ff8c00;
            transform: scale(1.02);
        }

        .remember-me {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .remember-me input {
            margin-right: 6px;
        }

        .message {
            margin-top: 15px;
            text-align: center;
        }

        .success {
            color: green;
            font-weight: bold;
            background-color: #e6ffe6;
            border: 1px solid #00cc00;
            padding: 10px;
            border-radius: 5px;
        }

        .error {
            color: #d32f2f;
            font-size: 14px;
            margin-top: 5px;
            background-color: #ffe6e6;
            border: 1px solid #ff0000;
            padding: 5px;
            border-radius: 5px;
        }

        .extra-links {
            margin-top: 10px;
            font-size: 14px;
            text-align: center;
        }

        .extra-links a {
            color: #666;
            text-decoration: none;
            transition: color 0.3s;
        }

        .extra-links a:hover {
            color: #ff6200;
            text-decoration: underline;
        }

        @media (max-width: 480px) {
            .login-container {
                flex-direction: column;
                width: 90%;
                height: auto;
            }

            .login-left img {
                width: 150px;
            }

            .login-right {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-left">
        <img src="images/images.png" alt="Laptop with User Icon">
    </div>
    <div class="login-right">
        <h2>Đăng Nhập / Đăng Ký</h2>

        <!-- Form Đăng Nhập -->
        <div id="login" class="form-section active">
            <form action="MainController" method="POST">
                <div class="form-group">
                    <input type="text" id="userID" name="userID" placeholder="UserID" required>
                </div>
                <div class="form-group">
                    <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
                </div>
                <div class="remember-me">
                    <input type="checkbox" id="rememberMe" name="rememberMe">
                    <label for="rememberMe">Ghi nhớ tài khoản</label>
                </div>
                <button type="submit" name="action" value="login" class="btn-submit">Đăng Nhập</button>
            </form>

            <c:if test="${not empty requestScope.ERROR}">
                <p class="error">${requestScope.ERROR}</p>
            </c:if>

            <div class="extra-links">
                <p><a href="forgotPassword.jsp">Quên mật khẩu?</a></p>
                <p><a href="signUp.jsp">Create your Account</a></p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
