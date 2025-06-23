<%-- 
    Document   : returnRequest
    Created on : Jun 24, 2025, 1:10:14 AM
    Author     : loan1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gửi Yêu Cầu Trả Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #fff;
        }
        .logo {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: white !important;
            font-weight: bold;
            font-size: 28px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logo-img {
            width: 45px;
            height: 45px;
            filter: drop-shadow(0 2px 3px rgba(0,0,0,0.3));
        }
        .header {
            background: linear-gradient(to right, #E55D00, #FF6B00);
            padding: 15px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        .cart-icon {
            position: relative;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            background-color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            color: #E55D00;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #ff3333;
            color: white;
            border-radius: 50%;
            width: 22px;
            height: 22px;
            font-size: 13px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            box-shadow: 0 1px 3px rgba(0,0,0,0.2);
        }
        .logout-button {
            background-color: white;
        }
        .welcome-text {
            color: white;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
            margin-right: 15px;
            font-weight: bold;
        }
        .nav-wrapper {
            background: linear-gradient(to right, #D95400, #E55D00);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .nav-menu {
            display: flex;
            flex-wrap: wrap;
            list-style: none;
            padding: 15px 0;
            gap: 20px;
            margin: 0;
        }
        .nav-menu li a {
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 4px;
            color: white !important;
            transition: all 0.3s ease;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
            text-decoration: none;
        }
        .nav-menu li a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .search-bar {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
            align-items: center;
        }
        .search-bar input[type="text"],
        .search-bar select {
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            flex: 1;
            min-width: 200px;
        }
        .search-bar input[type="submit"] {
            background-color: #e55d00;
            color: white;
            font-weight: bold;
            padding: 8px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .search-bar input[type="submit"]:hover {
            background-color: #d24d00;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px 12px;
            border: 1px solid #d35400;
        }
        .status-select {
            padding: 4px 8px;
            border-radius: 4px;
            border: 1px solid #aaa;
            font-size: 14px;
        }
        .btn-update {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 4px;
            padding: 6px 12px;
            cursor: pointer;
        }
        .btn-update:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="header py-3">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-3">
                <div class="logo font-weight-bold">
                    <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                    E-Commerce Store
                </div>
            </div>
            <div class="col-md-9 text-end">
                <c:if test="${not empty sessionScope.login}">
                    <a href="viewCart.jsp" class="cart-icon">
                        <i class="fas fa-shopping-cart"></i>
                        <c:choose>
                            <c:when test="${not empty sessionScope.cart}">
                                <span class="cart-count">${sessionScope.cart.size()}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="cart-count">0</span>
                            </c:otherwise>
                        </c:choose>
                    </a>
                    <span class="welcome-text">Welcome, ${sessionScope.login.fullName}!</span>
                    <a href="logout" class="btn btn-sm logout-button">Logout</a>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="nav-wrapper">
    <div class="container">
        <ul class="nav-menu">
            <li><a href="homePage.jsp">HOME</a></li>
        </ul>
    </div>
</div>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fefefe;
        }
        h2 {
            color: #e55d00;
            font-weight: bold;
            text-align: center;
            margin-top: 30px;
        }
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 25px 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .btn-submit {
            background-color: #e55d00;
            color: white;
            font-weight: bold;
            border: none;
        }
        .btn-submit:hover {
            background-color: #cc4a00;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Gửi Yêu Cầu Trả Hàng</h2>

    <c:if test="${not empty ERROR}">
        <div class="alert alert-danger mt-4 text-center">${ERROR}</div>
    </c:if>
    <c:if test="${not empty MESSAGE}">
        <div class="alert alert-success mt-4 text-center">${MESSAGE}</div>
    </c:if>

    <div class="form-container">
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="createReturn"/>
            <div class="mb-3">
                <label for="invoiceID" class="form-label">Mã Hóa Đơn (Invoice ID):</label>
                <input type="number" class="form-control" id="invoiceID" name="invoiceID" required>
            </div>
            <div class="mb-3">
                <label for="reason" class="form-label">Lý Do Trả Hàng:</label>
                <textarea class="form-control" id="reason" name="reason" rows="4" placeholder="Nhập lý do bạn muốn trả hàng..." required></textarea>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-submit px-4">Gửi Yêu Cầu</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
