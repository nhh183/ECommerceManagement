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
            <style>
                /* === RESET & BASE === */
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

                /* === HEADER === */
                .header {
                    background-color: #f8f9fa;
                    padding: 15px 0;
                    border-bottom: 1px solid #e1e1e1;
                }

                .logo {
                    font-size: 28px;
                    font-weight: bold;
                    color: #333;
                    float: left;
                }

                .user-actions {
                    float: right;
                    margin-top: 6px;
                }

                .search-box {
                    clear: both;
                    margin-top: 15px;
                }

                .search-box input[type="text"] {
                    padding: 8px;
                    width: 250px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                }

                .search-box button {
                    padding: 8px 12px;
                    background-color: #007bff;
                    color: #fff;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                }

                .search-box button:hover {
                    background-color: #0056b3;
                }

                /* === NAV MENU === */
                .nav-menu {
                    display: flex;
                    flex-wrap: wrap;
                    list-style: none;
                    padding: 15px 0;
                    gap: 20px;
                    border-top: 1px solid #e1e1e1;
                    border-bottom: 1px solid #e1e1e1;
                    margin-top: 20px;
                }

                .nav-menu li a {
                    font-weight: bold;
                    padding: 8px 10px;
                    border-radius: 4px;
                    color: #333;
                }

                .nav-menu li a:hover {
                    background-color: #007bff;
                    color: #fff;
                }

                /* === HERO SECTION === */
                .hero-section {
                    padding: 20px 0;
                    background-color: #fff3e0;
                }

                .hero-section .carousel-inner img {
                    height: 300px;
                    object-fit: cover;
                    border-radius: 10px;
                }

                .hero-section .carousel-control-prev-icon,
                .hero-section .carousel-control-next-icon {
                    background-color: rgba(0, 0, 0, 0.6);
                    border-radius: 50%;
                    padding: 12px;
                }

                .hero-section .carousel-indicators [data-bs-target] {
                    background-color: #fff;
                    width: 10px;
                    height: 10px;
                    border-radius: 50%;
                    margin: 0 4px;
                }

                .hero-section .carousel-indicators .active {
                    background-color: #000;
                }

                .right-banner .banner-img {
                    width: 100%;
                    height: 145px;
                    object-fit: cover;
                    border-radius: 10px;
                }

                /* Style carousel indicators */
                .carousel-indicators [data-bs-target] {
                    background-color: #fff;
                    width: 12px;
                    height: 12px;
                    border: 2px solid #333;
                    border-radius: 50%;
                    opacity: 0.7;
                }

                .carousel-indicators .active {
                    background-color: #333;
                    opacity: 1;
                }

                /* Style carousel controls */
                .carousel-control-prev-icon,
                .carousel-control-next-icon {
                    background-color: rgba(51, 51, 51, 0.7);
                    border-radius: 50%;
                    padding: 15px;
                    transition: background-color 0.3s;
                }

                .carousel-control-prev-icon:hover,
                .carousel-control-next-icon:hover {
                    background-color: rgba(51, 51, 51, 0.9);
                }

                /* === FEATURE BOX === */
                .feature-box {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    padding: 30px 0;
                    background-color: #f8f9fa;
                    text-align: center;
                }

                .feature {
                    flex: 1;
                    max-width: 33.33%;
                    padding: 0 15px;
                }

                .feature h3 {
                    color: #f4a10c;
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

                .product-grid {
                    display: grid;
                    grid-template-columns: repeat(4, 1fr);
                    gap: 20px;
                }

                .product-card {
                    background-color: #fff;
                    padding: 15px;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    text-align: center;
                    border-radius: 8px;
                }

                .product-card img {
                    max-width: 100%;
                    height: auto;
                    margin-bottom: 10px;
                }

                .product-card h3 {
                    font-size: 18px;
                    margin: 10px 0 5px;
                }

                .product-card p {
                    font-size: 16px;
                    color: #28a745;
                }

                .product-card button {
                    margin-top: 10px;
                    padding: 8px 12px;
                    background-color: #28a745;
                    border: none;
                    color: #fff;
                    border-radius: 4px;
                    cursor: pointer;
                }

                .product-card button:hover {
                    background-color: #218838;
                }

                /* === FOOTER === */
                .footer {
                    background-color: #333;
                    color: #fff;
                    padding: 20px 0;
                    text-align: center;
                }

                /* === MESSAGES === */
                p[style*="color:"] {
                    font-weight: bold;
                    text-align: center;
                    margin-top: 20px;
                }
            </style>
        </head>
        <body>
            <div class="header">
                <div class="container">
                    <div class="logo">E-Commerce Store</div>

                    <div class="user-actions">
                        <c:if test="${not empty sessionScope.login}">
                            <span>Welcome, ${sessionScope.login.fullName}!</span>
                            <a href="logout">Logout</a>
                        </c:if>
                    </div>

                    <div class="search-box">
                        <form action="MainController" method="GET">
                            <input type="text" name="search" placeholder="Search products...">
                            <input type="hidden" name="action" value="searchProduct">
                            <button type="submit">Search</button>
                        </form>
                    </div>

                    <ul class="nav-menu">
                        <li><a href="homePage.jsp">HOME</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=1">ĐIỆN THOẠI</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=2">LAPTOP</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=3">ÁO THUN</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=4">ĐỒ GIA DỤNG</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=5">SÁCH</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=6">THỂ THAO</a></li>
                        <li><a href="MainController?action=searchProduct&categoryID=7">MỸ PHẨM</a></li>

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
</DOCUMENT>