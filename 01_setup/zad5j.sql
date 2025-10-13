SELECT id_pracownika,(premia.kwota+pensja.kwota) as suma
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON pensja.id_pensji=wynagrodzenie.id_pensji
JOIN ksiegowosc.premia  ON premia.id_premii = wynagrodzenie.id_premii
ORDER BY (pensja.kwota + premia.kwota) DESC;
