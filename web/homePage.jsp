<%-- 
    Document   : welcome
    Created on : 16-Jun-2025, 04:18:32
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome</title>
    </head>
    <body>
        <h1>Welcome, ${sessionScope.login.fullName}!</h1>
        <a href="logout">Logout</a>

        <h2>Options</h2>
        <!-- Chỉ hiển thị liên kết View User List cho người dùng có roleID là AD -->
        <c:if test="${sessionScope.login.roleID == 'AD'}">
            <p><a href="MainController?action=searchUser">View User List</a></p>
        </c:if>
        <a href="MainController?action=searchProduct">View Product List</a><br/>
        <a href="MainController?action=searchCategory">View Category List</a>
        
        <h3>Customer Support</h3>
        <!-- Liên kết gửi phản hồi và xem phản hồi cho người dùng không phải AD hoặc CS -->
        <c:if test="${sessionScope.login.roleID != 'AD' && sessionScope.login.roleID != 'CS'}">
            <p><a href="submitFeedback.jsp">Submit Feedback</a></p>
            <p><a href="listFeedback.jsp">View My Feedback</a></p>
        </c:if>
        <!-- Liên kết quản lý ticket cho CS -->
        <c:if test="${sessionScope.login.roleID == 'CS'}">
            <p><a href="feedbackAdmin.jsp">Manage Feedback</a></p>
        </c:if>

        <!-- Hiển thị thông báo nếu có -->
        <c:if test="${not empty requestScope.MSG}">
            <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.MSG}</p>
        </c:if>
    </body>
</html>