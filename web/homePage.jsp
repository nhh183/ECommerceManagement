<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shoppyy | Trang Chủ</title>

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/homepage.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="container-fluid px-0">
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
                                <c:if test="${not empty sessionScope.cart}">
                                    <span class="cart-count">${sessionScope.cart.size()}</span>
                                </c:if>
                                <c:if test="${empty sessionScope.cart}">
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
                    <!-- Mục chung -->
                    <li><a href="MainController?action=homePage">HOME</a></li>
                        <c:forEach var="cat" items="${categoryList}">
                        <li><a href="MainController?action=searchProduct&categoryID=${cat.categoryID}&sourcePage=productPage">${cat.categoryName}</a></li>
                        </c:forEach>

                    <!-- Divider nếu có chức năng quản lý -->
                    <c:if test="${sessionScope.login.roleID == 'AD' || sessionScope.login.roleID == 'CS' || sessionScope.login.roleID == 'SL'}">
                        <li class="divider">|</li>
                        </c:if>

                    <!-- Mục cho ADMIN -->
                    <c:if test="${sessionScope.login.roleID == 'AD'}">
                        <li><a class="admin-link" href="MainController?action=searchUser">Quản lý KH</a></li>
                        <li><a class="admin-link" href="MainController?action=searchCategory">Danh mục</a></li>
                        <li><a class="admin-link" href="MainController?action=productList">Sản phẩm</a></li>
                        <li><a class="admin-link" href="feedbackAdmin.jsp">Phản hồi</a></li>
                        </c:if>

                    <!-- Mục cho CS -->
                    <c:if test="${sessionScope.login.roleID == 'CS'}">
                        <li><a class="admin-link" href="MainController?action=activateSeller">Kích hoạt Seller</a></li>
                        </c:if>

                    <!-- Mục cho SELLER -->
                    <c:if test="${sessionScope.login.roleID == 'SL'}">
                        <li><a class="admin-link" href="MainController?action=productList">Sản phẩm của tôi</a></li>
                        <li><a class="admin-link" href="MainController?action=myOrders">Đơn hàng</a></li>
                        </c:if>

                    <!-- Nút Logout -->
                    <c:if test="${not empty sessionScope.login}">
                        <li class="logout-item">
                            <a class="logout-link" href="MainController?action=logout">
                                <i class="fa fa-sign-out-alt"></i> Đăng xuất
                            </a>                        
                        </li>
                        </c:if>
                </ul>
            </div>
        </div>



        <!-- Phần còn lại của trang không thay đổi -->
        <!-- ... (giữ nguyên phần hero-section, featured-section, product-section, v.v.) ... -->
        <div class="hero-section">
            <div class="container d-flex justify-content-between">
                <!-- Carousel bên trái -->
                <div id="carouselExampleIndicators" class="carousel slide w-75" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="images/laptop.jpg" class="d-block w-100" alt="Slide 1">
                        </div>
                        <div class="carousel-item">
                            <img src="images/iphone.jpg" class="d-block w-100" alt="Slide 2">
                        </div>
                        <div class="carousel-item">
                            <img src="images/shirt.jpg" class="d-block w-100" alt="Slide 3">
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>

                <!-- 2 ảnh bên phải -->
                <div class="right-banner d-flex flex-column justify-content-between ms-3 w-25">
                    <img src="images/dakNhanTam.jpg" class="mb-3 banner-img" alt="Banner 1">
                    <img src="images/c3.jpg" class="banner-img" alt="Banner 2">
                </div>
            </div>
        </div>

        <div class="featured-section">
            <div class="container">
                <h2>Flash Sale</h2>
                <div class="product-grid">
                    <c:if test="${not empty promotedProducts}">
                        <c:forEach var="product" items="${promotedProducts}" end="3">
                            <div class="product-card">
                                <img src="${product.imgUrl}" alt="${product.name}">
                                <h3>${product.name}</h3>
                                <p><s>$${product.price * 1.2}</s> $${product.price}</p>
                                <form action="MainController" method="POST">
                                    <input type="hidden" name="action" value="addToCart">
                                    <input type="hidden" name="productID" value="${product.productID}">
                                    <button type="submit">ADD TO CART</button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="product-section">
            <div class="container">
                <h2>BEST SELLER</h2>
                <div class="product-grid">
                    <c:forEach var="product" items="${bestSellerProducts}" end="3">
                        <div class="product-card">
                            <img src="${product.imgUrl}" alt="${product.name}">
                            <h3>${product.name}</h3>
                            <p>$${product.price}</p>
                            <form action="MainController" method="POST">
                                <input type="hidden" name="action" value="addToCart">
                                <input type="hidden" name="productID" value="${product.productID}">
                                <button type="submit">ADD TO CART</button>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>


        <div class="product-section">
            <div class="container">
                <h2>NEW ARRIVALS</h2>
                <div class="product-grid">
                    <c:forEach var="product" items="${newArrivals}">
                        <div class="product-card">
                            <a href="MainController?action=viewProduct&id=${product.productID}">
                                <img src="${product.imgUrl}" alt="${product.name}">
                            </a>
                            <a href="MainController?action=viewProduct&id=${product.productID}">
                                <h3>${product.name}</h3>
                            </a>
                            <p><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> ₫</p>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <c:if test="${sessionScope.login.roleID != 'AD' && sessionScope.login.roleID != 'CS'}">
            <div class="container">
                <h3>Customer Support</h3>
                <p><a href="submitFeedback.jsp">Submit Feedback</a></p>
                <p><a href="listFeedback.jsp">View My Feedback</a></p>
            </div>
        </c:if>

        <div class="feature-box">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 feature">
                        <h3>CAM KẾT CHÍNH HÀNG</h3>
                        <p>100% Authentic<br>Cam kết sản phẩm chính hãng từ Châu Âu, Châu Mỹ...</p>
                    </div>
                    <div class="col-md-4 feature">
                        <h3>GIAO HÀNG HỎA TỐC</h3>
                        <p>Express delivery<br>SHIP hỏa tốc 1h nhận hàng trong nội thành HCM</p>
                    </div>
                    <div class="col-md-4 feature">
                        <h3>HỖ TRỢ 24/24</h3>
                        <p>Supporting 24/24<br>Gọi ngay 0909300746</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer">
            <div class="container">
                <p>Ecommerce WordPress Theme</p>
            </div>
        </div>

        <c:if test="${not empty requestScope.MSG}">
            <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.MSG}</p>
        </c:if>

        <!-- Bootstrap 5 JavaScript via CDN -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
