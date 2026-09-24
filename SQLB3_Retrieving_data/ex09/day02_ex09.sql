SELECT
    pe.name
FROM person AS pe
JOIN person_order AS po
    ON pe.id = po.person_id
JOIN menu AS m
    ON po.menu_id = m.id
WHERE pe.gender = 'female'
GROUP BY pe.id, pe.name
HAVING SUM(CASE WHEN m.pizza_name = 'cheese pizza' THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN m.pizza_name = 'pepperoni pizza' THEN 1 ELSE 0 END) > 0
ORDER BY pe.name;