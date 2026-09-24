SELECT DISTINCT
    m.pizza_name,
    pz.name AS pizzeria_name
FROM person_order AS po
JOIN person AS pe
    ON po.person_id = pe.id
JOIN menu AS m
    ON po.menu_id = m.id
JOIN pizzeria AS pz
    ON m.pizzeria_id = pz.id
WHERE pe.name = 'Denis'
   OR pe.name = 'Anna'
ORDER BY m.pizza_name, pizzeria_name;