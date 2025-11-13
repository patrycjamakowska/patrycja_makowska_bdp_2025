--ZAŁADOWANIE DANYCH

--sprawdzenie tabel w schemacie rasters
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'rasters';

--sprawdzenie typów
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_schema='rasters' AND table_name='landsat8';

--sprawdzenie widoku
SELECT * FROM public.raster_columns;

--TWORZENIE RASTRÓW Z INSTNIEJĄCYCH RASTRÓW I INTERAKACJA Z WEKTORAMI 

--sprawdzamy które kafelki rastra zgrywają się z geometrią wekt.
--bierzemy tylko gmine porto
CREATE TABLE makowska.intersects AS  
SELECT a.rast, b.municipality
FROM rasters.dem AS a, vectors.porto_parishes AS b  
WHERE ST_Intersects(a.rast, b.geom) 
  AND b.municipality ilike 'porto';

--dobre praktyki 
-- rid jako primary key
ALTER TABLE makowska.intersects
ADD COLUMN rid SERIAL PRIMARY KEY;

--stworzenie indeksu przestrzennego 
CREATE INDEX idx_intersects_rast_gist 
ON makowska.intersects USING gist (ST_ConvexHull(rast));

--dodanie ograniczeń
SELECT AddRasterConstraints('makowska'::name, 'intersects'::name,'rast'::name);

--ST_CLIP
--wycinanie rastra według geometri
-- raster dopasowany do granic gminy
CREATE TABLE makowska.clip AS  
SELECT ST_Clip(a.rast, b.geom, true), b.municipality  
FROM rasters.dem AS a, vectors.porto_parishes AS b  
WHERE ST_Intersects(a.rast, b.geom) 
  AND b.municipality like 'PORTO';
  
  
--ST_Unions 
--łączenie wielu kafelkow rastrwa w jeden raster
CREATE TABLE makowska.union AS
SELECT ST_Union(ST_Clip(a.rast, b.geom, true))
FROM rasters.dem AS a, vectors.porto_parishes AS b
WHERE b.municipality ilike 'porto'
  AND ST_Intersects(b.geom, a.rast);

--TWORZENIE RASTRÓW Z WEKTORÓW

--ST_AsRaster
--wybieramy jeden raster aby przeskalowac do tej samej geometrii
CREATE TABLE makowska.porto_parishes AS 
WITH r AS ( 
    SELECT rast FROM rasters.dem  
    LIMIT 1 
) 
--dla każdej geomteri powstaje osobny raster
SELECT ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767) AS rast 
FROM vectors.porto_parishes AS a, r 
WHERE a.municipality ilike 'porto';

--ST_Union
DROP TABLE makowska.porto_parishes;

CREATE TABLE makowska.porto_parishes AS 
WITH r AS (SELECT rast FROM rasters.dem LIMIT 1) 
--przekształcenie geometri wektorowej na rastry
--połaczenie pojedynczych rastrow(jedna gimna) w jeden (wszytskie gminy)
SELECT ST_Union(ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767)) AS rast 
FROM vectors.porto_parishes AS a, r 
WHERE a.municipality ilike 'porto';

--St_Tile
DROP TABLE makowska.porto_parishes;

CREATE TABLE makowska.porto_parishes AS 
WITH r AS (SELECT rast FROM rasters.dem LIMIT 1) 
--podział dużego rastra na mniejsze(kafelki)
SELECT ST_Tile(
    ST_Union(ST_AsRaster(a.geom, r.rast, '8BUI', a.id, -32767)),
    128, 128, true, -32767
) AS rast 
FROM vectors.porto_parishes AS a, r 
WHERE a.municipality ilike 'porto';

--KONWERTOWANIE RASTRÓW NA WEKTORY

--st_clip-zwraca przyciety raster
--st_intersection-zwraca wektor,dla kazdego kafelka wewnatrz poligonu przypisuje geo i val
CREATE TABLE makowska.intersection AS  
SELECT 
  a.rid,
  (ST_Intersection(b.geom, a.rast)).geom,
  (ST_Intersection(b.geom, a.rast)).val 
