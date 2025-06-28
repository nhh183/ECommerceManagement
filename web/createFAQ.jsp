<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Câu Hỏi Thường Gặp</title>
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
            <h2 class="form-title">Thêm Câu Hỏi Thường Gặp</h2>
            <form action="MainController" method="post" class="wide-form single-column">
                <div class="form-group">
                    <label class="form-label">Câu hỏi <span>*</span></label>
                    <input type="text" name="question" class="form-input" placeholder="Nhập câu hỏi..." required minlength="10">
                </div>

                <div class="form-group">
                    <label class="form-label">Trả lời <span>*</span></label>
                    <textarea name="answer" class="form-textarea" rows="5" placeholder="Nhập câu trả lời..." required minlength="20"></textarea>
                </div>

                <input type="hidden" name="status" value="active"/>

                <div class="form-bottom">
                    <button type="submit" name="action" value="createFAQ" class="form-button">+ Thêm FAQ</button>
                    <div>
                        <a href="MainController?action=searchFAQ" class="form-cancel">Hủy</a>
                    </div>
                </div>

            </form>
        </div>

    </body>
</html>
