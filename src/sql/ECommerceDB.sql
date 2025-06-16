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

-- 2. Ngành hàng
CREATE TABLE tblCategories (
    categoryID INT IDENTITY PRIMARY KEY ,
    categoryName NVARCHAR(100),
    description NVARCHAR(255)
);

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
