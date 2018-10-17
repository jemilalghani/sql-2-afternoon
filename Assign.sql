SELECT *
FROM Invoice i
JOIN InvoiceLine il ON il.invoiceId = i.invoiceId
WHERE il.UnitPrice > 0.99;
-- 
SELECT i.InvoiceDate, c.FirstName, c.LastName, i.Total
FROM Invoice i
JOIN Customer c ON c.CustomerId = i.CustomerId;
-- 
SELECT c.FirstName, c.LastName, e.FirstName, e.LastName
FROM Employee e
JOIN Customer c ON e.EmployeeId = c.SupportRepId;
-- 
SELECT ab.Title, ar.Name
FROM Album ab
JOIN Artist ar ON ab.ArtistId = ar.ArtistId;
-- 
SELECT pt.TrackId
FROM PlaylistTrack pt
JOIN Playlist p ON p.PlaylistId = pt.PlaylistId
Where p.Name='Music';
-- 
SELECT t.Name
FROM PlaylistTrack pt
JOIN Track t ON t.TrackId = pt.TrackId
Where pt.PlaylistId=5;
-- 
SELECT t.Name, p.Name
FROM PlaylistTrack pt
JOIN Track t 
ON t.TrackId = pt.TrackId
JOIN Playlist p
ON pt.PlaylistId = p.PlaylistId;
-- 
SELECT al.Title, t.Name
FROM Album al
JOIN Track t 
ON t.AlbumId = al.AlbumId
JOIN Genre g
ON g.GenreId = t.GenreId
where g.Name = "Alternative";
-- 
-- 

SELECT *
FROM Invoice
WHERE InvoiceId IN ( SELECT InvoiceId FROM InvoiceLine WHERE UnitPrice > 0.99 );
-- 
SELECT *
FROM PlaylistTrack 
WHERE PlaylistId IN ( SELECT PlaylistId FROM Playlist WHERE Name='Music' );
-- 
SELECT Name
FROM Track 
WHERE TrackId IN ( SELECT TrackId FROM PlaylistTrack WHERE PlaylistId = 5 );
-- 
SELECT *
FROM Track 
WHERE GenreId IN ( SELECT GenreId FROM Genre WHERE Name="Comedy" );
-- 
SELECT *
FROM Track 
WHERE AlbumId IN ( SELECT AlbumId FROM Album WHERE Title="Fireball" );
-- 
SELECT *
FROM Track 
WHERE AlbumId IN ( 
  SELECT AlbumId FROM Album WHERE ArtistId IN (
    SELECT ArtistId from Artist WHERE Name="Queen"
  )
);
-- 
-- 
Update Customer Set Fax = null Where Fax is not null;
select * from Customer;
-- 
Update Customer Set Company = "self" Where Company is null;
select * from Customer;
-- 
Update Customer Set LastName="Thompson" 
Where FirstName="Julia" AND LastName="Barnett";
select * from Customer;
-- 
Update Customer Set SupportRepId=4 
Where email="luisrojas@yahoo.cl";
select * from Customer;
-- 
Update Track Set Composer="The darkness around us" 
Where Composer is null and GenreId in (select GenreId from Genre where Name="Metal");
-- 
-- 
select Count(*), g.Name
from Track t
join Genre g on t.GenreId = g.GenreId
group by g.Name;
-- 
SELECT Count(*), g.Name
FROM Track t
JOIN Genre g ON g.GenreId = t.GenreId
WHERE g.Name = 'Pop' OR g.Name = 'Rock'
GROUP BY g.Name;
-- 
select Count(*), ar.Name
from Artist ar
join Album al on al.ArtistId=ar.ArtistId
group by al.ArtistId;
-- 
-- 
SELECT DISTINCT Composer
FROM Track;
-- 
SELECT DISTINCT BillingPostalCode
FROM Invoice;
-- 
SELECT DISTINCT Company
FROM Customer;
-- 
-- 
CREATE TABLE practice_delete ( Name string, Type string, Value integer );
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "silver", 100);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "silver", 100);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);

SELECT * FROM practice_delete;
-- 
delete from practice_delete where type="bronze";
select * from practice_delete;
-- 
delete from practice_delete where type="silver";
select * from practice_delete;
-- 
delete from practice_delete where value=150;
select * from practice_delete;
-- 
create table users (users_id serial primary key, Name text, Email text);
create table products (products_id serial primary key, Name text, Price int);
create table orders (orders_id serial primary key, products_id references products(products_id));

insert into users (Name, Email) values ('jojo', 'jojo@gmailcom');
insert into users (Name, Email) values ('koko', 'koko@gmailcom');
insert into users (Name, Email) values ('zozo', 'zozo@gmailcom');
select * from users

INSERT INTO products ( Name, price  ) VALUES ('P', 10);
INSERT INTO products ( Name, price ) VALUES ('T', 20);
INSERT INTO products ( Name, price ) VALUES ('D', 30);

select * from orders;

select orders_id from products p
join orders o on p.products_id = o.products_id 
where products_id = 1;

select sum(orders_id) from products p
join orders o on p.products_id = o.products_id;

select * from users;

alter table orders add column users_id int REFERENCES users(users_id);

insert into ordes (products_id, users_id) value (2,3);
insert into ordes (products_id, users_id) value (1,2);
insert into ordes (products_id, users_id) value (3,1);

select * from users u
join on orders o on u.users_id = o.users_id
group by u.users_id;

select Count(*) from users u
join on orders o on u.users_id = o.users_id
group by u.users_id;