WITH new_visits(person_name, seq_num) AS (
    VALUES ('Denis', 1),
           ('Irina', 2)
)
INSERT INTO person_visits (id, person_id, pizzeria_id, visit_date)
SELECT (SELECT COALESCE(MAX(pv.id), 0) FROM person_visits AS pv) + nv.seq_num,
       p.id,
       pz.id,
       DATE '2022-02-24'
FROM new_visits AS nv
JOIN person AS p
  ON p.name = nv.person_name
JOIN pizzeria AS pz
  ON pz.name = 'Dominos';
