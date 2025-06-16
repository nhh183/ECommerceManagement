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
        <h1>Welcome, ${sessionScope.USER.fullName}!</h1>
        <a href="logout">Logout</a>
        
        <h2>Options</h2>
        <p><a href="mainController?action=searchUser">View User List</a></p>
    </body>
</html>