FROM rasters.landsat8 AS a, vectors.porto_parishes AS b  
WHERE b.parish ilike 'paranhos' 
  AND ST_Intersects(b.geom, a.rast); --zwraca true jesli przynajniej jeden piksel w poligonie

--ST_DumpAsPolygons -zamienia przyciete rastry na poligony
CREATE TABLE makowska.dumppolygons AS 
SELECT 
  a.rid,
  (ST_DumpAsPolygons(ST_Clip(a.rast, b.geom))).geom, --st_clip--przycina raster do granic parafi
  (ST_DumpAsPolygons(ST_Clip(a.rast, b.geom))).val 
FROM rasters.landsat8 AS a, vectors.porto_parishes AS b  
WHERE b.parish ilike 'paranhos' 
  AND ST_Intersects(b.geom, a.rast);


--ANALIZA RASTRÓW

--st_band
--do wyodrębnienia pasma z ratsra 
CREATE TABLE makowska.landsat_nir AS 
SELECT rid, ST_Band(rast,4) AS rast 
FROM rasters.landsat8; 

--st_clip
--mozemy wyciac raster z innego rastra 
CREATE TABLE makowska.paranhos_dem AS 
SELECT a.rid,ST_Clip(a.rast, b.geom,true) as rast 
FROM rasters.dem AS a, vectors.porto_parishes AS b 
WHERE b.parish ilike 'paranhos' and ST_Intersects(b.geom,a.rast);

--st_slope
--do obliczenia anchylenia terenu 
CREATE TABLE makowska.paranhos_slope AS 
SELECT a.rid, ST_Slope(a.rast,1,'32BF','PERCENTAGE') AS rast 
FROM makowska.paranhos_dem AS a;

--st_reclass
--aby zreklasyfikować wartości rastra 
--od 0 do 15 1 klasa
CREATE TABLE makowska.paranhos_slope_reclass AS 
SELECT a.rid, ST_Reclass(a.rast,1,']0-15]:1,(15-30]:2,(30-9999:3','32BF',0) 
FROM makowska.paranhos_slope AS a;

--st_summarystats
--do statystyk dla danego rastra 
SELECT st_summarystats(a.rast) AS stats 
FROM makowska.paranhos_dem AS a;

--st_summarystats+st_union
--łączymy wszytskie rastry w jeden 
SELECT st_summarystats(ST_Union(a.rast)) 
FROM makowska.paranhos_dem AS a;

--zwracamy konkretne wartosci statystyk 
WITH t AS (
  SELECT st_summarystats(ST_Union(a.rast)) AS stats 
  FROM makowska.paranhos_dem AS a
)
SELECT (stats).min, (stats).max, (stats).mean FROM t;

--obliczenie statystyk dla każdej parafii osobno 
WITH t AS (
  SELECT b.parish AS parish, 
         st_summarystats(ST_Union(ST_Clip(a.rast, b.geom,true))) AS stats 
  FROM rasters.dem AS a, vectors.porto_parishes AS b 
  WHERE b.municipality ILIKE 'porto' AND ST_Intersects(b.geom,a.rast) 
  GROUP BY b.parish
)
SELECT parish, (stats).min, (stats).max, (stats).mean FROM t;

--st_value
--zwraca wartosc rastra w punkcie 
--st_dump-konwersja z wiepounktowej geometri na jednopunktowa
SELECT b.name, st_value(a.rast, (ST_Dump(b.geom)).geom) 
FROM rasters.dem a, vectors.places AS b 
WHERE ST_Intersects(a.rast,b.geom) 
ORDER BY b.name;

--TPI

--liczy tpi dla kazdego piksela
create table makowska.tpi30 as 
select ST_TPI(a.rast,1) as rast 
from rasters.dem a;

--indeks przestrzenny
CREATE INDEX idx_tpi30_rast_gist ON makowska.tpi30 
USING gist (ST_ConvexHull(rast)); 

--dodanie ograniczeń
SELECT AddRasterConstraints('makowska'::name, 
'tpi30'::name,'rast'::name); 


create table makowska.tpi30_porto as 
SELECT ST_TPI(a.rast,1) as rast 
FROM rasters.dem AS a, vectors.porto_parishes AS b  
WHERE ST_Intersects(a.rast, b.geom) AND b.municipality ilike 'porto'

