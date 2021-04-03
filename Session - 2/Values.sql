INSERT INTO Category (Id, TItle, ParentCategoryId) 
VALUES (1,"Mobile", Null);
INSERT INTO Category (Id, TItle, ParentCategoryId) 
VALUES (2,"Samsung", 1);
INSERT INTO Category (Id, TItle, ParentCategoryId) 
VALUES (3,"Laptop", Null);
INSERT INTO Category (Id, TItle, ParentCategoryId) 
VALUES (4,"Dell", 3);






INSERT INTO product (Id, Title, Price, Description, Stock, Active, CategoryId)
VALUES (1, 'Galaxy A15s', 100.99, "A Smart Phone", 5, 1, 2);
INSERT INTO product (Id, Title, Price, Description, Stock, Active, CategoryId)
VALUES (2, 'Inspiron', 159.99, "A Laptop", 6, 1, 4);
INSERT INTO product (Id, Title, Price, Description, Stock, Active, CategoryId)
VALUES (3, 'Galaxy A10s', 70.99, "A Phone", 2, 0, 2);
INSERT INTO product (Id, Title, Price, Description, Stock, Active, CategoryId)
VALUES (4, 'One Plus 7', 89.99, "A Smart Phone", 5, 1, 1);
INSERT INTO product (Id, Title, Price, Description, Stock, Active, CategoryId)
VALUES (5, 'MI', 100.99, "A Smart Phone", 100, 1, 1);





INSERT INTO shopper (Id, Email, Password, Name)
VALUES (1, 'zyx@metacube.com', '***', 'ZYX');
INSERT INTO shopper (Id, Email, Password, Name)
VALUES (2, 'yzx@metacube.com', '**', 'YZX');
INSERT INTO shopper (Id, Email, Password, Name)
VALUES (3, 'xyz@metacube.com', '****', 'XYZ');
INSERT INTO shopper (Id, Email, Password, Name)
VALUES (4, 'zxy@metacube.com', '*', 'ZXY');





INSERT INTO orders (Id, OrderDate, TotalCost, ShopperId)
VALUES (1, '2020-01-01', 300, 1);
INSERT INTO orders (Id, OrderDate, TotalCost, ShopperId)
VALUES (2, '2020-03-01', 500, 2);
INSERT INTO orders (Id, OrderDate, TotalCost, ShopperId)
VALUES (3, '2020-01-01', 350, 3);
INSERT INTO orders (Id, OrderDate, TotalCost, ShopperId)
VALUES (4, '2019-01-01', 50, 3);
INSERT INTO orders (Id, OrderDate, TotalCost, ShopperId)
VALUES (5, '2020-03-12', 45, 2);
INSERT INTO orders (Id, OrderDate, TotalCost, ShopperId)
VALUES (6, '2021-03-19', 55, 3);







INSERT INTO item (Id, State, Quantity, OrderId, ProductId)
VALUES (1, "Shipped", 5, 1, 5);
INSERT INTO item (Id, State, Quantity, OrderId, ProductId)
VALUES (2, "Delivered", 1, 1, 4);
INSERT INTO item (Id, State, Quantity, OrderId, ProductId)
VALUES (3, "Cancelled", 1, 2, 3);
INSERT INTO item (Id, State, Quantity, OrderId, ProductId)
VALUES (4, "Shipped", 4, 6, 4);







