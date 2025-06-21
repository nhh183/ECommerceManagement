<%-- 
    Document   : categoryList
    Created on : Jun 17, 2025, 8:43:01 PM
    Author     : User
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Danh Mục</title>
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
        <h2>Danh Sách Danh Mục</h2>
        <form action="MainController" method="get">
            <input type="text" name="keyword" placeholder="Tìm kiếm..." />
            <button type="submit" name="action" value="searchCategory" >Tìm Kiếm</button>
        </form>

        <c:if test="${not empty MSG}">
            <p style="color: green">${MSG}</p>
        </c:if>

        <c:if test="${not empty ERROR}">
            <p style="color: red">${ERROR}</p>
        </c:if>

        <c:if test="${not empty categoryList}">
            <table border="1" cellpadding="5" cellspacing="0">
                <tr>
                    <th>ID</th>
                    <th>Tên danh mục</th>
                    <th>Mô tả</th>
                    <th>Hành động</th>

                </tr>
                <c:forEach var="c" items="${categoryList}">
                    <tr>
                        <td>${c.categoryID}</td>
                        <td>${c.categoryName}</td>
                        <td>${c.description}</td>      
                        <td>
                            <a href="MainController?action=updateCategory&id=${c.categoryID}">Sửa</a> |
                            <a href="MainController?action=deleteCategory&id=${c.categoryID}"
                               onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                        </td>

                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <c:if test="${empty categoryList}">
            <p>Không tồn tại danh mục.</p>
        </c:if>


        <a href="createCategory.jsp">Thêm danh mục mới</a>


    </body>
</html>
