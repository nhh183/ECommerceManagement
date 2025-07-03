-- 0. Tạo mới CSDL
--DROP DATABASE IF EXISTS ECommerceDB;
CREATE DATABASE ECommerceDB;
USE ECommerceDB;

-- 1. Bảng người dùng
CREATE TABLE tblUsers (
    userID VARCHAR(20) PRIMARY KEY,
    fullName NVARCHAR(100),
    roleID VARCHAR(5),
    password VARCHAR(100),
    phone VARCHAR(15)
);

-- Thêm người dùng
INSERT INTO tblUsers (userID, fullName, roleID, password, phone)
VALUES 
('user001', N'Nguyễn Văn A', 'AD', '123456', '0901234567'),
('user002', N'Trần Thị B', 'NV', '123456', '0912345678'),
('user003', N'Lê Văn C', 'NV', '123456', '0923456789'),
('user004', N'Phạm Thị D', 'NV', '123456', '0934567890'),
('user005', N'Hoàng  Văn E', 'NV', '123456', '0945678901'),
('user077', N'Nguyen Thúc Thùy Tiên', 'SL', '123456', '0945678971');

-- 2. Bảng ngành hàng
CREATE TABLE tblCategories (
    categoryID INT IDENTITY PRIMARY KEY,
    categoryName NVARCHAR(100),
    description NVARCHAR(255)
);

INSERT INTO tblCategories (categoryName, description) 
VALUES 
(N'Điện thoại', N'Sản phẩm điện thoại di động và phụ kiện'),
(N'Máy tính', N'Laptop, PC và các linh kiện liên quan'),
(N'Thời trang', N'Quần áo, giày dép và phụ kiện thời trang'),
(N'Đồ gia dụng', N'Sản phẩm sử dụng trong gia đình'),
(N'Sách', N'Sách các thể loại: học tập, tiểu thuyết, kỹ năng'),
(N'Thể thao', N'Dụng cụ và trang phục thể thao'),
(N'Mỹ phẩm', N'Mỹ phẩm và sản phẩm chăm sóc da'),
(N'Đồ chơi', N'Đồ chơi trẻ em và người lớn'),
(N'Thiết bị văn phòng', N'Máy in, giấy, bút và các vật dụng khác'),
(N'Thiết bị nhà bếp', N'Đồ dùng nấu ăn và thiết bị nhà bếp');

-- 3. Bảng sản phẩm
CREATE TABLE tblProducts (
    productID INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100),
    categoryID INT,
    price FLOAT,
    quantity INT,
    imgUrl TEXT,
    sellerID VARCHAR(20),
    status VARCHAR(20),
    description NVARCHAR(MAX),
    FOREIGN KEY (categoryID) REFERENCES tblCategories(categoryID),
    FOREIGN KEY (sellerID) REFERENCES tblUsers(userID)
);

