--zadanie 6
SELECT COUNT(DISTINCT points.poi_id) AS store_count
FROM t2019_kar_poi_table points
JOIN t2019_kar_land_use_a land
  ON ST_DWithin(
       points.geom,
       land.geom,
       300
     )
WHERE points.type = 'Sporting Goods Store'
  AND land.type = 'Park (City/County)';
