CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT DISTINCT pz.name AS pizzeria_name
FROM person p
JOIN person_visits pv ON pv.person_id = p.id
JOIN pizzeria pz ON pz.id = pv.pizzeria_id
JOIN menu m ON m.pizzeria_id = pz.id
WHERE p.name = 'Dmitriy'
  AND pv.visit_date = date '2022-01-08'
  AND m.price < 800
ORDER BY pizzeria_name
WITH DATA;