-- Thêm sản phẩm mẫu
INSERT INTO tblProducts (name, categoryID, price, quantity, imgUrl, sellerID, status, description)
VALUES
(N'Iphone 12 promax', 1, 23000000, 20, 'images/ip12promax.jpg', 'user001', 'active', N'Mẫu iPhone mới nhất với camera cải tiến'),
(N'Điện Thoại Iphone 15 promax', 1, 30000000, 40, 'images/DTIphone15promax.jpg', 'user001', 'active', N'Phiên bản cao cấp với hiệu năng vượt trội.'),
(N'Áo Thun Nam', 3, 200000, 30, 'images/aothunnam.jpeg', 'user001', 'active', N'áo thun nam phiên bản giới hạn'),
(N'mac book air m1', 2, 60000000, 30, 'images/macbook-air-m1.jpg', 'user001', 'active', N'máy tính chính hãng đời mới nhất'),
(N'Sách Cây Cam Ngọt', 5, 130000, 50, 'images/sachcaycamngot.jpg', 'user001', 'active', N'Sách....'),
(N'Dell Inspiron 15', 2, 18000000, 10, 'images/dellinspiron.jpg', 'user002', 'active', N'Laptop Dell hiệu năng cao'),
(N'Áo thun nam', 3, 150000, 50, 'images/aothunnam.jpg', 'user002', 'active', N'Áo thun cotton mát mẻ'),
(N'Nồi cơm điện Sharp', 4, 900000, 15, 'images/noicomsharp.jpg', 'user003', 'active', N'Nồi cơm điện 1.8L'),
(N'Sách Đắc Nhân Tâm', 5, 89000, 100, 'images/dacnhantam.jpg', 'user002', 'active', N'Sách nghệ thuật giao tiếp'),
(N'Bóng đá Động Lực', 6, 250000, 30, 'images/bongdaluc.jpg', 'user003', 'active', N'Bóng đá chuẩn thi đấu'),
(N'Son môi 3CE đỏ cam', 7, 320000, 60, 'images/son3ce.jpg', 'user003', 'active', N'Son môi 3CE màu đỏ cam'),
(N'Bút bi Thiên Long', 9, 5000, 200, 'images/butthienlong.jpg', 'user003', 'active', N'Bút bi Thiên Long nét mảnh'),
(N'Nồi chiên không dầu Lock&Lock', 10, 2500000, 10, 'images/noichienlock.jpg', 'user003', 'active', N'Nồi chiên không dầu dung tích lớn');

-- 4. Bảng khuyến mãi
CREATE TABLE tblPromotions (
    promoID INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100),
    discountPercent FLOAT CHECK (discountPercent >= 0 AND discountPercent <= 100),
    startDate DATE,
    endDate DATE,
    status VARCHAR(20)
);

CREATE TABLE tblPromotion_Product (
    promoID INT,
    productID INT,
    PRIMARY KEY (promoID, productID),
    FOREIGN KEY (promoID) REFERENCES tblPromotions(promoID) ON DELETE CASCADE,
    FOREIGN KEY (productID) REFERENCES tblProducts(productID) ON DELETE CASCADE
);

-- Thêm khuyến mãi
INSERT INTO tblPromotions (name, discountPercent, startDate, endDate, status)
VALUES 
(N'Khuyến mãi điện thoại mùa hè', 10, '2025-06-25', '2025-07-31', 'active'),
(N'Giảm giá laptop tháng 6', 15, '2025-06-28', '2025-07-25', 'active'),
(N'Mua sách hè giảm giá', 20, '2025-06-20', '2025-07-30', 'active'),
(N'Siêu khuyến mãi gia dụng', 12, '2025-06-26', '2025-07-31', 'active');

-- Gán sản phẩm vào khuyến mãi
INSERT INTO tblPromotion_Product (promoID, productID)
VALUES 
(1, 1), (1, 2), (1, 3),
(2, 4), (2, 6),
(3, 5), (3, 9),
(4, 8), (4, 13);

-- 5. Bảng giỏ hàng
CREATE TABLE tblCarts (
    cartID INT IDENTITY PRIMARY KEY,
    userID VARCHAR(20),
    createdDate DATE,
    FOREIGN KEY (userID) REFERENCES tblUsers(userID)
);

CREATE TABLE tblCartDetails (
    cartID INT,
    productID INT,
    quantity INT,
    PRIMARY KEY (cartID, productID),
    FOREIGN KEY (cartID) REFERENCES tblCarts(cartID),
    FOREIGN KEY (productID) REFERENCES tblProducts(productID)
);

-- 6. Bảng hóa đơn
CREATE TABLE tblInvoices (
    invoiceID INT IDENTITY PRIMARY KEY,
    userID VARCHAR(20),
    totalAmount FLOAT,
    status VARCHAR(20),
    createdDate DATE,
    FOREIGN KEY (userID) REFERENCES tblUsers(userID)
);

CREATE TABLE tblInvoiceDetails (
    invoiceID INT,
    productID INT,
    quantity INT, 
    price FLOAT,
    PRIMARY KEY (invoiceID, productID),
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID),
    FOREIGN KEY (productID) REFERENCES tblProducts(productID)
);

