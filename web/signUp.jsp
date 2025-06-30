<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký</title>
    <meta charset="UTF-8">
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
        }

        .form-section {
            background-color: #fff;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
            width: 380px;
            padding: 40px 100px;
            animation: fadeIn 0.7s ease-in-out;
            text-align: center;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-section img {
            width: 120px;
            margin-bottom: 20px;
        }

        h1 {
            margin-bottom: 25px;
            font-size: 24px;
            font-weight: 600;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px 10px;
            border: 1px solid #ddd;
            border-radius: 25px;
            background-color: #f5f5f5;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus {
            border-color: #ffa500;
            background-color: #fff;
            box-shadow: 0 0 6px rgba(255, 165, 0, 0.4);
            outline: none;
        }

        .btn-submit {
            background-color: orange;
            color: white;
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
            transform: scale(1.03);
        }

        .extra-links {
            margin-top: 20px;
        }

        .extra-links a {
            text-decoration: none;
            color: #555;
            font-size: 14px;
        }

        .extra-links a:hover {
            color: #ff6200;
            text-decoration: underline;
        }

        .message p {
            margin: 10px 0;
            font-size: 14px;
        }

        .error {
            color: red;
        }

        .success {
            color: #ff6200;
        }
    </style>
</head>
<body>
    <div class="form-section">
        <img src="images/logo.png" alt="Logo">
        <h1>Đăng ký</h1>
        <form action="CreateUserController" method="POST">
            <input type="hidden" name="sourcePage" value="login">
            <div class="form-group">
                <input type="text" id="userID" name="userID" placeholder="UserID" required>
            </div>
            <div class="form-group">
                <input type="text" id="fullName" name="fullName" placeholder="Họ và tên" required>
            </div>
            <div class="form-group">
                <input type="text" id="roleID" name="roleID" placeholder="Role ID" required>
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
            </div>
            <div class="form-group">
                <input type="text" id="phone" name="phone" placeholder="Số điện thoại" required>
            </div>
            <button type="submit" class="btn-submit">Đăng Ký</button>
        </form>

        <div class="message">
            <c:if test="${not empty requestScope.ERROR}">
                <p class="error">${requestScope.ERROR}</p>
            </c:if>
            <c:if test="${not empty sessionScope.MSG}">
                <p class="success">${sessionScope.MSG}</p>
                <% session.removeAttribute("MSG"); %>
            </c:if>
        </div>

        <div class="extra-links">
            <p><a href="login.jsp">Quay lại Đăng Nhập</a></p>
        </div>
    </div>
</body>
</html>
