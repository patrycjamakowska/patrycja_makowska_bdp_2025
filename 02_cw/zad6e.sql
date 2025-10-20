--do obliczenia odleglosci st_distance 
SELECT ST_Distance(b.geometry, p.geometry) AS distance
FROM buildings b, poi p
WHERE b.name='BuldingC' AND p.name='K';
