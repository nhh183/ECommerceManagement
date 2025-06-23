<DOCUMENT filename="homePage.jsp">
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>E-Commerce Store</title>
            <!-- Bootstrap 5 CSS via CDN -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Font Awesome for icons -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 0;
                    color: #333;
                    background-color: #fff;
                }

                a {
                    text-decoration: none;
                    color: inherit;
                }

                .container {
                    width: 80%;
                    margin: 0 auto;
                }

                /* === HEADER - CẢI TIẾN MỚI === */
                .header {
                    background: linear-gradient(to right, #E55D00, #FF6B00) !important; /* Màu cam đậm hơn */
                    padding: 15px 0;
                    border-bottom: none !important;
                    box-shadow: 0 2px 10px rgba(0,0,0,0.2);
                }

                .logo {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    color: white !important;
                    font-weight: bold;
                    font-size: 28px;
                    text-shadow: 1px 1px 3px rgba(0,0,0,0.5); /* Bóng chữ đậm hơn */
                    display: flex;
                    align-items: center;
                    gap: 15px;
                }

                .logo-img {
                    width: 45px;
                    height: 45px;
                    filter: drop-shadow(0 2px 3px rgba(0,0,0,0.3));
                }

                @media (max-width: 767px) {
                    .logo, .user-actions {
                        text-align: center;
                        justify-content: center;
                    }
                    .header .row {
                        gap: 15px;
                    }
                }

                .search-box input {
                    border: 2px solid #fff !important;
                    border-radius: 5px 0 0 5px !important;
                }

                .search-box button {
                    padding: 8px 15px;
                    background-color: white !important;
                    color: #E55D00 !important; /* Màu cam đậm */
                    border: 2px solid #fff !important;
                    border-radius: 0 5px 5px 0 !important;
                    cursor: pointer;
                    font-weight: bold;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                }

                .search-box button:hover {
                    background-color: #FFEDCC !important;
                    transform: translateY(-3px);
                    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
                }

                .user-actions {
                    font-size: 14px;
                    display: flex;
                    align-items: center;
                    justify-content: flex-end;
                }

                .user-actions .btn {
                    background-color: white !important;
                    color: white !important; /* Màu cam đậm */
                    border: 2px solid #fff !important;
                    border-radius: 5px;
                    padding: 8px 15px;
                    font-weight: bold;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                }

                .user-actions .btn:hover {
                    background-color: #FFEDCC !important;
                    transform: translateY(-3px);
                    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
                }

                .welcome-text {
                    color: white;
                    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
                    margin-right: 15px;
                    font-weight: bold;
                }

                .cart-icon {
                    position: relative;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    margin-right: 15px;
                    background-color: white;
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    color: #E55D00;
                    font-size: 20px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                }

                .cart-icon:hover {
                    transform: scale(1.1);
                    box-shadow: 0 4px 8px rgba(0,0,0,0.3);
                }

                .cart-count {
                    position: absolute;
                    top: -5px;
                    right: -5px;
                    background-color: #ff3333;
                    color: white;
                    border-radius: 50%;
                    width: 22px;
                    height: 22px;
                    font-size: 13px;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-weight: bold;
                    box-shadow: 0 1px 3px rgba(0,0,0,0.2);
                }

                .logout-button {
                    background-color: white; /* Replace with your desired color */
                }
                /* === NAV MENU === */
                .nav-wrapper {
                    background: linear-gradient(to right, #D95400, #E55D00) !important; /* Màu cam đậm hơn */
                    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                }

                .nav-menu {
                    display: flex;
                    flex-wrap: wrap;
                    list-style: none;
                    padding: 15px 0;
                    gap: 20px;
                    margin-top: 0 !important;
                    background-color: transparent !important;
                }

                .nav-menu li a {
                    font-weight: bold;
                    padding: 8px 15px;
                    border-radius: 4px;
                    color: white !important;
                    transition: all 0.3s ease;
                    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
                }

                .nav-menu li a:hover {
                    background-color: rgba(255, 255, 255, 0.2);
                    transform: translateY(-3px);
                    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
                }

                /* === HERO SECTION === */
                .hero-section {
                    padding: 20px 0;
                    background-color: #FFF5E6;
                }

                .hero-section .carousel-inner img {
                    height: 300px;
                    object-fit: cover;
                    border-radius: 10px;
                    border: 2px solid #FF6B00;
                }

                .hero-section .carousel-control-prev-icon,
                .hero-section .carousel-control-next-icon {
                    background-color: rgba(255, 107, 0, 0.7);
                    border-radius: 50%;
                    padding: 12px;
                }

                .hero-section .carousel-indicators [data-bs-target] {
                    background-color: #fff;
                    width: 10px;
                    height: 10px;
                    border-radius: 50%;
                    margin: 0 4px;
                    border: 1px solid #FF6B00;
                }

                .hero-section .carousel-indicators .active {
                    background-color: #FF6B00;
                }

                .right-banner .banner-img {
                    width: 100%;
                    height: 145px;
                    object-fit: cover;
                    border-radius: 10px;
                    border: 2px solid #FF6B00;
                }

                /* === FEATURE BOX === */
                .feature-box {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    padding: 30px 0;
                    background-color: #FFF5E6;
                    text-align: center;
                }

                .feature h3 {
                    color: #FF6B00;
                    font-size: 18px;
                    margin-bottom: 5px;
                }

                .feature p {
                    color: #666;
                    font-size: 14px;
                    line-height: 1.4;
                    margin-top: 5px;
                }

                /* === PRODUCTS === */
                .product-section {
                    padding: 40px 0;
                }

                .product-section h2 {
                    color: #FF6B00;
                    border-bottom: 2px solid #FF6B00;
                    padding-bottom: 10px;
                    margin-bottom: 20px;
                }

                .product-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 20px;
                }

                .product-card {
                    background-color: #fff;
                    padding: 15px;
                    box-shadow: 0 2px 10px rgba(255, 107, 0, 0.1);
                    text-align: center;
                    border-radius: 8px;
                    transition: transform 0.3s ease;
                    border: 1px solid #FFE4CC;
                }

                .product-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 5px 15px rgba(255, 107, 0, 0.2);
                }

                .product-card img {
                    max-width: 100%;
                    height: auto;
                    margin-bottom: 10px;
                    border-radius: 5px;
                }

                .product-card h3 {
                    font-size: 18px;
                    margin: 10px 0 5px;
                }

                .product-card p {
                    font-size: 16px;
                    color: #FF6B00;
                    font-weight: bold;
                }

                .product-card button {
                    margin-top: 10px;
                    padding: 8px 12px;
                    background-color: #FF6B00;
                    border: none;
                    color: #fff;
                    border-radius: 4px;
                    cursor: pointer;
                    font-weight: bold;
                    transition: all 0.3s ease;
                }

                .product-card button:hover {
                    background-color: #E55D00;
                    transform: scale(1.05);
                }

                /* === FOOTER === */
                .footer {
                    background-color: #FF6B00;
                    color: #fff;
                    padding: 20px 0;
                    text-align: center;
                    font-weight: bold;
                }

                /* === MESSAGES === */
                p[style*="color:"] {
                    font-weight: bold;
                    text-align: center;
                    margin-top: 20px;
                    padding: 10px;
                    border-radius: 4px;
                }

                /* Customer Support Links */
                .container h3 {
                    color: #FF6B00;
                }
                .container a {
                    color: #FF6B00;
                    font-weight: bold;
                }
                .container a:hover {
                    color: #E55D00;
                    text-decoration: underline;
                }
            </style>
        </head>
        <body>
            <!-- HEADER -->
            <div class="header py-3">
                <div class="container">
                    <div class="row align-items-center">
                        <!-- Logo với hình giỏ hàng -->
                        <div class="col-md-3">
                            <div class="logo font-weight-bold">
                                <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                                E-Commerce Store
                            </div>
                        </div>

                        <!-- Search Box -->
                        <div class="col-md-6">
                            <form action="MainController" method="GET" class="input-group">
                                <input type="text" name="search" class="form-control" placeholder="Search products...">
                                <input type="hidden" name="action" value="searchProduct">
                                <div class="input-group-append">
                                    <button class="btn" type="submit">Search</button>
                                </div>
                            </form>
                        </div>

                        <!-- User Actions -->
                        <div class="col-md-3 text-right">
                            <c:if test="${not empty sessionScope.login}">
                                <a href="viewCart.jsp" class="cart-icon">
                                    <i class="fas fa-shopping-cart"></i>
                                    <c:if test="${not empty sessionScope.cart}">
                                        <span class="cart-count">${sessionScope.cart.size()}</span>
                                    </c:if>
                                    <c:if test="${empty sessionScope.cart}">
                                        <span class="cart-count">0</span>
                                    </c:if>
                                </a>
                                <span class="welcome-text" style="display: inline-block;">Welcome, ${sessionScope.login.fullName}!</span> <!-- Thêm style="display: inline-block;" -->
                                <a href="logout" class="btn btn-sm logout-button">Logout</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- NAVIGATION MENU -->
            <div class="nav-wrapper">
                <div class="container">
                    <ul class="nav-menu">
                        <li><a href="homePage.jsp">HOME</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=1">ĐIỆN THOẠI</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=2">LAPTOP</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=3">ÁO THUN</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=4">ĐỒ GIA DỤNG</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=6">THỂ THAO</a></li>
                        <li><a href="MainController?action=searchDelivery">Manage Deliveries</a></li>

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
                        <c:forEach var="product" items="${newArrivals}" end="3">
                            <div class="product-card">
                                <img src="${product.imgUrl}" alt="${product.name}">
                                <h3>${product.name}</h3>
                                <p>$${product.price}</p>
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
<!-- web/homePage.jsp (381-400) -->
<div class="col-md-3 text-right">
    <c:if test="${not empty sessionScope.login}">
        <a href="viewCart.jsp" class="cart-icon">
            <i class="fas fa-shopping-cart"></i>
            <c:if test="${not empty sessionScope.cart}">
                <span class="cart-count">${sessionScope.cart.size()}</span>
            </c:if>
            <c:if test="${empty sessionScope.cart}">
                <span class="cart-count">0</span>
            </c:if>
        </a>
        <span class="welcome-text" style="display: inline-block;">Welcome, ${sessionScope.login.fullName}!</span> <!-- Thêm style="display: inline-block;" -->
        <a href="logout" class="btn btn-sm logout-button">Logout</a>
    </c:if>
</DOCUMENT>
