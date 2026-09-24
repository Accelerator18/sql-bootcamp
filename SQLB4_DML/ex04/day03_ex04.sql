WITH female_orders AS (
    SELECT pz.name AS pizzeria_name
    FROM person_order AS po
    JOIN person AS p
      ON p.id = po.person_id
    JOIN menu AS m
      ON m.id = po.menu_id
    JOIN pizzeria AS pz
      ON pz.id = m.pizzeria_id
    WHERE p.gender = 'female'
),
male_orders AS (
    SELECT pz.name AS pizzeria_name
    FROM person_order AS po
    JOIN person AS p
      ON p.id = po.person_id
    JOIN menu AS m
      ON m.id = po.menu_id
    JOIN pizzeria AS pz
      ON pz.id = m.pizzeria_id
    WHERE p.gender = 'male'
)
(
    SELECT pizzeria_name
    FROM female_orders
    EXCEPT
    SELECT pizzeria_name
    FROM male_orders
)
UNION
(
    SELECT pizzeria_name
    FROM male_orders
    EXCEPT
    SELECT pizzeria_name
    FROM female_orders
)
ORDER BY pizzeria_name;
