SELECT name,ST_Area(geometry) as area
FROM buildings
ORDER BY name;
