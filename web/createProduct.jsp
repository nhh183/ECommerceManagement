<%-- 
    Document   : createProduct
    Created on : Jun 16, 2025, 11:26:45 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Product Page</title>
        <<link rel="stylesheet" href="css/form.css"/>
    </head>
    <body>

        <div class="wide-form-layout">
            <h2 class="form-title">Thêm sản phẩm</h2>
            <form action="CreateProductController" method="post" enctype="multipart/form-data" class="wide-form">

                <!-- Bên trái -->
                <div class="form-left">
                    <div class="form-group">
                        <label class="form-label">Tên sản phẩm <span>*</span></label>
                        <input type="text" name="name" class="form-input" placeholder="Nhập tên..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Giá <span>*</span></label>
                        <input type="number" name="price" class="form-input" min="0" step="0.01" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Ảnh sản phẩm <span>*</span></label>
                        <input type="file" name="image" class="form-file" accept="image/*" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-textarea" rows="5" placeholder="Mô tả sản phẩm..."></textarea>
                    </div>
                </div>

                <!-- Bên phải -->
                <div class="form-right">
                    <div class="form-group">
                        <label class="form-label">Danh mục <span>*</span></label>
                        <select name="categoryID" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.categoryID}">${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Số lượng <span>*</span></label>
                        <input type="number" name="quantity" class="form-input" min="1" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Trạng thái <span>*</span></label>
                        <select name="status" class="form-select" required>
                            <option value="active">Đang bán</option>
                            <option value="inactive">Ngừng bán</option>
                        </select>
                    </div>

                    <input type="hidden" name="sellerID" value="${loginUser.userID}" />
                </div>

                <!-- Nút -->
                <div class="form-bottom">
                    <button type="submit" class="form-button">+ Đăng sản phẩm</button>
                    <div>
                        <a href="MainController?action=searchProduct" class="form-cancel">Hủy</a>
                    </div>
                </div>
            </form>
        </div>




    </body>
</html>
