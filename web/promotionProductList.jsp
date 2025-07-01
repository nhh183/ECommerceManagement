<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="dto.UserDTO" %>
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
        <meta charset="UTF-8">
        <title>Danh sách Khuyến mãi - Sản phẩm</title>
        <link rel="stylesheet" href="css/tableList.css">
    </head>
    <body>

        <jsp:include page="headerList.jsp">
            <jsp:param name="page" value="promotionProduct"/>
        </jsp:include>

        <div class="container">
            <div class="title">
                <h1>Danh sách Khuyến mãi - Sản phẩm</h1>
            </div>

            <c:if test="${not empty MSG}">
                <div class="form-message success">${MSG}</div>
            </c:if>
            <c:if test="${not empty ERROR}">
                <div class="form-message error">${ERROR}</div>
            </c:if>

            <div class="search-create-wrapper">
                <form class="search-form" action="MainController" method="get">
                    <select name="promoID">
                        <option value="">-- Chọn Khuyến mãi --</option>
                        <c:forEach var="promo" items="${promoList}">
                            <option value="${promo.promoID}" ${param.promoID == promo.promoID ? 'selected' : ''}>${promo.name}</option>
                        </c:forEach>
                    </select>

                    <select name="productID">
                        <option value="">-- Chọn Sản phẩm --</option>
                        <c:forEach var="product" items="${productList}">
                            <option value="${product.productID}" ${param.productID == product.productID ? 'selected' : ''}>${product.name}</option>
                        </c:forEach>
                    </select>

                    <button type="submit" name="action" value="searchPromotionProduct">Tìm kiếm</button>
                </form>


                <a href="MainController?action=createPromotionProduct">
                    <button class="create-button" type="button">+ Thêm liên kết</button>
                </a>
            </div>

            <c:if test="${not empty promotionProductDetailList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID Khuyến mãi</th>
                            <th>Tên khuyến mãi</th>
                            <th>ID Sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detail" items="${promotionProductDetailList}">
                            <tr>
                                <td>${detail.promoID}</td>
                                <td>${detail.promoName}</td>
                                <td>${detail.productID}</td>
                                <td>${detail.productName}</td>
                                <td>
                                    <a class="action-link"
                                       href="MainController?action=deletePromotionProduct&promoID=${detail.promoID}&productID=${detail.productID}"
                                       onclick="return confirm('Bạn có chắc muốn xoá liên kết này?')">
                                        Xoá</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty promotionProductDetailList}">
                <p>Không có liên kết khuyến mãi - sản phẩm nào.</p>
            </c:if>
        </div>

    </body>
</html>
