<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO" %>
<%
    UserDTO loginUser = (UserDTO) session.getAttribute("login");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("loginUser", loginUser);
    String action = request.getParameter("action");
    if (action == null) action = "searchCategory";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách danh mục</title>
    <link rel="stylesheet" href="css/tableList.css">
</head>
<body>

<header class="main-header">
    <nav class="main-nav">
        <div class="header-left">
            <a href="homePage.jsp" class="<%= "home".equals(action) ? "active" : "" %>">Trang chủ</a>
            <a href="MainController?action=searchProduct" class="<%= "searchProduct".equals(action) ? "active" : "" %>">Danh sách sản phẩm</a>
            <a href="MainController?action=searchCategory" class="<%= "searchCategory".equals(action) ? "active" : "" %>">Danh sách danh mục</a>
        </div>
        <div class="header-right">
            <a href="MainController?action=logout">Logout</a>
        </div>
    </nav>
</header>

<div class="container">
    <div class="title">
        <h1>Danh mục sản phẩm</h1>
    </div>

    <c:if test="${not empty MSG}">
        <p class="message-success">${MSG}</p>
    </c:if>

    <c:if test="${not empty ERROR}">
        <p class="message-error">${ERROR}</p>
    </c:if>

    <form class="search-form" action="MainController" method="get">
        <input type="text" name="keyword" placeholder="Tìm kiếm danh mục..." value="${param.keyword}" />
        <button type="submit" name="action" value="searchCategory">Tìm kiếm</button>
    </form>

    <c:if test="${not empty categoryList}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Mô tả</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${categoryList}">
                    <tr>
                        <td>${c.categoryID}</td>
                        <td>${c.categoryName}</td>
                        <td>${c.description}</td>
                        <td>
                            <a class="action-link" href="MainController?action=updateCategory&id=${c.categoryID}">Sửa</a> |
                            <a class="action-link" href="MainController?action=deleteCategory&id=${c.categoryID}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>

    <c:if test="${empty categoryList}">
        <p>Không tồn tại danh mục.</p>
    </c:if>

    <div style="text-align: center; margin-top: 30px;">
        <a href="createCategory.jsp">
            <button class="create-button" type="button">+ Thêm danh mục mới</button>
        </a>
    </div>
</div>

</body>
</html>
