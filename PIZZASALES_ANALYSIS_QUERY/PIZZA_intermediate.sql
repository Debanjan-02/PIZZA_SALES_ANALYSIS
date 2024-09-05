/*Join the necessary tables to find the total quantity of each pizza category ordered.*/
SELECT pizza_types.category,SUM(order_details.quantity) AS quantity
FROM pizza_types JOIN pizzas
ON pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.category 
ORDER BY quantity DESC;

/*Determine the distribution of orders by hour of the day.*/
SELECT time_format(time,"%H") as Hour, COUNT(order_id) as orders
FROM orders
GROUP BY hour; 

/*Join relevant tables to find the category-wise distribution of pizzas.*/
SELECT category, COUNT(name) AS count
FROM pizza_types
GROUP BY category;

/*Group the orders by date and calculate the average number of pizzas ordered per day.*/
SELECT AVG(quantity) FROM
(SELECT orders.date, SUM(order_details.quantity) as quantity
FROM orders JOIN order_details
ON order_details_id=order_details.order_id
GROUP BY ORDERS.DATE) AS orders_per_day;

/*Determine the top 3 most ordered pizza types based on revenue.*/
SELECT pizza_types.name,SUM(pizzas.price * order_details.quantity) AS REVENUE
FROM pizza_types JOIN PIZZAS
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id=PIZZAS.PIZZA_ID
GROUP BY pizza_types.NAME
ORDER BY REVENUE DESC
LIMIT 3;