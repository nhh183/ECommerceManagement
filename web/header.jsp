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
                <a href="notification.jsp" class="header-link">
                    <i class="fas fa-bell"></i> Thông báo
                </a>
                <a href="support.jsp" class="header-link">
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

