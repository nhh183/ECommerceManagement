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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        html,body {
            height: 100%;
            background-color:  #f5f5f5;
        }
        .header { box-shadow: 0 2px 10px rgba(0,0,0,0.2); }
        .header-bottom p { color: #FF792B; }
        .header-bottom { background-color: #fff; }
                /* === HEADER-TOP === */
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            padding-bottom: 10px;
            background: transparent;
            background: linear-gradient(180deg, rgba(253, 29, 29, 1) 0%, rgba(255, 121, 43, 1) 100%);
            
        }

        /* Trái & phải đều là flex để căn đồng đều */
        .header-top-left,
        .header-top-right {
            display: flex;
            align-items: center;
            gap: 5px;
            margin: 0 20px;
        }

        /* Danh sách bên trái */
        .header-nav-list {
            list-style: none;
            display: flex;
            gap: 20px;
            margin: 0;
            padding: 0;
            background: transparent;
            align-items: center;
        }

        .header-nav-list li a,
        .header-top-right .header-link {
            color: white;
            font-weight: 400;
            font-size: 13px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: opacity 0.2s ease;
        }

        .header-link i {
            color: white;
        }

        .header-link:hover {
            color: white;
            text-decoration: none !important;
            opacity: 0.85;
        }

        .header-link,
        .header-link:visited,
        .header-link:focus,
        .header-link:active,
        .header-link:hover {
            color: white !important;
        }
        /* === USER DROPDOWN === */
        .user-dropdown {
            position: relative;
            display: inline-block;
            margin-left: 10px;
        }

        .user-toggle {
            color: white;
            font-weight: 300;
            font-size: 13px;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
        }

        .user-menu {
            opacity: 0;
            visibility: hidden;
            position: absolute;
            right: 0;
            top: 130%;
            background-color: white;
            border-radius: 6px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.15);
            min-width: 150px;
            z-index: 99;
            transition: opacity 0.2s ease, visibility 0.2s ease;
        }

        .user-dropdown:hover .user-menu {
            opacity: 1;
            visibility: visible;
        }

        .user-menu a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s;
        }

        .user-menu a:hover {
            background-color: #f5f5f5;
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
        .support-link {
            margin-bottom: -8px;
            font-weight: 600;
            color: #E55D00;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .support-link:hover {
            color: #CC4A00;
            text-decoration: none;
        }
        .search-btn {
            background-color: #FD1D1D;
        }
        .header-brand{
            gap:2px;
        }

        .divider-line {
            font-size: 30px;
            font-weight: bold;
            color: #FFD4B0;
        }
        .cus-check2 { left: -2px; }
        .popover-container {
  position: relative;
  display: inline-block;
}

.lang-button {
  display: flex;
  align-items: center;
  gap: 4px;
  cursor: pointer;
  color: white;
  font-size: 14px;
}

.popover-box {
  position: absolute;
  top: 30px;
  right: 0;
  background: white;
  border: 1px solid rgba(0, 0, 0, 0.09);
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  border-radius: 4px;
  padding: 8px 0;
  display: none;
  z-index: 999;
  width: 150px;
}

.popover-container:hover .popover-box {
  display: block;
}

/* Mũi tên nhọn */
.popover-arrow {
  position: absolute;
  top: 1px;
  left: 50%;
  transform: translate(-7px, -100%);
  width: 0;
  height: 0;
  border-bottom: 10px solid rgba(0, 0, 0, 0.09);
  border-left: 0 solid transparent;
  border-right: 0 solid transparent;
}

.arrow-inner {
  position: absolute;
  bottom: -10px;
  border-bottom: 10px solid white;
  border-left: 14px solid transparent;
  border-right: 14px solid transparent;
}

/* Button chọn ngôn ngữ */
.lang-option {
  display: block;
  width: 100%;
  padding: 8px 16px;
  border: none;
  background: none;
  text-align: left;
  font-size: 14px;
  cursor: pointer;
  color: black;
}

.lang-option:hover {
  background-color: #f5f5f5;
}

.lang-option.active {
  color: #f53d2d;
  font-weight: bold;
}
    </style>
</head>
<body onload="updateCartTotal()"> 
    <div class="header">
        <div class="header-top d-flex align-items-center">
            <div class="container d-flex justify-content-between align-items-center">
                <div class="header-top-left">
                    <ul class="header-nav-list">
                        <!-- Mục cho CS -->
                        <c:if test="${sessionScope.login.roleID == 'CS'}">
                            <li><a class="header-link" href="MainController?action=activateSeller">
                                    <i class="fas fa-user-check"></i> Kích hoạt Seller
                                </a></li>
                            </c:if>

                        <!-- Mục cho SELLER -->
                        <c:if test="${sessionScope.login.roleID == 'SL'}">
                            <li><a class="header-link" href="MainController?action=productList">
                                    <i class="fas fa-box-open"></i> Sản phẩm của tôi
                                </a></li>
                            <li><a class="header-link" href="MainController?action=myOrders">
                                    <i class="fas fa-receipt"></i> Đơn hàng
                                </a></li>
                            </c:if>

                        <c:if test="${sessionScope.login.roleID == 'AD'}">
                            <li><a href="MainController?action=productList" class="header-link">
                                    <i class="fas fa-chart-line"></i> Trang Quản Trị
                                </a></li>
                            </c:if>
                    </ul>
                </div>


                <div class="header-top-right">
                    <a href="NotificationListController" class="header-link">
                        <i class="fas fa-bell"></i> Thông báo
                    </a>
                    <a href="MainController?action=searchFAQ&sourcePage=support" class="header-link">
                        <i class="fas fa-circle-question"></i> Hỗ trợ
                    </a>
                    <div class="popover-container">
                        <div class="popover-target">
                            <div class="lang-button">
                                <!-- Icon địa cầu -->
                                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                                  <path d="M8 14.667C11.682 14.667 14.667 11.682 14.667 8S11.682 1.333 8 1.333 1.333 4.318 1.333 8 4.318 14.667 8 14.667Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" />
                                  <path d="M5.333 8c0 3.682 1.194 6.667 2.667 6.667s2.667-2.985 2.667-6.667-1.194-6.667-2.667-6.667S5.333 4.318 5.333 8Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" />
                                  <path d="M1.333 8h13.334" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" />
                                </svg>
                                <span>Tiếng Việt</span>
                                <!-- Mũi tên xuống -->
                                <svg width="12" height="12" viewBox="0 0 12 12" fill="currentColor">
                                  <path d="M6 8.146L11.146 3l.707.707-5.146 5.147a1 1 0 01-1.414 0L.146 3.707.854 3 6 8.146z"/>
                                </svg>
                            </div>
                        </div>

                        <!-- Popover hiển thị khi hover -->
                        <div class="popover-box">
                          <div class="popover-arrow">
                            <div class="arrow-inner"></div>
                          </div>
                          <button class="lang-option active">Tiếng Việt</button>
                          <button class="lang-option">English</button>
                        </div>
                  </div>

                    <!-- Dropdown User -->
                    <div class="user-dropdown">
                        <div class="user-toggle">
                            <i class="fas fa-user"></i> ${sessionScope.login.fullName}
                            <i class="fas fa-caret-down"></i>
                        </div>
                        <div class="user-menu">
                            <a href="MainController?action=myOrders"><i class="fas fa-receipt"></i> Đơn mua</a>
                            <a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="header-bottom p-3">
            <div class="inner-header-bottom row">
                <div class="header-bottom-left col-md-3">
                    <div class="header-brand d-flex align-items-center justify-content-center">
                            <a href="MainController?action=homePage" >
                                <img src="images/logo_orange.svg" alt="Shop Logo" class="svg ">
                            </a>
                            <span class="divider-line">|</span>
                            <h2 class="support-link">Giỏ hàng</h2>
                    </div>
                </div>
                <div class="header-bottom-right col-md-6">
                    <form action="MainController" method="GET" class="input-group">
                        <input type="text" name="search" class="form-control" placeholder="Tìm sản phẩm...">
                        <input type="hidden" name="action" value="searchProduct">
                        <div class="input-group-append">
                            <button class="btn btn-solid-primary search-btn" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
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
            <form id="checkoutForm" method="post" action="MainController">
                <div class="container bg-white mt-2">

                    <c:forEach var="item" items="${cartItems}" >
                        <div class="row align-items-center py-3 border-bottom" id="product-${item.getProductID()}"
                                        ${selectedId != null && selectedId.equals(String.valueOf(item.getProductID())) ? 'data-selected="true"' : ''}>
                            <div class="col-1 d-flex justify-content-center">
                                <label class="custom-checkbox">
                                    <input type="checkbox" class="cart-checkbox" ${selectedId != null && selectedId.equals(String.valueOf(item.getProductID())) ? "checked" : ""}>
                                    <span class="checkmark"></span>
                                </label>
                            </div>
                            <div class="col-3 d-flex">
                                <img src="${item.getImgUrl()}" alt="${item.getProductName()}" class="img-thumbnail mr-2 cart-img">
                                <div>
                                    <div>${item.getProductName()}</div>
                                </div>
                            </div>
                            <div class="col-2 text-center text-muted">
                                <c:if test="${item.getPrice() != item.getSalePrice()}" >
                                    <del>₫<fmt:formatNumber value="${item.getPrice()}" type="number" groupingUsed="true" /></del>
                                    <br>
                                </c:if>
                                <span class="text-danger">₫<fmt:formatNumber value="${item.getSalePrice()}" type="number" groupingUsed="true" /></span>
                            </div>
                            <div class="col-2 text-center">
                                <div class="input-group justify-content-center">
                                    <div class="input-group-prepend">
                                        <button class="btn btn-light border-dark btn-minus" data-productid="${item.getProductID()}" data-price="${item.getSalePrice()}">-</button>
                                    </div>
                                    <input type="text" class="form-control text-center pr-2 pl-2 quantity-input" value="${item.getQuantity()}" style="max-width: 50px;" readonly data-productid="${item.getProductID()}" data-price="${item.getSalePrice()}">
                                    <div class="input-group-append">
                                        <button class="btn btn-light border-dark btn-plus" data-productid="${item.getProductID()}" data-price="${item.getSalePrice()}">+</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-2 text-center text-danger">
                                ₫<span class="item-total" data-productid="${item.getProductID()}">
                                    <fmt:formatNumber value="${item.getSalePrice() * item.getQuantity()}" type="number" groupingUsed="true"/>
                                </span>
                            </div>
                            <div class="col-2 text-center"><a href="#" class="text-danger btn-delete" data-productid="${item.getProductID()}">Xóa</a></div>
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
                        <button id="checkoutBtn" class="btn btn-danger ml-3">Mua Hàng</button>
                    </div>
                </div>
            </form>
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
    document.querySelectorAll(".btn-delete").forEach(btn => {
        btn.addEventListener("click", function (e) {
            e.preventDefault(); // Ngăn chuyển trang

            const productId = this.dataset.productid;
            
            fetch("MainController", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: `action=DeleteFromCart&productId=` + productId
            })
            .then(response => response.text())
            .then(data => {
                const json = JSON.parse(data); 
                const row = document.getElementById("product-" + productId);
                if (row) {
                    row.remove(); // Xóa dòng sản phẩm trên giao diện
                    updateCartTotal(); // Cập nhật lại tổng tiền
                }
                if (json.status === "empty") {
                    // Reload lại trang để hiển thị "Không có sản phẩm trong giỏ hàng"
                    location.reload();
                }
                        })
            .catch(err => {
                console.error("Lỗi khi xóa:", err);
            });
        });
    });
