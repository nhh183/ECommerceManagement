<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shoppy | Giỏ Hàng</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/cart.css"/>
    </head>
    <body>
        <div class="header sticky-top">
            <div class="header-top">
                <div class="header-top-left">
                    
                </div>
                <div class="header-top-right">
                    <span class="welcome-text font-weight-light" style="display: inline-block;">Welcome, ${sessionScope.login.fullName}!</span> <!-- Thêm style="display: inline-block;" -->
                </div>
                
            </div>
            <div class="header-bottom p-3">
                <div class="inner-header-bottom row">
                    <!-- Logo với hình giỏ hàng -->
                    <div class="header-bottom-left col-md-3">
                        <div class="logo">
                            <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                            <p>Shoppy | Giỏ Hàng</p>
                        </div>
                    </div>

                    <!-- Search Box -->
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
            <h1>hi</h1>
        </div>
        <div class="footer">
            
        </div>
    </body>
</html>
