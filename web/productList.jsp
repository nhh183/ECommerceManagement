
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    if (action == null) action = "searchProduct";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách sản phẩm</title>
        <style>
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #ffffff;
            }

            /* === HEADER === */
            .main-header {
                background-color: #c64600;
                color: white;
                padding: 19px 10px;
            }

            .main-nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #c64600;
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

            /* === CONTENT WRAPPER === */
            .container {
                max-width: 1300px;
                margin: 20px auto;
                padding: 0 20px;
            }

            .title {
                text-align: center;
                margin: 30px 0;
            }

            .title h1 {
                color: #c64600;
                font-size: 28px;
                font-weight: bold;
                margin: 0;
            }

            /* === FORM === */
            .search-form.horizontal {
                padding: 15px 20px;
                display: flex;
                align-items: center;
                flex-wrap: wrap;
                gap: 12px;
                margin-bottom: 25px;
            }

            .search-form.horizontal input[type="text"],
            .search-form.horizontal input[type="number"],
            .search-form.horizontal select {
                padding: 8px 12px;
                border: 1px solid black;
                background-color: #fff;
                min-width: 120px;
                font-size: 14px;
                color: #333;
            }

            .search-form.horizontal input[type="text"]::placeholder {
                color: #999;
            }

            .search-form.horizontal button {
                background-color: #c64600;
                color: white;
                border: none;
                padding: 9px 16px;
                border-radius: 4px;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .search-form.horizontal button:hover {
                background-color: #e25500;
            }

            /* === TABLE === */
            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background-color: white;
                border: 1px solid #e0e0e0;
                border-radius: 6px;
                overflow: hidden;
            }

            table th,
            table td {
                padding: 12px 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
                border-right: 1px solid #ddd;
            }

            table th:last-child,
            table td:last-child {
                border-right: none;
            }

            table th {
                background-color: #c64600;
                color: white;
                font-weight: bold;
                text-align: center;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #fff3e0;
            }

            img.product-img {
                border-radius: 5px;
                width: 100px;
            }

            /* === MESSAGES === */
            .message-success {
                color: green;
                font-weight: bold;
            }

            .message-error {
                color: red;
                font-weight: bold;
            }

            /* === ACTION LINK === */
            .action-link {
                color: #c64600;
                font-weight: bold;
                text-decoration: none;
            }

            .action-link:hover {
                text-decoration: underline;
            }

            /* === CREATE BUTTON === */
            .create-button {
                background-color: #c64600;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .create-button:hover {
                background-color: #e25500;
            }

        </style>
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
                    <a href="MainController?action=searchProduct">Logout</a>
                </div>

            </nav>
        </header>

        <div class="container">
            <div class="title">
                <h1>
                    <c:choose>
                        <c:when test="${loginUser.roleID=='AD'}">Quản Lý Sản Phẩm</c:when>
                        <c:otherwise>Sản Phẩm Của Tôi</c:otherwise>
                    </c:choose>
                </h1>
            </div>


            <c:if test="${not empty MSG}">
                <p class="message-success">${MSG}</p>
            </c:if>

            <c:if test="${not empty ERROR}">
                <p class="message-error">${ERROR}</p>
            </c:if>

            <form class="search-form horizontal" action="MainController" method="get">
                <input type="hidden" name="sellerID" value="<%= loginUser.getUserID()%>"/>
                <input type="hidden" name="sourcePage" value="productList" />

                <input type="text" name="name" placeholder="Tên sản phẩm..." value="${param.name}" />

                <select name="categoryID">
                    <option value="">Tất cả danh mục</option>
                    <c:forEach var="c" items="${categoryList}">
                        <option value="${c.categoryID}" ${param.categoryID == c.categoryID ? 'selected' : ''}>
                            ${c.categoryName}
                        </option>
                    </c:forEach>
                </select>

                <input type="number" name="minPrice" step="0.01" min="0" value="${param.minPrice}" placeholder="Giá từ" />
                <input type="number" name="maxPrice" step="0.01" min="0" value="${param.maxPrice}" placeholder="Đến" />

                <select name="status">
                    <option value="">Tất cả trạng thái</option>
                    <option value="active" ${param.status == 'active' ? 'selected' : ''}>Đang bán</option>
                    <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
                </select>

                <button type="submit" name="action" value="searchProduct">Tìm kiếm</button>
            </form>



            <c:if test="${not empty productList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Người bán</th>
                            <th>Ảnh</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
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
                                <td>
                                    <c:if test="${not empty p.imgUrl}">
                                        <img src="${pageContext.request.contextPath}/${p.imgUrl}" class="product-img" alt="Ảnh sản phẩm"/>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 'active'}">Đang bán</c:when>
                                        <c:otherwise>Ngừng bán</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a class="action-link" href="MainController?action=updateProduct&id=${p.productID}">Sửa</a> |
                                    <a class="action-link" href="MainController?action=deleteProduct&id=${p.productID}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty productList}">
                <p>Không tồn tại sản phẩm.</p>
            </c:if>

            <!-- Nút đăng sản phẩm mới ở cuối -->
            <div style="text-align: center; margin-top: 30px;">
                <form action="MainController" method="POST">
                    <button type="submit" name="action" value="createProduct" class="create-button">
                        + Đăng sản phẩm mới
                    </button>
                </form>
            </div>

        </div>
    </body>
</html>
