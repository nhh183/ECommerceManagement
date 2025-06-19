<%-- 
    Document   : feedbackAdmin
    Created on : 18-Jun-2025, 04:25:00
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Service Dashboard</title>
    </head>
    <body>
        <h1>Customer Service Dashboard</h1>
        <a href="welcome.jsp">Back to Welcome</a> | <a href="logout">Logout</a>
        
        <!-- Kiểm tra đăng nhập và quyền CS -->
        <c:if test="${sessionScope.login == null}">
            <p style="color: red;">Please log in to access this page.</p>
            <a href="login.jsp">Login</a>
        </c:if>
        
        <c:if test="${sessionScope.login != null}">
            <!-- Kiểm tra quyền: Chỉ CS -->
            <p<c:if test="${sessionScope.login.roleID == 'CS'}">
                <h3>New Tickets</h3>
                <!-- Lấy danh sách ticket từ server -->
                <% 
                    dao.CustomerCaresDAO dao = new dao.CustomerCaresDAO();
                    java.util.List<dto.CustomerCaresDTO> tickets = dao.getTicketsByStatus("new");
                    request.setAttribute("tickets", tickets);
                %>
                
                <c:if test="${not empty tickets}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>Ticket ID</th>
                                <th>User ID</th>
                                <th>Subject</th>
                                <th>Content</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${tickets}" var="ticket">
                                <tr>
                                    <td>${ticket.ticketID}</td>
                                    <td>${ticket.userID}</td>
                                    <td>${ticket.subject}</td>
                                    <td>${ticket.content}</td>
                                    <td>
                                        <form action="MainController" method="POST">
                                            <input type="hidden" name="action" value="ReplyFeedback"/>
                                            <input type="hidden" name="ticketID" value="${ticket.ticketID}"/>
                                            <label>Reply:</label>
                                            <textarea name="reply" required></textarea><br/>
                                            <input type="submit" value="Send Reply"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
                <c:if test="${empty tickets}">
                    <p>No new tickets available.</p>
                </c:if>
            </c:if>
            <c:if test="${sessionScope.login.roleID != 'CS'}">
                <p style="color: red;">Only Customer Service agents can access this page.</p>
            </c:if>
        </c:if>
        
        <!-- Hiển thị thông báo -->
        <c:if test="${not empty message}">
            <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.message}</p>
        </c:if>
    </body>
</html>