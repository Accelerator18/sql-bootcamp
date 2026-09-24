SELECT DISTINCT
    pe.name
FROM person AS pe
JOIN person_order AS po
    ON pe.id = po.person_id
JOIN menu AS m
    ON po.menu_id = m.id
WHERE pe.gender = 'male'
  AND (pe.address = 'Moscow' OR pe.address = 'Samara')
  AND (
        m.pizza_name = 'pepperoni pizza'
        OR m.pizza_name = 'mushroom pizza'
      )
ORDER BY pe.name DESC;