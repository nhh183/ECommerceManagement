<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Khuyến Mãi</title>
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
    <h2 class="form-title">Thêm khuyến mãi</h2>
    <form action="MainController" method="post" class="wide-form single-column">
        <div class="form-group">
            <label class="form-label">Tên khuyến mãi <span>*</span></label>
            <input type="text" name="name" class="form-input" placeholder="Tên khuyến mãi" required>
        </div>

        <div class="form-group">
            <label class="form-label">Phần trăm giảm <span>*</span></label>
            <input type="number" step="0.1" min="0" max="100" name="discount" class="form-input" placeholder="VD: 10" required>
        </div>

        <div class="form-group">
            <label class="form-label">Ngày bắt đầu <span>*</span></label>
            <input type="date" name="startDate" class="form-input" required>
        </div>

        <div class="form-group">
            <label class="form-label">Ngày kết thúc <span>*</span></label>
            <input type="date" name="endDate" class="form-input" required>
        </div>

        <div class="form-group">
            <label class="form-label">Trạng thái <span>*</span></label>
            <select name="status" class="form-input" required>
                <option value="active">Hoạt động</option>
                <option value="inactive">Ngừng hoạt động</option>
            </select>
        </div>

        <div class="form-bottom">
            <button type="submit" name="action" value="createPromotion" class="form-button">+ Thêm khuyến mãi</button>
            <div><a href="MainController?action=searchPromotion" class="form-cancel">Hủy</a></div>
        </div>
    </form>
</div>
</body>
</html>
