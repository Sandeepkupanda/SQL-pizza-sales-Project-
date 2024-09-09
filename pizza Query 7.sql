-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    round(SUM(order_details.quantity * pizzas.price) / (SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
order_details
join
pizzas on pizzas.pizza_id = order_details.pizza_id) *100,2) AS revenue
from pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id 
GROUP BY pizza_types.category
ORDER BY revenue DESC;