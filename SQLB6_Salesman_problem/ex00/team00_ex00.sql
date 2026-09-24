DROP TABLE IF EXISTS nodes;

CREATE TABLE nodes (
    point1 CHAR(1) NOT NULL,
    point2 CHAR(1) NOT NULL,
    cost   INTEGER NOT NULL,
    PRIMARY KEY (point1, point2)
);

INSERT INTO nodes (point1, point2, cost) VALUES
    ('a', 'b', 10), ('b', 'a', 10),
    ('a', 'c', 15), ('c', 'a', 15),
    ('a', 'd', 20), ('d', 'a', 20),
    ('b', 'c', 35), ('c', 'b', 35),
    ('b', 'd', 25), ('d', 'b', 25),
    ('c', 'd', 30), ('d', 'c', 30);

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
complete_tours AS (
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
FROM complete_tours
WHERE total_cost = (SELECT MIN(total_cost) FROM complete_tours)
ORDER BY total_cost, tour;