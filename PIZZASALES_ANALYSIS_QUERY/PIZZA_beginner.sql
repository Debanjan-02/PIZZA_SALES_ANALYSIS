/* Retrieve the total number of orders placed.*/
USE  pizza;
SELECT COUNT(order_id) as TOTAL_ORDERS
FROM orders;

/*Calculate the total revenue generated from pizza sales.*/
SELECT
ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id = pizzas.pizza_id;


/*Identify the highest-priced pizza.*/
SELECT pizza_types.name,pizzas.price
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC 
LIMIT 1;

/*Identify the most common pizza size ordered.*/
SELECT pizzas.size, COUNT(order_details.quantity) as order_count
FROM order_details JOIN pizzas
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizzas.size ORDER BY order_count DESC
LIMIT 1;

/*List the top 5 most ordered pizza types along with their quantities.*/
SELECT pizza_types.name,COUNT(order_details.quantity) as order_count
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY order_count DESC
limit 5;