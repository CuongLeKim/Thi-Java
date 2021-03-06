--------------------------------------------------------------------------
-- Use Master
USE master
GO


--------------------------------------------------------------------------
-- TẠO DATABASE
CREATE DATABASE java
GO

--------------------------------------------------------------------------
-- DÙNG DATABASE
USE java
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Tài Khoản
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Admin' )
DROP TABLE dbo.Admin
--------------------------------------------------------------------------
CREATE TABLE dbo.Admin(
	Username VARCHAR(50) NOT NULL,
	Password VARCHAR(50) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	Access INT NOT NULL,
	
	PRIMARY KEY(Username),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Phòng Ban
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Departments' )
DROP TABLE dbo.Departments
--------------------------------------------------------------------------
CREATE TABLE dbo.Departments(
	ID VARCHAR(12) NOT NULL,
	NameDepartment NVARCHAR(50) NOT NULL,

	PRIMARY KEY(ID)	
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Loại Nhân Viên
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'EmployeeTypes' )
DROP TABLE dbo.EmployeeTypes
--------------------------------------------------------------------------
CREATE TABLE dbo.EmployeeTypes(
	ID VARCHAR(12) NOT NULL,
	NameEmployeeType NVARCHAR(50) NOT NULL,
	
	PRIMARY KEY (ID)
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Nhân Viên
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Employees' )
DROP TABLE dbo.Employees
--------------------------------------------------------------------------
CREATE TABLE dbo.Employees(
	ID VARCHAR(20) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	Password NVARCHAR(50) NOT NULL,
	NameEmployee NVARCHAR(50) NOT NULL,
	Gender INT NOT NULL,
	Photo NVARCHAR (MAX) NULL,
	Address NVARCHAR(50) NOT NULL,
	NumberPhone NVARCHAR(25) NOT NULL,
	Birthday DATETIME NOT NULL,
	Access INT NOT NULL,
	Activated BIT NOT NULL,
	DepartmentID VARCHAR(12) NOT NULL,
	EmployeeTypeID VARCHAR(12) NOT NULL,
	
	PRIMARY KEY(ID),
	FOREIGN KEY(DepartmentID) REFERENCES Departments(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY(EmployeeTypeID) REFERENCES EmployeeTypes(ID) ON DELETE NO ACTION ON UPDATE CASCADE,
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Hợp Đồng
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Contracts' )
DROP TABLE dbo.Contracts
--------------------------------------------------------------------------
CREATE TABLE dbo.Contracts(
	ID VARCHAR(20) NOT NULL,
	NameContract NVARCHAR(50) NOT NULL,
	StartTime DATETIME NOT NULL,
	EndTime DATETIME NULL,
	Subsidize INT NULL,
	Insurrance FLOAT NULL,
	Salary FLOAT NULL,
	Status INT NOT NULL,
	
	PRIMARY KEY(ID),
	CONSTRAINT FK_Employees FOREIGN KEY(ID) REFERENCES Employees(ID)
)
GO


--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Khen thưởng
IF  EXISTS (SELECT * FROM sysobjects WHERE name = N'Bonus' )
DROP TABLE dbo.Bonus
--------------------------------------------------------------------------
CREATE TABLE dbo.Bonus
(
	ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY(ID),
	EmployeeID VARCHAR(20) NOT NULL,
	Type BIT NOT NULL,
	Amount FLOAT,
	Reason NVARCHAR(50),
	DateWrite DATETIME NOT NULL,
	
	CONSTRAINT FK_Bonus_Employees FOREIGN KEY (EmployeeID) REFERENCES Employees(ID)

)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Nhà Sản Xuát
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Producers' )
DROP TABLE dbo.Producers
--------------------------------------------------------------------------
CREATE TABLE dbo.Producers
(
	ID INT NOT NULL IDENTITY(1,1),
	NameProducer NVARCHAR(50) NOT NULL,
	Logo NVARCHAR(MAX) NULL,
	Address NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	NumberPhone NVARCHAR(25) NOT NULL,
	PRIMARY KEY(ID),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Danh Mục
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Categories' )
DROP TABLE dbo.Categories
--------------------------------------------------------------------------
CREATE TABLE dbo.Categories
(
	ID INT NOT NULL IDENTITY(1,1),
	NameCategory NVARCHAR(50) NOT NULL,
	NameCategoryEN NVARCHAR(50) NOT NULL,
	PRIMARY KEY(ID),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Sản Phẩm
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Products' )
DROP TABLE dbo.Products
--------------------------------------------------------------------------
CREATE TABLE dbo.Products
(
	ID INT NOT NULL IDENTITY(1,1),
	NameProduct NVARCHAR(50) NOT NULL,
	Photo NVARCHAR(MAX) NULL,
	Quantity INT NOT NULL,
	ProductDate DATETIME NOT NULL,
	UnitBrief NVARCHAR(50) NOT NULL,
	UnitPrice FLOAT NOT NULL,
	Discount FLOAT NULL,
	Description NVARCHAR(1000) NULL,
	Views INT NULL,
	Available BIT NULL,
	Special BIT NULL,
	Latest BIT NULL,
	Status BIT NOT NULL,
	CategoryID INT NOT NULL,
	ProducerID INT NOT NULL,
	
	PRIMARY KEY(ID),
	CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(ID),
	CONSTRAINT FK_Products_Producers FOREIGN KEY (ProducerID) REFERENCES Producers(ID)
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Khách Hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Customers' )
DROP TABLE dbo.Customers
--------------------------------------------------------------------------
CREATE TABLE dbo.Customers
(
	ID VARCHAR(20) NOT NULL,
	Email NVARCHAR(50) NOT NULL,
	Password NVARCHAR(50) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	Photo NVARCHAR(MAX) NULL,
	Address NVARCHAR(50) NOT NULL,
	NumberPhone NVARCHAR(25) NOT NULL,
	Birthday DATETIME NOT NULL,
	Gender INT NOT NULL,
	Activated BIT NOT NULL,
	
	PRIMARY KEY(ID),
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Đơn Hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'Orders' )
DROP TABLE dbo.Orders
--------------------------------------------------------------------------
CREATE TABLE dbo.Orders
(
	ID INT NOT NULL IDENTITY(1,1),
	OrderDate DATETIME NOT NULL,
	RequireDate DATETIME NOT NULL,
	Amount FLOAT NOT NULL,
	Receiver NVARCHAR(50) NOT NULL,
	Address NVARCHAR(50) NOT NULL,
	Description NVARCHAR(1000) NULL,
	Status INT NOT NULL,
	NumberPhone VARCHAR(15)NULL,
	CustomerID VARCHAR(20)NULL,
	
	PRIMARY KEY (ID),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(ID)
)
GO

--------------------------------------------------------------------------
-- Tạo Bảng lưu thông tin Chi Tiết Đơn Hàng
IF EXISTS (SELECT * FROM sysobjects WHERE name = N'OrderDetails' )
DROP TABLE dbo.OrderDetails
--------------------------------------------------------------------------
CREATE TABLE dbo.OrderDetails
(
	ID INT NOT NULL IDENTITY(1,1),
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	Amount FLOAT NOT NULL,
	Discount FLOAT NOT NULL,
	
	PRIMARY KEY (ID),
	CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ID),
	CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(ID)
)
GO


--------------------------------------------------------------------------

--> QUẢN LÝ

-- Chèn dữ liệu Admin - Tài khoản
INSERT INTO Admin (Username,Password,FullName,Access) VALUES ('cuonglekim24@gmail.com','123456abc','Le Kim Cuong',1);

-- Chèn dữ liệu Departments - Phòng ban
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB1',N'Phòng IT');
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB2',N'Phòng Kế Toán');
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB3',N'Phòng Nhân Sự');
INSERT INTO Departments (ID,NameDepartment) VALUES ('PB4',N'Phòng Marketting');

-- Chèn dữ liệu EmployeeTypes - Loại nhân viên
INSERT INTO EmployeeTypes (ID,NameEmployeeType) VALUES ('LNV1','FullTime');
INSERT INTO EmployeeTypes (ID,NameEmployeeType) VALUES ('LNV2','PartTime');

-- Chèn dữ liệu Employees - Nhân Viên
INSERT INTO Employees (ID,DepartmentID,EmployeeTypeID,Email,Password,NameEmployee,Gender,Photo,Address,NumberPhone,Birthday, Access,Activated) 
VALUES ('cuonglekim22','PB1','LNV1','cuonglekim22@gmail.com','123456abc',N'Le Kim Cuong',1,'NV001.PNG',N'Phu yen','0344684483',CAST(0x00008AB400000000 AS DateTime),1,1)

INSERT INTO Employees (ID,DepartmentID,EmployeeTypeID,Email,Password,NameEmployee,Gender,Photo,Address,NumberPhone,Birthday, Access, Activated)
VALUES ('lekimcuong','PB2','LNV2','lekimcuong@gmail.com','123456abc',N'Cuong Le',2,'NV002.jpg',N'Phu Yen','0344684483',CAST(0x00008AB400000000 AS DateTime),1,1)

-- Chèn dữ liệu Contract - Hợp Đồng
INSERT INTO Contracts (ID,NameContract,StartTime,EndTime,Subsidize,Insurrance,Salary,Status)
VALUES ('cuonglekim22','HD Khong Xac Dinh Thoi Han',CAST(0x0000A8CE00000000 AS DateTime),CAST(0x0000B9ED00000000 AS DateTime),500000,0.08,5000000,1)

INSERT INTO Contracts (ID,NameContract,StartTime,EndTime,Subsidize,Insurrance,Salary,Status)
VALUES ('lekimcuong','HD Xac Dinh Thoi Han',CAST(0x0000A8CE00000000 AS DateTime),CAST(0x0000B9ED00000000 AS DateTime),500000,0.18,5000000,1)

--------------------------------------------------------------------------

--> BÁN HÀNG

-- Chèn dữ liệu Categories - Danh Mục
INSERT INTO Categories (NameCategory,NameCategoryEN) VALUES (N'Điện Thoại','Phone')



-- Chèn dữ liệu Producer - Hãng Sản Xuất
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Apple','Apple.png',N'Hoa Kỳ', 'apple@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Samsung','Samsung.jpg',N'Hàn Quốc', 'samsung@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('OPPO','Oppo.jpg',N'Hàn Quốc', 'oppo@gmail.com','113')
INSERT INTO  Producers (NameProducer,Logo,Address,Email,NumberPhone) VALUES ('Nokia','Nokia.jpg',N'Hàn Quốc', 'nokia@gmail.com','113')






-- ĐIỆN THOẠI

--Apple--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone X 256GB','DT001.jpg',10, CAST(0x0000A9D200000000 AS DateTime),N'1 Chiếc', 34790000,0,NULL,0,1,0,0,1,1,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone 7 Plus 32GB','DT002.jpg',23, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 19999000,0,NULL,0,0,1,0,1,1,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone 8 256GB','DT003.jpg',18, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 34790000,0,NULL,0,0,0,1,1,1,1)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'iPhone 6s Plus 32GB','DT004.jpg',14, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 13990000,0.10,NULL,0,0,1,0,1,1,1)

--Samsung--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy S9 +','DT005.jpg',30, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 24990000,0,NULL,0,1,0,0,1,1,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy Note 8','DT006.jpg',15, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 22499000,0,NULL,0,0,1,0,1,1,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy A8+ (2018)','DT007.jpg',17, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 13490000,0,NULL,0,0,0,1,1,1,2)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Samsung Galaxy J7+','DT008.jpg',14, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 7290000,0.08,NULL,0,0,1,0,1,1,2)


--OPPO--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'OPPO F7 128GB','DT009.jpg',11, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 9990000,0,NULL,0,1,0,0,1,1,3)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'SOPPO F5 6GB','DT010.jpg',12, CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 8990000,0,NULL,0,0,1,0,1,1,3)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'OPPO F5 Youth','DT011.jpg',7,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 6190000,0,NULL,0,0,0,1,1,1,3)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'OPPO F1s 2017 (64GB)','DT012.jpg',14,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 4990000,0.05,NULL,0,1,1,0,1,1,3)


--Nokia--
INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 8','DT013.jpg',9,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 12990000,0,NULL,0,1,0,0,1,1,4)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 6','DT014.jpg',6,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 5590000,0,NULL,0,0,1,0,1,1,4)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 5','DT015.jpg',17,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 4259000,0,NULL,0,0,0,1,1,1,4)

INSERT INTO Products (NameProduct, Photo, Quantity, ProductDate, UnitBrief,UnitPrice,Discount,Description,Views,Available,Special,Latest,Status,CategoryID,ProducerID) 
VALUES (N'Nokia 3','DT016.jpg',11,CAST(0x0000A8D200000000 AS DateTime),N'1 Chiếc', 2990000,0.03,NULL,0,1,0,1,1,1,4)



-- Chèn dữ liệu Customers - Khách Hàng
INSERT INTO Customers (ID,Email,Password,FullName,Photo,Address,NumberPhone,Birthday,Gender,Activated) 
VALUES ('hieuboyfc','cuonglekim22@gmail.com','123456abc',N'Le Kim Cuong','KH001.jpg',N'Phu yen','0344684483',CAST(0x00008AB400000000 AS DateTime),1,1)

INSERT INTO Customers (ID,Email,Password,FullName,Photo,Address,NumberPhone,Birthday,Gender,Activated) 
VALUES ('lekimcuong','lekimcuong@gmail.com','123456abc',N'CuongLe','KH002.jpg',N'PhuYen','0344684483',CAST(0x00008AB400000000 AS DateTime),1,1)

