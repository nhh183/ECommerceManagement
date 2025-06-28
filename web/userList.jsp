<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User List - E-Commerce Store</title>
    <style>
        /* === RESET & BASE === */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
            background-color: #fff;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .container {
            width: 80%;
            margin: 0 auto;
        }

        /* === HEADER === */
        .header {
            background-color: #FFF5E6; /* Nền cam nhạt */
            padding: 15px 0;
            border-bottom: 1px solid #FFD8B1; /* Viền cam nhạt */
        }

        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #FF6B00; /* Màu cam chủ đạo */
            float: left;
        }

        .user-actions {
            float: right;
            margin-top: 6px;
        }

        .user-actions a {
            margin-left: 10px;
            font-weight: bold;
            color: #FF6B00; /* Màu cam */
        }

        .user-actions a:hover {
            color: #E55D00; /* Cam đậm hơn khi hover */
            text-decoration: underline;
        }

        /* === NAVIGATION === */
        .nav-menu {
            display: flex;
            flex-wrap: wrap;
            list-style: none;
            padding: 15px 0;
            gap: 20px;
            border-top: 1px solid #FFD8B1;
            border-bottom: 1px solid #FFD8B1;
            margin-top: 20px;
            background-color: #FFF5E6; /* Nền cam nhạt */
        }

        .nav-menu li a {
            font-weight: bold;
            padding: 8px 10px;
            border-radius: 4px;
            color: #333;
            transition: all 0.3s ease;
        }

        .nav-menu li a:hover {
            background-color: #FF6B00;
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(255, 107, 0, 0.3);
        }

        /* === MAIN CONTENT === */
        .main-content {
            padding: 40px 0;
        }

        h1, h3 {
            color: #FF6B00; /* Tiêu đề màu cam */
            margin-bottom: 20px;
            border-bottom: 2px solid #FFD8B1;
            padding-bottom: 10px;
        }

        /* === BUTTONS === */
        .add-user-button {
            padding: 8px 12px;
            background-color: #FF6B00; /* Nút màu cam */
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .add-user-button:hover {
            background-color: #E55D00;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(255, 107, 0, 0.3);
        }

        /* === FORMS === */
        .search-form {
            background-color: #FFF5E6; /* Nền cam nhạt */
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(255, 107, 0, 0.1);
            border: 1px solid #FFD8B1;
        }

        .search-form input[type="text"] {
            padding: 8px;
            width: 250px;
            border: 1px solid #FFD8B1;
            border-radius: 4px;
            margin-right: 10px;
        }

        .search-form input[type="submit"] {
            padding: 8px 12px;
            background-color: #FF6B00;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .search-form input[type="submit"]:hover {
            background-color: #E55D00;
            transform: translateY(-2px);
        }

        /* === MODAL === */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: #FFF5E6;
            padding: 20px;
            border-radius: 8px;
            width: 400px;
            max-width: 90%;
            box-shadow: 0 4px 16px rgba(255, 107, 0, 0.2);
            position: relative;
            border: 1px solid #FFD8B1;
        }

        .modal-content h3 {
            margin-top: 0;
            color: #FF6B00;
        }

        .close-button {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 20px;
            color: #FF6B00;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .close-button:hover {
            color: #E55D00;
            transform: scale(1.1);
        }

        .create-form label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #FF6B00;
        }

        .create-form input[type="text"], .create-form input[type="password"] {
            padding: 8px;
            width: 200px;
            border: 1px solid #FFD8B1;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        .create-form input[type="submit"] {
            padding: 8px 12px;
            background-color: #FF6B00;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .create-form input[type="submit"]:hover {
            background-color: #E55D00;
            transform: translateY(-2px);
        }

        .create-form .error {
            color: #FF3333;
            font-size: 12px;
            margin-left: 110px;
            display: none;
        }

        /* === TABLE === */
        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(255, 107, 0, 0.1);
            border: 1px solid #FFD8B1;
        }

        .user-table th, .user-table td {
            padding: 12px;
            text-align: left;
            border: 1px solid #FFD8B1;
        }

        .user-table th {
            background-color: #FF6B00; /* Header bảng màu cam */
            color: white;
            font-weight: bold;
        }

        .user-table tr:nth-child(even) {
            background-color: #FFF5E6; /* Hàng chẵn màu cam nhạt */
        }

        .user-table tr:hover {
            background-color: #FFE4CC; /* Hover màu cam sáng */
        }

        .user-table input[type="text"], .user-table input[type="password"] {
            padding: 6px;
            border: 1px solid #FFD8B1;
            border-radius: 4px;
            margin-right: 5px;
        }

        .user-table input[type="submit"] {
            padding: 6px 10px;
            background-color: #FF6B00;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .user-table input[type="submit"]:hover {
            background-color: #E55D00;
            transform: scale(1.05);
        }

        .user-table input[value="Delete"] {
            background-color: #FF3333; /* Nút xóa màu đỏ cam */
        }

        .user-table input[value="Delete"]:hover {
            background-color: #CC0000;
        }

        /* === MESSAGES === */
        p[style*="color:"] {
            font-weight: bold;
            text-align: center;
            margin: 20px 0;
            padding: 10px;
            border-radius: 4px;
        }

        /* === FOOTER === */
        .footer {
            background-color: #FF6B00; /* Footer màu cam */
            color: white;
            padding: 20px 0;
            text-align: center;
            font-weight: bold;
        }

        /* === RESPONSIVE DESIGN === */
        @media (max-width: 768px) {
            .container {
                width: 95%;
            }

            .nav-menu {
                flex-direction: column;
                gap: 10px;
            }

            .search-form input[type="text"] {
                width: 100%;
                margin-bottom: 10px;
            }

            .create-form input[type="text"], .create-form input[type="password"] {
                width: 100%;
            }

            .user-table {
                font-size: 14px;
            }

            .modal-content {
                width: 90%;
            }
        }

        @media (max-width: 480px) {
            .user-table th, .user-table td {
                padding: 8px;
                font-size: 12px;
                display: block;
                width: 100%;
            }

            .user-table tr {
                margin-bottom: 15px;
                display: block;
                border: 1px solid #FFD8B1;
            }

            .user-table input[type="text"], .user-table input[type="password"] {
                width: 100%;
                margin-bottom: 5px;
            }

            .create-form label {
                width: auto;
                display: block;
            }

            .create-form .error {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="container">
            <div class="logo">E-Commerce Store</div>
            <div class="user-actions">
                <c:if test="${not empty sessionScope.login}">
                    <span>Welcome, ${sessionScope.login.fullName}!</span>
                    <a href="logout">Logout</a>
                    <a href="homePage.jsp">Back to Home</a>
                </c:if>
            </div>
            <ul class="nav-menu">
                <li><a href="MainController?action=homePage">HOME</a></li>
                <c:if test="${sessionScope.login.roleID == 'AD'}">
                    <li><a href="MainController?action=searchUser">Manage Users</a></li>
                    <li><a href="MainController?action=searchCategory">Manage Categories</a></li>
                </c:if>
                <c:if test="${sessionScope.login.roleID == 'CS'}">
                    <li><a href="feedbackAdmin.jsp">Manage Feedback</a></li>
                </c:if>
            </ul>
        </div>
    </div>

    <div class="main-content">
        <div class="container">
            <h1>User Management</h1>

            <!-- Form to search users -->
            <div class="search-form">
                <h3>Search Users</h3>
                <form action="MainController" method="GET">
                    <input type="hidden" name="action" value="searchUser"/>
                    <input type="text" name="searchUser" value="${requestScope.searchUser}" placeholder="Search by ID, Name, or Role"/>
                    <input type="submit" value="Search"/>
                </form>
            </div>

            <!-- Button to open create user modal -->
            <button class="add-user-button" onclick="openModal()">Add New User</button>

            <!-- Modal for create user form -->
            <div id="createUserModal" class="modal">
                <div class="modal-content">
                    <span class="close-button" onclick="closeModal()">&times;</span>
                    <h3>Create New User</h3>
                    <form id="createUserForm" action="CreateUserController" method="POST" class="create-form">
                        <input type="hidden" name="sourcePage" value="userList">
                        <input type="hidden" name="action" value="createUser"/>
                        <label>User ID:</label>
                        <input type="text" name="userID" id="userID" required/>
                        <span class="error" id="userIDError"></span><br/>
                        <label>Full Name:</label>
                        <input type="text" name="fullName" id="fullName" required/>
                        <span class="error" id="fullNameError"></span><br/>
                        <label>Role ID:</label>
                        <input type="text" name="roleID" id="roleID" required/>
                        <span class="error" id="roleIDError"></span><br/>
                        <label>Password:</label>
                        <input type="password" name="password" id="password" required/>
                        <span class="error" id="passwordError"></span><br/>
                        <label>Phone:</label>
                        <input type="text" name="phone" id="phone" required/>
                        <span class="error" id="phoneError"></span><br/>
                        <input type="submit" id="submitButton" value="Create User"/>
                    </form>
                </div>
            </div>

            <!-- Display message if any -->
            <c:if test="${not empty requestScope.MSG}">
                <p style="color: ${requestScope.MSG.contains('successfully') ? 'green' : 'red'}">${requestScope.MSG}</p>
            </c:if>

            <!-- Display user list -->
            <h3>User List</h3>
            <c:if test="${not empty requestScope.listUsers}">
                <table class="user-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Password</th>
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
                                <td>${user.password}</td>
                                <td>${user.roleID}</td>
                                <td>${user.phone}</td>
                                <td>
                                    <!-- Form to update user -->
                                    <form action="MainController" method="POST" style="display:inline;">
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
                                    <form action="MainController" method="POST" style="display:inline;">
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
        </div>
    </div>

    <div class="footer">
        <div class="container">
            <p>Ecommerce WordPress Theme</p>
        </div>
    </div>

    <script>
        // Modal control functions
        function openModal() {
            document.getElementById('createUserModal').style.display = 'flex';
            // Reset form and errors
            document.getElementById('createUserForm').reset();
            document.querySelectorAll('.error').forEach(error => error.style.display = 'none');
            document.getElementById('submitButton').value = 'Create User';
            document.getElementById('submitButton').disabled = false;
        }

        function closeModal() {
            document.getElementById('createUserModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('createUserModal');
            if (event.target === modal) {
                closeModal();
            }
        }

        // Form validation
        document.getElementById('createUserForm').addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent immediate form submission

            // Get form elements
            const userID = document.getElementById('userID').value.trim();
            const fullName = document.getElementById('fullName').value.trim();
            const roleID = document.getElementById('roleID').value.trim();
            const password = document.getElementById('password').value;
            const phone = document.getElementById('phone').value.trim();

            // Reset error messages
            document.querySelectorAll('.error').forEach(error => error.style.display = 'none');

            let isValid = true;

            // Validation rules
            if (!userID) {
                document.getElementById('userIDError').textContent = 'User ID is required.';
                document.getElementById('userIDError').style.display = 'block';
                isValid = false;
            } else if (userID.length < 3) {
                document.getElementById('userIDError').textContent = 'User ID must be at least 3 characters.';
                document.getElementById('userIDError').style.display = 'block';
                isValid = false;
            }

            if (!fullName) {
                document.getElementById('fullNameError').textContent = 'Full Name is required.';
                document.getElementById('fullNameError').style.display = 'block';
                isValid = false;
            } else if (fullName.length < 2) {
                document.getElementById('fullNameError').textContent = 'Full Name must be at least 2 characters.';
                document.getElementById('fullNameError').style.display = 'block';
                isValid = false;
            }

            if (!roleID) {
                document.getElementById('roleIDError').textContent = 'Role ID is required.';
                document.getElementById('roleIDError').style.display = 'block';
                isValid = false;
            } else if (!['AD', 'SE', 'BU', 'MK', 'AC', 'DL', 'CS'].includes(roleID.toUpperCase())) {
                document.getElementById('roleIDError').textContent = 'Invalid Role ID (must be AD, SE, BU, MK, AC, DL, or CS).';
                document.getElementById('roleIDError').style.display = 'block';
                isValid = false;
            }

            if (!password) {
                document.getElementById('passwordError').textContent = 'Password is required.';
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            } else if (password.length < 6) {
                document.getElementById('passwordError').textContent = 'Password must be at least 6 characters.';
                document.getElementById('passwordError').style.display = 'block';
                isValid = false;
            }

            if (!phone) {
                document.getElementById('phoneError').textContent = 'Phone is required.';
                document.getElementById('phoneError').style.display = 'block';
                isValid = false;
            } else if (!/^\d{10,15}$/.test(phone)) {
                document.getElementById('phoneError').textContent = 'Phone must be 10-15 digits.';
                document.getElementById('phoneError').style.display = 'block';
                isValid = false;
            }

            if (isValid) {
                if (confirm('Are you sure you want to create this user?')) {
                    const submitButton = document.getElementById('submitButton');
                    submitButton.value = 'Creating...';
                    submitButton.disabled = true;
                    this.submit(); // Submit the form
                }
            }
        });
    </script>
</body>
</html>