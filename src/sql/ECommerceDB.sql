﻿CREATE DATABASE ECommerceDB;
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
('user002', N'Trần Thị B', 'SL', '123456', '0912345678'),
('user003', N'Lê Văn C', 'CS', '123456', '0923456789'),
('user004', N'Phạm Thị D', 'CS', '123456', '0934567890'),
('user005', N'Hoàng Văn E', 'SL', '123456', '0945678901');

UPDATE tblUsers
SET roleID = 'SL' --seller
WHERE userID = 'user002';

UPDATE tblUsers
SET roleID = 'CS'
WHERE userID = 'user003';

UPDATE tblUsers
SET roleID = 'CS'
WHERE userID = 'user004';

UPDATE tblUsers
SET roleID = 'SL'
WHERE userID = 'user005';

-- 2. Ngành hàng
CREATE TABLE tblCategories (
    categoryID INT IDENTITY PRIMARY KEY ,
    categoryName NVARCHAR(100),
    description NVARCHAR(255)
);

ALTER TABLE tblCategories
ADD imgUrl TEXT;

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

UPDATE tblCategories SET imgUrl = 'images/dienthoai.jpg' WHERE categoryID = 1;
UPDATE tblCategories SET imgUrl = 'images/maytinh.jpg' WHERE categoryID = 2;
UPDATE tblCategories SET imgUrl = 'images/thoitrang.jpg' WHERE categoryID = 3;
UPDATE tblCategories SET imgUrl = 'images/dogiadung.jpg' WHERE categoryID = 4;
UPDATE tblCategories SET imgUrl = 'images/sach.jpg' WHERE categoryID = 5;
UPDATE tblCategories SET imgUrl = 'images/thethao.jpg' WHERE categoryID = 6;
UPDATE tblCategories SET imgUrl = 'images/mypham.jpg' WHERE categoryID = 7;
UPDATE tblCategories SET imgUrl = 'images/dochoi.jpg' WHERE categoryID = 8;
UPDATE tblCategories SET imgUrl = 'images/thietbivanphong.jpg' WHERE categoryID = 9;
UPDATE tblCategories SET imgUrl = 'images/thietbinhaBep.png' WHERE categoryID = 10;


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


--mot so co the them-co anh roi 
INSERT INTO tblProducts (name, categoryID, price, quantity, imgUrl, sellerID, status, description)
VALUES
(N'Dell Inspiron 15', 2, 18000000, 10, 'images/dellinspiron.jpg', 'user002', 'active', N'Laptop Dell hiệu năng cao, thiết kế hiện đại, phù hợp học tập và làm việc.'),
(N'Áo thun nam', 3, 150000, 50, 'images/aothunnam.jpg', 'user002', 'active', N'Áo thun nam cotton, thoáng mát, phù hợp mặc hằng ngày.'),
(N'Nồi cơm điện Sharp', 4, 900000, 15, 'images/noicomsharp.jpg', 'user005', 'active', N'Nồi cơm điện thương hiệu Sharp, dung tích 1.8L, nấu cơm nhanh và ngon.'),
(N'Sách Đắc Nhân Tâm', 5, 89000, 100, 'images/dacnhantam.jpg', 'user005', 'active', N'Tác phẩm kinh điển về nghệ thuật giao tiếp và đối nhân xử thế.'),
(N'Bóng đá Động Lực', 6, 250000, 30, 'images/bongdaluc.jpg', 'user005', 'active', N'Bóng đá thương hiệu Động Lực, chuẩn thi đấu, độ bền cao.'),
(N'Son môi 3CE đỏ cam', 7, 320000, 60, 'images/son3ce.jpg', 'user005', 'active', N'Son môi 3CE màu đỏ cam, lên màu chuẩn, giữ màu lâu, thiết kế thời trang.'),
(N'Bút bi Thiên Long', 9, 5000, 200, 'images/butthienlong.jpg', 'user005', 'active', N'Bút bi Thiên Long nét mảnh, mực ra đều, dùng trong học tập và văn phòng.'),
(N'Nồi chiên không dầu Lock&Lock', 10, 2500000, 10, 'images/noichienlock.jpg', 'user005', 'active', N'Nồi chiên không dầu Lock&Lock, dung tích lớn, giúp món ăn giòn ngon mà không cần dầu.');


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

-- 8. Trả hàng
CREATE TABLE tblReturns (
    returnID INT IDENTITY PRIMARY KEY,
    invoiceID INT,
    reason NVARCHAR(255),
    status VARCHAR(50),
    FOREIGN KEY (invoiceID) REFERENCES tblInvoices(invoiceID)
);

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

--bai ca nhan cua Tien
--10. 
drop 
CREATE TABLE tblFAQs (
    faqID INT IDENTITY(1,1) PRIMARY KEY,
    question NVARCHAR(MAX) NOT NULL,
    answer NVARCHAR(MAX) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'active'
);

INSERT INTO tblFAQs (question, answer, status) VALUES
(N'Làm sao để đặt hàng trên trang web?', 
 N'Bạn chỉ cần chọn sản phẩm, nhấn "Thêm vào giỏ" và tiến hành thanh toán theo hướng dẫn.', 
 'active'),

(N'Tôi có thể thanh toán bằng hình thức nào?', 
 N'Bạn có thể thanh toán qua ví điện tử, thẻ ngân hàng hoặc thanh toán khi nhận hàng (COD).', 
 'active'),

(N'Bao lâu thì tôi nhận được hàng?', 
 N'Thời gian giao hàng thường từ 2-5 ngày tùy khu vực. Bạn có thể theo dõi đơn hàng trong mục “Đơn hàng của tôi”.', 
 'active'),

(N'Tôi muốn hủy đơn hàng thì phải làm sao?', 
 N'Bạn có thể hủy đơn trong vòng 24h sau khi đặt hàng, nếu đơn chưa được vận chuyển.', 
 'active'),

(N'Tôi có thể đổi/trả hàng không?', 
 N'Có. Bạn có thể yêu cầu đổi/trả hàng trong vòng 7 ngày nếu sản phẩm bị lỗi hoặc không đúng mô tả.', 
 'active');