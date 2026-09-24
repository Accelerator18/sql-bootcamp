WITH female_visits AS (
    SELECT pz.name AS pizzeria_name
    FROM person_visits AS pv
    JOIN person AS p
      ON p.id = pv.person_id
    JOIN pizzeria AS pz
      ON pz.id = pv.pizzeria_id
    WHERE p.gender = 'female'
),
male_visits AS (
    SELECT pz.name AS pizzeria_name
    FROM person_visits AS pv
    JOIN person AS p
      ON p.id = pv.person_id
    JOIN pizzeria AS pz
      ON pz.id = pv.pizzeria_id
    WHERE p.gender = 'male'
)
(
    SELECT pizzeria_name
    FROM female_visits
    EXCEPT ALL
    SELECT pizzeria_name
    FROM male_visits
)
UNION ALL
(
    SELECT pizzeria_name
    FROM male_visits
    EXCEPT ALL
    SELECT pizzeria_name
    FROM female_visits
)
ORDER BY pizzeria_name;
