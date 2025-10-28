--zadanie 1
DROP TABLE IF EXISTS new_b;
CREATE TABLE new_b AS
SELECT b19.*
FROM t2019_kar_buildings b19
LEFT JOIN t2018_kar_buildings b18 
ON ST_Equals(b19.geom,b18.geom) -- łączymy po pokrywających się lokalizacjach
WHERE b18.gid is NULL;

