<%-- 
    Document   : addNotification
    Created on : Jun 30, 2025, 1:58:31 PM
    Author     : loan1
--%>

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
        <title>Tạo Thông Báo Mới</title>
        <!-- CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/header.css">
        <link rel="stylesheet" href="css/footer.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            body {
                background-color: #f8f9fa;
            }
            .btn-orange {
                background-color: #ff5d00;
                color: white;
                font-weight: bold;
            }
            .btn-orange:hover {
                background-color: #e65100;
            }
            .form-container {
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            label {
                font-weight: 500;
            }
            h2.title {
                color: #c64600;
                font-weight: bold;
                margin-bottom: 30px;
            }
            /* Ẩn thanh tìm kiếm trong header nếu có */
            #searchForm {
                display: none !important;
            }
        </style>
    </head>

    <body class="container-fluid px-0">
        <jsp:include page="header.jsp"/>

        <div class="container mt-5 mb-5 px-5">
            <div class="row justify-content-center">
                <div class="col-md-8 form-container">

                    <h2 class="text-center title">Tạo Thông Báo Mới</h2>

                    <!-- THÔNG BÁO -->
                    <c:if test="${not empty sessionScope.MESSAGE}">
                        <div class="alert alert-success">${sessionScope.MESSAGE}</div>
                        <c:remove var="MESSAGE" scope="session"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.ERROR}">
                        <div class="alert alert-danger">${sessionScope.ERROR}</div>
                        <c:remove var="ERROR" scope="session"/>
                    </c:if>

                    <!-- FORM -->
                    <form action="MainController" method="post">
                        <input type="hidden" name="action" value="createNotification"/>

                        <!-- UserID -->
                        <div class="mb-3">
                            <label class="form-label">Người nhận (UserID)</label>
                            <input type="text" class="form-control" name="userID" placeholder="Nhập UserID người nhận" required />
                        </div>

                        <!-- Event Type -->
                        <div class="mb-3">
                            <label class="form-label">Loại sự kiện</label>
                            <select class="form-select" name="eventType" required>
                                <option value="">-- Chọn loại --</option>
                                <option value="Order">Order</option>
                                <option value="Return">Return</option>
                                <option value="Promotion">Promotion</option>
                                <option value="CustomerCare">CustomerCare</option>
                                <option value="System">System</option>
                                <option value="Another">Khác</option>
                            </select>
                        </div>

                        <!-- Message -->
                        <div class="mb-3">
                            <label class="form-label">Nội dung thông báo</label>
                            <textarea class="form-control" name="message" rows="4" required></textarea>
                        </div>

                        <!-- Buttons -->
                        <div class="text-end">
                            <button type="submit" class="btn btn-orange px-4">Gửi Thông Báo</button>
                            <a href="MainController?action=notificationList" class="btn btn-secondary ms-2">Quay lại</a>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
