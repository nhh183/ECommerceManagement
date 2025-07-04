<%-- 
    Document   : header
    Created on : Jun 25, 2025, 3:55:35 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.NotificationDAO" %>
<%@ page import="dto.NotificationDTO" %>
<%@ page import="java.util.List" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<fmt:setLocale value="${sessionScope.lang != null ? sessionScope.lang : 'vi'}" scope="session"/>
<fmt:setBundle basename="messages"/>
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
.cart-container {
    position: relative;
    transform: scale(1.1);
}

.icon-cart:hover {
    transform: scale(1.4);
}

.cart-count {
    position: absolute;
    top: -8px;
    right:95px;
    background-color: #fff;
    color: orangered;
    border-radius: 40%;
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

.icon-cart {
  color: #fff;
  stroke: currentColor;
  fill: currentColor;
  width: 24px;
  height: 24px;
}
.popover-container {
  position: relative;
  display: inline-block;
}

.lang-button {
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  color: white;
  font-size: 14px;
}

.popover-box {
  position: absolute;
  top: 30px;
  right: 0;
  background: white;
  border: 1px solid rgba(0, 0, 0, 0.09);
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  border-radius: 4px;
  padding: 8px 0;
  display: none;
  z-index: 999;
  width: 150px;
}

.popover-container:hover .popover-box {
  display: block;
}

/* Mũi tên nhọn */
.popover-arrow {
  position: absolute;
  top: 1px;
  left: 50%;
  transform: translate(-7px, -100%);
  width: 0;
  height: 0;
  border-bottom: 10px solid rgba(0, 0, 0, 0.09);
  border-left: 0 solid transparent;
  border-right: 0 solid transparent;
}

.arrow-inner {
  position: absolute;
  bottom: -10px;
  border-bottom: 10px solid white;
  border-left: 14px solid transparent;
  border-right: 14px solid transparent;
}

/* Button chọn ngôn ngữ */
.lang-option {
  display: block;
  width: 100%;
  padding: 8px 16px;
  border: none;
  background: none;
  text-align: left;
  font-size: 14px;
  cursor: pointer;
  color: black;
}

.lang-option:hover {
  background-color: #f5f5f5;
}

.lang-option.active {
  color: #f53d2d;
  font-weight: bold;
}
.notification-container{position:relative;display:inline-block;margin-right:15px;color:white;}
.notification-toggle{display:flex;align-items:center;gap:5px;font-size:13px;cursor:pointer;}
.notification-toggle:hover{opacity:.9;}
.notification-dropdown{display:none;position:absolute;top:140%;right:0;min-width:260px;max-height:400px;overflow-y:auto;background:#fff;border-radius:8px;box-shadow:0 4px 12px rgba(0,0,0,.18);z-index:999;color:#333;}
.notification-container:hover .notification-dropdown{display:block;}
.notification-item{padding:10px 12px;border-bottom:1px solid #f0f0f0;font-size:13px;line-height:1.4;text-decoration:none;display:block;color:#333;}
.notification-item:last-child{border-bottom:none;}
.notification-item.unread{background:#fff4ef;font-weight:600;}
.notification-empty{padding:20px;text-align:center;font-size:14px;color:#777;}

</style>

<%
if (session.getAttribute("login") != null && request.getAttribute("notificationList") == null) {
    UserDTO loginUserTemp = (UserDTO) session.getAttribute("login");
    NotificationDAO dao = new NotificationDAO();
    List<NotificationDTO> list = dao.getNotificationsByUser(loginUserTemp.getUserID());
    request.setAttribute("notificationList", list);
}
%>

<div class="header sticky-top">
    <div class="header-top">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="header-top-left">
                <ul class="header-nav-list">
                    <!-- Mục cho CS -->
                    <c:if test="${sessionScope.login.roleID == 'CS'}">
                        <li><a class="header-link" href="MainController?action=activateSeller">
                                <i class="fas fa-user-check"></i> <fmt:message key="header.activateSeller"/>
                            </a></li>
                        </c:if>

                    <!-- Mục cho SELLER -->
                    <c:if test="${sessionScope.login.roleID == 'SL'}">
                        <li><a class="header-link" href="MainController?action=productList">
                                <i class="fas fa-box-open"></i> <fmt:message key="header.myProducts"/>
                            </a></li>
                        <li><a class="header-link" href="MainController?action=myOrders">
                                <i class="fas fa-receipt"></i> <fmt:message key="header.myOrders"/>
                        </c:if>

                    <c:if test="${sessionScope.login.roleID == 'AD'}">
                        <li><a href="MainController?action=productList" class="header-link">
                                <i class="fas fa-chart-line"></i> <fmt:message key="header.adminPage"/>
                            </a></li>
                        </c:if>
                </ul>
            </div>


            <div class="header-top-right">
                <div class="notification-container" onclick="location.href='MainController?action=notificationList'">
    <div class="notification-toggle">
        <i class="fas fa-bell"></i>  <fmt:message key="header.notification"/>
    </div>
    <div class="notification-dropdown">
        <c:choose>
            <c:when test="${empty notificationList}">
                <div class="notification-item"><fmt:message key="noti.nonoti"/></div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${notificationList}" var="n">
                    <div class="notification-item ${n.read ? '' : 'unread'}">
                        <b>${n.eventType}</b><br/>
                        ${n.message}<br/>
                        <small><fmt:formatDate value="${n.createdAt}" pattern="dd/MM/yyyy HH:mm"/></small>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>


                <a href="MainController?action=searchFAQ&sourcePage=support" class="header-link">
                    <i class="fas fa-circle-question"></i> <fmt:message key="header.support"/>
                </a>
                <div class="popover-container">
                    <div class="popover-target">
                        <div class="lang-button">
                            <!-- Icon địa cầu -->
                            <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                              <path d="M8 14.667C11.682 14.667 14.667 11.682 14.667 8S11.682 1.333 8 1.333 1.333 4.318 1.333 8 4.318 14.667 8 14.667Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" />
                              <path d="M5.333 8c0 3.682 1.194 6.667 2.667 6.667s2.667-2.985 2.667-6.667-1.194-6.667-2.667-6.667S5.333 4.318 5.333 8Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" />
                              <path d="M1.333 8h13.334" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" />
                            </svg>
                            <span>
                                <c:choose>
                                    <c:when test="${sessionScope.lang.language == 'en'}"><fmt:message key="lang.en"/></c:when>
                                    <c:otherwise><fmt:message key="lang.vi"/></c:otherwise>
                                </c:choose>
                            </span>
                            <!-- Mũi tên xuống -->
                            <svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor">
                              <path d="M6 8.146L11.146 3l.707.707-5.146 5.147a1 1 0 01-1.414 0L.146 3.707.854 3 6 8.146z"/>
                            </svg>
                        </div>
                    </div>

                    <!-- Popover hiển thị khi hover -->
                    <div class="popover-box">
                      <div class="popover-arrow">
                        <div class="arrow-inner"></div>
                      </div>
                        <a href="MainController?action=ChangeLanguage&lang=vi" class="lang-option ${sessionScope.lang.language == 'vi' ? 'active' : ''} text-decoration-none">Tiếng Việt</a>
                        <a href="MainController?action=ChangeLanguage&lang=en" class="lang-option ${sessionScope.lang.language == 'en' ? 'active' : ''} text-decoration-none">English</a>

                    </div>
              </div>

                <!-- Dropdown User -->
                <div class="user-dropdown">
                    <div class="user-toggle">
                        <i class="fas fa-user"></i> ${sessionScope.login.fullName}
                        <i class="fas fa-caret-down"></i>
                    </div>
                    <div class="user-menu">
                        <a href="MainController?action=searchDelivery"><i class="fas fa-receipt"></i>	<fmt:message key="header.purchaseOrders"/></a>
                        <a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> <fmt:message key="header.logout"/></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="header-bottom p-3 mt-1">
        <div class="container inner-header-bottom row">
            <!-- Logo với hình giỏ hàng -->
            <div class="col-md-3">
                <div class="logo">
                    <a href="MainController?action=homePage" class="logo-link">
                        <img src="images/logo_white.svg" alt="Shop Logo" class="svg w-75">
                    </a>
                </div>

            </div>

            <!-- Search Box -->
            <div class="col-md-6">
                <form action="MainController" method="GET" class="input-group">
                    <input type="text" name="name" class="form-control" placeholder="<fmt:message key="header.search.placeholder"/>">
                    <input type="hidden" name="action" value="searchProduct">
                    <div class="input-group-append">
                        <button class="btn btn-solid-primary search-btn" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                    </div>
                </form>
            </div>

            <!-- User Actions -->
            <div class="col-md-3 text-right">
                <c:if test="${not empty sessionScope.login}">
                    <a href="MainController?action=ViewCart" class="d-flex justify-content-center cart-container ">
                        <svg viewBox="0 0 26.6 25.6" width="32" height="32" fill="currentColor" stroke="currentColor" class="icon-cart">
                            <title>Shopping Cart</title>
                            <polyline fill="none" points="2 1.7 5.5 1.7 9.6 18.3 21.2 18.3 24.6 6.1 7 6.1" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10" stroke-width="2.5"/>
                            <circle cx="10.7" cy="23" r="2.2" stroke="none"/>
                            <circle cx="19.7" cy="23" r="2.2" stroke="none"/>
                        </svg>
                        <c:if test="${not empty sessionScope.cartId}">
                            <span class="cart-count ">${sessionScope.cartSize}</span>
                        </c:if>
                        <c:if test="${empty sessionScope.cartId}">
                            <span class="cart-count ">0</span>
                        </c:if>
                    </a>

                </c:if>
            </div>
        </div>

    </div>
</div>

