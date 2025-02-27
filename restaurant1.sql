use restaurant_db;


-- Objective 1

-- 1.View the menu items table
select * from menu_items;
-- 2.Find the number of items on the menu.
select count(*) from menu_items;
-- 3.What are the least and most expensive items on the menu?
select * from menu_items
order by price;

select * from menu_items
order by price desc;
-- 4.How many Italian dishes are on the menu?
select count(*) from menu_items
where category = "Italian";
-- 5.What are the least and most expensive Italian dishes on the menu?
select * from menu_items
where category="Italian"
order by price;

select * from menu_items
where category="Italian"
order by price desc;

-- 6.How many dishes are in each category?
select category,count(menu_item_id) as num_dishes 
from menu_items
group by category;

-- 7.what is the average dish price within each category?
select category,avg(price)as Average_price
from menu_items
group by category;

-- Objective 2

-- 1.View the order_details table.
select * from order_details;
-- 2. what is the data range of the table?
select min(order_date),max(order_date) 
from order_details;
-- 3.How many orders were made within this date range?
select count(distinct order_id)from order_details;
-- 4.How many items were ordered within this data range?
select count(*) from order_details;
-- 5.Which order had the most number of items?
select order_id,count(item_id) as num_items from order_details
group by order_id
order by num_items desc;
-- 6.How many orders had more than 12 dishes?
select count(order_id) as Count
from
(select order_id,count(item_id) as num_items from order_details
group by order_id
having num_items > 12) as Count;

-- Objective 3

-- 1.Combine the menu_items and order_details tables into a single table.
select * from order_details od
left join menu_items mi
on od.item_id=mi.menu_item_id;

-- 2.What were the least and most ordered items?what categories were they in?
select item_name,category,count(order_details_id)as num_purchases
from order_details od
left join menu_items mi
on od.item_id=mi.menu_item_id
group by item_name,category
order by num_purchases desc;

-- 3.What were the top 5 orders that spend the most money?
with cte as(
select od.order_id,sum(mi.price)as total_spent, dense_rank() over (order by sum(mi.price) desc) as dn
from order_details od
left join menu_items mi
on od.item_id=mi.menu_item_id
group by order_id
)
select  order_id, total_spent from cte
where dn<=5;

-- 4.View the details of highest spend order.What insights can you gather from the 

select category,count(item_id)as num_items
from order_details od
left join menu_items mi
on od.item_id=mi.menu_item_id
where order_id = 440
group by category;

-- 5..View the details of top 5 highest spend order.What insights can you gather from the 

select order_id,category,count(item_id)as num_items
from order_details od
left join menu_items mi
on od.item_id=mi.menu_item_id
where order_id in(440,2075,1957,330,2675)
group by order_id,category;

