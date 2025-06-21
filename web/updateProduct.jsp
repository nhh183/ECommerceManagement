<%-- 
    Document   : updateProductController
    Created on : Jun 16, 2025, 9:48:03 PM
    Author     : User
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật sản phẩm</title>
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

        <h2>Cập nhật sản phẩm</h2>

        <c:if test="${not empty MSG}">
            <p style="color: green">${MSG}</p>
        </c:if>

        <c:if test="${not empty ERROR}">
            <p style="color: red">${ERROR}</p>
        </c:if>

        <form action="UpdateProductController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productID" value="${product.productID}" />

            Tên: <input type="text" name="name" value="${product.name}" required/><br/>

            Danh mục:
            <select name="categoryID">
                <option value="">-- Chọn danh mục --</option>
                <c:forEach var="cat" items="${categoryList}">
                    <option value="${cat.categoryID}" <c:if test="${cat.categoryID == product.categoryID}">selected</c:if>>
                        ${cat.categoryName}
                    </option>

                </c:forEach>
            </select><br/>

            Giá:
            <input type="number" name="price" step="0.01" min="0" value="${product.price}" required/><br/>

            Số lượng: <input type="number" name="quantity" step="1" min="1" value="${product.quantity}" required/><br/>

            Seller ID: <input type="text" name="sellerID" value="${loginUser.userID}" readonly/><br/>

            Ảnh sản phẩm (chọn nếu muốn thay): 
            <input type="file" name="image" accept="image/*" /><br/>
            <input type="hidden" name="oldImageUrl" value="${product.imgUrl}" />
            <c:if test="${not empty product.imgUrl}">
                <img src="${pageContext.request.contextPath}/${product.imgUrl}" alt="Ảnh sản phẩm" width="150"/>
            </c:if>
            <br/>

            Trạng thái:
            <select name="status" required>
                <option value="active" ${product.status == 'active' ? 'selected' : ''}>Đang bán</option>
                <option value="inactive" ${product.status == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
            </select><br/>

            <button type="submit">Cập nhật sản phẩm</button>
        </form>

    </body>
</html>

