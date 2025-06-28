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
        <link rel="stylesheet" href="css/viewProduct.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <div class="header sticky-top">
            <div class="header-top">
                <div class="header-top-left">

                </div>
                <div class="header-top-right">
                    <span class="welcome-text font-weight-light" style="display: inline-block;">Welcome, ${sessionScope.login.fullName}!</span> <!-- Thêm style="display: inline-block;" -->
                </div>

            </div>
            <div class="header-bottom p-3">
                <div class="container inner-header-bottom row">
                    <!-- Logo với hình giỏ hàng -->
                    <div class="col-md-3">
                        <div class="logo font-weight-bold">
                            <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                            Shoppy
                        </div>
                    </div>

                    <!-- Search Box -->
                    <div class="col-md-6">
                        <form action="MainController" method="GET" class="input-group">
                            <input type="text" name="name" class="form-control" placeholder="Tìm sản phẩm...">
                            <input type="hidden" name="sourcePage" value="home">
                            <input type="hidden" name="action" value="searchProduct">
                            <div class="input-group-append">
                                <button class="btn btn-solid-primary search-btn" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                            </div>
                        </form>
                    </div>

                    <!-- User Actions -->
                    <div class="col-md-3 text-right">
                        <c:if test="${not empty sessionScope.login}">
                            <a href="viewCart.jsp" class="cart-icon">
                                <i class="fa fa-shopping-cart"></i>
                                <c:if test="${not empty sessionScope.cartId}">
                                    <span class="cart-count">${sessionScope.cartSize}</span>
                                </c:if>
                                <c:if test="${empty sessionScope.cartId}">
                                    <span class="cart-count">0</span>
                                </c:if>
                            </a>

                        </c:if>
                    </div>
                </div>

            </div>
        </div>


        <!-- NAVIGATION MENU -->
        <div class="nav-wrapper">
            <div class="container">
                <ul class="nav-menu">
                    <li><a href="MainController?action=homePage">HOME</a></li>
                    <li><a href="MainController?action=searchProduct&categoryID=1">ĐIỆN THOẠI</a></li>
                    <li><a href="MainController?action=searchProduct&categoryID=2">LAPTOP</a></li>
                    <li><a href="MainController?action=searchProduct&categoryID=3">ÁO THUN</a></li>
                    <li><a href="MainController?action=searchProduct&categoryID=4">ĐỒ GIA DỤNG</a></li>
                    <li><a href="MainController?action=searchProduct&categoryID=6">THỂ THAO</a></li>

                    <c:if test="${sessionScope.login.roleID == 'AD'}">
                        <li><a href="MainController?action=searchUser">Manage Users</a></li>
                        <li><a href="MainController?action=searchCategory">Manage Categories</a></li>
                        </c:if>
                        <c:if test="${sessionScope.login.roleID == 'CS'}">
                        <li><a href="feedbackAdmin.jsp">Manage Feedback</a></li>
                        </c:if>
                </ul>
            </div>
        </div>


        <!-- Product Section -->
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


                            
                    <form action="MainController"  method="POST">
                        <input type="hidden" name="productID" value="${product.productID}">
                        <div class="quantity-select">
                            <label for="quantity">Chọn số lượng:</label>
                            <div class="quantity-box">
                                <button type="button" class="qty-btn" onclick="changeQty(-1)">−</button>
                                <input type="number" id="quantity0" name="quantity" value="1" min="1" max="${product.quantity}">
                                <button type="button" class="qty-btn" onclick="changeQty(1)">+</button>
                            </div>
                        </div>
                        <div class="action-buttons">
                            <button type="submit" name="action" value="buyNow" class="buy-button">Mua ngay</button>
                            <button type="button" onclick="addToCart(${product.productID})" class="add-to-cart-button">
                                <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ hàng
                            </button>
                        </div>
                        
                    </form>
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
                const qtyInput = document.getElementById("quantity0");
                let current = parseInt(qtyInput.value);
                const min = parseInt(qtyInput.min);
                const max = parseInt(qtyInput.max);
                let newVal = current + delta;
                if (newVal < min)
                    newVal = min;
                if (newVal > max)
                    newVal = max;
                qtyInput.value = newVal;
            };
            function addToCart(productId) {
                const quantity = document.getElementById("quantity0").value;
                fetch("MainController", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: `action=AddToCart&productID=`+productId+`&quantity=`+quantity
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Cập nhật số lượng trong giỏ hàng ở góc trên phải
                        document.querySelector(".cart-count").innerText = data.cartSize;
                        alert("Đã thêm vào giỏ hàng!");
                    } else {
                        alert("Thêm vào giỏ hàng thất bại!");
                    }
                })
                .catch(error => {
                    console.error("Lỗi:", error);
                    alert("Đã có lỗi xảy ra!");
                });
            }
        </script>
    </body>
</html>
