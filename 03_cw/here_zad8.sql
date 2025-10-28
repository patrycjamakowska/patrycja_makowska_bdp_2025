--zadanie 8
--ST_PointOnSurface-zawsze zwrca jeden punkt nawet jeśli przecicie jest linestring
DROP TABLE IF EXISTS T2019_KAR_BRIDGES;
CREATE TABLE T2019_KAR_BRIDGES AS
SELECT ST_PointOnSurface(ST_Intersection(r.geom, w.geom)) AS geom --czesc wspolna 
FROM t2019_kar_railways r
JOIN t2019_kar_water_lines w
ON ST_Intersects(r.geom, w.geom); --sprawdza czy sie przecinają 
