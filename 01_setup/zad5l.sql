SELECT AVG(CAST(pensja.kwota AS decimal(10, 2))) AS średnia
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
WHERE pensja.stanowisko='sprzedawca'
