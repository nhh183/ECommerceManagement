<%-- 
    Document   : createReturn
    Created on : Jun 30, 2025, 7:44:34 PM
    Author     : loan1
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Yêu cầu trả hàng</title></head>
<body>
<h2>Gửi yêu cầu trả hàng</h2>

<c:if test="${not empty ERROR}">
    <p style="color:red">${ERROR}</p>
</c:if>

<form action="MainController" method="post">
    <input type="hidden" name="action" value="createReturn"/>
    Mã hóa đơn (invoiceID): <input type="number"   name="invoiceID" required/><br/>
    Lý do trả hàng:         <textarea name="reason" rows="4" cols="40" required></textarea><br/>
    <button type="submit">Gửi yêu cầu</button>
</form>
<p><a href="MainController?action=listReturns">Xem danh sách yêu cầu</a></p>
</body>
</html>
