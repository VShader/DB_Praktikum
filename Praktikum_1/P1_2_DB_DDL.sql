
------ Batch fürs Praktikum
--- Die eckigen Klammern - z.b. [Professoren] stellen sicher, dass Sonderzeichen
--- Leerzeichen oder sogar Schlüsselworte als Tabellen/Spaltennamen genutzt werden können.
--- So könnte man eine Tabelle auch [Table] oder [Straße und Hausnummer] nennen.

-- Nutze Praktikum Datenbank

USE [Praktikum]

GO

-- Bedingtes Löschen: Sofern in den Systemtabellen die entsprechenden Tabellen 
-- verzeichnet sind, werden diese gedropped.

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[T_HeftetAn]') AND type in (N'U'))
DROP TABLE [T_HeftetAn]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Dokumente]') AND type in (N'U'))
DROP TABLE [Dokumente]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Module]') AND type in (N'U'))
DROP TABLE [Module]

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Professoren]') AND type in (N'U'))
DROP TABLE [Professoren]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Beiträge]') AND type in (N'U'))
DROP TABLE [Beiträge]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Diskussionen]') AND type in (N'U'))
DROP TABLE [Diskussionen]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Studenten]') AND type in (N'U'))
DROP TABLE [Studenten]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Benutzer]') AND type in (N'U'))
DROP TABLE [Benutzer]

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Foren]') AND type in (N'U'))
DROP TABLE [Foren]

GO

-- Entities


CREATE TABLE [Foren](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Foren_ID PRIMARY KEY (ID),
	[Bezeichnung] [nvarchar](50) NOT NULL,
	CONSTRAINT FK_Foren_ID_Oberforum FOREIGN KEY (ID) 
		REFERENCES Foren(ID) -- 1 Forum besitzt N Unterforen.
)

GO

CREATE TABLE [Diskussionen](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Diskussionen_ID PRIMARY KEY (ID),
	[Titel] [nvarchar](50) NOT NULL,
	[AnzahlSichtungen] [int] DEFAULT 0,
	CONSTRAINT FK_Diskussionen_ID_Foren FOREIGN KEY (ID)
		REFERENCES Foren(ID) -- 1 Forum enthält N Diskussionen.
)

GO

CREATE TABLE [Beiträge](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Beiträge_ID PRIMARY KEY (ID),
	[Mitteilung] [ntext] NOT NULL,
	[Änderungsdatum] [datetime2] DEFAULT CURRENT_TIMESTAMP
)

GO

CREATE TABLE [Benutzer](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Benutzer_ID PRIMARY KEY (ID),
	[Nickname] [nvarchar](30) NOT NULL,
	[Vorname] [nvarchar](50) NOT NULL,
	[Nachname] [nvarchar](50) NOT NULL,
	[Passwort] [binary](16) NOT NULL,
	[Email] [varchar](50),
	CONSTRAINT UC_Benutzer_Email UNIQUE (Email)
)

GO

CREATE TABLE [Studenten](
	ID INTEGER NOT NULL,
	CONSTRAINT PK_Studenten_ID PRIMARY KEY (ID),
	CONSTRAINT FK_Studenten_ID_Benutzer FOREIGN KEY (ID) REFERENCES Benutzer (ID)
		ON DELETE CASCADE,
	[Matrikel] [int] NOT NULL,
	CONSTRAINT UC_Studenten_Matrikel UNIQUE (Matrikel),
	[EinschreibeDatum] [datetime2] NOT NULL,
)

CREATE TABLE [Professoren](
	ID INTEGER NOT NULL,
	CONSTRAINT PK_Professoren_ID PRIMARY KEY (ID),
	CONSTRAINT FK_Professoren_ID_Benutzer FOREIGN KEY (ID) REFERENCES Benutzer (ID)
		ON DELETE CASCADE,
	[AkademischerTitel] [varchar](10) DEFAULT 'Prof.',
)


GO

CREATE TABLE [Module](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Module_ID PRIMARY KEY (ID),
	[Bezeichnung] [nvarchar](50) NOT NULL,
	[FachNummer] [int] NOT NULL,
	CONSTRAINT CHK_Module_FachNummer CHECK (FachNummer > 500 AND FachNummer < 999),
	CONSTRAINT FK_Module_ID_Professoren FOREIGN KEY (ID) 
		REFERENCES Professoren(ID) -- 1 Prof. ist für N Module verantwortlich.
)

GO

CREATE TABLE [Dokumente](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Dokumente_ID PRIMARY KEY (ID),
	[Kategorie] [nvarchar](50) NOT NULL,
	CONSTRAINT CHK_Dokumente_Kategorie CHECK (Kategorie='Vorlesung' OR Kategorie='Übung' OR 
		Kategorie='Praktikum' OR Kategorie='Sonstiges'),
	[Datei] [varbinary](max) NOT NULL,
	[Titel] [nvarchar](50) NOT NULL,
	[Bereitstellungsdatum] [datetime2] DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FK_Dokumente_ID_Benutzer FOREIGN KEY (ID)
		REFERENCES Benutzer(ID), -- 1 Bentuzer stellt N Dokumente zur Verfügung.
	CONSTRAINT FK_Dokumente_ID_Module FOREIGN KEY (ID) 
		REFERENCES Module(ID) -- 1 Modul stellt N Dokumente zur Verfügung.
)

GO

CREATE TABLE [T_HeftetAn](
	ID INTEGER IDENTITY (0,1),
	CONSTRAINT PK_Heftet_an_ID PRIMARY KEY (ID),
	CONSTRAINT FK_HeftetAn_ID_Dokumente FOREIGN KEY (ID)
		REFERENCES Dokumente(ID), -- M Dokumente sind an N Beiträgen angehäftet.
	CONSTRAINT FK_HeftetAn_ID_Beiträge FOREIGN KEY (ID)
		REFERENCES Beiträge(ID) -- N Beiträge haben M Dokumente angehäftet.
)

GO

-------------------------------------------------------------------------------------------------------------------
ALTER TABLE Beiträge
	ADD	CONSTRAINT FK_Beiträge_ID_Benutzer 
	FOREIGN KEY (ID)
		REFERENCES Benutzer(ID) -- 1 Bentuzer verfasst N Beiträge.
ALTER TABLE Beiträge
	ADD CONSTRAINT FK_Beiträge_ID_Diskussionen 
	FOREIGN KEY (ID)
		REFERENCES Diskussionen(ID) -- 1 Diskussion hat N Beiträge.

GO

IF EXISTS (SELECT name FROM sys.indexes
    WHERE object_id = OBJECT_ID(N'ForenID'))
DROP INDEX ForenID ON dbo.Disussionen
GO

CREATE INDEX ForenID
    ON dbo.Diskussionen(Titel);
GO

-- GO singalisiert das Ende eine Batch-Befehls, so kann man mehrere davon in einer Datei schreiben.
-- Optionale Attribute werden in einer separaten Tabelle gespeichert und mittels Fremdschlüssels referenziert.
-- Constraints: NOT NULL	= Spalte muss belegt sein.
--				UNIQUE		= Jeder Wert der Spalte ist einzigartig.
--				PRIMARY KEY	= Kombination aus NOT NULL und UNIQUE für den Primärschlüssel
--				FOREIGN KEY = Schützt Verbindungen zwischen Tabellen und kann nur Werte des Primärschlüssels enthalten auf den er zeigt.
--				CHECK		= Überprüft ob Wert einer Bedingung entspricht.
--				DEFAULT		= Gibt dem Eintrag einen definierten Standardwert.
