<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="dto.UserDTO" %>

<%
    UserDTO loginUser = (UserDTO) session.getAttribute("login");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Shoppy | Giỏ Hàng</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <style>
        html,body {
            height: 100%;
            background-color:  #f5f5f5;
        }
        .header { box-shadow: 0 2px 10px rgba(0,0,0,0.2); }
        .header-bottom p { color: #FF792B; }
        .header-bottom { background-color: #fff; }
        .header-top {
            background: linear-gradient(180deg, rgba(253, 29, 29, 1) 0%, rgba(255, 121, 43, 1) 100%);
        }
        .logo {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: white !important;
            font-weight: bold;
            font-size: 28px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logo img {
            width: 45px;
            height: 45px;
            filter: drop-shadow(0 2px 3px rgba(0,0,0,0.3));
        }
        .custom-checkbox {
            position: relative;
            padding-left: 30px;
            cursor: pointer;
            user-select: none;
        }
        .custom-checkbox input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }
        .custom-checkbox .checkmark {
            position: absolute;
            top: -5px;
            left: 0;
            height: 20px;
            width: 20px;
            background-color: #eee;
            border: 2px solid #FF792B;
            border-radius: 4px;
        }
        .custom-checkbox input:checked ~ .checkmark {
            background-color: #FF792B;
        }
        .custom-checkbox .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }
        .custom-checkbox input:checked ~ .checkmark:after {
            display: block;
        }
        .custom-checkbox .checkmark:after {
            left: 5px;
            top: 1px;
            width: 6px;
            height: 12px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
        }
        .cart-img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 5px;
        }
        .sticky-footer {
            position: sticky;
            bottom: 0;
            background-color: white;
            padding: 10px;
            border-top: 1px solid #ccc;
            z-index: 1000;
        }
        .footer-line {
            background: linear-gradient(90deg, rgba(253, 29, 29, 1) 0%, rgba(252, 176, 69, 1) 100%);
        }
        .cus-check2 { left: -2px; }
    </style>
</head>
<body onload="updateCartTotal()"> 
    <div class="header">
        <div class="header-top">
            <div class="header-top-left"></div>
            <div class="header-top-right">
                <span class="welcome-text font-weight-light" style="display: inline-block;">
                    Welcome, ${sessionScope.login.fullName}!
                </span>
            </div>
        </div>
        <div class="header-bottom p-3">
            <div class="inner-header-bottom row">
                <div class="header-bottom-left col-md-3">
                    <div class="logo">
                        <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                        <p>Shoppy | Giỏ Hàng</p>
                    </div>
                </div>
                <div class="header-bottom-right col-md-6">
                    <form action="MainController" method="GET" class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Tìm sản phẩm...">
                        <input type="hidden" name="action" value="searchProduct">
                        <div class="input-group-append">
                            <button class="btn btn-solid-primary search-btn" type="submit">🔍</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="section">
        <div class="container bg-white">
            <div class="row font-weight-bold border-bottom py-4 align-items-md-center mt-3 justify-content-center">
                <div class="col-1 d-flex justify-content-center">
                    <label class="custom-checkbox">
                        <input type="checkbox" class="selectAll">
                        <span class="checkmark"></span>
                    </label>
                </div>
                <div class="col-3">Sản Phẩm</div>
                <div class="col-2 text-center">Đơn Giá</div>
                <div class="col-2 text-center">Số Lượng</div>
                <div class="col-2 text-center">Số Tiền</div>
                <div class="col-2 text-center">Thao Tác</div>
            </div>
        </div>
        <c:if test="${not empty cartItems}">
            <div class="container bg-white mt-2">
                <c:forEach var="item" items="${cartItems}">
                    <div class="row align-items-center py-3 border-bottom">
                        <div class="col-1 d-flex justify-content-center">
                            <label class="custom-checkbox">
                                <input type="checkbox" class="cart-checkbox">
                                <span class="checkmark"></span>
                            </label>
                        </div>
                        <div class="col-3 d-flex">
                            <img src="${item.getImgUrl()}" alt="${item.getProductName()}" class="img-thumbnail mr-2 cart-img">
                            <div>
                                <div>${item.getProductName()}</div>
                                <small class="text-muted">Phân loại hàng: </small>
                            </div>
                        </div>
                        <div class="col-2 text-center text-muted">
                            <del>₫<fmt:formatNumber value="${item.getSalePrice()}" type="number" groupingUsed="true" /></del>
                            <br>
                            <span class="text-danger">₫<fmt:formatNumber value="${item.getPrice()}" type="number" groupingUsed="true" /></span>
                        </div>
                        <div class="col-2 text-center">
                            <div class="input-group justify-content-center">
                                <div class="input-group-prepend">
                                    <button class="btn btn-light border-dark btn-minus" data-productid="${item.getProductID()}" data-price="${item.getPrice()}">-</button>
                                </div>
                                <input type="text" class="form-control text-center pr-2 pl-2 quantity-input" value="${item.getQuantity()}" style="max-width: 50px;" readonly data-productid="${item.getProductID()}" data-price="${item.getPrice()}">
                                <div class="input-group-append">
                                    <button class="btn btn-light border-dark btn-plus" data-productid="${item.getProductID()}" data-price="${item.getPrice()}">+</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-2 text-center text-danger">
                            ₫<span class="item-total" data-productid="${item.getProductID()}">
                                <fmt:formatNumber value="${item.getPrice() * item.getQuantity()}" type="number" groupingUsed="true" />
                            </span>
                        </div>
                        <div class="col-2 text-center"><a href="#" class="text-danger">Xóa</a></div>
                    </div>
                </c:forEach>
            </div>
            <div class="d-flex container justify-content-between align-items-center mt-2 border-top pt-3 sticky-footer">
                <div class="buy-section d-flex justify-content-center align-items-center pl-4">
                    <div class="buy-section d-flex align-items-center">
                        <label class="custom-checkbox cus-check2">
                            <input type="checkbox" class="selectAll">
                            <span class="checkmark"></span>
                        </label>
                        <span>Tất cả | <a href="#" class="text-danger">Xoá</a></span>
                    </div>
                </div>
                <div>
                    Tổng cộng (sản phẩm đã chọn: <span id="selected-count">0</span>, số lượng: <span id="total-quantity">0</span>): <span class="text-danger font-weight-bold" id="cart-total">₫0</span>
                    <button class="btn btn-danger ml-3">Mua Hàng</button>
                </div>
            </div>
        </c:if>
        <c:if test="${empty cartItems}">
            <div class="d-flex justify-content-center">
                <p>Không có sản phẩm trong giỏ hàng</p>
            </div>
        </c:if>
    </div>
    <%@include file="footer.jsp" %>
