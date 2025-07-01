<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO" %>
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
        <title>Danh sách thương hiệu</title>
        <link rel="stylesheet" href="css/tableList.css">
        <style>
            /* Modal Styling */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                width: 400px;
                max-width: 90%;
            }
            .modal-content h2 {
                margin-top: 0;
            }
            .modal-content form {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            .modal-content input, .modal-content textarea, .modal-content select {
                padding: 8px;
                font-size: 14px;
            }
            .modal-content button {
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                cursor: pointer;
            }
            .modal-content button:hover {
                background-color: #218838;
            }
            .modal-content .close {
                background-color: #dc3545;
                margin-top: 10px;
            }
            .modal-content .close:hover {
                background-color: #c82333;
            }
            .form-message {
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 3px;
            }
            .form-message.success {
                background-color: #d4edda;
                color: #155724;
            }
            .form-message.error {
                background-color: #f8d7da;
                color: #721c24;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <div class="header-top">
            </div>
            <div class="header-top">
                <div class="header-top-left">
                    <div class="logo">
                        <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                        Shoppy
                    </div>
                </div>
                <div class="header-top-right">
                    <span class="welcome-text">Welcome, ${sessionScope.login.fullName}!</span>
                </div>
            </div>
        </div>
        <header class="main-header">
            <nav class="main-nav">
                <div class="header-left">
                    <a href="MainController?action=homePage">HOME</a>
                    <a href="MainController?action=productList">Danh Sách Sản Phẩm</a>
                    <a href="MainController?action=searchCategory">Danh Sách Danh Mục</a>
                    <a href="MainController?action=searchBrand" class="active">Danh Sách Thương Hiệu</a>
                    <a href="MainController?action=searchUser">Danh Sách Khách Hàng</a>
                    <a href="MainController?action=searchFAQ&sourcePage=faqList">Danh sách FAQ</a>
                </div>
                <div class="header-right">
                    <a href="MainController?action=logout">Đăng Xuất</a>
                </div>
            </nav>
        </header>

        <div class="container">
            <div class="title">
                <h1>Danh sách thương hiệu</h1>
            </div>

            <c:if test="${not empty MSG}">
                <div class="form-message success">${MSG}</div>
            </c:if>

            <c:if test="${not empty ERROR}">
                <div class="form-message error">${ERROR}</div>
            </c:if>

            <div class="search-create-wrapper">
                <form class="search-form" action="SearchBrandController" method="post">
                    <input type="text" name="keyword" placeholder="Tìm kiếm thương hiệu..." value="${param.keyword}" />
                    <button type="submit">Tìm kiếm</button>
                </form>

                <button class="create-button" onclick="openCreateModal()">+ Thêm thương hiệu mới</button>
            </div>

            <c:if test="${not empty brandList}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên thương hiệu</th>
                            <th>Mô tả</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${brandList}">
                            <tr>
                                <td>${b.brandID}</td>
                                <td>${b.brandName}</td>
                                <td>${b.description}</td>
                                <td>${b.status}</td>
                                <td>
                                    <a class="action-link" href="#" onclick="openUpdateModal('${b.brandID}', '${b.brandName}', '${b.description}', '${b.status}')">Sửa</a> |
                                    <a class="action-link" href="DeleteBrandController?brandID=${b.brandID}" onclick="return confirm('Bạn có chắc muốn xóa?')">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty brandList}">
                <p>Không tồn tại thương hiệu.</p>
            </c:if>

            <!-- Create Brand Modal -->
            <div id="createModal" class="modal">
                <div class="modal-content">
                    <h2>Thêm thương hiệu mới</h2>
                    <div id="createMessage"></div>
                    <form id="createBrandForm">
                        <input type="text" name="brandID" placeholder="ID thương hiệu" required />
                        <input type="text" name="brandName" placeholder="Tên thương hiệu" required />
                        <textarea name="description" placeholder="Mô tả"></textarea>
                        <select name="status" required>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                        <button type="submit">Tạo</button>
                        <button type="button" class="close" onclick="closeCreateModal()">Đóng</button>
                    </form>
                </div>
            </div>

            <!-- Update Brand Modal -->
            <div id="updateModal" class="modal">
                <div class="modal-content">
                    <h2>Sửa thương hiệu</h2>
                    <div id="updateMessage"></div>
                    <form id="updateBrandForm">
                        <input type="text" name="brandID" id="updateBrandID" readonly />
                        <input type="text" name="brandName" id="updateBrandName" placeholder="Tên thương hiệu" required />
                        <textarea name="description" id="updateDescription" placeholder="Mô tả"></textarea>
                        <select name="status" id="updateStatus" required>
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                        <button type="submit">Cập nhật</button>
                        <button type="button" class="close" onclick="closeUpdateModal()">Đóng</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Create Modal Functions
            function openCreateModal() {
                document.getElementById('createModal').style.display = 'flex';
                document.getElementById('createMessage').innerHTML = '';
                document.getElementById('createBrandForm').reset();
            }

            function closeCreateModal() {
                document.getElementById('createModal').style.display = 'none';
            }

            // Update Modal Functions
            function openUpdateModal(brandID, brandName, description, status) {
                document.getElementById('updateModal').style.display = 'flex';
                document.getElementById('updateMessage').innerHTML = '';
                document.getElementById('updateBrandID').value = brandID;
                document.getElementById('updateBrandName').value = brandName;
                document.getElementById('updateDescription').value = description;
                document.getElementById('updateStatus').value = status;
            }

            function closeUpdateModal() {
                document.getElementById('updateModal').style.display = 'none';
            }

            // Handle Create Form Submission
            document.getElementById('createBrandForm').addEventListener('submit', function(e) {
                e.preventDefault();
                const formData = new FormData(this);
                fetch('CreateBrand', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    if (data.includes('Brand đã được tạo thành công')) {
                        document.getElementById('createMessage').innerHTML = '<div class="form-message success">Tạo thương hiệu thành công!</div>';
                        setTimeout(() => {
                            window.location.href = 'MainController?action=searchBrand';
                        }, 1000);
                    } else {
                        document.getElementById('createMessage').innerHTML = '<div class="form-message error">' + (data.includes('brand đã tồn tại') ? 'ID thương hiệu đã tồn tại!' : 'Lỗi khi tạo thương hiệu!') + '</div>';
                    }
                })
                .catch(error => {
                    document.getElementById('createMessage').innerHTML = '<div class="form-message error">Lỗi hệ thống!</div>';
                });
            });

            // Handle Update Form Submission
            document.getElementById('updateBrandForm').addEventListener('submit', function(e) {
                e.preventDefault();
                const formData = new FormData(this);
                fetch('UpdateBrandController', {
                    method: 'POST',
                    body: formData
                })
                .then(response => response.text())
                .then(data => {
                    if (data.includes('Cập nhật danh mục thành công')) {
                        document.getElementById('updateMessage').innerHTML = '<div class="form-message success">Cập nhật thương hiệu thành công!</div>';
                        setTimeout(() => {
                            window.location.href = 'MainController?action=searchBrand';
                        }, 1000);
                    } else {
                        document.getElementById('updateMessage').innerHTML = '<div class="form-message error">Lỗi khi cập nhật thương hiệu!</div>';
                    }
                })
                .catch(error => {
                    document.getElementById('updateMessage').innerHTML = '<div class="form-message error">Lỗi hệ thống!</div>';
                });
            });
        </script>
    </body>
</html>