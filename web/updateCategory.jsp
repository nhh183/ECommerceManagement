<%-- 
    Document   : updateCategory
    Created on : Jun 17, 2025, 9:39:15 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sửa Danh Mục</title>
    </head>
    <body>
        <h2>Sửa Danh Mục</h2>

        <form action="MainController" method="post">
            <input type="hidden" name="categoryID" value="${category.categoryID}">

            <label>Tên danh mục:</label>
            <input type="text" name="categoryName" value="${category.categoryName}" required><br><br>

            <label>Mô tả:</label>
            <textarea name="description" rows="4" cols="30">${category.description}</textarea><br><br>

            <button type="submit" name="action" value="updateCategory">Cập Nhật</button>
            <a href="MainController?action=searchCategory">Hủy</a>
        </form>
    </body>
</html>
