-- Aufgabe 1
--SELECT * FROM dbo.Benutzer WHERE Nickname LIKE 'S%' OR Nickname LIKE 'T%';
--SELECT Bezeichnung FROM dbo.Foren WHERE OberforumID IS NULL ORDER BY Bezeichnung;
--SELECT COUNT(*) FROM dbo.Beitr�ge WHERE �nderungsdatum BETWEEN '2000-01-01 00:00:00' AND '2014-01-01 00:00:00';
--SELECT TOP 3 * FROM dbo.Diskussionen ORDER BY AnzahlSichtungen DESC;
--SELECT Benutzer, COUNT(*) as Anzahl FROM dbo.Beitr�ge GROUP BY Benutzer;
--SELECT Titel FROM dbo.Diskussionen WHERE LEN(Titel)>15 GROUP BY ID, Titel;

-- Aufgabe 2
--SELECT Benutzer.Vorname, Benutzer.Nickname, Studenten.Matrikel FROM dbo.Benutzer RIGHT JOIN Studenten ON Benutzer.Nickname=Studenten.Nickname WHERE Benutzer.Nickname LIKE 'S%' OR Benutzer.Nickname LIKE 'T%';
--SELECT Dokumente.Titel FROM dbo.Dokumente RIGHT JOIN Professoren ON Dokumente.Benutzer=Professoren.Nickname WHERE Professoren.Nickname='ritz';
--SELECT A.Nickname, A.Vorname, A.Nachname FROM Benutzer as A INNER JOIN Benutzer as B ON A.Vorname=B.Vorname WHERE A.Nickname!=B.Nickname AND A.Vorname!='' ORDER BY A.Vorname;
--SELECT TOP 1 Foren.Bezeichnung, COUNT(Beitr�ge.ID) as 'Anzahl Beitr�ge' FROM dbo.Foren JOIN dbo.Diskussionen ON Foren.ID=Diskussionen.ForumID JOIN dbo.Beitr�ge ON Diskussionen.ID=Beitr�ge.DiskussionsID GROUP BY Foren.Bezeichnung ORDER BY [Anzahl Beitr�ge] DESC;
--SELECT Benutzer.Vorname, Benutzer.Nachname, COUNT(Beitr�ge.ID) as 'Anzahl Beitr�ge' FROM dbo.Benutzer JOIN dbo.Beitr�ge ON Benutzer.Nickname=Beitr�ge.Benutzer GROUP BY Benutzer.Vorname, Benutzer.Nachname ORDER BY [Anzahl Beitr�ge];
--SELECT AVG(CAST(a.Anzahl as float)) as 'Beitr�ge pro Diskussion' FROM (SELECT COUNT(Beitr�ge.ID) as 'Anzahl' FROM Diskussionen LEFT JOIN Beitr�ge ON Diskussionen.ID=Beitr�ge.DiskussionsID GROUP BY Diskussionen.ID)a;

-- Aufgabe 3
--SELECT Titel FROM dbo.Dokumente LEFT JOIN dbo.DokumenteHeftenAnBeitr�ge ON Dokumente.ID=DokumenteHeftenAnBeitr�ge.DokumentenID WHERE BeitragsID IS NULL;

--SELECT 'Professor' as 'Typ', Benutzer.Nickname, Benutzer.Vorname, Benutzer.Nachname FROM dbo.Benutzer JOIN dbo.Professoren ON Benutzer.Nickname=Professoren.Nickname UNION
--SELECT 'Student' as 'Typ', Benutzer.Nickname, Benutzer.Vorname, Benutzer.Nachname FROM dbo.Benutzer JOIN dbo.Studenten ON Benutzer.Nickname=Studenten.Nickname UNION
--SELECT 'Mitarbeiter' as 'Typ', Benutzer.Nickname, Benutzer.Vorname, Benutzer.Nachname FROM dbo.Benutzer JOIN dbo.Mitarbeiter ON Benutzer.Nickname=Mitarbeiter.Nickname ORDER BY Typ; 

--SELECT TOP 3 Beitr�ge.Benutzer as 'Nickname', AVG(CAST(DATALENGTH(Mitteilung) as float)) as 'Beitrags L�nge im Durchschnitt' FROM dbo.Beitr�ge GROUP BY Beitr�ge.Benutzer ORDER BY [Beitrags L�nge im Durchschnitt] DESC;
--SELECT * FROM (SELECT Beitr�ge.Benutzer as 'Nickname', AVG(CAST(DATALENGTH(Mitteilung) as float)) as 'Beitrags L�nge im Durchschnitt' FROM dbo.Beitr�ge GROUP BY Beitr�ge.Benutzer)a WHERE a.[Beitrags L�nge im Durchschnitt]<50;
--SELECT Beitr�ge.Benutzer, Dokumente.Titel as 'Datei', Diskussionen.Titel as 'Diskussion' FROM dbo.Beitr�ge JOIN dbo.DokumenteHeftenAnBeitr�ge ON DokumenteHeftenAnBeitr�ge.BeitragsID=Beitr�ge.ID JOIN Dokumente ON DokumenteHeftenAnBeitr�ge.DokumentenID=Dokumente.ID JOIN Diskussionen ON Diskussionen.ID=Beitr�ge.DiskussionsID;

-- Aufgabe 4
WITH F(OberID, UnterID, Tiefe) AS
(
SELECT Foren.OberforumID as OberID, Foren.ID as UnterID, 1 as Tiefe FROM Foren WHERE OberforumID IS NULL
UNION ALL
SELECT F.UnterID as OberID, Foren.ID as UnterID, F.Tiefe+1 FROM F JOIN Foren ON Foren.OberforumID=F.UnterID
)
SELECT F.*, Foren.Bezeichnung FROM F JOIN Foren ON UnterID=Foren.ID ORDER BY OberID