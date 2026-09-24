WITH dates AS (
    SELECT gs::date AS generated_date
    FROM generate_series('2022-01-01'::date, '2022-01-10'::date, '1 day') AS gs
)
SELECT
    d.generated_date AS missing_date
FROM dates AS d
LEFT JOIN (
    SELECT DISTINCT visit_date
    FROM person_visits
    WHERE person_id = 1 OR person_id = 2
) AS pv
    ON d.generated_date = pv.visit_date
WHERE pv.visit_date IS NULL
ORDER BY missing_date;