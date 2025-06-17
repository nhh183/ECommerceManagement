<%-- 
    Document   : productList
    Created on : Jun 16, 2025, 1:44:32 PM
    Author     : User
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>

        <%
                UserDTO loginUser = (UserDTO) session.getAttribute("login");
                if (loginUser == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                request.setAttribute("loginUser", loginUser);
        %>

        <h2>
            <c:choose>
                <c:when test="${loginUser.roleID=='AD'}">Danh sách sản phẩm</c:when>
                <c:otherwise>Danh sách sản phẩm của tôi</c:otherwise>
            </c:choose>
        </h2>
        <c:if test="${not empty MSG}">
            <p style="color: green">${MSG}</p>
        </c:if>

        <c:if test="${not empty ERROR}">
            <p style="color: red">${ERROR}</p>
        </c:if>
        <form action="MainController" method="get">
            <input type="hidden" name="sellerID" value="<%= loginUser.getUserID()%>"/>
            <input type="hidden" name="sourcePage" value="productList" />

            <input type="text" name="name" placeholder="Tìm kiếm...." value="${param.name}"/>

            Danh mục:
            <select name="categoryID">
                <option value="">Tất cả</option>
                <c:forEach var="c" items="${categoryList}">
                    <option value="${c.categoryID}" ${param.categoryID == c.categoryID ? 'selected' : ''}>
                        ${c.categoryName}
                    </option>
                </c:forEach>
            </select>

            Giá từ: <input type="number" name="minPrice" step="0.01" min="0" value="${param.minPrice}" />
            đến: <input type="number" name="maxPrice" step="0.01" min="0" value="${param.maxPrice}" />

            Trạng thái:
            <select name="status">
                <option value="">Tất cả</option>
                <option value="active" ${param.status == 'active' ? 'selected' : ''}>Đang bán</option>
                <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
            </select>

            <button type="submit" name="action" value="searchProduct" >Tìm kiếm</button>
        </form>
        <c:if test="${not empty productList}">
            <table border="1" cellpadding="5" cellspacing="0">
                <tr>
                    <th>ID</th>
                    <th>Tên sản phẩm</th>
                    <th>Danh mục</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Người bán</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
                <c:forEach var="p" items="${productList}">

                    <tr>
                        <td>${p.productID}</td>
                        <td>${p.name}</td>
                        <td>
                            <c:forEach var="c" items="${categoryList}">
                                <c:if test="${c.categoryID == p.categoryID}">
                                    ${c.categoryName}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" /></td>
                        <td>${p.quantity}</td>
                        <td>${p.sellerID}</td>
                        <td><c:choose>
                                <c:when test="${p.status == 'active'}">Đang bán</c:when>
                                <c:otherwise>Ngừng bán</c:otherwise>
                            </c:choose></td>
                        <td>
                            <a href="MainController?action=updateProduct&id=${p.productID}">Sửa</a> |
                            <a href="MainController?action=deleteProduct&id=${p.productID}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        <c:if test="${empty productList}">
            <p>Không tồn tại sản phẩm.</p>
        </c:if>
        <a href="MainController?action=createProduct">Đăng bán sản phẩm</a> 
    </body>
</html>
