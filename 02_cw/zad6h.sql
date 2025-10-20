WITH building_c AS(
SELECT name,geometry 
FROM buildings 
WHERE name='BuildingC'
)
--ST_SymDifference-zwraca czesc ktora nie jest wspolna 
SELECT ST_Area(ST_SymDifference(geometry,ST_GeomFromText('POLYGON((4 7,6 7,6 8,4 8,4 7))'))) as area
FROM building_c
