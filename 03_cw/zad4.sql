--zadanie 4
--dodanie obiektu 7
--ST_Union do złączenia dwóch obiektów 
INSERT INTO obiekty (name, geometry)
SELECT 'obiekt7' AS name,ST_Union(
 (SELECT geometry FROM obiekty WHERE name= 'obiekt3'),
 (SELECT geometry FROM obiekty WHERE name = 'obiekt4') ) AS geometry;
