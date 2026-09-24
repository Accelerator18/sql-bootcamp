WITH new_orders(person_name, seq_num) AS (
    VALUES ('Denis', 1),
           ('Irina', 2)
)
INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT (SELECT COALESCE(MAX(po.id), 0) FROM person_order AS po) + no.seq_num,
       p.id,
       m.id,
       DATE '2022-02-24'
FROM new_orders AS no
JOIN person AS p
  ON p.name = no.person_name
JOIN menu AS m
  ON m.pizza_name = 'sicilian pizza'
JOIN pizzeria AS pz
  ON pz.id = m.pizzeria_id
 AND pz.name = 'Dominos';