document.getElementById("checkoutBtn").addEventListener("click", function (e) {
    e.preventDefault(); // Ngăn submit mặc định

    const form = document.getElementById("checkoutForm");
    // Xoá các input ẩn cũ nếu có
    form.querySelectorAll("input[name='productID']").forEach(el => el.remove());

    const selectedIds = Array.from(document.querySelectorAll(".cart-checkbox"))
        .filter(cb => cb.checked)
        .map(cb => {
            const row = cb.closest(".row");
            if (row && row.id.startsWith("product-")) {
                return row.id.replace("product-", "").trim();
            }
            return null;
        })
        .filter(id => id !== null && id !== "");

    if (selectedIds.length === 0) {
        alert("Vui lòng chọn sản phẩm để thanh toán!");
        return;
    }

    // Tạo input hidden cho từng productID được chọn
    selectedIds.forEach(id => {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = "productID";
        input.value = id;
        form.appendChild(input);
    });

    // Thêm action nếu cần
    const actionInput = document.createElement("input");
    actionInput.type = "hidden";
    actionInput.name = "action";
    actionInput.value = "CheckOut";
    form.appendChild(actionInput);

    form.submit(); // Submit form sau khi gắn dữ liệu
});


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
    window.onload = function () {
        updateCartTotal();

        const target = document.querySelector('[data-selected="true"]');
        if (target) {
            setTimeout(() => {
                target.scrollIntoView({ behavior: "smooth", block: "center" });
            }, 100);
        }
    };
</script>
</html>
