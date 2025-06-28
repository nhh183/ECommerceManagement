<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Trung Tâm Trợ Giúp | Shoppy</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/support.css"> <!-- CSS bạn chỉnh ở trên -->
    </head>
    <body>

        <div class="header">
            <div class="sticky-top">
                <!-- === HEADER TOP === -->
                <div class="header-top">
                    <div class="container d-flex justify-content-between align-items-center">
                        <div class="header-brand d-flex align-items-center gap-3">
                            <a href="MainController?action=homePage" class="header-logo">
                                <img src="images/shop.jpg" alt="Cart Logo" class="logo-img">
                                <span class="logo-text">Shoppy</span>
                            </a>
                            <span class="divider-line">|</span>
                            <a href="support.jsp" class="support-link">Trung Tâm Trợ Giúp Shoppy</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- === HEADER BOTTOM === -->
            <div class="header-bottom">
                <div class="container text-center">
                    <p class="support-title">Shoppy có thể hỗ trợ gì cho bạn?</p>
                    <form action="MainController" method="get" class="search-form mx-auto">
                        <input type="text" name="keyword" class="form-control search-input" placeholder="Tìm câu hỏi bạn cần...">
                        <input type="hidden" name="sourcePage" value="support"/>
                        <input type="hidden" name="action" value="searchFAQ">
                        <button class="btn search-btn" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>




        <!-- === NỘI DUNG CHÍNH: Gợi ý câu hỏi / hỗ trợ === -->
        <div class="container mt-5">
            <h3 class="section-title text-center">Gợi ý dành cho bạn</h3>

            <div class="accordion custom-accordion" id="faqAccordion">
                <c:forEach var="faq" items="${faqList}" varStatus="loop">
                    <div class="accordion-item ${loop.index >= 6 ? 'd-none more-faq' : ''}">
                        <h2 class="accordion-header" id="heading${loop.index}">
                            <button class="accordion-button collapsed" type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#collapse${loop.index}" aria-expanded="false"
                                    aria-controls="collapse${loop.index}">
                                <i class="fas fa-question-circle me-2"></i> ${faq.question}
                            </button>
                        </h2>
                        <div id="collapse${loop.index}" class="accordion-collapse collapse"
                             aria-labelledby="heading${loop.index}" data-bs-parent="#faqAccordion">
                            <div class="accordion-body">
                                ${faq.answer}
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Nút xem thêm -->
            <div class="text-center mt-3">
                <button class="btn btn-outline-warning fw-bold" id="showMoreBtn">Xem thêm</button>
            </div>



            <!-- Link đến Chăm sóc khách hàng -->
            <div class="text-center mt-5">
                <p class="need-help-text">Bạn cần thêm hỗ trợ?</p>
                <a href="contactSupport.jsp" class="btn contact-btn">Liên hệ Chăm Sóc Khách Hàng</a>
            </div>
        </div>

        <!-- === FOOTER === -->
        <footer class="footer mt-5 py-3 bg-light text-center">
            <p class="mb-0 text-muted">© 2025 Shoppy - Trung Tâm Trợ Giúp</p>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById("showMoreBtn").addEventListener("click", function () {
                document.querySelectorAll(".more-faq").forEach(function (item) {
                    item.classList.remove("d-none");
                });
                this.style.display = "none"; // Ẩn nút sau khi hiện hết
            });
        </script>


    </body>
</html>
