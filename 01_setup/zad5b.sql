SELECT id_pracownika
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
JOIN ksiegowosc.premia ON premia.id_premii = wynagrodzenie.id_premii
WHERE CAST((pensja.kwota+premia.kwota) AS decimal(10, 2)) > 1000.00;
