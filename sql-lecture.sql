DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS line_items;

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  shipping_address TEXT,
  user_id INTEGER 
  references users(id)
);

CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name TEXT,
  price DECIMAL CHECK (price > 0)
);

CREATE TABLE IF NOT EXISTS line_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER,
  product_id INTEGER,
  qty INTEGER 
);

INSERT INTO users
  (name, email)
VALUES
  ('Daniel', 'gmail@daniel.com'),
  ('Tyler', 'gmail@t$.com'),
  ('Daniel', 'gmail@danny.luv');
    
INSERT INTO orders
  (shipping_address, user_id)
VALUES
  ('123 N Street Rd', 1),
  ('321 S Road St', 1),
  ('321 S Road St', 2),
  ('123 S Street Rd', 3);
--   ('123 N PLace', 4);
    
INSERT INTO products
  (name, price)
VALUES
  ('AA Batteries', 5),
  ('AAA Batteries', 4),
  ('C Batteries', 6),
  ('D Batteries', 7),
  ('Z Batteries', 40);

INSERT INTO line_items
  (order_id, product_id, qty)
VALUES
  (1, 1, 2),
  (1, 2, 2),
  (1, 3, 2),
  (2, 1, 1),
  (2, 2, 1),
  (2, 3, 1),
  (3, 3, 3),
  (3, 4, 2);

select name user_name, u.email from users u;
select * from orders;
select * from line_items;


-- which user has the most orders?
select o.user_id, u.name, count(o.user_id)
from users u
join orders o
on u.id = o.user_id
group by o.user_id, u.name
order by count(o.user_id) desc;
-- 
select o.user_id, u.name, sum(li.qty)
from users u
join orders o
on u.id = o.user_id
join line_items li
on li.order_id = o.id
group by o.user_id, u.name
order by sum(li.qty) desc;
-- 
select *
from users u
join orders o
on o.user_id=u.id;

-- Use (inner) joins to show users and orders, but only those that have line items
select *
from users u 
join orders o
on u.id = o.user_id
join line_items li
on li.order_id = o.id
join products p 
on p.id = li.product_id;
-- Use outer joins to see all users and orders regardless of if they have line items 

select *
from users u 
join orders o 
on u.id = o.user_id
left join line_items li
on li.order_id = o.id
left join products p 
on p.id = li.product_id;

--  Use where clause to find orders without line items

select *
from users u 
join orders o 
on u.id = o.user_id
left join line_items li
on li.order_id = o.id
left join products p 
on p.id = li.product_id
where li.id is null;

select * from users;
alter table users add column date_of_birth date not null default '1800-01-01';
alter table users drop column date_of_birth;



