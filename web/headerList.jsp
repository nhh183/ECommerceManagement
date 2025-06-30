<%-- 
    Document   : headerList
    Created on : Jun 30, 2025, 5:03:15 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dto.UserDTO" %>

<c:set var="loginUser" value="${sessionScope.login}" />


<style>
    /* === HEADER === */
    .header {
        border-bottom: none;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        background: linear-gradient(180deg, rgba(253, 29, 29, 1) 0%, rgba(255, 121, 43, 1) 100%);
        padding-bottom: 10px;
    }

    .header-top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px;
    }

    .header-top-right {
        text-align: right;
        margin-right: 20px;
    }

    .welcome-text {
        color: white;
        font-weight: bold;
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
    }

    .header-top-left {
        display: flex;
        align-items: center;
        margin-left: 20px;
    }

    .logo {
        display: flex;
        align-items: center;
        gap: 10px;
        color: white;
        font-size: 28px;
        font-weight: bold;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.5);
    }

    .logo-img {
        width: 45px;
        height: 45px;
        filter: drop-shadow(0 2px 3px rgba(0, 0, 0, 0.3));
    }

    /* ===MAIN HEADER === */
    .main-header {
        position: sticky;
        top: 0;
        z-index: 999;
        background: linear-gradient(to right, #D95400, #E55D00);
        color: white;
        padding: 19px 10px;
    }



    .main-nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: linear-gradient(to right, #D95400, #E55D00);
        flex-wrap: wrap;
    }

    .header-left a,
    .header-right a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        padding: 20px 12px;
        transition: background 0.3s;
    }

    .header-left a:hover,
    .header-right a:hover,
    .header-left a.active {
        background-color: white;
        color: #c64600;
    }

</style>

<c:set var="page" value="${param.page}" />
<div class="header">
    <div class="header-top"></div>
    <div class="header-top">
        <div class="header-top-left">
            <div class="logo">
                <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                Shoppy
            </div>
        </div>
        <div class="header-top-right">
            <span class="welcome-text">Welcome, ${sessionScope.login.fullName}!</span>
        </div>
    </div>
</div>

<header class="main-header">
    <nav class="main-nav">
        <div class="header-left">
            <a href="MainController?action=homePage" class="${page == 'home' ? 'active' : ''}">HOME</a>
            <a href="MainController?action=productList" class="${page == 'products' ? 'active' : ''}">Sản phẩm</a>
            <c:if test="${loginUser.roleID == 'AD'}">
                <a href="MainController?action=searchCategory" class="${page == 'categories' ? 'active' : ''}">Danh mục</a>
                <a href="MainController?action=searchPromotion" class="${page == 'promotions' ? 'active' : ''}">Khuyến mãi</a>
                <a href="MainController?action=searchPromotionProduct" class="${page == 'promotionProduct' ? 'active' : ''}">Sản phẩm-Khuyến mãi</a>
                <a href="MainController?action=searchUser" class="${page == 'users' ? 'active' : ''}">Khách hàng</a>
                <a href="MainController?action=searchFAQ"${page == 'faqs' ? 'active' : ''}">FAQ</a>
            </c:if>
        </div>
        <div class="header-right">
            <a href="MainController?action=logout">Đăng xuất</a>
        </div>
    </nav>
</header>


