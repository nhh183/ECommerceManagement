
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .footer-line {
            background: linear-gradient(90deg, rgba(253, 29, 29, 1) 0%, rgba(252, 176, 69, 1) 100%);
        }
    .feature-box {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        background-color: #FFF5E6 !important;
        text-align: center;
    }

    .feature h3 {
        color: #FF6B00;
        font-size: 18px;
    }

    .feature p {
        color: #666;
        font-size: 14px;
        line-height: 1.4;
    }
    .footer a {
        color: #E55D00; /* màu cam nhẹ */
        text-decoration: none;
        transition: color 0.3s ease, text-decoration 0.3s ease;
        font-weight: 500;
    }

    .footer a:hover {
        color: #CC4400; /* cam đậm hơn khi hover */
        text-decoration: underline;
    }

</style>

<div class="footer mt-5 pt-4 pb-4 text-muted">
    <div class="footer-line py-1"></div>
    <div class="feature-box pt-5 pb-5 mb-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 feature">
                    <h3>CAM KẾT CHÍNH HÀNG</h3>
                    <p>100% Authentic<br>Cam kết sản phẩm chính hãng từ Châu Âu, Châu Mỹ...</p>
                </div>
                <div class="col-md-4 feature">
                    <h3>GIAO HÀNG HỎA TỐC</h3>
                    <p>Express delivery<br>SHIP hỏa tốc 1h nhận hàng trong nội thành HCM</p>
                </div>
                <div class="col-md-4 feature">
                    <h3>HỖ TRỢ 24/24</h3>
                    <p>Supporting 24/24<br>Gọi ngay 0909300746</p>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h6>Về Shoppy</h6>
                <ul class="list-unstyled">
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Tuyển dụng</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6>Chính sách</h6>
                <ul class="list-unstyled">
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Chính sách đổi trả</a></li>
                    <li><a href="#">Chính sách giao hàng</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6>Hỗ trợ khách hàng</h6>
                <ul class="list-unstyled">
                    <li><a href="#">Trung tâm trợ giúp</a></li>
                    <li><a href="#">Liên hệ hỗ trợ</a></li>
                    <li><a href="#">Hướng dẫn mua hàng</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6>Liên hệ</h6>
                <ul class="list-unstyled">
                    <li>Email: support@shoppy.vn</li>
                    <li>Hotline: 1900 9999</li>
                    <li>Địa chỉ: TP.HCM</li>
                </ul>
            </div>
        </div>
        <hr>
        <div class="text-center small">© 2025 Shoppy. All rights reserved.</div>
    </div>
</div>
