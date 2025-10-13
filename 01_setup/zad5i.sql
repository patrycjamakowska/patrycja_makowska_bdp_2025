SELECT wynagrodzenie.id_pracownika,pensja.kwota
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
ORDER BY pensja.kwota;
