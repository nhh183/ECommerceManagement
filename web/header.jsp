<%-- 
    Document   : header
    Created on : Jun 25, 2025, 3:55:35 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dto.UserDTO" %>
<style>
    /* === HEADER === */
.header {
    border-bottom: none;
    justify-content: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    background: #FD1D1D;
    background: linear-gradient(180deg,rgba(253, 29, 29, 1) 0%, rgba(255, 121, 43, 1) 100%);
}

/* === HEADER-TOP === */
.header-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 10px;
    background: transparent;
}

/* Trái & phải đều là flex để căn đồng đều */
.header-top-left,
.header-top-right {
    display: flex;
    align-items: center;
    gap: 5px;
    margin: 0 20px;
}

/* Danh sách bên trái */
.header-nav-list {
    list-style: none;
    display: flex;
    gap: 20px;
    margin: 0;
    padding: 0;
    background: transparent;
    align-items: center;
}

.header-nav-list li a,
.header-top-right .header-link {
    color: white;
    font-weight: 400;
    font-size: 13px;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: opacity 0.2s ease;
}

.header-link i {
    color: white;
}

.header-link:hover {
    color: white;
    text-decoration: none !important;
    opacity: 0.85;
}

.header-link,
.header-link:visited,
.header-link:focus,
.header-link:active,
.header-link:hover {
    color: white !important;
}
/* === USER DROPDOWN === */
.user-dropdown {
    position: relative;
    display: inline-block;
    margin-left: 10px;
}

.user-toggle {
    color: white;
    font-weight: 300;
    font-size: 13px;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
    display: flex;
    align-items: center;
    gap: 5px;
    cursor: pointer;
}

.user-menu {
    opacity: 0;
    visibility: hidden;
    position: absolute;
    right: 0;
    top: 130%;
    background-color: white;
    border-radius: 6px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
    min-width: 150px;
    z-index: 99;
    transition: opacity 0.2s ease, visibility 0.2s ease;
}

.user-dropdown:hover .user-menu {
    opacity: 1;
    visibility: visible;
}

.user-menu a {
    display: block;
    padding: 10px 15px;
    color: #333;
    text-decoration: none;
    font-weight: 500;
    transition: background 0.3s;
}

.user-menu a:hover {
    background-color: #f5f5f5;
}




.header-bottom{
    background: transparent;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: -10px;
}

.inner-header-bottom{
    align-items: center;
}


@media (max-width: 767px) {
    .logo, .user-actions {
        text-align: center;
        justify-content: center;
    }
    .header .row {
        gap: 15px;
    }
}

.search-box input {
    border: 2px solid #fff ;
    border-radius: 5px 0 0 5px ;
}

.search-box button {
    padding: 8px 15px;
    background-color: white;
    color: #E55D00 ; /* Màu cam đậm */
    border: 2px solid #fff ;
    border-radius: 0 5px 5px 0 ;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.3s ease;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.search-box button:hover {
    background-color: #FFEDCC;
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
}

.user-actions {
    font-size: 14px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
}

.user-actions .btn {

    border: 2px solid #fff;
    border-radius: 5px;
    padding: 8px 15px;
    font-weight: bold;
    transition: all 0.3s ease;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.user-actions .btn:hover {
    background-color: #FFEDCC;
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
}

.welcome-text {
    color: white;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
    margin-right: 15px;
    font-weight: bold;
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

.cart-icon:hover {
    transform: scale(1.1);
    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
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

.search-btn {
    background-color: #FD1D1D;
}

/* === LOGO === */
.logo-link {
    display: flex;
    align-items: center;
    gap: 15px;
    text-decoration: none !important;  /* Xoá gạch chân */
    color: white !important;           /* Giữ màu trắng */
    font-weight: bold;
    font-size: 28px;
    text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
}

.logo-link:hover {
    text-decoration: none !important;
    color: white !important;
}

.logo-img {
    width: 45px;
    height: 45px;
    filter: drop-shadow(0 2px 3px rgba(0,0,0,0.3));
}

</style>
<div class="header sticky-top">
    <div class="header-top">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="header-top-left">
                <ul class="header-nav-list">
                    <!-- Mục cho CS -->
                    <c:if test="${sessionScope.login.roleID == 'CS'}">
                        <li><a class="header-link" href="MainController?action=activateSeller">
                                <i class="fas fa-user-check"></i> Kích hoạt Seller
                            </a></li>
                        </c:if>

                    <!-- Mục cho SELLER -->
                    <c:if test="${sessionScope.login.roleID == 'SL'}">
                        <li><a class="header-link" href="MainController?action=productList">
                                <i class="fas fa-box-open"></i> Sản phẩm của tôi
                            </a></li>
                        <li><a class="header-link" href="MainController?action=myOrders">
                                <i class="fas fa-receipt"></i> Đơn hàng
                            </a></li>
                        </c:if>

                    <c:if test="${sessionScope.login.roleID == 'AD'}">
                        <li><a href="MainController?action=productList" class="header-link">
                                <i class="fas fa-chart-line"></i> Trang Quản Trị
                            </a></li>
                        </c:if>
                </ul>
            </div>


            <div class="header-top-right">
                <a href="NotificationListController" class="header-link">
                    <i class="fas fa-bell"></i> Thông báo
                </a>
                <a href="MainController?action=searchFAQ&sourcePage=support" class="header-link">
                    <i class="fas fa-circle-question"></i> Hỗ trợ
                </a>

                <!-- Dropdown User -->
                <div class="user-dropdown">
                    <div class="user-toggle">
                        <i class="fas fa-user"></i> ${sessionScope.login.fullName}
                        <i class="fas fa-caret-down"></i>
                    </div>
                    <div class="user-menu">
                        <a href="MainController?action=myOrders"><i class="fas fa-receipt"></i> Đơn mua</a>
                        <a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="header-bottom p-3">
        <div class="container inner-header-bottom row">
            <!-- Logo với hình giỏ hàng -->
            <div class="col-md-3">
                <div class="logo">
                    <a href="MainController?action=homePage" class="logo-link">
                        <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                        <span class="logo-text">Shoppy</span>
                    </a>
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
                    <a href="MainController?action=ViewCart" class="cart-icon">
                        <i class="fa fa-shopping-cart"></i>
                        <c:if test="${not empty sessionScope.cartId}">
                            <span class="cart-count">${sessionScope.cartSize}</span>
                        </c:if>
                        <c:if test="${empty sessionScope.cartId}">
                            <span class="cart-count">0</span>
                        </c:if>
                    </a>

                </c:if>
            </div>
        </div>

    </div>
</div>

