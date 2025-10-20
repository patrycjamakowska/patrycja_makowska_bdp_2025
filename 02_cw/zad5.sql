--ST_GeomFromText-tworzenie obiektu za pomoca podania punktow 
INSERT INTO buildings (geometry,name) VALUES
(ST_GeomFromText('POLYGON((8 4, 10.5 4, 10.5 1.5,8 1.5, 8 4))'),'BuildingA'),
(ST_GeomFromText('POLYGON((4 7, 6 7, 6 5,4 5,4 7))'),'BuildingB'),
(ST_GeomFromText('POLYGON((3 8, 5 8,5 6,3 6,3 8))'),'BuildingC'),
(ST_GeomFromText('POLYGON((9 9, 10 9, 10 8 ,9 8 ,9 9))'),'BuildingD'),
(ST_GeomFromText('POLYGON((1 2,2 2,2 1,1 1,1 2))'),'BuildingF');

INSERT INTO roads (geometry,name) VALUES 
(ST_GeomFromText('LINESTRING(0 4.5,12 4.5)'),'RoadX'),
(ST_GeomFromText('LINESTRING(7.5 0,7.5 10.5)'),'RoadY');

INSERT INTO poi (geometry,name) VALUES
(ST_GeomFromText('POINT(1 3.5)'),'G'),
(ST_GeomFromText('POINT(5.5 1.5)'),'H'),
(ST_GeomFromText('POINT(9.5 6)'),'I'),
(ST_GeomFromText('POINT(6.5 6)'),'J'),
(ST_GeomFromText('POINT(6 9.5)'),'K');
