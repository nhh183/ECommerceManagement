<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đặt lại mật khẩu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        h2 {
            color: #ff5722;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        label {
            display: block;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #ff5722;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #e64a19;
        }
        .message {
            margin-top: 15px;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
            display: block;
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
            color: red;
            font-size: 14px;
            margin-top: 5px;
            text-align: left;
            background-color: #ffe6e6;
            border: 1px solid #ff0000;
            padding: 5px;
            border-radius: 5px;
        }
        a {
            color: #ff5722;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        @media (max-width: 480px) {
            .form-container {
                padding: 20px;
                margin: 10px;
            }
            .message {
                margin-top: 10px;
                padding: 8px;
            }
            .success, .error {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Đặt lại mật khẩu</h2>
        <form action="ResetPasswordController" method="POST">
            <input type="hidden" name="userID" value="${requestScope.userID}" />
            <div class="form-group">
                <label for="newPassword">Mật khẩu mới:</label>
                <input type="password" id="newPassword" name="newPassword" required />
            </div>
            <div class="form-group">
                <label for="confirmPassword">Xác nhận mật khẩu:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required />
            </div>
            <button type="submit">Cập nhật mật khẩu</button>
        </form>
        <c:if test="${not empty requestScope.ERROR}">
            <p class="error">${requestScope.ERROR}</p>
        </c:if>
        <c:if test="${not empty requestScope.SUCCESS}">
            <p class="success">${requestScope.SUCCESS}</p>
        </c:if>
        <p><a href="login.jsp">← Quay lại đăng nhập</a></p>
    </div>
</body>
</html>