<%-- 
    Document   : createProduct
    Created on : Jun 16, 2025, 11:26:45 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Product Page</title>
    </head>
    <body>
        <h2>Thêm sản phẩm</h2>
        <form action="MainController" method="post" enctype="multipart/form-data">
            Tên: <input type="text" name="name" required/><br/>
            Danh mục:
            <select name="categoryID" required>
                <c:forEach var="c" items="${categoryList}">
                    <option value="${c.categoryID}">${c.categoryName}</option>
                </c:forEach>
            </select><br/>
            Giá: <input type="number" name="price" step="0.01" min="0" required/><br/>
            Số lượng: <input type="number" name="quantity" step="1" min="1" required/><br/>
            Seller ID: <input type="text" name="sellerID" /><br/>
            Ảnh sản phẩm: <input type="file" name="image" accept="image/*" required/><br/>
            Trạng thái:
            <select name="status" required>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
            </select><br/>
            <button name="action" value="CreateProductController">Đăng sản phẩm</button>
        </form>
    </body>
</html>
