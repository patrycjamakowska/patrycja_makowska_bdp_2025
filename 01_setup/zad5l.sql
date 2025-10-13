SELECT AVG(CAST(pensja.kwota AS decimal(10, 2))) AS średnia
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
WHERE pensja.stanowisko='sprzedawca'

SELECT MIN(CAST(pensja.kwota AS decimal(10, 2))) AS minimalna,stanowisko
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
WHERE pensja.stanowisko='sprzedawca'
GROUP BY pensja.stanowisko;

SELECT MAX(CAST(pensja.kwota AS decimal(10, 2))) AS maksymalna,stanowisko
FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
WHERE pensja.stanowisko='sprzedawca'
GROUP BY pensja.stanowisko;
