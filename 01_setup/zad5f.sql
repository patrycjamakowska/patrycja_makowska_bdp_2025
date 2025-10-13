SELECT pracownicy.imie,pracownicy.nazwisko,(godziny.liczba_godzin-160) AS nadgodzinny
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON pracownicy.id_pracownika=godziny.id_pracownika
WHERE (godziny.liczba_godzin-160)>0;
