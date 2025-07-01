<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.List"%>
<%@page import="dto.ProductDTO"%>


<%
    List<ProductDTO> checkoutItems = (List<ProductDTO>) request.getAttribute("checkoutItems");
    double total = 0;
    for (ProductDTO item : checkoutItems) {
        total += item.getPrice()*item.getQuantity();
    }
    request.setAttribute("totalAmount", total);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận đơn hàng</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body class="container mt-4">
    <h3>Địa Chỉ Nhận Hàng</h3>
    <p><b>Nguyễn Hoàng Huy</b> | SĐT: <b>0977851758</b><br/>
       F5/6, tổ 13, ấp 6A, Xã Vĩnh Lộc B, Huyện Bình Chánh, TP. Hồ Chí Minh</p>

    <hr>
    <h4>Sản phẩm</h4>
    <table class="table table-bordered">
        <thead class="thead-light">
            <tr>
                <th>Tên</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${checkoutItems}">
                <tr>
                    <td>${item.name}</td>
                    <td><fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" /></td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${item.price*item.quantity}" type="number" groupingUsed="true" /></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="text-right font-weight-bold">
        Tổng cộng: ₫<fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true" />
    </div>

    <form action="CreateInvoiceController" method="post">
        <input type="hidden" name="totalAmount" value="${totalAmount}" />
        <c:forEach var="item" items="${checkoutItems}">
            <input type="hidden" name="productId" value="${item.productID}" />
            <input type="hidden" name="quantity" value="${item.quantity}" />
            <input type="hidden" name="price" value="${item.price}" />
        </c:forEach>
        <div class="text-right mt-3">
            <button type="submit" class="btn btn-danger">Đặt hàng</button>
        </div>
    </form>
</body>
</html>
