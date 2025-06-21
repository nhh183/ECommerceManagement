<%-- 
    Document   : submitFeedback
    Created on : 18-Jun-2025, 04:16:00
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submit Feedback</title>
    </head>
    <body>
        <h1>Submit Feedback</h1>
        <a href="homePage.jsp">Back to Welcome</a> | <a href="logout">Logout</a>
        
        <!-- Kiểm tra xem USER có tồn tại không -->
        <c:if test="${sessionScope.login == null}">
            <p style="color: red;">Please log in to submit feedback.</p>
            <a href="login.jsp">Login</a>
        </c:if>
        
        <c:if test="${sessionScope.login != null}">
            <!-- Kiểm tra quyền: Không phải AD hoặc CS -->
            <c:if test="${sessionScope.USER.roleID != 'AD' && sessionScope.USER.roleID != 'CS'}">
                <h3>Feedback Form</h3>
                <form action="MainController" method="POST">
                    <input type="hidden" name="action" value="CustomerSupport"/>
                    <label>Subject:</label>
                    <input type="text" name="subject" required/><br/>
                    <label>Content:</label>
                    <textarea name="content" required></textarea><br/>
                    <input type="submit" value="Submit Feedback"/>
                </form>
            </c:if>
            <c:if test="${sessionScope.USER.roleID == 'AD' || sessionScope.USER.roleID == 'CS'}">
                <p style="color: red;">Admins and Customer Service cannot submit feedback.</p>
            </c:if>
        </c:if>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty requestScope.MSG}">
            <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.MSG}</p>
        </c:if>
    </body>
</html>