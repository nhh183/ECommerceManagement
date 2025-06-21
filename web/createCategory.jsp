<%-- 
    Document   : createCategory
    Created on : Jun 17, 2025, 9:37:20 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Danh Mục</title>
    </head>
    <body>
        <h2>Thêm Danh Mục Mới</h2>
        <form action="MainController" method="post">
            <label>Tên danh mục:</label>
            <input type="text" name="categoryName" required><br><br>

            <label>Mô tả:</label>
            <textarea name="description" rows="4" cols="30"></textarea><br><br>

            <button type="submit" name="action" value="createCategory">Thêm</button>
            <a href="MainController?action=searchCategory">Hủy</a>
        </form>
    </body>
</html>
