<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <title>Cập nhật sản phẩm</title>
        <link rel="stylesheet" href="css/form.css"/>
    </head>
    <body>

        <div class="wide-form-layout">
            <h2 class="form-title">Cập nhật sản phẩm</h2>

            <c:if test="${not empty MSG}">
                <div class="form-message success">${MSG}</div>
            </c:if>

            <c:if test="${not empty ERROR}">
                <div class="form-message error">${ERROR}</div>
            </c:if>


            <form action="UpdateProductController" method="post" enctype="multipart/form-data" class="wide-form">
                <input type="hidden" name="productID" value="${product.productID}" />

                <!-- Bên trái -->
                <div class="form-left">
                    <div class="form-group">
                        <label class="form-label">Tên sản phẩm <span>*</span></label>
                        <input type="text" name="name" class="form-input" value="${product.name}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Giá <span>*</span></label>
                        <input type="number" name="price" class="form-input" min="0" step="0.01"
                               value="<fmt:formatNumber value='${product.price}' type='number' groupingUsed='false' maxFractionDigits='2'/>" required>

                    </div>

                    <div class="form-group">
                        <label class="form-label">Ảnh sản phẩm (chọn nếu muốn thay)</label>
                        <input type="file" name="image" class="form-file" accept="image/*">
                        <input type="hidden" name="oldImageUrl" value="${product.imgUrl}" />
                        <c:if test="${not empty product.imgUrl}">
                            <img src="${pageContext.request.contextPath}/${product.imgUrl}" alt="Ảnh sản phẩm" width="150" style="margin-top:10px; border:1px solid #ddd; border-radius:6px;"/>
                        </c:if>
                    </div>


                </div>

                <!-- Bên phải -->
                <div class="form-right">
                    <div class="form-group">
                        <label class="form-label">Danh mục <span>*</span></label>
                        <select name="categoryID" class="form-select" required>
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.categoryID}" <c:if test="${cat.categoryID == product.categoryID}">selected</c:if>>${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Số lượng <span>*</span></label>
                        <input type="number" name="quantity" class="form-input" min="1" value="${product.quantity}" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Trạng thái <span>*</span></label>
                        <select name="status" class="form-select" required>
                            <option value="active" ${product.status == 'active' ? 'selected' : ''}>Đang bán</option>
                            <option value="inactive" ${product.status == 'inactive' ? 'selected' : ''}>Ngừng bán</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Mô tả</label>
                        <textarea name="description" class="form-textarea">${product.description}</textarea>
                    </div>

                    <input type="hidden" name="sellerID" value="${loginUser.userID}" />
                </div>

                <!-- Nút -->
                <div class="form-bottom">
                    <button type="submit" class="form-button">Cập nhật sản phẩm</button>
                    <div>
                        <a href="MainController?action=productList" class="form-cancel">Hủy</a>
                    </div>
                </div>
            </form>
        </div>

    </body>
</html>
