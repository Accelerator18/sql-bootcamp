INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT
    (SELECT COALESCE(MAX(id), 0) + 1 FROM person_visits),
    (SELECT id FROM person WHERE name = 'Dmitriy'),
    (
        SELECT p.id
        FROM pizzeria p
        JOIN menu m ON m.pizzeria_id = p.id
        WHERE p.name = 'Best Pizza'
          AND m.price < 800
        LIMIT 1
    ),
    date '2022-01-08';

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
