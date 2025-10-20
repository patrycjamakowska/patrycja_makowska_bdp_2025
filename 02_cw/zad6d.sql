SELECT name,ST_Area(geometry) as area,ST_Perimeter(geometry) as perimeter
FROM buildings
ORDER BY area DESC
LIMIT 2;
