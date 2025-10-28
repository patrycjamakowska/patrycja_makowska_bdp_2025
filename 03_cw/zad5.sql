--zadanie 5
WITH witout_bows AS (
    SELECT *
    FROM obiekty
    WHERE NOT ST_HasArc(geometry)
)

SELECT *,ST_Area(ST_Buffer(geometry, 5)) AS pole
FROM witout_bows;
