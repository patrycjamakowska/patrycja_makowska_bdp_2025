INSERT INTO ksiegowosc.pracownicy(id_pracownika,imie,nazwisko,adres,telefon) VALUES
(1,'Anna','Kowalska','Kielce',123456789),
(2,'Antek','Pościel','Kraków',223456789),
(3,'Jolanta','Góra','Warszawa',323456789),
(4,'Kazimierz','Wysoki','Katowice',423456789),
(5,'Sebastian','Nowy','Białystok',523456789),
(6,'Monika','Jabłko','Radom',623456789),
(7,'Marek','Komoda','Rzeszów',723456789),
(8,'Krzysztof','Nowak','Warszawa',823456789),
(9,'Katarzyna','Słodka','Zakopane',923456789),
(10,'Aleksandra','Mądra','Tarnów',103456789);
SELECT * FROM ksiegowosc.pracownicy;


INSERT INTO ksiegowosc.godziny(id_godziny,data,liczba_godzin,id_pracownika) VALUES
(1,'01.01.2021',1,1),
(2,'02.02.2022',2,2),
(3,'03.03.2023',387,3),
(4,'04.04.2014',1491,4),
(5,'05.05.2015',500,5),
(6,'06.06.2016',16,6),
(7,'07.07.2013',79,7),
(8,'08.08.2018',18,8),
(9,'09.09.2019',9190,9),
(10,'10.10.2020',56,10);
SELECT * FROM ksiegowosc.godziny;



INSERT INTO ksiegowosc.pensja(id_pensji,stanowisko,kwota) VALUES
(1,'sprzedawca',111),
(2,'sprzedawca',222),
(3,'sprzedawca',333),
(4,'manager',4444),
(5,'zastępca menagera',1555),
(6,'sprzedawaca',6669),
(7,'sprzedawca',7771),
(8,'sprzedawca',1888),
(9,'prezes',9979),
(10,'sprzedawca',1111);
SELECT * FROM ksiegowosc.pensja;

INSERT INTO ksiegowosc.premia(id_premii,rodzaj,kwota) VALUES
(1,'za dobra praca',1),
(2,'nadgodzinny',54321),
(3,'świeta',567890),
(4,'na dzieci',908765),
(5,'chorobowe',34567),
(6,'regulaminowa',9894),
(7,'uznaniowa',563),
(8,'za frekwencje',849040),
(9,'periodyczne',930330),
(10,'miesięczne',3846489);
SELECT * FROM ksiegowosc.premia;

INSERT INTO ksiegowosc.wynagrodzenie(id_wynagrodzenia,data,id_pracownika, id_pensji ,id_premii) VALUES
(1,'09.09.2012',3,1,1),
(2,'13.12.2020',8,8,2),
(3,'24.10.2019',1,9,2),
(4,'05.03.2016',5,3,1),
(5,'01.02.2023',2,4,5),
(6,'30.07.2014',4,8,1),
(7,'10.10.2010',9,6,6),
(8,'04.06.2023',10,10,10),
(9,'30.09.2017',7,3,9),
(10,'18.09.2023',6,8,8);
SELECT * FROM ksiegowosc.wynagrodzenie;
