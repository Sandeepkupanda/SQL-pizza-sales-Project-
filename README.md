# SQL-pizza-sales-Project-
pizza-sales---SQL Full Portfolio Project 

Questions to Solve in this Project
•	Basic:
•	Retrieve the total number of orders placed.
•	Calculate the total revenue generated from pizza sales.
•	Identify the highest-priced pizza.
•	Identify the most common pizza size ordered.
•	List the top 5 most ordered pizza types along with their quantities.
•	Intermediate:
•	Join the necessary tables to find the total quantity of each pizza category ordered.
•	Determine the distribution of orders by hour of the day.
•	Join relevant tables to find the category-wise distribution of pizzas.
•	Group the orders by date and calculate the average number of pizzas ordered per day.
•	Determine the top 3 most ordered pizza types based on revenue.
•	Advanced:
•	Calculate the percentage contribution of each pizza type to total revenue.
•	Analyse the cumulative revenue generated over time.
•	Determine the top 3 most ordered pizza types based on revenue for each pizza category.
Solved Query
	List the top 5 most ordered pizza types along with their quantities.
1.	SELECT
2.	pizza_types.name, SUM(order_details.quantity) AS quantity
3.	FROM
4.	pizza_types
5.	JOIN
6.	pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
7.	JOIN
8.	order_details ON order_details.pizza_id = pizzas.pizza_id
9.	GROUP BY pizza_types.name
10.	ORDER BY quantity DESC
11.	LIMIT 5;

	Join the necessary tables to find the total quantity of each pizza category ordered.
1.	SELECT 
2.	pizza_types.category,
3.	SUM(order_details.quantity) AS quantity
4.	FROM
5.	pizza_types
6.	JOIN
7.	pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
8.	JOIN
9.	order_details ON order_details.pizza_id = pizzas.pizza_id
10.	GROUP BY pizza_types.category
11.	ORDER BY quantity DESC;
	-- Determine the distribution of orders by hour of the day.

1.	SELECT 
2.	    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
3.	FROM
4.	    orders
5.	GROUP BY HOUR(order_time);
	Join relevant tables to find the category-wise distribution of pizzas.
1.	SELECT 
2.	category, COUNT(name)
3.	FROM
4.	pizza_types
5.	GROUP BY category;

	Group the orders by date and calculate the average number of pizzas ordered per day.
1.	SELECT 
2.	ROUND(AVG(quantity), 0) as avg_pizza_ordered_per_day
3.	FROM
4.	(SELECT 
5.	orders.order_date, SUM(order_details.quantity) AS quantity
6.	FROM
7.	orders
8.	JOIN order_details ON orders.order_id = order_details.order_id
9.	GROUP BY orders.order_date) AS order_quantity;

	Determine the top 3 most ordered pizza types based on revenue.

1.	SELECT 
2.	pizza_types.name,
3.	SUM(order_details.quantity * pizzas.price) AS revenue
4.	FROM
5.	pizza_types
6.	JOIN
7.	pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
8.	JOIN
9.	order_details ON order_details.pizza_id = pizzas.pizza_id
10.	GROUP BY pizza_types.name
11.	ORDER BY revenue DESC
12.	LIMIT 3;








	Calculate the percentage contribution of each pizza type to total revenue.

1.	SELECT 
2.	pizza_types.category,
3.	round(SUM(order_details.quantity * pizzas.price) / (SELECT 
4.	ROUND(SUM(order_details.quantity * pizzas.price),
5.	2) AS total_sales
6.	FROM
7.	order_details
8.	join
9.	pizzas on pizzas.pizza_id = order_details.pizza_id) *100,2) AS revenue
10.	from pizza_types JOIN pizzas 
11.	ON pizza_types.pizza_type_id = pizzas.pizza_type_id
12.	JOIN
13.	order_details ON order_details.pizza_id = pizzas.pizza_id 
14.	GROUP BY pizza_types.category
15.	ORDER BY revenue DESC;

	Analyze the cumulative revenue generated over time.

1.	select order_date,
2.	sum(revenue) over (order by order_date) as cum_revenue
3.	from
4.	(select orders.order_date,
5.	sum(order_details.quantity * pizzas.price) as revenue
6.	from order_details join pizzas
7.	on order_details.pizza_id = pizzas.pizza_id
8.	join orders
9.	on orders.order_id = order_details.order_id
10.	group by orders.order_date) as Sales;

	Determine the top 3 most ordered pizza types based on revenue for each pizza category.

1.	select name,revenue from 
2.	(select category,name,revenue,
3.	rank() over(partition by category order by revenue desc) as rn
4.	from
5.	(select pizza_types.category,pizza_types.name,
6.	Sum( (order_details.quantity) * pizzas.price) as revenue
7.	from pizza_types join pizzas
8.	on pizza_types.pizza_type_id = pizzas.pizza_type_id
9.	join order_details
10.	on order_details.pizza_id = pizzas.pizza_id
11.	group by pizza_types.category,pizza_types.name) as a) as b
12.	where rn <= 3;
