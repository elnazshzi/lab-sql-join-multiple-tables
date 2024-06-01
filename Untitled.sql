-- 1. Write a query to display for each store its store ID, city, and country.

select s.store_id, ci.city, co.country 
from sakila.store s
join sakila.address a using(address_id)
join sakila.city ci using(city_id)
join sakila.country co using(country_id);



-- 2. Write a query to display how much business, in dollars, each store brought in.

select s.store_id, sum(p.amount)
from sakila.store as s
join sakila.customer as cu using(store_id)
join sakila.payment as p using(customer_id)
group by s.store_id;



-- 3. What is the average running time of films by category?
select  c.name, avg(f.length) as avg_running_time
from sakila.category as c
join sakila.film_category fc using(category_id)
join sakila.film f using(film_id)
group by c.name;



-- 4. Which film categories are longest?

select c.name, max(f.length) as max_running_time
from sakila.category c
join sakila.film_category fc using(category_id)
join sakila.film f using(film_id)
group by c.name
order by max_running_time desc;



-- 5. Display the most frequently rented movies in descending order.

select f.title, count(r.rental_id) as rental_count
from sakila.film f
join sakila.inventory i using(film_id)
join sakila.rental r using(inventory_id)
group by f.title
order by rental_count desc;


-- 6. List the top five genres in gross revenue in descending order.

SELECT c.name AS category, SUM(p.amount) AS total_revenue
from sakila.payment p
join sakila.rental r ON p.rental_id = r.rental_id
join sakila.inventory i ON r.inventory_id = i.inventory_id
join sakila.film_category fc ON i.film_id = fc.film_id
join sakila.category c ON fc.category_id = c.category_id
group by c.name
order by total_revenue DESC
limit 5;



-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select count(*) AS availability
from sakila.inventory i
join sakila.film f ON i.film_id = f.film_id
left join sakila.rental r ON i.inventory_id = r.inventory_id AND r.return_date IS NULL
where f.title = 'Academy Dinosaur' 
    and i.store_id = 1 
    and r.rental_id is null;


