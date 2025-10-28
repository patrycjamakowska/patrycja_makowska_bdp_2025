--zadanie 4
--tworzenie tabeli 
DROP TABLE IF EXISTS input_points;

CREATE TABLE input_points (
id SERIAL,
geom geometry(Point)
);

INSERT INTO input_points (geom)
VALUES
    (ST_SetSRID(ST_MakePoint(8.36093, 49.03174), 4326)),
    (ST_SetSRID(ST_MakePoint(8.39876, 49.00644), 4326));

