USE sakila;

-- number of films per category
SELECT c.name AS category_name, COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

-- store ID, city, and country for each store
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;

-- total revenue by each store in dollars
SELECT s.store_id, SUM(p.amount) AS total$_revenue
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id;

-- average running time of films for each category
SELECT c.name AS category_name, AVG(f.length) AS average_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name ORDER BY average_running_time
DESC;

-- Bonus

-- Film categories with longest avg running time
SELECT c.name AS category_name, AVG(f.length) AS average_running_time
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running_time DESC
LIMIT 3;

-- 10 most frequently rented movies in descending order
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 10;

-- Dinosaur Academy in store 1? yes
SELECT f.title, i.store_id
FROM film f
JOIN inventory i ON f.film_id = i.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1;

-- list of all distinct film titles, along with their availability status in the inventory
SELECT DISTINCT f.title,
CASE 
WHEN IFNULL(i.film_id, 0) = 0 THEN 'NOT available'
ELSE 'Available'
END AS availability_status
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id;





