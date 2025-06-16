<%-- 
    Document   : userList
    Created on : 16-Jun-2025, 04:18:32
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
    </head>
    <body>
        <h1>User Management</h1>
        <a href="welcome.jsp">Back to Welcome</a> | <a href="logout">Logout</a>
        
        <!-- Form to search users -->
        <h3>Search Users</h3>
        <form action="mainController" method="GET">
            <input type="hidden" name="action" value="searchUser"/>
            <input type="text" name="searchUser" value="${requestScope.searchUser}" placeholder="Search by ID, Name, or Role"/>
            <input type="submit" value="Search"/>
        </form>
        
        <!-- Form to create a new user -->
        <h3>Create New User</h3>
        <form action="mainController" method="POST">
            <input type="hidden" name="action" value="createUser"/>
            <label>User ID:</label>
            <input type="text" name="userID" required/><br/>
            <label>Full Name:</label>
            <input type="text" name="fullName" required/><br/>
            <label>Role ID:</label>
            <input type="text" name="roleID" required/><br/>
            <label>Password:</label>
            <input type="password" name="password" required/><br/>
            <label>Phone:</label>
            <input type="text" name="phone" required/><br/>
            <input type="submit" value="Create User"/>
        </form>
        
        <!-- Display message if any -->
        <c:if test="${not empty requestScope.MSG}">
            <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.MSG}</p>
        </c:if>
        
        <!-- Display user list -->
        <h3>User List</h3>
        <c:if test="${not empty requestScope.listUsers}">
            <table border="1">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Full Name</th>
                        <th>Role ID</th>
                        <th>Phone</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${requestScope.listUsers}" var="user">
                        <tr>
                            <td>${user.userID}</td>
                            <td>${user.fullName}</td>
                            <td>${user.roleID}</td>
                            <td>${user.phone}</td>
                            <td>
                                <!-- Form to update user -->
                                <form action="mainController" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="updateUser"/>
                                    <input type="hidden" name="userID" value="${user.userID}"/>
                                    <input type="hidden" name="searchUser" value="${requestScope.searchUser}"/>
                                    <input type="text" name="fullName" value="${user.fullName}" required/>
                                    <input type="text" name="roleID" value="${user.roleID}" required/>
                                    <input type="password" name="password" placeholder="New password"/>
                                    <input type="text" name="phone" value="${user.phone}" required/>
                                    <input type="submit" value="Update"/>
                                </form>
                                <!-- Form to delete user -->
                                <form action="mainController" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="deleteUser"/>
                                    <input type="hidden" name="userID" value="${user.userID}"/>
                                    <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this user?');"/>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty requestScope.listUsers}">
            <p>No users found.</p>
        </c:if>
    </body>
</html>