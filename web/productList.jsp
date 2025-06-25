
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

            <form class="search-form" action="MainController" method="get">
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
                            <th>Mô tả</th>
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
                                        <img src="${pageContext.request.contextPath}/${p.imgUrl}?t=${now.time}" class="product-img" alt="Ảnh sản phẩm"/>
                                    </c:if>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 'active'}">Đang bán</c:when>
                                        <c:otherwise>Ngừng bán</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="description-cell" title="${p.description}">
                                    ${p.description}
                                </td>

                                <td>
                                    <a class="action-link" href="MainController?action=updateProduct&id=${p.productID}">Sửa</a> |
                                    <a class="action-link" href="MainController?action=deleteProduct&id=${p.productID}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>|
                                    <a class="action-link" href="ViewProductController?id=${p.productID}">xem sản phẩm</a> |
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty productList}">
                <p>Không tồn tại sản phẩm.</p>
            </c:if>

            <div style="text-align: center; margin-top: 30px;">
                <form action="MainController" method="GET">
                    <input type="hidden" name="action" value="createProduct" />
                    <button type="submit" class="create-button">
                        + Đăng sản phẩm mới
                    </button>
                </form>
            </div>

        </div>
    </body>
</html>
