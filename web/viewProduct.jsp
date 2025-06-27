<%-- 
    Document   : viewProduct
    Created on : Jun 23, 2025, 3:51:59 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dto.UserDTO" %>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("login");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("loginUser", loginUser);
    String action = request.getParameter("action");
    if (action == null) action = "viewProduct";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem chi tiết sản Phẩm</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/viewProduct.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <--<!-- Product Section -->
        <div class="container my-5">
            <div class="row product-container">
                <div class="col-md-4 product-image">
                    <img src="${product.imgUrl}" alt="${product.name}">
                </div>
                <div class="col-md-6">
                    <div class="product-details">
                        <div class="product-name">${product.name}</div>

                        <div class="product-rating">
                            <span>★★★★☆ (4.2/5)</span> | <a href="#reviews">45 đánh giá</a>
                        </div>
                    </div>
                    <div class="price-container">
                        <span class="product-price">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> ₫
                        </span>
                        <span class="product-sale-price">
                            <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> ₫
                        </span>
                    </div>

                    <div class="product-quantity">Số lượng còn: <strong>${product.quantity}</strong></div>

                    <div class="quantity-select">
                        <label for="quantity">Chọn số lượng:</label>
                        <div class="quantity-box">
                            <button type="button" class="qty-btn" onclick="changeQty(-1)">−</button>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantity}">
                            <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
                        </div>
                    </div>

                    <div class="action-buttons">
                        <button class="buy-button">Mua ngay</button>
                        <button class="add-to-cart-button">
                            <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ hàng
                        </button>
                    </div>
                </div>


            </div>
        </div>

        <!-- Mô tả -->
        <div class="description-section">
            <h3>Mô tả sản phẩm</h3>
            <p>${product.description}</p>
        </div>

        <!-- Bình luận -->
        <div class="comment-section">
            <h3>Bình luận</h3>
            <div class="comment">
                <strong>Minh Nhật:</strong> Sản phẩm đẹp, giao hàng nhanh.
            </div>
            <div class="comment">
                <strong>Ngọc Trinh:</strong> Chất lượng tốt, đúng như mô tả.
            </div>
            <!-- Thêm input hoặc form nếu muốn cho người dùng bình luận -->
        </div>    
        <script>
            function changeQty(delta) {
                const qtyInput = document.getElementById("quantity");
                let current = parseInt(qtyInput.value);
                const min = parseInt(qtyInput.min);
                const max = parseInt(qtyInput.max);
                let newVal = current + delta;
                if (newVal < min)
                    newVal = min;
                if (newVal > max)
                    newVal = max;
                qtyInput.value = newVal;
            }
        </script>
    </body>
</html>