-- Thêm hóa đơn mẫu
INSERT INTO tblInvoices (userID, totalAmount, status, createdDate)
VALUES 
('user002', 500000, 'pending', '2025-06-20'),
('user003', 700000, 'delivered', '2025-06-21');
('user003', 800000, 'delivered', '2025-06-21');

INSERT INTO tblInvoices (userID, totalAmount)
VALUES 
('user002', 900000)

-- 7. Giao hàng
CREATE TABLE tblDeliveries (
    deliveryID INT IDENTITY PRIMARY KEY,
    invoiceID INT,
    address NVARCHAR(255),
    deliveryDate DATE,
    status VARCHAR(50),
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID)
);

INSERT INTO tblDeliveries (invoiceID, address, deliveryDate, status)
VALUES 
(1, N'123 Nguyễn Huệ, Q1, TP.HCM', '2025-06-21', 'pending'),
(2, N'456 Lê Lợi, Q1, TP.HCM', '2025-06-22', 'delivered');

-- 8. Trả hàng
CREATE TABLE tblReturns (
    returnID INT IDENTITY PRIMARY KEY,
    invoiceID INT,
    reason NVARCHAR(255),
    status VARCHAR(50),
    returnDate DATE,
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID)
);

INSERT INTO tblReturns (invoiceID, reason, status, returnDate)
VALUES 
(1, N'Hàng bị lỗi', 'pending', '2025-06-25'),
(2, N'Không đúng mẫu đặt', 'approved', '2025-06-26'),
(1, N'Muốn đổi màu sản phẩm', 'rejected', '2025-06-27');

-- 9. Chăm sóc khách hàng
CREATE TABLE tblCustomerCares (
    ticketID INT IDENTITY PRIMARY KEY,
    userID VARCHAR(20),
    subject NVARCHAR(100),
    content TEXT,
    status VARCHAR(50),
    reply TEXT,
    FOREIGN KEY (userID) REFERENCES tblUsers(userID)
);

-- 10. Thông báo
CREATE TABLE tblNotifications (
    notificationID INT IDENTITY PRIMARY KEY,
    userID VARCHAR(20) NOT NULL,
    eventType NVARCHAR(100),
    message NVARCHAR(255),
    isRead BIT DEFAULT 0,
    createdAt DATETIME DEFAULT GETDATE()
);

-- Thêm mẫu thông báo
INSERT INTO tblNotifications (userID, eventType, message, isRead)
VALUES 
('user002', N'Delivery', N'Đơn hàng #1 của bạn đang được giao.', 0),
('user003', N'Promotion', N'Khuyến mãi mới 20% cho đơn hàng trên 1 triệu.', 0),
('user001', N'Order', N'Bạn vừa duyệt đơn hàng #2 của người dùng.', 0);

-- 11. Thương hiệu
CREATE TABLE tblBrands (
    brandID VARCHAR(20) PRIMARY KEY,
    brandName VARCHAR(50) NOT NULL,
    description NVARCHAR(MAX),
    status VARCHAR(10) DEFAULT 'active' CHECK (status IN ('active', 'inactive'))
);

INSERT INTO tblBrands (brandID, brandName, description, status)
VALUES 
('Brand001', 'Apple', N'Công ty công nghệ Mỹ', 'active'),
('Brand002', 'Lenovo', N'Tập đoàn công nghệ Trung Quốc', 'active'),
('Brand003', 'Nike', N'Tập đoàn thời trang thể thao Mỹ', 'active');


ALTER TABLE tblInvoices
ADD shippingAddress NVARCHAR(255);
UPDATE tblInvoices
SET shippingAddress = N'123 Nguyễn Huệ, Q1, TP.HCM'
WHERE invoiceID = 3;

UPDATE tblInvoices
SET shippingAddress = N'456 Lê Lợi, Q1, TP.HCM'
WHERE invoiceID = 2;

