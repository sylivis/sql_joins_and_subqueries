-- 1. list all customers who live in texas.
SELECT customer.first_name, customer.last_name
FROM customer
FULL JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

--Get all payments above $6.99 with the customer's fill name.
SELECT payment.payment_id, payment.amount, customer.first_name, customer.last_name
FROM payment 
FULL JOIN customer
ON payment.customer_id = customer.customer_id 
WHERE payment.amount > 6.99;

--show all customer  names wo made payments over $176
SELECT first_name, last_name 
FROM customer 
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment 
	WHERE amount > 176
);

--list all customers that live in nepal
SELECT customer.first_name, customer.last_name, country.country 
FROM customer 
FULL JOIN address 
ON customer.address_id = address.address_id 
FULL JOIN city 
ON address.city_id = city.city_id 
FULL JOIN country 
ON city.country_id = country.country_id 
WHERE country.country = 'Nepal';

--which staff member had the most transactions?
SELECT staff.first_name, staff.last_name, x.count
FROM staff 
FULL JOIN (
	SELECT staff_id, count(staff_id)
	FROM payment
	GROUP BY staff_id 
	ORDER BY count DESC 
) AS x 
ON staff.staff_id = x.staff_id
ORDER BY x.count DESC 
LIMIT 1;

--how many movies of each rating are there?
SELECT rating, count(rating) 
FROM film 
GROUP BY rating;

--show all customers who made a single payment above 6.99
SELECT customer.first_name, customer.last_name
FROM (
	SELECT x.customer_id,  count(x.amount)
	FROM (
		SELECT payment.payment_id, payment.amount, customer.customer_id, customer.first_name, customer.last_name
		FROM payment 
		FULL JOIN customer
		ON payment.customer_id = customer.customer_id 
		WHERE amount > 6.99
		) AS x
	GROUP BY x.customer_id 
	) AS y
FULL JOIN customer 
ON y.customer_id = customer.customer_id 
WHERE count = 1;

--how many free rentals did our stores give away
SELECT count(amount)
FROM payment p 
WHERE amount < 0
OR amount = 0;






