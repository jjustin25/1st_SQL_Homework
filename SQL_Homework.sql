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
WHERE language_id in
	(SELECT language_id 
    FROM language 
    where name='English')
AND (title LIKE 'K%') OR (title LIKE 'Q%');
-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.

USE Sakila;

SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
        
-- 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.

USE Sakila;

SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';

-- 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies 
-- categorized as family films.

USE Sakila;

SELECT title, category
FROM film_list
WHERE category = 'Family';
		

-- 7e. Display the most frequently rented movies in descending order.

USE Sakila;

SELECT i.film_id, f.title, COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;

-- 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);

-- 7g. Write a query to display for each store its store ID, city, and country.

USE Sakila;

SELECT s.store_id, city, country
FROM store s
INNER JOIN customer cu
ON s.store_id = cu.store_id
INNER JOIN staff st
ON s.store_id = st.store_id
INNER JOIN address a
ON cu.address_id = a.address_id
INNER JOIN city ci
ON a.city_id = ci.city_id
INNER JOIN country coun
ON ci.country_id = coun.country_id;
WHERE country = 'CANADA' AND country = 'AUSTRAILA';
-- Where 


-- 7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following 
-- tables: category, film_category, inventory, payment, and rental.)

USE Sakila;

SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

-- 8a. In your new role as an executive, you would like to have an easy way of

CREATE VIEW top_five_grossing_genres AS

SELECT name, SUM(p.amount)
FROM category c
INNER JOIN film_category fc
INNER JOIN inventory i
ON i.film_id = fc.film_id
INNER JOIN rental r
ON r.inventory_id = i.inventory_id
INNER JOIN payment p
GROUP BY name
LIMIT 5;

-- 8b. How would you display the view that you created in 8a?

SELECT * FROM top_five_grossing_genres;

-- 8c. You find that you no longer need the view top_five_genres. 
-- Write a query to delete it.

DROP VIEW top_five_grossing_genres;
 







