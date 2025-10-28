ALTER TABLE t2019_kar_streets 
ALTER COLUMN geom TYPE geometry(MultiLineString, 4326)
USING ST_SetSRID(geom, 4326);

DROP TABLE IF EXISTS streets_reprojected;
CREATE TABLE streets_reprojected AS
SELECT *,
    ST_Transform(geom, 3068) AS geom_2
FROM t2019_kar_streets ;
