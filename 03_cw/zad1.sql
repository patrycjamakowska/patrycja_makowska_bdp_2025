--zadanie 1

--utworzenie tabeli przechowującej obiekty 
DROP TABLE IF EXISTS obiekty;
CREATE TABLE obiekty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    geometry GEOMETRY
);

--obiekt 1
--ST_LineToCurve(geometry)-zamiana prostej na prosta z łukami
INSERT INTO obiekty (name,geometry)
VALUES ('obiekt1',ST_LineToCurve(ST_GeomFromText('LINESTRING(0 1, 1 1, 2 0, 3 1, 4 2, 5 1,6 1)')));

--obiekt 2
INSERT INTO obiekty (name, geometry)
VALUES ('obiekt2',
ST_LineToCurve(ST_GeomFromText('POLYGON((10 6, 14 6, 16 4, 14 2, 12 0, 10 2, 10 6),(13 2, 11 2, 11 3, 13 3, 13 2))')));

--obiket 3
INSERT INTO obiekty (name, geometry)
VALUES ('obiekt3', ST_GeomFromText('POLYGON((7 15, 10 17, 12 13,7 15))'));

--obiekt 4
--ST_LineFromMultiPoint-tworzy linie z zewstawu punktow 
--MULTIPOINT-zbior wielu punkto w jednej geometri 
INSERT INTO obiekty (name,geometry)
VALUES ('obiekt4',
ST_LineFromMultiPoint(ST_GeomFromText('MULTIPOINT((20 20),(25 25),(27 24),(25 22),(26 21),(22 19),(20.5 19.5))')));

--obiekt 5
--MULTIPOINTZ-do 3 wymiarow
INSERT INTO obiekty (name,geometry)
VALUES ('obiekt5',ST_GeomFromText('MULTIPOINTZ((30 30 59), (38 32 234))'));

--obiekt 6 
INSERT INTO obiekty (name, geometry)
VALUES ('obiekt6',ST_GeomFromText('GEOMETRYCOLLECTION(POINT(4 2),LINESTRING(1 1, 3 2))'));

SELECT * FROM obiekty;
