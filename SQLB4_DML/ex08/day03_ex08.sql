INSERT INTO menu (id, pizzeria_id, pizza_name, price)
SELECT COALESCE(MAX(m.id), 0) + 1,
       (
           SELECT pz.id
           FROM pizzeria AS pz
           WHERE pz.name = 'Dominos'
       ),
       'sicilian pizza',
       900
FROM menu AS m;
