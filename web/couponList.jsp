<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO" %>
<%
    UserDTO loginUser = (UserDTO) session.getAttribute("login");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách mã giảm giá</title>
    <link rel="stylesheet" href="css/tableList.css">
</head>
<body>

<jsp:include page="headerList.jsp">
    <jsp:param name="page" value="coupons"/>
</jsp:include>

<div class="container">
    <div class="title">
        <h1>Danh sách mã giảm giá</h1>
    </div>

    <c:if test="${not empty MSG}">
        <div class="form-message success">${MSG}</div>
    </c:if>
    <c:if test="${not empty ERROR}">
        <div class="form-message error">${ERROR}</div>
    </c:if>

    <div class="search-create-wrapper">
        <form class="search-form" action="MainController" method="get">
            <input type="text" name="keyword" placeholder="Tìm kiếm mã giảm giá..." value="${param.keyword}" />
            <select name="status">
                <option value="">Tất cả</option>
                <option value="active" ${param.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Không hoạt động</option>
            </select>
            <button type="submit" name="action" value="searchCoupon">Tìm kiếm</button>
        </form>

        <a href="createCoupon.jsp">
            <button class="create-button" type="button">+ Thêm mã giảm giá mới</button>
        </a>
    </div>

    <c:if test="${not empty couponList}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Mã</th>
                    <th>Giảm (%)</th>
                    <th>Thời gian</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${couponList}">
                    <tr>
                        <td>${c.code}</td>
                        <td>${c.discountPercent}</td>
                        <td>${c.quantity}</td>
                        <td>${c.startDate} - ${c.endDate}</td>
                        <td>${c.status}</td>
                        <td>
                            <a class="action-link" href="MainController?action=updateCoupon&code=${c.code}">Sửa</a> |
                            <a class="action-link" href="MainController?action=deleteCoupon&code=${c.code}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty couponList}">
        <p>Không có mã giảm giá nào.</p>
    </c:if>
</div>

</body>
</html>
