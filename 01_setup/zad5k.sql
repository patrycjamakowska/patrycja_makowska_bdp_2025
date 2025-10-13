SELECT COUNT(wynagrodzenie.id_pracownika)AS liczba_pracowników,pensja.stanowisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
GROUP BY pensja.stanowisko;
