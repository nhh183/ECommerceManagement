<%-- 
    Document   : header
    Created on : Jun 25, 2025, 3:55:35 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dto.UserDTO" %>

<div class="header sticky-top">
    <div class="header-top">
        <div class="header-top-left">

        </div>
        <div class="header-top-right">
            <span class="welcome-text font-weight-light" style="display: inline-block;">Welcome, ${sessionScope.login.fullName}!</span> <!-- Thêm style="display: inline-block;" -->
        </div>

    </div>
    <div class="header-bottom p-3">
        <div class="container inner-header-bottom row">
            <!-- Logo với hình giỏ hàng -->
            <div class="col-md-3">
                <div class="logo font-weight-bold">
                    <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                    Shoppy
                </div>
            </div>

            <!-- Search Box -->
            <div class="col-md-6">
                <form action="MainController" method="GET" class="input-group">
                    <input type="text" name="name" class="form-control" placeholder="Tìm sản phẩm...">
                    <input type="hidden" name="action" value="searchProduct">
                    <div class="input-group-append">
                        <button class="btn btn-solid-primary search-btn" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                    </div>
                </form>
            </div>

            <!-- User Actions -->
            <div class="col-md-3 text-right">
                <c:if test="${not empty sessionScope.login}">
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


<!-- NAVIGATION MENU -->
<div class="nav-wrapper">
    <div class="container">
        <ul class="nav-menu">
            <!-- Mục chung -->
            <li><a href="MainController?action=homePage">HOME</a></li>
                <c:forEach var="cat" items="${categoryList}">
                <li><a href="MainController?action=searchProduct&categoryID=${cat.categoryID}&sourcePage=productPage">${cat.categoryName}</a></li>
                </c:forEach>

            <!-- Divider nếu có chức năng quản lý -->
            <c:if test="${sessionScope.login.roleID == 'AD' || sessionScope.login.roleID == 'CS' || sessionScope.login.roleID == 'SL'}">
                <li class="divider">|</li>
                </c:if>

            <!-- Mục cho ADMIN -->
            <c:if test="${sessionScope.login.roleID == 'AD'}">
                <li><a class="admin-link" href="MainController?action=searchUser">Quản lý KH</a></li>
                <li><a class="admin-link" href="MainController?action=searchCategory">Danh mục</a></li>
                <li><a class="admin-link" href="MainController?action=productList">Sản phẩm</a></li>
                <li><a class="admin-link" href="feedbackAdmin.jsp">Phản hồi</a></li>
                </c:if>

            <!-- Mục cho CS -->
            <c:if test="${sessionScope.login.roleID == 'CS'}">
                <li><a class="admin-link" href="MainController?action=activateSeller">Kích hoạt Seller</a></li>
                </c:if>

            <!-- Mục cho SELLER -->
            <c:if test="${sessionScope.login.roleID == 'SL'}">
                <li><a class="admin-link" href="MainController?action=productList">Sản phẩm của tôi</a></li>
                <li><a class="admin-link" href="MainController?action=myOrders">Đơn hàng</a></li>
                </c:if>

            <!-- Nút Logout -->
            <c:if test="${not empty sessionScope.login}">
                <li class="logout-item">
                    <a class="logout-link" href="MainController?action=logout">
                        <i class="fa fa-sign-out-alt"></i> Đăng xuất
                    </a>                        
                </li>
            </c:if>
        </ul>
    </div>
</div>

