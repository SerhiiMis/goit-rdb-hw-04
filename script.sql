-- 1. Creating the LibraryManagement database and tables 

create database LibraryManagement;
use LibraryManagement;

create table authors ( 
author_id int auto_increment primary key,
author_name varchar(255) not null);

create table genres (
genre_id int auto_increment primary key,
genre_name varchar(255) not null);

create table books ( 
book_id int auto_increment primary key,
title varchar(255) not null,
publication_year year not null,
author_id int,
genre_id int,
foreign key (author_id) references authors(author_id),
foreign key (genre_id) references genres(genre_id));

create table users (
user_id int auto_increment primary key,
username varchar(255) not null,
email varchar(255) not null);

create table borrowed_books (
borrow_id int auto_increment primary key,
book_id int,
user_id int,
borrow_date date not null,
return_date date,
foreign key (book_id) references books(book_id),
foreign key (user_id) references users(user_id));

-- 2. Filling up the tables

use LibraryManagement;

insert into authors (author_name) values ('Stephen King'), ('Jack London'), ('Kazuo Ishiguro');

insert into genres (genre_name) values ('Horror'), ('Science Fiction'), ('Adventure Fiction');

insert into books (title, publication_year, author_id, genre_id) values ('The Shining', 1977, 1, 1), ('Klara and the Sun', 2021, 3, 2), ('White Fang', 1906, 2, 3);

insert into users (username, email) values ('Serhii', 'serhii@gmail,com'), ('Anna', 'anna@gmail.com');

insert into borrowed_books (book_id, user_id, borrow_date, return_date) values (2, 1, '2025-02-02', '2025-02-05'), (3, 2, '2025-01-09', '2025-02-01');

-- 3. Table join

use mydb;
select
    orders.id as order_id,
    customers.name as customer_name,
    employees.first_name as employee_first_name,
    employees.last_name as employee_last_name,
    orders.date as order_date,
    shippers.name as shipper_name,
    products.name as product_name,
    categories.name as category_name,
    suppliers.name as supplier_name,
    order_details.quantity as quantity,
    products.price as unit_price
from orders
inner join customers on orders.customer_id = customers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id;

-- 4. Count, Inner, Left, Right, Avg, Group by, Limit, Offset
-- 4.1 and 4.2

use mydb;
select count(*) as total_rows
from orders
left join customers on orders.customer_id = customers.id
left join employees on orders.employee_id = employees.employee_id
left join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
left join categories on products.category_id = categories.id
left join suppliers on products.supplier_id = suppliers.id

select count(*) as total_rows
from orders
right join customers on orders.customer_id = customers.id
right join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
right join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
right join suppliers on products.supplier_id = suppliers.id;

-- 4.3

select 
    orders.id as order_id,
    customers.name as customer_name,
    employees.first_name as employee_first_name,
    employees.last_name as employee_last_name,
    orders.date as order_date,
    shippers.name as shipper_name,
    products.name as product_name,
    categories.name as category_name,
    suppliers.name as supplier_name,
    order_details.quantity as quantity,
    products.price as unit_price
from orders
inner join customers on orders.customer_id = customers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
where employees.employee_id > 3 and employees.employee_id <= 10;

-- 4.4

select 
    categories.name as category_name,
    COUNT(*) as total_orders,
    avg(order_details.quantity) as avg_quantity_per_order
from orders
inner join customers on orders.customer_id = customers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
group by categories.name;

-- 4.5

select 
categories.name as category_name,
    COUNT(*) as total_orders,
    avg(order_details.quantity) as avg_quantity_per_order
from orders
inner join customers on orders.customer_id = customers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
group by categories.name
having avg(order_details.quantity) > 21;

-- 4.6

select 
 categories.name as category_name,
    COUNT(*) as total_orders,
    AVG(order_details.quantity) as avg_quantity_per_order
from orders
inner join customers on orders.customer_id = customers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
group by categories.name
having avg(order_details.quantity) > 21
order by total_orders desc;

-- 4.7
select 
categories.name as category_name,
    count(*) as total_orders,
    avg(order_details.quantity) as avg_quantity_per_order
from orders
inner join customers on orders.customer_id = customers.id
inner join employees on orders.employee_id = employees.employee_id
inner join shippers on orders.shipper_id = shippers.id
inner join order_details on orders.id = order_details.order_id
inner join products on order_details.product_id = products.id
inner join categories on products.category_id = categories.id
inner join suppliers on products.supplier_id = suppliers.id
group by categories.name
having avg(order_details.quantity) > 21
order by total_orders desc
limit 4 offset 1;