</body>

<script>
    const selectAllCheckboxes = document.querySelectorAll(".selectAll");
    const itemCheckboxes = document.querySelectorAll(".cart-checkbox");

    // Đồng bộ checkbox Tất cả
    selectAllCheckboxes.forEach(selectAllCheckbox => {
        selectAllCheckbox.addEventListener("change", function () {
            const isChecked = this.checked;
            itemCheckboxes.forEach(cb => cb.checked = isChecked);
            selectAllCheckboxes.forEach(cb => cb.checked = isChecked);
            updateCartTotal(); // Cập nhật lại tổng khi chọn/bỏ tất cả
        });
    });

    // Nếu 1 checkbox thay đổi, cập nhật trạng thái "Tất cả"
    itemCheckboxes.forEach(cb => {
        cb.addEventListener("change", function () {
            const allChecked = Array.from(itemCheckboxes).every(c => c.checked);
            selectAllCheckboxes.forEach(cb => cb.checked = allChecked);
            updateCartTotal(); // Cập nhật lại tổng khi tick/bỏ từng cái
        });
    });

    // Định dạng VND
    function formatCurrency(amount) {
        return amount.toLocaleString('vi-VN');
    }

    // Cập nhật lại giá cho từng item
    function updateTotal(productId, price, quantity) {
        document.querySelectorAll(".item-total").forEach(el => {
            if (el.dataset.productid === productId) {
                el.textContent = formatCurrency(price * quantity);
            }
        });
        updateCartTotal(); // Gọi lại tổng tiền
    }

    // Cập nhật tổng tiền chỉ các sản phẩm được tick
    function updateCartTotal() {
        let total = 0;
        let count = 0;
        let totalQuantity = 0;
        document.querySelectorAll(".quantity-input").forEach(input => {
            const row = input.closest(".row");
            const checkbox = row.querySelector(".cart-checkbox");
            if (checkbox && checkbox.checked) {
                const price = parseFloat(input.dataset.price);
                const quantity = parseInt(input.value);
                if (!isNaN(price) && !isNaN(quantity)) {
                    total += price * quantity;
                    count += 1;
                    totalQuantity+=quantity;
                }
            }
        });
        document.querySelector("#cart-total").textContent = '₫' + formatCurrency(total);
        document.querySelector("#selected-count").textContent = count;
        document.querySelector("#total-quantity").textContent = totalQuantity;
    }

    // Nút tăng số lượng
    document.querySelectorAll(".btn-plus").forEach(btn => {
        btn.addEventListener("click", function () {
            const input = this.closest(".input-group").querySelector(".quantity-input");
            let quantity = parseInt(input.value);
            const price = parseFloat(this.dataset.price);
            const productId = this.dataset.productid;

            if (!isNaN(quantity)) {
                quantity++;
                input.value = quantity;
                updateTotal(productId, price, quantity);
                updateQuantityDebounced(productId, quantity);
                
            }
        });
    });

    // Nút giảm số lượng
    document.querySelectorAll(".btn-minus").forEach(btn => {
        btn.addEventListener("click", function () {
            const input = this.closest(".input-group").querySelector(".quantity-input");
            let quantity = parseInt(input.value);
            const price = parseFloat(this.dataset.price);
            const productId = this.dataset.productid;

            if (!isNaN(quantity) && quantity > 1) {
                quantity--;
                input.value = quantity;
                updateTotal(productId, price, quantity);
                updateQuantityDebounced(productId, quantity);
            }
        });
    });

    // Gọi khi trang vừa load
    window.onload = updateCartTotal;
    function updateQuantityAjax(productId, quantity) {
    fetch("MainController", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: `action=UpdateCart&productId=`+productId+`&quantity=`+quantity
        })
        .then(response => response.text())
        .then(data => {
            
        })
        .catch(err => {
            console.error("Lỗi kết nối:", err);
        });
    }
    let debounceTimeout;
    function updateQuantityDebounced(productId, quantity) {
        clearTimeout(debounceTimeout);
        debounceTimeout = setTimeout(() => {
            updateQuantityAjax(productId, quantity);
        }, 300); // chỉ gửi sau 300ms kể từ lần nhấn cuối
    }

</script>
</html>
