<%-- 
    Document   : returnList
    Created on : Jun 30, 2025, 7:44:58 PM
    Author     : loan1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
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
    <title>Danh sách yêu cầu trả hàng</title>

    <!-- BOOTSTRAP & ICONS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- STYLE DÙNG CHUNG (giống delivery) -->
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/delivery.css"><!-- dùng lại để đồng bộ màu bảng -->

    <style>
        th, td { vertical-align: middle; }
        .alert-pos { margin-top: 10px; }
    </style>
</head>

<body class="container-fluid px-0">
    <%@ include file="header.jsp" %>

    <div class="container my-4 px-5" id="top">
        <h2 class="mb-4 text-center" style="color:#c64600;font-weight:bold;">Danh Sách Yêu Cầu Trả Hàng</h2>

        <!-- THÔNG BÁO -->
        <c:if test="${not empty sessionScope.MESSAGE}">
            <div class="alert alert-success alert-pos">${sessionScope.MESSAGE}</div>
            <c:remove var="MESSAGE" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.ERROR}">
            <div class="alert alert-danger alert-pos">${sessionScope.ERROR}</div>
            <c:remove var="ERROR" scope="session"/>
        </c:if>

        <!-- BẢNG DANH SÁCH -->
        <table class="table table-bordered table-hover bg-white">
            <thead class="table-warning text-center">
                <tr>
                    <th>ID</th>
                    <th>Invoice ID</th>
                    <th>Lý do</th>
                    <th style="width:180px;">Trạng thái</th>
                    <th>Ngày gửi</th>
                </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty RETURN_LIST}">
                    <tr><td colspan="5" class="text-center text-muted">Không có yêu cầu trả hàng nào.</td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="r" items="${RETURN_LIST}">
                        <tr>
                            <td>${r.returnID}</td>
                            <td>${r.invoiceID}</td>
                            <td>${r.reason}</td>

                            <!-- Cột trạng thái – AD & SL có thể chỉnh, các role khác chỉ xem -->
                            <td>
                                <c:choose>
                                    <c:when test="${loginUser.roleID=='AD' || loginUser.roleID=='SL'}">
                                        <form action="MainController#top" method="post" class="d-flex">
                                            <input type="hidden" name="action" value="updateReturnStatus"/>
                                            <input type="hidden" name="returnID" value="${r.returnID}"/>

                                            <select name="newStatus" class="form-select form-select-sm me-2">
                                                <option value="pending"  ${r.status=='pending'  ? 'selected':''}>Pending</option>
                                                <option value="approved" ${r.status=='approved' ? 'selected':''}>Approved</option>
                                                <option value="rejected" ${r.status=='rejected' ? 'selected':''}>Rejected</option>
                                            </select>
<button class="btn btn-sm" style="background-color: #c64600; color: white;">Lưu</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        ${r.status}
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <fmt:formatDate value="${r.returnDate}" pattern="yyyy-MM-dd"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
