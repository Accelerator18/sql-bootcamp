SELECT m.pizza_name,
       m.price,
       pz.name AS pizzeria_name
FROM menu AS m
JOIN pizzeria AS pz
  ON pz.id = m.pizzeria_id
WHERE m.id IN (
    SELECT menu_id
    FROM (
        SELECT m1.id AS menu_id
        FROM menu AS m1
        WHERE m1.id NOT IN (
            SELECT po.menu_id
            FROM person_order AS po
        )
    ) AS forgotten_menu
)
ORDER BY m.pizza_name, m.price;
