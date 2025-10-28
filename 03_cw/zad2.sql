WITH street AS (
SELECT ST_ShortestLine(c.geometry,d.geometry) as geom
FROM obiekty c, obiekty d
WHERE c.name='obiekt3' AND d.name='obiekt4'
)

--pole powierzchni bufora o promieniu 5
SELECT ST_Area(ST_Buffer(geom, 5)) AS pole_bufora
FROM street;
