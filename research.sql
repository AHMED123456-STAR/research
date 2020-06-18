create database MiniSupermarket;
use MiniSupermarket;

CREATE TABLE Product_Categories
(
		Category_Id    integer primary key,
		Category_Name  nvarchar(300) unique not null
);

CREATE TABLE Products
(
		Product_Id     integer primary key,
		Product_Name   nvarchar(300) not null,
		Product_Price  decimal(9,3) check(Product_Price >= 0),
		Category_Id    integer references Product_Categories(Category_Id)
);

CREATE TABLE Customer
(
		Customer_Id   integer primary key,
		First_Name    nvarchar(200) not null,
		Last_Name     nvarchar(200) not null,
		Email         nvarchar(250) unique,
		Phone         nvarchar(20)
);

CREATE TABLE Employee
(
		Employee_Id     integer primary key,
		First_Name      nvarchar(200) not null,
		Last_Name		nvarchar(200) not null,
		Hire_Date		date default getdate(),
		Gender			char check(Gender in ('M','F')),
		Contract_Type	nvarchar(20)  check(Contract_Type in('FIXED','HOURLY'))
);

CREATE TABLE Fixed_Employee
(
		Employee_Id			integer primary key references Employee(Employee_Id),
		Salary_In_Month		decimal(8,2) check(Salary_In_Month between 2000 and 8000)
);

CREATE TABLE Hourly_Employee
(
		Employee_Id			integer primary key references Employee(Employee_Id),
		Working_Hours		decimal(6,2) check(Working_Hours > 0),
		Salary_Of_Hours		decimal(6,2) check(Salary_Of_Hours > 0)
);

CREATE TABLE Sales
(
		Sales_Id			integer primary key identity(1,1),
		Customer_Id			integer not null references Customer(Customer_Id),
		Employee_Id			integer not null references Employee(Employee_Id),
		Sales_Date			date default getdate(),
		Total_Price			decimal(7,2),
		Discount			decimal(7,2) default 0,
		Final_Price			decimal(7,2)
);

CREATE TABLE Sales_Of_Products
(
		Sale_Id				integer references Sales(Sales_Id),
		Product_Id			integer references Products(Product_Id),
		Quantity			decimal(7,2),
		Price_Of_Unit		decimal(7,2),
		primary key(Sale_Id,Product_Id),
		check (Quantity > 0),
		check (Price_Of_Unit >=0)
);