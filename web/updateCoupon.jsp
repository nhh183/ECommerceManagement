<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cập Nhật Mã Giảm Giá</title>
    <link rel="stylesheet" href="css/form.css"/>
    <style>
        body {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .wide-form.single-column {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .wide-form-layout.single {
            max-width: 600px;
            width: 100%;
            margin: auto;
        }
    </style>
</head>
<body>
<div class="wide-form-layout single">
    <h2 class="form-title">Cập nhật mã giảm giá</h2>
    <form action="MainController" method="post" class="wide-form single-column">
        <input type="hidden" name="action" value="updateCoupon" />

        <div class="form-group">
            <label class="form-label">Mã coupon </label>
            <input type="text" name="code" class="form-input" value="${coupon.code}" readonly>
        </div>

        <div class="form-group">
            <label class="form-label">Phần trăm giảm <span>*</span></label>
            <input type="number" step="0.1" min="0" max="100" name="discount" class="form-input" value="${coupon.discountPercent}" required>
        </div>

        <div class="form-group">
            <label class="form-label">Ngày bắt đầu <span>*</span></label>
            <input type="date" name="startDate" class="form-input"
                   value="<fmt:formatDate value='${coupon.startDate}' pattern='yyyy-MM-dd'/>" required>
        </div>

        <div class="form-group">
            <label class="form-label">Ngày kết thúc <span>*</span></label>
            <input type="date" name="endDate" class="form-input"
                   value="<fmt:formatDate value='${coupon.endDate}' pattern='yyyy-MM-dd'/>" required>
        </div>

        <div class="form-group">
            <label class="form-label">Số lượng <span>*</span></label>
            <input type="number" name="quantity" class="form-input" value="${coupon.quantity}" required>
        </div>

        <div class="form-group">
            <label class="form-label">Trạng thái <span>*</span></label>
            <select name="status" class="form-input" required>
                <option value="active" ${coupon.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                <option value="inactive" ${coupon.status == 'inactive' ? 'selected' : ''}>Ngừng hoạt động</option>
                <option value="expired" ${coupon.status == 'expired' ? 'selected' : ''}>Hết hạn</option>
                <option value="out_of_stock" ${coupon.status == 'out_of_stock' ? 'selected' : ''}>Hết mã</option>
            </select>
        </div>

        <div class="form-bottom">
            <button type="submit" class="form-button">Lưu thay đổi</button>
            <div><a href="MainController?action=searchCoupon" class="form-cancel">Hủy</a></div>
        </div>
    </form>
</div>
</body>
</html>
