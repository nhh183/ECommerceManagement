<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập Nhật Câu Hỏi Thường Gặp</title>
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
            <h2 class="form-title">Cập Nhật Câu Hỏi Thường Gặp</h2>
            <form action="MainController" method="post" class="wide-form single-column">
                
                <input type="hidden" name="faqID" value="${faq.faqID}"/>

                <div class="form-group">
                    <label class="form-label">Câu hỏi <span>*</span></label>
                    <input type="text" name="question" class="form-input" required minlength="10"
                           value="${faq.question}" placeholder="Nhập câu hỏi...">
                </div>

                <div class="form-group">
                    <label class="form-label">Trả lời <span>*</span></label>
                    <textarea name="answer" class="form-textarea" rows="5" required minlength="20"
                              placeholder="Nhập câu trả lời...">${faq.answer}</textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Trạng thái <span>*</span></label>
                    <select name="status" class="form-input" required>
                        <option value="active" ${faq.status == 'active' ? 'selected' : ''}>Hoạt động</option>
                        <option value="inactive" ${faq.status == 'inactive' ? 'selected' : ''}>Ngừng hoạt động</option>
                    </select>
                </div>

                <div class="form-bottom">
                    <button type="submit" name="action" value="updateFAQ" class="form-button">✔ Cập nhật</button>
                    <div>
                        <a href="MainController?action=searchFAQ" class="form-cancel">Hủy</a>
                    </div>
                </div>

            </form>
        </div>

    </body>
</html>
