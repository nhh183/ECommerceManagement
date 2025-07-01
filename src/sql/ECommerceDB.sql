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

-- Admin
INSERT INTO tblUsers (userID, fullName, roleID, password, phone)
VALUES ('user001', N'Nguyễn Văn A', 'AD', '123456', '0901234567');

-- Normal users
INSERT INTO tblUsers (userID, fullName, roleID, password, phone)
VALUES 
('user002', N'Trần Thị B', 'NV', '123456', '0912345678'),
('user003', N'Lê Văn C', 'NV', '123456', '0923456789'),
('user004', N'Phạm Thị D', 'NV', '123456', '0934567890'),
('user005', N'Hoàng Văn E', 'NV', '123456', '0945678901');

-- SL
INSERT INTO tblUsers (userID, fullName, roleID, password, phone)
VALUES ('user077', N'Nguyen Thúc Thùy Tiên', 'SL', '123456', '0945678971');

-- 2. Ngành hàng
CREATE TABLE tblCategories (
    categoryID INT IDENTITY PRIMARY KEY ,
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

-- 3. Sản phẩm
CREATE TABLE tblProducts (
    productID INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100),
    categoryID INT,
    price FLOAT,
    quantity INT,
    imgUrl TEXT,
    sellerID VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (categoryID) REFERENCES tblCategories(categoryID),
    FOREIGN KEY (sellerID) REFERENCES tblUsers(userID)
);

ALTER TABLE tblProducts
ADD description NVARCHAR(MAX);

--co anh dung de test thu 
INSERT INTO tblProducts (name, categoryID, price, quantity, imgUrl, sellerID, status, description)
VALUES
(N'Iphone 12 promax', 1, 23000000, 20, 'images/ip12promax.jpg', 'user001', 'active', N'Mẫu iPhone mới nhất với camera cải tiến'),
(N'Điện Thoại Iphone 15 promax', 1, 30000000, 40, 'images/DTIphone15promax.jpg', 'user001', 'active', N'Phiên bản cao cấp với hiệu năng vượt trội.'),
(N'Áo Thun Nam', 3, 200000, 30, 'images/aothunnam.jpeg', 'user001', 'active', N'áo thun nam phiên bản giới hạn'),
(N'mac book air m1', 2, 60000000, 30, 'images/macbook-air-m1.jpg', 'user001', 'active', N'máy tính chính hãng đời mới nhất'),
(N'Sách Cây Cam Ngọt', 5, 130000, 50, 'images/sachcaycamngot.jpg', 'user001', 'active', N'Sách....');


--mot so co the them-chua co anh 
INSERT INTO tblProducts (name, categoryID, price, quantity, imgUrl, sellerID, status, description)
VALUES
(N'Dell Inspiron 15', 2, 18000000, 10, 'images/dellinspiron.jpg', 'user002', 'active', N'Laptop Dell hiệu năng cao, thiết kế hiện đại, phù hợp học tập và làm việc.'),
(N'Áo thun nam', 3, 150000, 50, 'images/aothunnam.jpg', 'user002', 'active', N'Áo thun nam cotton, thoáng mát, phù hợp mặc hằng ngày.'),
(N'Nồi cơm điện Sharp', 4, 900000, 15, 'images/noicomsharp.jpg', 'user003', 'active', N'Nồi cơm điện thương hiệu Sharp, dung tích 1.8L, nấu cơm nhanh và ngon.'),
(N'Sách Đắc Nhân Tâm', 5, 89000, 100, 'images/dacnhantam.jpg', 'user002', 'active', N'Tác phẩm kinh điển về nghệ thuật giao tiếp và đối nhân xử thế.'),
(N'Bóng đá Động Lực', 6, 250000, 30, 'images/bongdaluc.jpg', 'user003', 'active', N'Bóng đá thương hiệu Động Lực, chuẩn thi đấu, độ bền cao.'),
(N'Son môi 3CE đỏ cam', 7, 320000, 60, 'images/son3ce.jpg', 'user003', 'active', N'Son môi 3CE màu đỏ cam, lên màu chuẩn, giữ màu lâu, thiết kế thời trang.'),
(N'Bút bi Thiên Long', 9, 5000, 200, 'images/butthienlong.jpg', 'user003', 'active', N'Bút bi Thiên Long nét mảnh, mực ra đều, dùng trong học tập và văn phòng.'),
(N'Nồi chiên không dầu Lock&Lock', 10, 2500000, 10, 'images/noichienlock.jpg', 'user003', 'active', N'Nồi chiên không dầu Lock&Lock, dung tích lớn, giúp món ăn giòn ngon mà không cần dầu.');


