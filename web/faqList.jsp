
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO" %>
<%@page import="dto.FAQDTO" %>
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
        <title>Danh sách FAQ</title>
        <link rel="stylesheet" href="css/tableList.css">
    </head>
    <body>
        <div class="header">
            <div class="header-top">
                <div class="logo">
                    <img src="images/shop.jpg" alt="Logo" class="logo-img"> Shoppy
                </div>
                <div class="welcome-text">
                    Welcome, ${sessionScope.login.fullName}!
                </div>
            </div>
        </div>

        <header class="main-header">
            <nav class="main-nav">
                <div class="header-left">
                    <a href="MainController?action=homePage">HOME</a>
                    <a href="MainController?action=productList">Danh Sách Sản Phẩm</a>
                    <a href="MainController?action=searchCategory">Danh Sách Danh Mục</a>
                    <a href="MainController?action=searchUser">Danh Sách Khách Hàng</a>
                    <a href="MainController?action=searchFAQ&sourcePage=faqList" class="active">Danh sách FAQ</a>
                </div>
                <div class="header-right">
                    <a href="MainController?action=logout">Đăng xuất</a>
                </div>
            </nav>
        </header>

        <div class="container">
            <div class="title">
                <h1>Quản Lý Câu Hỏi Thường Gặp (FAQ)</h1>
            </div>

            <c:if test="${not empty MSG}">
                <div class="form-message success">${MSG}</div>
            </c:if>
            <c:if test="${not empty ERROR}">
                <div class="form-message error">${ERROR}</div>
            </c:if>

            <div class="search-create-wrapper">
                <!-- Form tìm kiếm -->
                <form class="search-form" action="MainController" method="post">
                    <input type="hidden" name="sourcePage" value="faqList"/>
                    <input type="text" name="keyword" placeholder="Từ khóa câu hỏi..." value="${param.keyword}" />
                    <select name="status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="active" ${param.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                        <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Ngừng hoạt động</option>
                    </select>
                    <button type="submit" name="action" value="searchFAQ">Tìm kiếm</button>
                </form>

                <!-- Nút tạo FAQ -->              
                <a href="createFAQ.jsp">
                    <button class="create-button" type="button">+ Thêm FAQ mới</button>
                </a>
            </div>

            <c:if test="${not empty faqList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Câu hỏi</th>
                            <th>Trả lời</th>
                            <th>Trạng thái</th>
                            <th>Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="f" items="${faqList}">
                            <tr>
                                <td>${f.faqID}</td>
                                <td>${f.question}</td>
                                <td>${f.answer}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${f.status == 'active'}">Hoạt động</c:when>
                                        <c:otherwise>Ngừng hoạt động</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a class="action-link" href="MainController?action=updateFAQ&id=${f.faqID}">Sửa</a> |
                                    <a class="action-link" href="MainController?action=deleteFAQ&id=${f.faqID}" onclick="return confirm('Bạn có chắc muốn xóa FAQ này không?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty faqList}">
                <p>Không có FAQ nào.</p>
            </c:if>
        </div>
    </body>
</html>
