/* Assignment 1  */


/*
return number of orders in a month
@param - month:int,year:int
*/
delimiter $$
CREATE FUNCTION no_of_order(month int,year int)
       RETURNS int 
BEGIN
        DECLARE total_orders integer;

select 
    count(Id) into total_orders
from
    Orders
where
    extract(MONTH from OrderDate) = month and extract(YEAR from OrderDate) = year;

        RETURN total_orders;
END$$
delimiter ;


/*
call the function
*/
select  no_of_order(3,2021) as total_orders ;




/*
return month in a year having maximum orders
@param - year:int
*/
delimiter $$
CREATE FUNCTION max_sale_month(year int)
       RETURNS int 
BEGIN
        DECLARE max_month integer;

select 
    result.month into max_month
from
    (select 
    EXTRACT(MONTH FROM OrderDate) as month, count(EXTRACT(MONTH FROM OrderDate)) as count
from
    Orders
where
    extract(YEAR FROM Orders.OrderDate) = year
group by month order by count limit 1) as result;

        RETURN max_month;
END$$
delimiter ;

/*
call the function
*/
select max_sale_month(2020) as max_orders_month;













/* Assignment 2 */



/*
 retrieve average sales of each product in a month
 @param-month and year
*/
delimiter $$
create procedure avg_sale(month int,year int)
    begin
select 
    I.ProductId, P.Title, count(I.ProductId)/30
from
    Orders O,
    Item I,
    Product P
where
    O.orderId = od.order_id and od.p_id = p.p_id and extract(MONTH from o.order_date) = month and extract(YEAR from o.order_date) = year group by od.p_id;
    end$$

delimiter ;
/*
call the procedure
*/
call avg_sale(3,2021);



/*
retrieve table having order detail with status for a given period
@param - start_date and end_date in 'YYYY-MM-DD' format
*/
delimiter $$
create procedure order_details(start_date date,end_date date)
begin
select P.Id, P.Title, case when I.State = "Shipped" then 'shipped'
when I.State = "Cancelled" then 'cancelled'
when I.State = "Returned" then 'returned'
else 'processed'
end as status from Orders O, Item I, Product P 
where O.Id = I.OrderId and P.Id = I.ProductId and 
case when start_date > end_date then date(O.OrderDate) 
between start_date - DAY(start_date) + 1 and end_date
else date(O.OrderDate) between start_date and end_date
end;
end$$
delimiter ;



/*
call the procedure
*/
call order_details('2021-03-19', '2021-03-19');



















/* Assignment 3 */

/*creating index for the most used column in these three tables*/
create index productId_index on  product(Id);
create index order_index on orders(Id, OrderDate);
create index category_index on category(Id, Title);

show index from product from storefront;
show index from orders from storefront;
show index from category from storefront;