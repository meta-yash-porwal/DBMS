use storefront;


/* Assignment 2 */

SELECT P.Id, P.Title, count(P.CategoryId) AS no_of_category
FROM Product P INNER JOIN Category C
ON P.Id = C.Id
GROUP BY C.Id;






SELECT 
  CASE 
    WHEN price BETWEEN 0 AND 100 THEN '0-100'
    WHEN price BETWEEN 101 AND 500 THEN '101-500'
    else 'above 500'
  END AS `Range in rs`,
  count(1) AS `Count`
FROM product
GROUP BY `Range in rs`;









SELECT C.Title, count(P.CategoryId) from Product P inner join Category C
ON P.CategoryId = C.Id
GROUP BY P.CategoryId;







/* Assignment 3 */

SELECT S.Id, S.Name, COUNT(O.ShopperId) AS orders_in_last_60_days
FROM Shopper as S INNER JOIN Orders as O
ON S.Id = O.ShopperId
WHERE O.OrderDate > (DATE_SUB(CURDATE(), INTERVAL 2 MONTH));

/*GROUP BY O.ShopperId;*/






/*

SELECT S.Id, S.Name, sum(O.TotalCost) as total_revenue
FROM Shopper as S INNER JOIN Orders as O
ON S.Id = O.ShopperId
WHERE O.OrderDate > (DATE_SUB(CURDATE(), INTERVAL 2 MONTH))
and S.Id IN (select ShopperId from Orders
                    order by TotalCost desc)
group by O.ShopperId
limit 2;

*/


SELECT S.Id, S.Name, sum(O.TotalCost) as total_revenue
FROM Shopper as S INNER JOIN Orders as O
ON S.Id = O.ShopperId
WHERE O.OrderDate > (DATE_SUB(CURDATE(), INTERVAL 2 MONTH))
group by O.ShopperId
order by total_revenue desc
limit 2;











SELECT P.Id, P.Title, COUNT(I.ProductId) as product_count
FROM Product as P INNER JOIN Item as I
ON P.Id = I.ProductId
INNER JOIN Orders O
ON I.OrderId = O.Id
WHERE O.OrderDate > (DATE_SUB(CURDATE(), INTERVAL 2 MONTH))
GROUP BY I.ProductId
ORDER BY product_count desc
LIMIT 3;







SELECT MONTHNAME(OrderDate) AS month, SUM(TotalCost) AS total_order
FROM Orders
WHERE OrderDate > (DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
GROUP BY month(OrderDate);







SET SQL_SAFE_UPDATES = 0;
UPDATE Product
SET Active = 0
WHERE Id IN 
    (SELECT I.ProductId
     FROM Orders O INNER JOIN item I
     ON O.Id = I.OrderId
     WHERE O.OrderDate < (DATE_SUB(CURDATE(), INTERVAL 3 MONTH))
    );
SET SQL_SAFE_UPDATES = 1;
SELECT Title, Active from Product;
 
 
 
 
 
 
 
 
 
SELECT P.Title
FROM Product as P INNER JOIN Category as C
ON P.CategoryId = C.Id
WHERE C.Title = "Mobile";









SELECT P.Id , P.Title , COUNT(I.State = "Cancelled") as cancel_count
FROM Product as P INNER JOIN item as I
ON P.Id = I.ProductId
WHERE I.State = "Cancelled"
GROUP BY I.ProductId
ORDER BY cancel_count DESC
LIMIT 3;











/* Assignment 4 */




CREATE TABLE state (
    Id INTEGER AUTO_INCREMENT,
    Name VARCHAR(20),
    PRIMARY KEY(Id)
    );

CREATE TABLE city (
    Id INTEGER AUTO_INCREMENT,
    Name VARCHAR(20),
    StateId INTEGER,
    PRIMARY KEY(Id),
    FOREIGN KEY(StateId) REFERENCES state(Id)
    );
    
CREATE TABLE zipcode (
    Id CHAR(6),
    CityId INTEGER,
    PRIMARY KEY(Id),
    FOREIGN KEY(CityId) REFERENCES city(Id)
    );


INSERT INTO state (Name)
VALUES  ("Rajasthan"),
        ("Haryana"),
        ("Uttar Pradesh"),
        ("Madhya Pradesh");
        
INSERT INTO city(Name, StateId)
VALUES  ("Udaipur", 1),
        ("Jaipur", 1),
        ("Faridabad", 2),
        ("Rohtak", 2),
        ("Agra", 3),
        ("Jhansi", 3),
        ("Shahdol", 4),
        ("Gwalior", 4);

INSERT INTO zipcode(Id,CityId)
VALUES  ("313002", 1),
        ("313003", 1),
        ("302002", 2),
        ("302003", 2),
        ("121003", 3),
        ("124001", 4),
        ("124021", 4),
        ("223007", 5),
        ("282005", 5),
        ("284001", 6),
        ("284002", 6),
        ("484001", 7),
        ("474005", 8);
        
        
SELECT Z.Id, C.Name, S.Name
FROM zipcode Z, city C, state S
WHERE Z.CityId = C.Id AND C.StateId = S.Id
ORDER BY S.Name, C.Name;







/* Assignement 5 */




CREATE OR REPLACE VIEW orders_in_past_60_days
	AS
		SELECT O.Id as OrderId, P.Id as ProductId, P.Title, P.Price, S.Name, S.Email, O.OrderDate, I.State
		FROM Orders as O, Product as P, Shopper as S, Item as I
        WHERE O.Id = I.OrderId AND 
        I.ProductId = P.Id AND 
        O.ShopperId = S.Id AND 
        O.OrderDate > (DATE_SUB(CURDATE(), INTERVAL 2 MONTH))

    ORDER BY I.OrderId DESC;
    
SELECT * FROM orders_in_past_60_days;











SELECT Title
FROM orders_in_past_60_days 
WHERE State = "Shipped";







SELECT Title, COUNT(Title) AS quantity_sold
FROM orders_in_past_60_days
GROUP BY Title
ORDER BY quantity_Sold DESC
LIMIT 2;