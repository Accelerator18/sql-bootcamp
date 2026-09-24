
WITH RECURSIVE routes AS (
    SELECT
        n.point1 AS start_point,
        n.point2 AS current_point,
        n.cost AS total_cost,
        CAST('{' || n.point1 || ',' || n.point2 || '}' AS VARCHAR) AS tour,
        CAST(',' || n.point1 || ',' || n.point2 || ',' AS VARCHAR) AS visited,
        2 AS depth
    FROM nodes n
    WHERE n.point1 = 'a'

    UNION ALL

    SELECT
        r.start_point,
        n.point2 AS current_point,
        r.total_cost + n.cost AS total_cost,
        CAST(
            substring(r.tour FROM 1 FOR char_length(r.tour) - 1) || ',' || n.point2 || '}'
            AS VARCHAR
        ) AS tour,
        CAST(r.visited || n.point2 || ',' AS VARCHAR) AS visited,
        r.depth + 1 AS depth
    FROM routes r
    JOIN nodes n
      ON n.point1 = r.current_point
    WHERE r.depth < 4
      AND POSITION(',' || n.point2 || ',' IN r.visited) = 0
),
all_tours AS (
    SELECT
        r.total_cost + n.cost AS total_cost,
        CAST(
            substring(r.tour FROM 1 FOR char_length(r.tour) - 1) || ',' || r.start_point || '}'
            AS VARCHAR
        ) AS tour
    FROM routes r
    JOIN nodes n
      ON n.point1 = r.current_point
     AND n.point2 = r.start_point
    WHERE r.depth = 4
)
SELECT total_cost, tour
FROM all_tours
WHERE total_cost IN (
    (SELECT MIN(total_cost) FROM all_tours),
    (SELECT MAX(total_cost) FROM all_tours)
)
ORDER BY total_cost, tour;