SELECT generated_date AS missing_date
FROM v_generated_dates
EXCEPT
SELECT visit_date AS missing_date
FROM person_visits
WHERE visit_date BETWEEN date '2022-01-01' AND date '2022-01-31'
ORDER BY missing_date;
