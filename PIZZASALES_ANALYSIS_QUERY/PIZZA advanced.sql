/*Calculate the percentage contribution of each pizza type to total revenue.*/
SELECT pizza_types.category,
ROUND((SUM(pizzas.price * order_details.quantity) / (SELECT 
ROUND (SUM(order_details.quantity * pizzas.price),2) AS total_revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id=pizzas.pizza_id)) *100,2) AS percentage
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id=pizzas.pizza_type_id
GROUP BY pizza_types.category 
ORDER BY PERCENTAGE DESC;


/*Analyze the cumulative revenue generated over time.*/
SELECT date,
SUM(revenue) OVER(ORDER  BY date) AS cum_revenue
from
(SELECT orders.date, SUM(pizzas.price*order_details.quantity) AS REVENUE
FROM orders JOIN order_details
ON orders.order_id=order_details.order_id
JOIN pizzas
ON pizzas.pizza_id=order_details.pizza_id
GROUP BY orders.date) AS SALES;


/*Determine the top 3 most ordered pizza types based on revenue for each pizza category.*/
SELECT CATEGORY, NAME, REVENUE FROM
(SELECT category,name,revenue, 
Rank() OVER (partition by CATEGORY ORDER BY revenue DESC) AS r
FROM
(SELECT pizza_types.category,pizza_types.name,SUM(pizzas.price* order_details.quantity) AS revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.category,pizza_types.name) AS p) AS z
WHERE r<=3;