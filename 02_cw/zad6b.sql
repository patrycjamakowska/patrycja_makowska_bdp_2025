--do wypisania geometri wkt - ST_AsText(obiekt typu geometry),
--do policzenia pola - ST_Area(obiekt typu geometry)
--do obwodu - ST_Perimeter(obiekt typu geometry)
SELECT name,ST_AsText(geometry) AS wkt,ST_Area(geometry) AS area,ST_Perimeter(geometry) AS perimeter
FROM buildings
WHERE name = 'BuildingA';
