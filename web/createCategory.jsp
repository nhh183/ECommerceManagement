<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Danh Mục</title>
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
            <h2 class="form-title">Thêm danh mục</h2>
            <form action="MainController" method="post" class="wide-form single-column">
                <div class="form-group">
                    <label class="form-label">Tên danh mục <span>*</span></label>
                    <input type="text" name="categoryName" class="form-input" placeholder="Nhập tên danh mục..." required>
                </div>

                <div class="form-group">
                    <label class="form-label">Mô tả</label>
                    <textarea name="description" class="form-textarea" rows="5" placeholder="Mô tả danh mục..."></textarea>
                </div>

                <div class="form-bottom">
                    <button type="submit" name="action" value="createCategory" class="form-button">+ Thêm danh mục</button>
                    <div>
                        <a href="MainController?action=searchCategory" class="form-cancel">Hủy</a>
                    </div>
                </div>
            </form>
        </div>

    </body>
</html>
