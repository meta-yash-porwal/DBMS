
CREATE DATABASE StoreFront;

use StoreFront;

CREATE TABLE Category (
Id INT PRIMARY KEY,
Title VARCHAR(60),
ParentCategoryId INT
);

CREATE TABLE Product (
Id INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
Price DECIMAL(12,2),
Description VARCHAR(500),
Stock INT,
Image BLOB(50000),
Active TINYINT(1),
CategoryId INT,
FOREIGN KEY (CategoryId) REFERENCES Category (Id)
);


CREATE TABLE Shopper (
Id INT PRIMARY KEY,
Email VARCHAR(80),
Password VARCHAR(20),
Name TINYTEXT,
Address VARCHAR(1000)
);





CREATE TABLE Orders (
Id INT PRIMARY KEY, 
OrderDate DATE,
TotalCost DECIMAL(14,2),
ShippingAddress VARCHAR(1000),
ShopperId INT, 
FOREIGN KEY (ShopperId) REFERENCES Shopper(Id)
);



CREATE TABLE Item (
Id INT PRIMARY KEY,
State VARCHAR(255),
Quantity INT,
OrderId INT,
ProductId INT,
FOREIGN KEY (OrderId) REFERENCES Orders(Id),
FOREIGN KEY (ProductId) REFERENCES Product(Id)
);


SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Shopper;
SELECT * FROM Orders;
SELECT * FROM Item;


SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE Product;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE Product (
Id INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
Price DECIMAL(12,2),
Description VARCHAR(500),
Stock INT,
Image BLOB(50000),
Active TINYINT(1),
CategoryId INT,
FOREIGN KEY (CategoryId) REFERENCES Category (Id)
);






        /* Assignment Question -> 2    */





SELECT P.Id, P.Title, C.Title, P.Price FROM Product P INNER JOIN Category C ON P.CategoryId = C.Id
WHERE Active > 0
LIMIT 1 ;





SELECT * FROM Product
WHERE Image = NULL;



SELECT Title FROM Product 
WHERE 'Null' IN (SELECT IFNULL(Image, 'Null') FROM Product);






SELECT C1.Id, C1.Title, (SELECT C2.Title FROM Category C2 
WHERE C1.ParentCategoryId = C2.Id) AS ParentCategoryName
FROM Category C1
WHERE C1.Id NOT IN (SELECT IFNULL(ParentCategoryId, 'TopCategory') FROM Category);








SELECT C1.Id, C1.Title, IFNULL((SELECT C2.Title FROM Category C2 
WHERE C1.ParentCategoryId = C2.Id), "Top Category") AS ParentCategoryName
FROM Category C1
ORDER BY (SELECT C2.Title FROM Category C2 
WHERE C2.ParentCategoryId = C2.Id), C1.Title; 
















SELECT P.Title, P.Price, P.Description FROM Product P INNER JOIN Category C 
ON P.CategoryId = C.Id
WHERE C.Title = "Mobile" OR ParentCategoryId 
IN 
(SELECT Id FROM Category WHERE Title = "Mobile");







SELECT Title FROM Product
WHERE Stock < 50;








    /* Assignment Question 3 */





SELECT Id, OrderDate, TotalCost FROM Orders
LIMIT 50;


SELECT * FROM Orders
ORDER BY TotalCost DESC
LIMIT 10;


SELECT O.Id, O.OrderDate, O.TotalCost FROM Orders O INNER JOIN Item I
ON O.Id = I.OrderId 
WHERE (O.OrderDate  NOT BETWEEN DATE_SUB(CURDATE(), INTERVAL 10 DAY) AND CURDATE())
AND I.State = "Shipped";




SELECT DISTINCT Id, Name, Email FROM Shopper
WHERE Id NOT IN
(SELECT ShopperId FROM Orders 
WHERE OrderDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 30 DAY) AND CURDATE());





SELECT S.Id, S.Name, S.Email, O.Id FROM Shopper S INNER JOIN Orders O 
ON O.ShopperId = S.Id
WHERE O.OrderDate BETWEEN DATE_SUB(CURDATE(), INTERVAL 15 DAY) AND CURDATE() ;





SELECT O.ID, O.OrderDate FROM Orders O INNER JOIN Item I
ON I.OrderId = O.Id
WHERE I.State = "Shipped";                    





SELECT Id, OrderDate FROM Orders
WHERE TotalCost >= 20 and TotalCost <= 50;