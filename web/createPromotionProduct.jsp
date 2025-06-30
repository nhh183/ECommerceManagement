<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Khuyến Mãi Sản Phẩm</title>
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

            select.form-input {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 6px;
            }
        </style>
    </head>
    <body>

        <div class="wide-form-layout single">
            <h2 class="form-title">Thêm khuyến mãi cho sản phẩm</h2>
            <form action="MainController" method="post" class="wide-form single-column">

                <div class="form-group">
                    <label class="form-label">Chọn khuyến mãi <span>*</span></label>
                    <select name="promoID" class="form-input" required>
                        <option value="">-- Chọn khuyến mãi --</option>
                        <c:forEach var="promo" items="${promoList}">
                            <option value="${promo.promoID}">${promo.promoID} - ${promo.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Chọn sản phẩm <span>*</span></label>
                    <select name="productID" class="form-input" required>
                        <option value="">-- Chọn sản phẩm --</option>
                        <c:forEach var="product" items="${productList}">
                            <option value="${product.productID}">${product.productID} - ${product.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-bottom">
                    <button type="submit" name="action" value="createPromotionProduct" class="form-button">+ Thêm khuyến mãi sản phẩm</button>
                    <div>
                        <a href="MainController?action=searchPromotionProduct" class="form-cancel">Hủy</a>
                    </div>
                </div>

            </form>
        </div>

    </body>
</html>
