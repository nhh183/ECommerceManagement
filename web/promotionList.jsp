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
        <title>Danh sách khuyến mãi</title>
        <link rel="stylesheet" href="css/tableList.css">
    </head>
    <body>

        <jsp:include page="headerList.jsp">
            <jsp:param name="page" value="promotions"/>
        </jsp:include>
        <div class="container">
            <div class="title">
                <h1>Danh sách khuyến mãi</h1>
            </div>

            <c:if test="${not empty MSG}">
                <div class="form-message success">${MSG}</div>
            </c:if>
            <c:if test="${not empty ERROR}">
                <div class="form-message error">${ERROR}</div>
            </c:if>

            <div class="search-create-wrapper">
                <form class="search-form" action="MainController" method="get">
                    <input type="text" name="keyword" placeholder="Tìm kiếm khuyến mãi..." value="${param.keyword}" />
                    <select name="status">
                        <option value="">Tất cả</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                    <button type="submit" name="action" value="searchPromotion">Tìm kiếm</button>
                </form>

                <a href="createPromotion.jsp">
                    <button class="create-button" type="button">+ Thêm khuyến mãi mới</button>
                </a>
            </div>

            <c:if test="${not empty promotionList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên</th>
                            <th>Giảm (%)</th>
                            <th>Thời gian</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${promotionList}">
                            <tr>
                                <td>${p.promoID}</td>
                                <td>${p.name}</td>
                                <td>${p.discountPercent}</td>
                                <td>${p.startDate} - ${p.endDate}</td>
                                <td>${p.status}</td>
                                <td>
                                    <a class="action-link" href="MainController?action=updatePromotion&id=${p.promoID}">Sửa</a> |
                                    <a class="action-link" href="MainController?action=deletePromotion&id=${p.promoID}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty promotionList}">
                <p>Không có chương trình khuyến mãi nào.</p>
            </c:if>
        </div>
    </body>
</html>
