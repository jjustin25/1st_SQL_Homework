use sakila;

-- 1a
SELECT first_name, last_name
FROM actor;
-- 1b
ALTER TABLE actor ADD Actor_Name VARCHAR(50);

SELECT 
CONCAT(UPPER(SUBSTRING(first_name,1,29)),' ',UPPER(SUBSTRING(last_name,1,29))) AS 'Name'
FROM actor
AS Actor_Name;
-- 2a
SELECT actor_id, first_name, last_name
   FROM actor
   WHERE first_name ="Joe";
-- 2b
SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE "%GEN%";
-- 2c
SELECT last_name, first_name FROM actor WHERE last_name LIKE '%LI%';
-- 2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
-- 3a
ALTER TABLE actor
	ADD middle_name VARCHAR(25) AFTER first_name;
-- 3b
ALTER TABLE actor
	MODIFY COLUMN middle_name blob;
-- 3c
ALTER TABLE actor
	DROP COLUMN middle_name;
-- 4a
SELECT last_name, COUNT(*) AS 'count' FROM actor GROUP BY last_name;
-- 4b
SELECT last_name, COUNT(*) AS 'count' FROM actor GROUP BY last_name HAVING COUNT(*) > 1;
# 4c
UPDATE actor
SET first_name ='HARPO'
WHERE (first_name ='GROUCHO' AND last_name = 'WILLIAMS');
# 4d
UPDATE actor
SET first_name ='GROUCHO'
WHERE (first_name ='HARPO' AND last_name = 'WILLIAMS');

UPDATE actor
SET first_name ='MUCHO GROUCHO'
WHERE first_name ='GROUCHO';
-- 5a
SHOW CREATE TABLE address;
# 6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;
# 6b
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS 'Total', payment.payment_date
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '%2005_08%';
# 6c
SELECT film.title, COUNT(film_actor.actor_id)
FROM film
INNER join film_actor ON
film.film_id = film_actor.film_id
GROUP BY film.title;
# 6d
SELECT COUNT(*)
FROM inventory
WHERE film_id IN
	(
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
    );
# 6e
SELECT customer.last_name, customer.first_name, SUM(payment.amount)
FROM customer
INNER JOIN payment ON
customer.customer_id = payment.customer_id
GROUP BY customer.last_name;
-- 7a (renamed language column to avoid statement error but can't figure out the syntax error)
RENAME TABLE language1 TO language;
ALTER TABLE `language` CHANGE  `name1` `name` VARCHAR(255) NOT NULL;

SELECT title FROM film 
WHERE (title LIKE 'K%' AND 'Q%')
AND language_id = (SELECT language_id FROM language where name='English')








