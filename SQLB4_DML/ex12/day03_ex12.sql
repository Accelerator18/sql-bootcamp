WITH person_sequence AS (
    SELECT p1.id AS person_id,
           (
               SELECT COUNT(*)
               FROM person AS p2
               WHERE p2.id <= p1.id
           ) AS seq_num
    FROM person AS p1
)
INSERT INTO person_order (id, person_id, menu_id, order_date)
SELECT (SELECT COALESCE(MAX(po.id), 0) FROM person_order AS po) + gs.generated_number,
       ps.person_id,
       (
           SELECT m.id
           FROM menu AS m
           JOIN pizzeria AS pz
             ON pz.id = m.pizzeria_id
           WHERE m.pizza_name = 'greek pizza'
             AND pz.name = 'Dominos'
       ),
       DATE '2022-02-25'
FROM generate_series(1, (SELECT COUNT(*) FROM person)) AS gs(generated_number)
JOIN person_sequence AS ps
  ON ps.seq_num = gs.generated_number;
