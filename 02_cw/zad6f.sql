--stworzenie bufora- ST_Buffer
WITH building_b AS(
SELECT name,ST_Buffer(geometry,0.5) as bufor
FROM buildings 
WHERE name='BuildingB'
),
building_c AS(
SELECT name,geometry
FROM buildings 
WHERE name='BuildingC'
)

--do obliczenia różnicy ST_Difference
SELECT ST_Area(ST_Difference(c.geometry,b.bufor)) AS area
FROM building_c as c, building_b as b;
