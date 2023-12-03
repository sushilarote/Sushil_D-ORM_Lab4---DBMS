create database DBMSAssessment;
use DBMSAssessment;

/*Creating Table*/

create table Supplier (
SUPP_ID int PRIMARY KEY,
SUPP_NAME varchar(50) Not Null,
SUPP_CITY varchar(50) Not Null,
SUPP_PHONE varchar(50) Not Null
);

create table Customer (
CUS_ID int PRIMARY KEY,
CUS_NAME varchar(20) Not Null,
CUS_PHONE varchar(10) Not Null,
CUS_CITY varchar(30) Not Null,
CUS_GENDER char
);

create table Category (
CAT_ID int PRIMARY KEY,
CAT_NAME varchar(20) Not Null
);

create table Product (
PRO_ID int PRIMARY KEY,
PRO_NAME varchar(20) Not Null DEFAULT 'Dummy',
PRO_DESC varchar(60),
CAT_ID int Not Null,
FOREIGN KEY (CAT_ID) REFERENCES Category(CAT_ID) 
);

create table Supplier_Pricing (
PRICING_ID int PRIMARY KEY,
PRO_ID int,
SUPP_ID int ,
SUPP_PRICE int DEFAULT '0',
FOREIGN KEY (PRO_ID) REFERENCES Product(PRO_ID), 
FOREIGN KEY (SUPP_ID) REFERENCES Supplier(SUPP_ID) 
);

create table orders (
ORD_ID int PRIMARY KEY,
ORD_AMOUNT int Not Null,
ORD_DATE DATE Not Null,
CUS_ID int ,
PRICING_ID int ,
FOREIGN KEY (CUS_ID) REFERENCES Customer(CUS_ID), 
FOREIGN KEY (PRICING_ID) REFERENCES Supplier_Pricing(PRICING_ID) 
);

create table rating (
RAT_ID int PRIMARY KEY,
ORD_ID int,
RAT_RATSTARS  int Not Null,
FOREIGN KEY (ORD_ID) REFERENCES orders(ORD_ID) 
);

/*Inserting Data*/

INSERT INTO Supplier
VALUES
(1, 'Rajesh Retails', 'Delhi','1234567890'),
(2, 'Appario Ltd.', 'Mumbai','2589631470'),
(3, 'Knome products', 'Banglore','9785462315'),
(4, 'Bansal Retails', 'Kochi','8975463285'),
(5, 'Mittal Ltd.', 'Lucknow','7898456532');


INSERT INTO Customer
VALUES
(1, 'AAKASH', '9999999999','DELHI','M'),
(2, 'AMAN', '9785463215','NOIDA','M'),
(3, 'NEHA', '9999999999','MUMBAI','F'),
(4, 'MEGHA', '9994562399','KOLKATA','F'),
(5, 'PULKIT', '7895999999','LUCKNOW','M');

INSERT INTO Category
VALUES
(1, 'BOOKS'),
(2, 'GAMES'),
(3, 'GROCERIES'),
(4, 'ELECTRONICS'),
(5, 'CLOTHES');