CREATE INDEX idx_tpi30_porto_rast_gist ON makowska.tpi30_porto 
USING gist (ST_ConvexHull(rast)); 


SELECT AddRasterConstraints('makowska'::name, 
'tpi30_porto'::name,'rast'::name); 

--ALGEBRA MAP

--algebra-pozwala wykonywac operacje matematyczne na rastrach
--albo przez wyrazenie-podajemy odrazu wzor
--funkcja zwrotna-definiujeny funkcje a pozniej wywolujemy ja na rastrach 
CREATE TABLE makowska.porto_ndvi AS  
WITH r AS ( 
SELECT a.rid,ST_Clip(a.rast, b.geom,true) AS rast 
FROM rasters.landsat8 AS a, vectors.porto_parishes AS b 
WHERE b.municipality ilike 'porto' and ST_Intersects(b.geom,a.rast) 
) 
SELECT 
r.rid,ST_MapAlgebra( 
r.rast, 1, 
r.rast, 4, 
'([rast2.val] - [rast1.val]) / ([rast2.val] + 
[rast1.val])::float','32BF' 
) AS rast 
FROM r; 


CREATE INDEX idx_porto_ndvi_rast_gist ON makowska.porto_ndvi 
USING gist (ST_ConvexHull(rast)); 

SELECT AddRasterConstraints('makowska'::name, 
'porto_ndvi'::name,'rast'::name); 

--funkcja zwrotna 
create or replace function makowska.ndvi( 
value double precision [] [] [],  
pos integer [][], 
VARIADIC userargs text [] 
) 
RETURNS double precision AS 
$$ 
BEGIN --RAISE NOTICE 'Pixel Value: %', value [1][1][1];-->For debug 
RETURN (value [2][1][1] - value [1][1][1])/(value [2][1][1]+value 
[1][1][1]); --> NDVI calculation! 
END; 
$$ 
LANGUAGE 'plpgsql' IMMUTABLE COST 1000; 


CREATE TABLE makowska.porto_ndvi2 AS  
WITH r AS ( 
SELECT a.rid,ST_Clip(a.rast, b.geom,true) AS rast 
FROM rasters.landsat8 AS a, vectors.porto_parishes AS b 
WHERE b.municipality ilike 'porto' and ST_Intersects(b.geom,a.rast) 
) 
SELECT 
r.rid,ST_MapAlgebra( 
r.rast, ARRAY[1,4], 
'makowska.ndvi(double precision[], 
integer[],text[])'::regprocedure, --> This is the function! 
'32BF'::text 
) AS rast 
FROM r;


CREATE INDEX idx_porto_ndvi2_rast_gist ON makowska.porto_ndvi2 
USING gist (ST_ConvexHull(rast)); 

SELECT AddRasterConstraints('makowska'::name, 
'porto_ndvi2'::name,'rast'::name);

--EKSPORT DANYCH 

--st_astiff
--tworzy binarna reprezzentacje tiff
SELECT ST_AsTiff(ST_Union(rast))
FROM makowska.porto_ndvi;

--st_asgdalraster
--podobne do st_astiff ale mozemy wybrac dowolny format oblugiwany
--dododatkowo kompresja 
SELECT ST_AsGDALRaster(
    ST_Union(rast), 
    'GTiff',  
    ARRAY['COMPRESS=DEFLATE','PREDICTOR=2','ZLEVEL=9']
)
FROM makowska.porto_ndvi;

--aby wyswietlic liste oblugiwanych formatow 
SELECT ST_GDALDrivers();

--large object
--możemy przechowywac dane binarne jako large object 
--a nastepnie eksportowac na dysk
CREATE TABLE tmp_out AS 
SELECT lo_from_bytea(0,
    ST_AsGDALRaster(ST_Union(rast),'GTiff',ARRAY['COMPRESS=DEFLATE','PREDICTOR=2','ZLEVEL=9'])
) AS loid
FROM makowska.porto_ndvi;


SELECT lo_export(loid, 'C:\\Temp\\myraster.tiff')
FROM tmp_out;


SELECT lo_unlink(loid)
FROM tmp_out;

