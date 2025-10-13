SELECT pracownicy.imie,pracownicy.nazwisko
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON godziny.id_pracownika=pracownicy.id_pracownika
WHERE (godziny.liczba_godzin-160)>0 ;
