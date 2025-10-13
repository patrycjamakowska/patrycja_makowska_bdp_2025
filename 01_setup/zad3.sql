--pracownicy 
CREATE TABLE IF NOT EXISTS ksiegowosc.pracownicy
(
    id_pracownika INT PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(50),
    telefon VARCHAR(20)
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'TABELA-PRACOWNICY ';

--godziny 
CREATE TABLE IF NOT EXISTS ksiegowosc.godziny
(
    id_godziny INT PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin INTEGER NOT NULL,
    id_pracownika INTEGER NOT NULL
);
COMMENT ON TABLE ksiegowosc.godziny IS 'TABELA-GODZINY';

--pensja 
CREATE TABLE IF NOT EXISTS ksiegowosc.pensja
(
    id_pensji INT PRIMARY KEY,
    stanowisko VARCHAR(50) NOT NULL,
    kwota money NOT NULL
);
COMMENT ON TABLE ksiegowosc.pensja IS 'TABELA-PENSJA';

--premia 
CREATE TABLE IF NOT EXISTS ksiegowosc.premia
(
    id_premii INT PRIMARY KEY,
    rodzaj VARCHAR(50) NOT NULL,
    kwota money
);
COMMENT ON TABLE ksiegowosc.premia IS 'TABELA-PREMIA';

--wynagrodzenie
CREATE TABLE IF NOT EXISTS ksiegowosc.wynagrodzenie
(
    id_wynagrodzenia INT PRIMARY KEY,
    data DATE NOT NULL,
    id_pracownika INTEGER NOT NULL,
    id_pensji INTEGER NOT NULL,
    id_premii INTEGER
);
COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'TABELA-WYNAGRODZENIE';

ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premia(id_premii);

