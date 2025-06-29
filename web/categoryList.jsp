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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách danh mục</title>
        <link rel="stylesheet" href="css/tableList.css">
    </head>
    <body>
        <div class="header">
            <div class="header-top">

            </div>

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
                    <a href="MainController?action=homePage">HOME</a>
                    <a href="MainController?action=productList">Danh Sách Sản Phẩm</a>
                    <a href="MainController?action=searchCategory" class="active">Danh Sách Danh Mục</a>
                    <a href="MainController?action=searchUser">Danh Sách Khách Hàng</a>
                    <a href="MainController?action=searchFAQ&sourcePage=faqList">Danh sách FAQ</a>
                </div>
                <div class="header-right">
                    <a href="MainController?action=logout">Đăng Xuất</a>
                </div>
            </nav>
        </header>

        <div class="container">
            <div class="title">
                <h1>Danh mục sản phẩm</h1>
            </div>

            <c:if test="${not empty MSG}">
                <div class="form-message success">${MSG}</div>
            </c:if>

            <c:if test="${not empty ERROR}">
                <div class="form-message error">${ERROR}</div>
            </c:if>

            <div class="search-create-wrapper">
                <form class="search-form" action="MainController" method="get">
                    <input type="text" name="keyword" placeholder="Tìm kiếm danh mục..." value="${param.keyword}" />
                    <button type="submit" name="action" value="searchCategory">Tìm kiếm</button>
                </form>

                <a href="createCategory.jsp">
                    <button class="create-button" type="button">+ Thêm danh mục mới</button>
                </a>
            </div>


            <c:if test="${not empty categoryList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên danh mục</th>
                            <th>Ảnh</th>
                            <th>Mô tả</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${categoryList}">
                            <tr>
                                <td>${c.categoryID}</td>
                                <td>${c.categoryName}</td>
                                <td>
                                    <c:if test="${not empty c.imgUrl}">
                                        <img src="${pageContext.request.contextPath}/${c.imgUrl}?t=${now.time}" class="form-img" alt="Ảnh danh mục"/>
                                    </c:if>
                                </td>
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

        </div>

    </body>
</html>
