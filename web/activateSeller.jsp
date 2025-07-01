<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shoppyy | Kích Hoạt Seller</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/homepage.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .activate-form-container {
                max-width: 500px;
                margin: 50px auto;
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
            }
            .activate-form-container h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                font-weight: 500;
                margin-bottom: 5px;
                display: block;
            }
            .form-group input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 16px;
            }
            .form-group input:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0,123,255,0.3);
            }
            .btn-submit {
                background-color: #dc3545;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: 600;
            }
            .btn-submit:hover {
                background-color: #c82333;
            }
            .error-message {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
            .success-message {
                color: green;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
        <body class="container-fluid px-0">
            <div class="header sticky-top">
                <div class="header-top">
                    <div class="header-top-right">
                        <span class="welcome-text font-weight-light" style="display: inline-block;">Welcome, ${sessionScope.login.fullName}!</span>
                    </div>
                </div>
                <div class="header-bottom p-3">
                    <div class="container inner-header-bottom row">
                        <div class="col-md-3">
                            <div class="logo font-weight-bold">
                                <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                                Shoppy
                            </div>
                        </div>
                        <div class="col-md-6">
                            <form action="MainController" method="GET" class="input-group">
                                <input type="text" name="name" class="form-control" placeholder="Tìm sản phẩm...">
                                <input type="hidden" name="action" value="searchProduct">
                                <div class="input-group-append">
                                    <button class="btn btn-solid-primary search-btn" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                                </div>
                            </form>
                        </div>
                     ="col-md-3 text-right">
                               <div class<c:if test="${not empty sessionScope.login}">
                                <a href="viewCart.jsp" class="cart-icon">
                                    <i class="fa fa-shopping-cart"></i>
                                    <c:if test="${not empty sessionScope.cart}">
                                        <span class="cart-count">${sessionScope.cart.size()}</span>
                                    </c:if>
                                    <c:if test="${empty sessionScope.cart}">
                                        <span class="cart-count">0</span>
                                    </c:if>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <div class="activate-form-container">
                <h2>Kích Hoạt Seller</h2>
                <form action="UpdateCSToSellerController" method="POST" onsubmit="return confirm('Bạn có chắc muốn đổi vai trò thành Seller không?');">
                    <div class="form-group">
                        <label for="userID">User ID</label>
                        <input type="text" id="userID" name="userID" required placeholder="Nhập User ID">
                    </div>
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu">
                    </div>
                    <button type="submit" class="btn-submit">Kích Hoạt</button>
                </form>
                <c:if test="${not empty requestScope.error}">
                    <p class="error-message">${requestScope.error}</p>
                </c:if>
                <c:if test="${not empty requestScope.success}">
                    <p class="success-message">${requestScope.success}</p>
                </c:if>
            </div>

            <div class="footer">
                <div class="container">
                    <p>Ecommerce WordPress Theme</p>
                </div>
            </div>

            <!-- Bootstrap 5 JavaScript via CDN -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
</html>