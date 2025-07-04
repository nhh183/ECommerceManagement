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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="container-fluid px-0">

        <%@include file="header.jsp" %>


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

        <!-- Danh mục -->
        <div class="category-section">
            <div class="category-title"><fmt:message key="category.title"/></div>
            <div class="category-grid">
                <c:forEach var="cat" items="${categoryList}">
                    <div class="category-item" onclick="window.location.href = 'MainController?action=searchProduct&categoryID=${cat.categoryID}'">
                        <img src="${cat.imgUrl}" alt="${cat.categoryName}" />
                        <div class="category-name">${cat.categoryName}</div>
                    </div>
                </c:forEach>
            </div>
        </div>


        <div class="featured-section">
            <div class="container">
                <h2><fmt:message key="flashsale.title" /></h2>
                <div class="product-grid">
                    <c:if test="${not empty promotedProducts}">
                        <c:forEach var="product" items="${promotedProducts}">
                            <a href="MainController?action=viewProduct&id=${product.productID}" style="text-decoration: none;">
                                <div class="product-card">
                                    <img src="${product.imgUrl}" alt="${product.name}">
                                    <h3>${product.name}</h3>

                                    <c:if test="${product.promotion != null}">
                                        <p>
                                            <s><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/> ₫</s>
                                            <strong class="text-danger">
                                                <fmt:formatNumber value="${product.price * (1 - product.promotion.discountPercent / 100)}" type="number" groupingUsed="true"/> ₫
                                            </strong>
                                        </p>
                                        <div class="discount-badge">-${product.promotion.discountPercent}%</div>
                                    </c:if>
                                </div>
                            </a>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
        </div>


  
        <div class="product-section">
            <div class="container">
                <h2><fmt:message key="product.title" /></h2> 
                <div class="product-grid">
                    <c:forEach var="product" items="${productList}">
                        <a href="MainController?action=viewProduct&id=${product.productID}">
                            <div class="product-card position-relative">

                                <!-- Badge Giảm giá -->
                                <c:if test="${product.promotion != null}">
                                    <div class="discount-badge">-${product.promotion.discountPercent}%</div>
                                </c:if>

                                <!-- Ảnh sản phẩm -->
                                <img src="${product.imgUrl}" alt="${product.name}">

                                <!-- Tên sản phẩm -->
                                <h3>${product.name}</h3>

                                <!-- Hiển thị giá -->
                                <c:choose>
                                    <c:when test="${product.promotion != null}">
                                        <p>
                                            <s><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> ₫</s><br>
                                            <strong class="text-danger fs-5">
                                                <fmt:formatNumber value="${product.price * (1 - product.promotion.discountPercent / 100)}" type="number" groupingUsed="true" /> ₫
                                            </strong>
                                        </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p>
                                            <strong class="text-dark">
                                                <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" /> ₫
                                            </strong>
                                        </p>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </a>
                    </c:forEach>
                </div>

            </div>
      </div>


   
        <%@include file="footer.jsp" %>
        
    </body>
</html>

