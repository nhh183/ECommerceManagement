<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="java.util.List"%>
<%@page import="dto.CartItem"%>


<%
    List<CartItem> checkoutItems = (List<CartItem>) session.getAttribute("checkoutItems");
    double total = 0;
    if (checkoutItems != null) {
        for (CartItem item : checkoutItems) {
            total += item.getSalePrice() * item.getQuantity();
        }
    }
    session.setAttribute("total", total); // Gán vào session để JSTL dùng được
%>


<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận đơn hàng</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
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
                .header-brand{
            gap:2px;
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
        .divider-line {
            font-size: 30px;
            font-weight: bold;
            color: #FFD4B0;
        }
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
 .section {
        padding: 20px 0;
        background-color: #f5f5f5;
        min-height: 100vh;
    }

    .section .container {
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        padding: 20px;
        margin-bottom: 20px;
        background-color: white;
    }

    .section h3, .section h4 {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 15px;
        color: #333;
    }

    .section table th,
    .section table td {
        vertical-align: middle;
        font-size: 15px;
    }

    .section .text-right {
        text-align: right;
        font-size: 18px;
        padding: 10px 0;
        color: #FF5722;
    }

    .section .btn-danger {
        padding: 10px 25px;
        font-size: 16px;
        font-weight: 500;
        border-radius: 6px;
    }
    .table {
    border: none !important;
}

.table th, .table td {
    border: none !important;
}
.sec-end > div{
    flex: 1;
}
    </style>
</head>
<body>
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
                            <h2 class="support-link">Thanh toán</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="section"> 
        <div class="address container bg-white mt-3">
            <h3>Địa Chỉ Nhận Hàng</h3>
            <p><b>Nguyễn Văn A</b> | SĐT: <b>09123456</b><br/>
           đường, tổ, xã , phường</p>
        </div>
        <div class="container bg-white">
        <table class="table">
            <thead class="">
                <tr>
                    <th>Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${checkoutItems}">
                    <tr>
                        
                        <td><img src="${item.imgUrl}" width="60" height="60" class="rounded mr-2" /> ${item.productName}</td>
                        <td><fmt:formatNumber value="${item.salePrice}" type="number" groupingUsed="true" /></td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.salePrice*item.quantity}" type="number" groupingUsed="true" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table> 
        </div>
        <div class="sec-end container bg-white d-flex">
            <div class="text-left">
                <form action="CouponController" method="post" class="mb-3 d-flex align-items-center ">
                    <input type="text" name="couponCode" placeholder="Nhập mã giảm giá" class="form-control w-50 me-2" />
                    <button type="submit" class="btn btn-outline-primary">Áp dụng</button>
                </form>

                <c:if test="${not empty invalidCoupon}">
                    <div class="text-danger text-end mb-2">${invalidCoupon}</div>
                </c:if>

                <c:if test="${not empty coupon}">
                    <div class="text-success text-end mb-2">Mã <strong>${coupon.code}</strong> đã được áp dụng! Giảm ${coupon.discountPercent}%</div>
                </c:if>
            </div>
            <div class="gap-1 text-right">
                <div class="font-weight-bold">
    <c:choose>
        <c:when test="${not empty sessionScope.discountedTotal}">
            Tổng cộng: <del class="text-muted">₫<fmt:formatNumber value="${sessionScope.total}" type="number" groupingUsed="true"/></del>
            <strong class="text-danger ms-2">₫<fmt:formatNumber value="${sessionScope.discountedTotal}" type="number" groupingUsed="true"/></strong>
        </c:when>
        <c:otherwise>
            Tổng cộng: ₫<fmt:formatNumber value="${sessionScope.total}" type="number" groupingUsed="true"/>
        </c:otherwise>
    </c:choose>
</div>

                <form action="MainController" method="post">
                    <input type="hidden" name="totalAmount" value="${not empty sessionScope.discountedTotal ? sessionScope.discountedTotal : sessionScope.total}" />

                    <c:forEach var="item" items="${checkoutItems}">
                        <input type="hidden" name="productId" value="${item.productID}" />
                        <input type="hidden" name="quantity" value="${item.quantity}" />
                        <input type="hidden" name="price" value="${item.salePrice}" />
                    </c:forEach>

                    <div class="text-right mt-3">
                        <button type="submit" name="action" value="CreateInvoice" class="btn btn-danger">Đặt hàng</button>
                    </div>
                </form>
            </div>
            
            
        </div>
                      
    </div>
    
        <%@include file="footer.jsp" %>
</body>
</html>
