--do wyznaczenia długości - ST_Length(obiekt typu geometry)
SELECT SUM(ST_LENGTH(geometry)) as length
FROM roads;
