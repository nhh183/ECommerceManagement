<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>E-Commerce Store</title>
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
            background-color: #f1f1f1;
            text-align: center;
            padding: 60px 20px;
        }

        .hero-section h1 {
            font-size: 36px;
            margin-bottom: 10px;
        }

        .hero-section p {
            font-size: 18px;
            color: #555;
        }

        /* === CATEGORIES === */
        .categories {
            padding: 40px 0;
        }

        .category-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .category-item {
            flex: 1 1 calc(33.33% - 20px);
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            transition: transform 0.2s;
        }

        .category-item:hover {
            transform: translateY(-5px);
        }

        .category-item h3 a {
            color: #007bff;
            font-size: 20px;
        }

        /* === FEATURED SECTION === */
        .featured-section {
            background-color: #f8f9fa;
            padding: 40px 20px;
            text-align: center;
        }

        .featured-item h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .featured-item h4 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .featured-item p {
            color: #666;
        }

        .featured-item a {
            display: inline-block;
            margin-top: 10px;
            color: #007bff;
            font-weight: bold;
        }

        /* === FEATURE BOX === */
        .feature-box {
            display: flex;
            justify-content: space-around;
            padding: 30px 0;
            background-color: #f8f9fa;
        }

        .feature {
            text-align: center;
            width: 30%;
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
                <li><a href="MainController?action=searchProduct&categoryID=1">CLOTHING</a></li>
                <li><a href="MainController?action=searchProduct&categoryID=2">ELECTRONICS</a></li>
                <li><a href="MainController?action=searchProduct&categoryID=3">HEALTH & BEAUTY</a></li>
                <li><a href="MainController?action=searchProduct&categoryID=4">WATCHES</a></li>
                <li><a href="MainController?action=searchProduct&categoryID=5">JEWELLERY</a></li>
                <li><a href="MainController?action=searchProduct&categoryID=6">SHOES</a></li>
                <li><a href="MainController?action=searchProduct&categoryID=7">KIDS & GIRLS</a></li>

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
        <div class="container">
            <h1>Welcome to Our Store</h1>
            <p>Discover amazing products at great prices</p>
        </div>
    </div>

    <div class="categories">
        <div class="container">
            <h2>CATEGORIES</h2>
            <div class="category-list">
                <c:forEach var="category" items="${categoryList}" end="5">
                    <div class="category-item">
                        <h3><a href="MainController?action=searchProduct&categoryID=${category.categoryID}">${category.categoryName}</a></h3>
                        <p>${category.description}</p>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="featured-section">
        <div class="container">
            <div class="featured-item">
                <h3>LOREM IPSUM</h3>
                <h4>LOREM IPSUM IS SIMPLY</h4>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam isoreet purus placerat leo agestas, sit amet tempus nibh tempus.</p>
                <a href="#">READ MORE</a>
            </div>
        </div>
    </div>

    <div class="feature-box">
        <div class="container">
            <div class="feature">
                <h3>MONEY BACK</h3>
                <p>30 Days Money Back Guarantee</p>
            </div>
            <div class="feature">
                <h3>FREE SHIPPING</h3>
                <p>30 Days Money Back Guarantee</p>
            </div>
            <div class="feature">
                <h3>SPECIAL SALE</h3>
                <p>30 Days Money Back Guarantee</p>
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

    <div class="footer">
        <div class="container">
            <p>Ecommerce WordPress Theme</p>
        </div>
    </div>

    <c:if test="${not empty requestScope.MSG}">
        <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.MSG}</p>
    </c:if>
</body>
</html>
