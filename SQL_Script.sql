SELECT * FROM customers;

select * from customers
where creditLimit > 20000 and creditLimit < 70000;

select * from customers where creditLimit between 20000 and 70000;

select * from customers where creditLimit between 20000 and 70000;

select * from customers 
where customerNumber in (103, 121, 203, 222);


select * from customers
where creditLimit between 20000 and 50000 
order by creditLimit desc
limit 5
offset 1;

select * from customers
where country = 'UK' or country = 'USA';

select count(*) from customers
where creditLimit > 20000 and creditLimit < 70000;

select * from products;

select max(buyPrice) from products;

select min(buyPrice) from products;

select avg(buyPrice) from products;

select count(distinct country) as 'number of countries' from customers;

select * from payments;

select customerNumber, sum(amount) as 'average purchase'
from payments
group by customerNumber
order by 'total amount';

select customerNumber, avg(amount) as 'average purchase'
from payments
group by customerNumber
order by 'average purchase' desc;

select customerNumber, sum(amount) as totalpurchase
from payments
group by customerNumber
order by totalpurchase desc;

select productLine, count(productLine) as product_line from products
where product_line > 3
group by productLine;


select productLine, count(productLine) from products
where productLine > 3
group by productLine;

SELECT productLine, COUNT(productLine) AS productLineCount
FROM products
WHERE productLine > 3
GROUP BY productLine;

select productLine, count(productLine) as product_line from products
group by productLine
Having product_line > 3;

select * from products;

select productLine, sum(quantityInStock) as qty_in_stock from products
group by productLine
having qty_in_stock > 20000;

select 
productLine, 
sum(quantityInStock * buyPrice) as value_in_stock, 
(sum(quantityInStock * buyPrice) * 100) / sum(sum(quantityInStock * buyPrice)) as percent 
from products;
-- group by productLine;
-- order by value_in_stock desc;


select 
productLine, 
sum(quantityInStock * buyPrice) as value_in_stock
from products
group by productLine
order by value_in_stock desc;

SELECT productLine, SUM(quantityInStock * buyPrice) AS value_in_stock, (SUM(quantityInStock * buyPrice) / SUM(quantityInStock * buyPrice) OVER ()) * 100 AS percentage
FROM products
GROUP BY productLine
ORDER BY value_in_stock DESC;


select * from products;

select *, if (country = 'USA', 'Yes', 'No') as foreigner, if (postalCode = 44000, 'Yes', 'No') as post from customers;

select *, (quantityInStock * buyPrice) as worth,
case 
	when quantityInStock * buyPrice >= 500000 then 'gold'
	when quantityInStock * buyPrice >= 200000 then 'silver'
else 'copper'
end as status_of_customer
from products;


select * from payments;

select customerNumber, sum(amount) as total 
from payments
group by customerNumber
having total > 10000
order by customerNumber;

select * from products;

select productLine, sum((MSRP - buyPrice) * quantityInStock) as profit_in_stock
from products
group by productLine
having profit_in_stock > 2000000
order by profit_in_stock desc;

select avg(MSRP) from products;

select 
c.customerNumber,
c.customerName, 
c.phone, 
c.creditLimit,
sum(p.amount) as total_amount,
if (sum(p.amount) > 100000, 'premium', 'non premium') as status
from customers as c
join payments as p
using (customerNumber)
group by c.customerNumber
order by customerNumber;


select 
c.customerNumber,
c.customerName,
c.country,
ord.orderDate,
ord.status,
p.productName,
ordD.quantityOrdered,
ordD.priceEach,
(ordD.quantityOrdered * ordD.priceEach) as total_cost
from customers as c
join orders as ord
using (customerNumber)
join orderdetails as ordD
using (orderNumber)
join products as p
using (productCode);


select * from 
(select amount from payments) as pay
where amount > 20000 and amount < 40000;


select 
ordD.productCode, 
ord.orderNumber, 
ordD.quantityOrdered, 
ordD.priceEach, 
ord.orderDate, 
(ordD.quantityOrdered * ordD.priceEach) as total
from orderdetails as ordD
join orders as ord
using(orderNumber)
where orderNumber in (
select orderNumber
from orders
where orderDate > '2003-12-31' and orderDate < '2005-01-01'
);

select orderNumber from orders
where orderDate > '2003-12-31' and orderDate < '2005-01-01';

select productCode, quantityOrdered, priceEach
from orderdetails;

select orderDate 
from orders
where orderDate > '2002-12-31' and orderDate < '2004-01-01';


select e.firstName, e.lastName, 
(select city from offices as o
where e.officeCode = o.officeCode) as city
from employees as e;

select customerName, phone from customers where city in 
(select city from offices where country = 'France' or country = 'Japan');

-- orderdetails products 

select * from orderdetails join products;

explain format = tree
select orderNumber, quantityOrdered, priceEach, 
(select productLine from products where orderdetails.productCode = products.productCode) as product_line
from orderdetails
having product_line = 'Vintage Cars';


with 
odr_table 
as (select * from orders
where status = 'Shipped'),
ORD_table 
as (select * from orderdetails
where orderLineNumber > 5)
select orderNumber, sum(quantityOrdered) as total_quantity from odr_table join ORD_table using(orderNumber)
group by orderNumber
having total_quantity > 200
order by total_quantity desc;


with ord as (select * from orders 
where orderDate > '2003-12-31' and orderDate < '2005-01-01'),
prd as (select * from products
where productLine = 'Motorcycles' or productLine = 'Vintage Cars'),
det as (
select * from orderdetails
where orderLineNumber > 5)
select 
	orderNumber
	productCode, 
    productName, 
    quantityInStock, 
    buyPrice, 
    MSRP, 
    quantityOrdered as quantity_sold,
    round((quantityInStock * buyPrice), 0) as total_cost,
    round((quantityOrdered * MSRP), 0) as gross_sales,
    round((quantityInStock * buyPrice - quantityOrdered * MSRP), 0) as profit
from prd 
join det
using (productCode)
join ord
using (orderNumber);

set @name = 'Souvik';
select @name;

select @address :=  'briji' as address;

select @average_price := (
select buyPrice as buyprice from products
where productName = '1940 Ford Pickup Truck') as buyprice;

SELECT @average_price := AVG(MSRP) AS average_price
FROM products
WHERE buyPrice > 60;

select @avgprice := avg(MSRP) as averagePrice from products where buyPrice > 60;

select now();

select date_add(now(), interval 12 month);

select classicmodels.result2('Motorcycles');

select year(o.orderDate) as year, month(o.orderDate) as month, c.country, sum(ord.quantityOrdered * ord.priceEach) as gross_sales
from customers as c 
join orders as o
using(customerNumber)
join orderdetails as ord
using(orderNumber)
group by year, month, c.country;

select month from gross_sale_report;






























