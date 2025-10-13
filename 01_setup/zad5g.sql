SELECT pracownicy.imie, pracownicy.nazwisko,pensja.kwota
FROM ksiegowosc.wynagrodzenie
JOIN ksiegowosc.pensja ON wynagrodzenie.id_pensji=pensja.id_pensji
JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika=pracownicy.id_pracownika
WHERE CAST(pensja.kwota AS decimal(10, 2)) BETWEEN 1500 AND 3000;
