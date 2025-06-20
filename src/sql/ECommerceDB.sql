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
('user002', N'Trần Thị B', 'NV', '123456', '0912345678'),
('user003', N'Lê Văn C', 'NV', '123456', '0923456789'),
('user004', N'Phạm Thị D', 'NV', '123456', '0934567890'),
('user005', N'Hoàng Văn E', 'NV', '123456', '0945678901');

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

INSERT INTO tblProducts (name, categoryID, price, quantity, imgUrl, sellerID, status)
VALUES 
(N'Iphone 12 promax', 1, 23000000, 20, 'images/ip12promax.jpg', 'user001', 'active'),
(N'Điện Thoại Iphone 15 promax', 1, 30000000, 40, 'images/DTIphone15promax.jpg', 'user001', 'active');

--mot so co the them-chua co anh 
INSERT INTO tblProducts (name, categoryID, price, quantity, imgUrl, sellerID, status)
VALUES

(N'Dell Inspiron 15', 2, 18000000, 10, 'images/dellinspiron.jpg', 'user002', 'active'),

(N'Áo thun nam', 3, 150000, 50, 'images/aothunnam.jpg', 'user002', 'active'),

(N'Nồi cơm điện Sharp', 4, 900000, 15, 'images/noicomsharp.jpg', 'user003', 'active'),

(N'Sách Đắc Nhân Tâm', 5, 89000, 100, 'images/dacnhantam.jpg', 'user002', 'active'),

(N'Bóng đá Động Lực', 6, 250000, 30, 'images/bongdaluc.jpg', 'user003', 'active'),

(N'Son môi 3CE đỏ cam', 7, 320000, 60, 'images/son3ce.jpg', 'user003', 'active'),

(N'Bút bi Thiên Long', 9, 5000, 200, 'images/butthienlong.jpg', 'user003', 'active'),

(N'Nồi chiên không dầu Lock&Lock', 10, 2500000, 10, 'images/noichienlock.jpg', 'user003', 'active');


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
