SET enable_seqscan =OFF;
EXPLAIN ANALYSE
SELECT m.pizza_name as pizza_name, pz.name as pizzeria_name
FROM menu m
JOIN pizzeria pz on m.pizzeria_id = pz.id;