-- 4. Chương trình khuyến mãi
CREATE TABLE tblPromotions (
    promoID INT IDENTITY PRIMARY KEY,
    name NVARCHAR(100),
    discountPercent FLOAT,
    startDate DATE,
    endDate DATE,
    status VARCHAR(20)
);

-- 5. Giỏ hàng
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

-- 6. Hóa đơn
CREATE TABLE tblInvoices (
    invoiceID INT IDENTITY PRIMARY KEY,
    userID VARCHAR(20),
    totalAmount FLOAT,
    status VARCHAR(20),
    createdDate DATE,
    FOREIGN KEY (userID) REFERENCES tblUsers(userID)
);

('user002', 5000000, 'completed', '2025-06-20'),
('user003', 7000000, 'completed', '2025-06-21');
CREATE TABLE tblInvoiceDetails (
    invoiceID INT,
    productID INT,
    quantity INT,
    price FLOAT,
    PRIMARY KEY (invoiceID, productID),
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID),
    FOREIGN KEY (productID) REFERENCES tblProducts(productID)
);

-- 7. Giao hàng
CREATE TABLE tblDeliveries (
    deliveryID INT IDENTITY PRIMARY KEY,
    invoiceID INT,
    address NVARCHAR(255),
    deliveryDate DATE,
    status VARCHAR(50),
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID)
);
(1, N'123 Nguyễn Huệ, Q1, TP.HCM', '2025-06-21', 'pending'),
(2, N'456 Lê Lợi, Q1, TP.HCM', '2025-06-22', 'delivered');

UPDATE tblDeliveries
SET status = 'pending'
WHERE status = 'delivered';


-- 8. Trả hàng
CREATE TABLE tblReturns (
    returnID INT IDENTITY PRIMARY KEY,
    invoiceID INT,
    reason NVARCHAR(255),
    status VARCHAR(50),
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID)
);

ALTER TABLE tblReturns
ADD returnDate DATE;

INSERT INTO tblReturns (invoiceID, reason, status, returnDate)
VALUES 
(1, N'Hàng bị lỗi', 'pending', '2025-06-25'),
(2, N'Không đúng mẫu đặt', 'approved', '2025-06-26'),
(1, N'Muốn đổi màu sản phẩm', 'rejected', '2025-06-27');
UPDATE tblReturns
SET status = 'pending'
UPDATE tblReturns
SET  returnDate = '2025-06-16'
where  returnDate = '2025-06-24'

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


CREATE TABLE tblNotifications (
    notificationID INT IDENTITY(1,1) PRIMARY KEY,
    userID VARCHAR(20) NOT NULL,
    eventType NVARCHAR(100),
    message NVARCHAR(255),
    isRead BIT DEFAULT 0,
    createdAt DATETIME DEFAULT GETDATE()
);
-- Thêm thông báo cho user002
INSERT INTO tblNotifications (userID, eventType, message, isRead)
VALUES 
('user002', N'Delivery', N'Đơn hàng #5 của bạn đang được giao.', 0),
('user002', N'Return', N'Yêu cầu trả hàng của bạn đã được duyệt.', 0),
('user002', N'Order', N'Đơn hàng #6 đã được tạo thành công.', 1);

-- Thêm thông báo cho user003
INSERT INTO tblNotifications (userID, eventType, message, isRead)
VALUES 
('user003', N'Promotion', N'Khuyến mãi mới 20% cho đơn hàng trên 1 triệu.', 0),
('user003', N'Order', N'Đơn hàng #7 đã bị hủy theo yêu cầu của bạn.', 1);
-- Thêm thông báo cho Admin (user001)
INSERT INTO tblNotifications (userID, eventType, message, isRead)
VALUES 
('user001', N'Order', N'Bạn vừa duyệt đơn hàng #8 của người dùng.', 0),
('user001', N'Return', N'Yêu cầu trả hàng #3 vừa được gửi từ user002.', 0),
('user001', N'System', N'Sao lưu dữ liệu hệ thống lúc 10:00 AM hoàn tất.', 1),
('user001', N'CustomerCare', N'Bạn có 2 phản hồi chăm sóc khách hàng chưa đọc.', 0),
('user001', N'Promotion', N'Bạn đã cập nhật khuyến mãi tháng 7 thành công.', 1);

