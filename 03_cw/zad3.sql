--zadanie 3

--sprawdzenie typu-jest LineString
SELECT ST_GeometryType(geometry) FROM obiekty WHERE name = 'obiekt4';

--poligon musi być zamknięty dlatego dodanie punktu początkowego
UPDATE obiekty 
SET geometry=ST_MakePolygon(ST_AddPoint(geometry,ST_StartPoint(geometry)))
WHERE name='obiekt4';

SELECT ST_GeometryType(geometry) FROM obiekty WHERE name = 'obiekt4';
