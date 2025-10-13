DELETE 
FROM ksiegowosc.wynagrodzenie
WHERE id_pensji IN( 
SELECT id_pensji 
FROM ksiegowosc.pensja
WHERE CAST(pensja.kwota AS decimal(10, 2)) < 1200  );
