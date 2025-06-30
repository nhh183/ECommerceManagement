<%-- 
    Document   : deliveryList
    Created on : Jun 30, 2025, 1:57:48 AM
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
        <title>Danh sách giao hàng</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/footer.css">
        <link rel="stylesheet" href="css/delivery.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            .filter-form select {
                min-width: 200px;
            }
            .btn-orange {
                background-color: #ff5d00;
                color: white;
            }
            .btn-gray {
                background-color: #ccc;
                color: #333;
            }
        </style>
    </head>
    <body class="container-fluid px-0">
        <%@include file="header.jsp" %>

        <div class="container mt-4 px-5">
            <h2 class="mb-4 text-center" style="color: #c64600; font-weight: bold;">Danh Sách Giao Hàng</h2>

            <!-- FORM TÌM KIẾM -->
            <form action="MainController" method="get" class="row align-items-end filter-form mb-4">
                <input type="hidden" name="action" value="searchDelivery">

                <div class="col-md-4">
                    <input type="text" name="invoiceID" class="form-control" placeholder="Tìm theo InvoiceID" value="${param.invoiceID}">
                </div>

                <div class="col-md-4">
                    <label class="form-label">Trạng thái</label>
                    <select name="status" class="form-select">
                        <option value="">-- Tất cả --</option>
                        <option value="pending"    ${param.status=='pending' ? 'selected':''}>Pending</option>
                        <option value="preparing"  ${param.status=='preparing' ? 'selected':''}>Preparing</option>
                        <option value="delivering" ${param.status=='delivering' ? 'selected':''}>Delivering</option>
                        <option value="delivered"  ${param.status=='delivered' ? 'selected':''}>Delivered</option>
                    </select>
                </div>

                <div class="col-md-4 d-flex gap-2">
                    <button type="submit" class="btn btn-orange w-50">Tìm kiếm</button>
                    <a href="MainController?action=searchDelivery" class="btn btn-gray w-50">Hủy lọc</a>
                </div>
            </form>

            <!-- THÔNG BÁO -->
            <c:if test="${not empty sessionScope.MESSAGE}">
                <div class="alert alert-success">${sessionScope.MESSAGE}</div>
                <c:remove var="MESSAGE" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.ERROR}">
                <div class="alert alert-danger">${sessionScope.ERROR}</div>
                <c:remove var="ERROR" scope="session"/>
            </c:if>

            <!-- BẢNG DANH SÁCH -->
            <table class="table table-bordered table-hover bg-white">
                <thead class="table-warning text-center">
                    <tr>
                        <th>ID</th><th>Invoice</th><th>Địa chỉ</th>
                        <th>Ngày giao</th><th style="width: 180px;">Trạng thái</th><th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listDeliveries}">
                            <tr><td colspan="6" class="text-center text-muted">Không có đơn giao hàng nào.</td></tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="d" items="${listDeliveries}">
                                <tr>
                                    <td>${d.deliveryID}</td>
                                    <td>${d.invoiceID}</td>
                                    <td>${d.address}</td>
                                    <td><fmt:formatDate value="${d.deliveryDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <form action="UpdateDeliveryStatusController" method="post" class="d-flex">
                                            <input type="hidden" name="deliveryID" value="${d.deliveryID}"/>
                                            <select name="newStatus" class="form-select form-select-sm me-2">
                                                <option value="pending"
                                                        ${d.status == 'pending' ? 'selected' : ''}
                                                        ${d.status != 'pending' ? 'disabled' : ''}>Pending</option>

                                                <option value="preparing"
                                                        ${d.status == 'preparing' ? 'selected' : ''}
                                                        ${d.status == 'pending' ? '' : 'disabled'}>Preparing</option>

                                                <option value="delivering"
                                                        ${d.status == 'delivering' ? 'selected' : ''}
                                                        ${d.status == 'preparing' ? '' : 'disabled'}>Delivering</option>

                                                <option value="delivered"
                                                        ${d.status == 'delivered' ? 'selected' : ''}
                                                        ${d.status == 'delivering' || d.status == 'delivered' ? '' : 'disabled'}>Delivered</option>
                                            </select>
                                            <button class="btn btn-sm" style="background-color: #c64600; color: white;">Lưu</button>
                                        </form>
                                    </td>
                                    <td><!-- Tuỳ chọn thêm --></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <%@include file="footer.jsp" %>
    </body>
</html>
