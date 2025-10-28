DROP TABLE IF EXISTS points;
CREATE TABLE points AS 
SELECT p19.* 
FROM t2019_kar_poi_table p19 
LEFT JOIN t2018_kar_poi_table p18 
ON ST_Equals(p19.geom, p18.geom) 
WHERE p18.geom IS NULL;

--zmiana układu na metry z stopni 
ALTER TABLE points
ALTER COLUMN geom TYPE geometry(Point, 25832)
USING ST_Transform(ST_SetSRID(geom, 4326), 25832);

ALTER TABLE new_b
ALTER COLUMN geom TYPE geometry(MultiPolygon, 25832)
USING ST_Transform(ST_SetSRID(geom, 4326), 25832);


SELECT pp.type,COUNT(*) as count_type
FROM points pp
JOIN new_b b
ON ST_DWithin(pp.geom,b.geom,500)
GROUP BY pp.type;
