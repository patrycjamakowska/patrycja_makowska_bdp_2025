SELECT COUNT(premia.id_premii) AS liczba_premi,pensja.stanowisko
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii=wynagrodzenie.id_premii
GROUP BY pensja.stanowisko;
