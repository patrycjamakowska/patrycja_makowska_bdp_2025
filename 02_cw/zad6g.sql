WITH road AS (
SELECT geometry
FROM roads
WHERE name='RoadX'
),
--ST_Centroid -zwraca punkt bedacy środkiem budynku 
centroids AS(
SELECT name, ST_Centroid(geometry) as centroid
FROM buildings
)
--wspolrzedna y mówi nam o wysokosci
--ST_Y -wartoscy punktu
SELECT c.name
FROM centroids c,road r
WHERE ST_Y(c.centroid)>ST_YMAX(r.geometry);
