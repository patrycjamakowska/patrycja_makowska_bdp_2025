--zadanie 5
--stworzenie lini z dwóch punktów 
DROP TABLE IF EXISTS line_;
CREATE TABLE line_ AS
SELECT ST_MakeLine(geom) AS geom
FROM input_points;

--reprojekcja geometrii w odpowiedni układ
--ALTER TABLE t2019_kar_street_node
--ALTER COLUMN geom TYPE geometry(Point, 3068)
--USING ST_Transform(ST_SetSRID(geom, 4326), 3068);
SELECT DISTINCT ST_SRID(geom)
FROM t2019_kar_street_node;

SELECT node.*
FROM t2019_kar_street_node node
JOIN line_ l
ON ST_DWithin(node.geom, l.geom, 200);