INSERT INTO Product
VALUES
(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM','2'),
(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations','5'),
(3, 'ROG LAPTOP', 'Windows 10 with 15inch screen, i7 processor, 1TB SSD','4'),
(4, 'OATS', 'Highly Nutritious from Nestle','3'),
(5, 'HARRY POTTER', 'Best Collection of all time by J.K Rowling','1'),
(6, 'MILK', '1L Toned MIlk','3'),
(7, 'Boat Earphones', '1.5Meter long Dolby Atmos','4'),
(8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color','5'),
(9, 'Project IGI', 'compatible with windows 7 and above','2'),
(10, 'Hoodie', 'Black GUCCI for 13 yrs and above','5'),
(11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki','1'),
(12, 'Train Your Brain', 'By Shireen Stephen','1');


INSERT INTO Supplier_pricing
VALUES
(1 , 1 ,2, 1500 ),
(2 , 3 ,5, 30000),
(3 , 5 ,1, 3000 ),
(4 , 2 ,3, 2500 ),
(5 , 4 ,1, 1000 ),
(6 , 12,2, 780  ),
(7 , 12,4, 789  ),
(8 , 3 ,1, 31000),
(9 , 1 ,5, 1450 ),
(10, 4 ,2, 999  ),
(11, 7 ,3, 549  ),
(12, 7 ,4, 529  ),
(13, 6 ,2, 105  ),
(14, 6 ,1, 99   ),
(15, 2 ,5, 2999 ),
(16, 5 ,2, 2999 );

INSERT INTO Orders
VALUES
(101,1500,'2021-10-06',2,1),
(102,1000,'2021-10-12',3,5),
(103,30000,'2021-09-16',5,2),
(104,1500,'2021-10-05',1,1),
(105,3000,'2021-08-16',4,3),
(106,1450,'2021-08-18',1,9),
(107,789,'2021-09-01',3,7),
(108,780,'2021-09-07',5,6),
(109,3000,'2021-09-10',5,3),
(110,2500,'2021-09-10',2,4),
(111,1000,'2021-09-15',4,5),
(112,789,'2021-09-16',4,7),
(113,31000,'2021-09-16',1,8),
(114,1000,'2021-09-16',3,5),
(115,3000,'2021-09-16',5,3),
(116,99,'2021-09-17',2,14);

INSERT INTO Rating
VALUES
(1 , 101, 4),
(2 , 102, 3),
(3 , 103, 1),
(4 , 104, 2),
(5 , 105, 4),
(6 , 106, 3),
(7 , 107, 4),
(8 , 108, 4),
(9 , 109, 3),
(10, 110, 5),
(11, 111, 3),
(12, 112, 4),
(13, 113, 2),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);

/*4) Display the total number of customers based on gender who have placed individual orders of worth at least Rs.3000.
*/

SELECT
    c.CUS_GENDER,
    COUNT(DISTINCT c.CUS_ID) AS Total_Customers
FROM
    Customer c
JOIN
    orders o ON c.CUS_ID = o.CUS_ID

WHERE
    o.ORD_AMOUNT >= 3000
GROUP BY
    c.CUS_GENDER;
    
 /* 5) Display all the orders along with product name ordered by a customer having Customer_Id=2
*/   

SELECT
    o.ORD_ID,
    p.PRO_NAME,
    o.ORD_AMOUNT
FROM
    customer c
JOIN
    orders o ON c.CUS_ID = o.CUS_ID
JOIN
    Supplier_pricing sp ON o.PRICING_ID = sp.PRICING_ID
JOIN
    product p ON sp.PRO_ID = p.PRO_ID
WHERE
    c.CUS_ID = 2;

 /* 6) Display the Supplier details who can supply more than one product.
*/  
SELECT
    s.SUPP_ID,
    s.SUPP_NAME,
    COUNT(sp.PRO_ID) AS total_products_supplied
FROM
    Supplier s
JOIN
    Supplier_pricing sp ON s.SUPP_ID = sp.SUPP_ID
JOIN
    Product P ON P.PRO_ID = sp.PRO_ID
GROUP BY
    s.SUPP_ID, s.SUPP_NAME
HAVING
    COUNT(sp.PRO_ID) > 1;
    
 /*7) Find the least expensive product from each category and print the table with category id, name, product name and price of the product
*/

SELECT
    c.CAT_ID,
    c.CAT_NAME,
    p.PRO_NAME,
    MIN(sp.SUPP_PRICE) AS least_expensive_price
FROM
    Category c
JOIN
    product p ON c.CAT_ID = p.CAT_ID
JOIN
    Supplier_pricing sp ON p.PRO_ID = sp.PRO_ID
GROUP BY
    c.CAT_ID, c.CAT_NAME, p.PRO_NAME; 
    
/*8)Display the Id and Name of the Product ordered after “2021-10-05”
*/    

SELECT
    p.PRO_ID AS Id,
    p.PRO_NAME AS Name
FROM
    product p
JOIN
    Supplier_pricing sp ON p.PRO_ID = sp.PRO_ID
JOIN
    orders o ON sp.PRICING_ID = o.PRICING_ID
WHERE
    o.ORD_DATE > '2021-10-05';
    

/*9)Display customer name and gender whose names start or end with character 'A'.
*/   

SELECT
    CUS_NAME,
    CUS_GENDER
FROM
    customer
WHERE
    CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A'; 
/*10) Create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and
Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average
Service” else print “Poor Service”. Note that there should be one rating per supplier.
*/

    
DELIMITER //

CREATE PROCEDURE DisplaySupplierDetails1()
BEGIN
    SELECT
        s.SUPP_ID,
        s.SUPP_NAME,
        AVG(R.RAT_RATSTARS) AS Rating,
        CASE
            WHEN AVG(R.RAT_RATSTARS) = 5 THEN 'Excellent Service'
            WHEN AVG(R.RAT_RATSTARS) > 4 THEN 'Good Service'
            WHEN AVG(R.RAT_RATSTARS) > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service
    FROM
        supplier s
	LEFT JOIN
        Supplier_pricing sp ON s.SUPP_ID = sp.SUPP_ID
    LEFT JOIN
        product p ON sp.PRO_ID = p.PRO_ID
   
    LEFT JOIN
        Orders o ON o.PRICING_ID = sp.PRICING_ID   
    LEFT JOIN
        Rating R ON R.ORD_ID = o.ORD_ID    
    GROUP BY
        s.SUPP_ID, s.SUPP_NAME;
END //

DELIMITER ;    

CALL DisplaySupplierDetails1();
