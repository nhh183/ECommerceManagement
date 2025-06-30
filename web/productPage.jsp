<%-- 
    Document   : productPage
    Created on : Jun 25, 2025, 2:09:05 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản Phẩm</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">        
        <link rel="stylesheet" href="css/productPage.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body class="container-fluid px-0">
        <%@include file="header.jsp" %>
        <div class="container-fluid mt-4 px-5">

            <div class="row d-flex">
                <!-- SIDEBAR FILTER -->
                <div class="col-md-3 sidebar-filter">
                    <form action="MainController" method="get">
                        <input type="hidden" name="action" value="searchProduct">
                        <input type="hidden" name="sourcePage" value="productPage">

                        <!-- LỌC DANH MỤC -->
                        <h5>Danh Mục</h5>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="categoryID" value="" 
                                   ${empty param.categoryID ? 'checked' : ''}>
                            <label class="form-check-label">Tất cả</label>
                        </div>

                        <c:forEach var="cat" items="${categoryList}">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="categoryID" value="${cat.categoryID}" 
                                       ${param.categoryID == cat.categoryID ? 'checked' : ''}>
                                <label class="form-check-label">${cat.categoryName}</label>
                            </div>
                        </c:forEach>

                        <!-- GIÁ TỪ - ĐẾN -->
                        <h5 class="mt-3">Khoảng Giá</h5>
                        <div class="price-row">
                            <input type="number" name="minPrice" class="form-control" min="0" step="0.1" placeholder="Giá từ" value="${param.minPrice}">
                            <input type="number" name="maxPrice" class="form-control" min="0" step="0.1" placeholder="Giá đến" value="${param.maxPrice}">
                        </div>

                        <!-- TRẠNG THÁI -->
                        <h5 class="mt-3">Trạng Thái</h5>
                        <select name="status" class="form-control">
                            <option value="">Tất cả</option>
                            <option value="active" ${param.status == 'active' ? 'selected' : ''}>Còn hàng</option>
                            <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Hết hàng</option>
                        </select>

                        <!-- NÚT LỌC -->
                        <button type="submit" class="btn btn-primary mt-3">Lọc</button>
                    </form>
                </div>

                <!-- PRODUCT LIST -->
                <div class="col-md-9">
                    <div class="product-section">
                        <div class="product-grid">
                            <c:forEach var="product" items="${productList}">
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
            </div>
        </div>

       <%@include file="footer.jsp" %>     

    </body>
</html>
