<%-- 
    Document   : createProduct
    Created on : Jun 16, 2025, 11:26:45 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Product Page</title>
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
        <h2>Thêm sản phẩm</h2>
        <c:if test="${not empty MSG}">
            <p style="color: green">${MSG}</p>
        </c:if>

        <c:if test="${not empty ERROR}">
            <p style="color: red">${ERROR}</p>
        </c:if>
        <form action="CreateProductController" method="post" enctype="multipart/form-data">
            Tên: <input type="text" name="name" required/><br/>
            Danh mục:
            <select name="categoryID">
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryID}">${cat.categoryID} -${cat.categoryName}</option>
                </c:forEach>
            </select><br/>
            Giá: <input type="number" name="price" step="0.01" min="0" required/><br/>
            Số lượng: <input type="number" name="quantity" step="1" min="1" required/><br/>
            Seller ID: <input type="text" name="sellerID" value="${loginUser.userID}" readonly/><br/>
            Ảnh sản phẩm: <input type="file" name="image" accept="image/*" required/><br/>
            Trạng thái:
            <select name="status" required>
                <option value="active">Đang bán</option>
                <option value="inactive">Ngừng bán</option>
            </select><br/>

            <button type="submit">Đăng sản phẩm</button>
        </form>
    </body>
</html>
