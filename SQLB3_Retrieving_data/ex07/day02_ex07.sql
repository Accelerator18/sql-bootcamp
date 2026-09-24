SELECT DISTINCT
    pz.name
FROM person AS pe
JOIN person_visits AS pv
    ON pe.id = pv.person_id
JOIN pizzeria AS pz
    ON pv.pizzeria_id = pz.id
JOIN menu AS m
    ON pz.id = m.pizzeria_id
WHERE pe.name = 'Dmitriy'
  AND pv.visit_date = '2022-01-08'
  AND m.price < 800;