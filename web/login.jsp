<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhập</title>
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
            .login-container {
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
            .tab-buttons {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
            }
            .tab-buttons button {
                width: 48%;
                background-color: #ddd;
                color: #333;
            }
            .tab-buttons button.active {
                background-color: #ff5722;
                color: #fff;
            }
            .form-section {
                display: none;
            }
            .form-section.active {
                display: block;
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
            @media (max-width: 480px) {
                .login-container {
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
        <script>
            function showSection(sectionId) {
                const sections = document.getElementsByClassName('form-section');
                const buttons = document.getElementsByClassName('tab-btn');
                for (let i = 0; i < sections.length; i++) {
                    sections[i].classList.remove('active');
                    buttons[i].classList.remove('active');
                }
                document.getElementById(sectionId).classList.add('active');
                document.querySelector(`[onclick="showSection('${sectionId}')"]`).classList.add('active');
            }
            window.onload = function () {
                // Check if there is a success message for signup
                const sessionMsg = '<%= session.getAttribute("MSG") != null ? session.getAttribute("MSG") : "" %>';
                if (sessionMsg) {
                    showSection('signup'); // Switch to signup tab if success message exists
                } else {
                    showSection('login'); // Default to login tab
                }
            };
        </script>
    </head>
    <body>
        <div class="login-container">
            <h2>Đăng Nhập / Đăng Ký</h2>
            <div class="tab-buttons">
                <button class="tab-btn active" onclick="showSection('login')">Đăng Nhập</button>
                <button class="tab-btn" onclick="showSection('signup')">Đăng Ký</button>
            </div>

            <!-- Form Đăng Nhập -->
            <div id="login" class="form-section active">
                <form action="MainController" method="POST">
                    <div class="form-group">
                        <label for="userID">UserID:</label>
                        <input type="text" id="userID" name="userID" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" name="action" value="login">Đăng Nhập</button>
                </form>
                <c:if test="${not empty requestScope.ERROR}">
                    <p class="error">${requestScope.ERROR}</p>
                </c:if>
                <div class="message"></div>  
            </div>

            <!-- Form Đăng Ký -->
            <div id="signup" class="form-section">
                <form action="CreateUserController" method="POST">
                    <input type="hidden" name="sourcePage" value="login">
                    <div class="form-group">
                        <label for="userID">UserID:</label>
                        <input type="text" id="userID" name="userID" required>
                    </div>
                    <div class="form-group">
                        <label for="fullName">Họ và tên:</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    <div class="form-group">
                        <label for="roleID">Role ID:</label>
                        <input type="text" id="roleID" name="roleID" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Số điện thoại:</label>
                        <input type="text" id="phone" name="phone" required>
                    </div>
                    <button type="submit">Đăng Ký</button>
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
            </div>
        </div>
    </body>
</html>