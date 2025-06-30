<%-- 
    Document   : notificationList
    Created on : Jun 30, 2025, 1:58:07 PM
    Author     : loan1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dto.UserDTO" %>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("login");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("loginUser", loginUser);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông báo của bạn</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/footer.css">
        <style>
            .btn-orange {
                background-color: #ff5d00;
                color: white;
            }
            .btn-gray {
                background-color: #ccc;
                color: #333;
            }
            .fw-bold {
                font-weight: bold;
            }
        </style>
    </head>
    <body class="container-fluid px-0">
        <%@include file="header.jsp" %>

        <div class="container mt-4 px-5">
            <h2 class="mb-4 text-center" style="color: #c64600; font-weight: bold;">Danh Sách Thông Báo</h2>

            <!-- THÔNG BÁO -->
            <c:if test="${not empty sessionScope.MESSAGE}">
                <div class="alert alert-success">${sessionScope.MESSAGE}</div>
                <c:remove var="MESSAGE" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.ERROR}">
                <div class="alert alert-danger">${sessionScope.ERROR}</div>
                <c:remove var="ERROR" scope="session"/>
            </c:if>

            <!-- BẢNG THÔNG BÁO -->
            <table class="table table-bordered table-hover bg-white">
                <thead class="table-warning text-center">
                    <tr>
                        <th>#</th>
                        <th>Loại</th>
                        <th>Nội dung</th>
                        <th>Thời gian</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty notificationList}">
                            <tr><td colspan="6" class="text-center text-muted">Không có thông báo nào.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="n" items="${notificationList}" varStatus="loop">
                                <tr class="${n.read ? '' : 'fw-bold'}">
                                    <td>${loop.count}</td>
                                    <td>${n.eventType}</td>
                                    <td>${n.message}</td>
                                    <td><fmt:formatDate value="${n.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${n.read}">Đã đọc</c:when>
                                            <c:otherwise>Chưa đọc</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex gap-1 justify-content-center">
                                            <c:if test="${!n.read}">
                                                <form action="MainController" method="post">
                                                    <input type="hidden" name="actionF" value="markAsRead"/>
                                                    <input type="hidden" name="notificationID" value="${n.notificationID}"/>
                                                    <button class="btn btn-sm" style="background-color: #c64600; color: white;">Đánh dấu</button>
                                                </form>
                                            </c:if>
                                            <form action="MainController" method="get">
                                                <input type="hidden" name="action" value="deleteNotification"/>
                                                <input type="hidden" name="notificationID" value="${n.notificationID}"/>
                                                <button class="btn btn-sm" style="background:#ccc;color:#333;">Xóa</button>
                                            </form>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <c:if test="${loginUser.roleID == 'AD' || loginUser.roleID == 'SL'}">
                <a href="addNotification.jsp" class="btn btn-warning mb-3">+ Gửi Thông Báo</a>
            </c:if>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
