USE [Praktikum]
GO
/****** Object:  Table [dbo].[Beiträge]    Script Date: 18.11.2014 14:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Beiträge](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Mitteilung] [text] NOT NULL,
	[DiskussionsID] [int] NOT NULL,
	[Benutzer] [varchar](20) NOT NULL,
	[Änderungsdatum] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Benutzer]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Benutzer](
	[Nickname] [varchar](20) NOT NULL,
	[Vorname] [varchar](50) NULL,
	[Nachname] [varchar](50) NULL,
	[Passwort] [varchar](32) NOT NULL,
	[Email] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Nickname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Diskussionen]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Diskussionen](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Titel] [varchar](100) NOT NULL DEFAULT ('Kein Titel'),
	[AnzahlSichtungen] [int] NOT NULL DEFAULT ((0)),
	[ForumID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Dokumente]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Dokumente](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Kategorie] [varchar](10) NOT NULL,
	[Datei] [varbinary](max) NULL,
	[Titel] [varchar](100) NOT NULL,
	[Bereitstellungsdatum] [datetime] NOT NULL,
	[Benutzer] [varchar](20) NOT NULL,
	[ModulID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DokumenteHeftenAnBeiträge]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DokumenteHeftenAnBeiträge](
	[BeitragsID] [int] NOT NULL,
	[DokumentenID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BeitragsID] ASC,
	[DokumentenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Foren]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Foren](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Bezeichnung] [varchar](50) NOT NULL,
	[OberforumID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Mitarbeiter]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Mitarbeiter](
	[Nickname] [varchar](20) NOT NULL,
	[RaumNr] [varchar](10) NOT NULL,
	[Aufgabenbereich] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Nickname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Module]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Module](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Bezeichnung] [varchar](100) NOT NULL,
	[FachNummer] [int] NOT NULL,
	[Verantwortlicher] [varchar](20) NOT NULL,
	[ForumID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Professoren]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Professoren](
	[Nickname] [varchar](20) NOT NULL,
	[AkademischerTitel] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Nickname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Studenten]    Script Date: 18.11.2014 14:20:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Studenten](
	[Nickname] [varchar](20) NOT NULL,
	[Matrikel] [int] NOT NULL,
	[EinschreibeDatum] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Nickname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Beiträge] ON 

INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (1, N'Hat das einer mit der Generalisierung verstanden?', 1, N'driver', CAST(N'2014-23-09 14:12:34.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (2, N'Da gibt es doch 3 Varianten. Keine Ahnung wie die genau waren.', 1, N'patex', CAST(N'2014-23-09 15:03:21.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (3, N'Eine davon ist: Der Primärschlüssel des Supertypen ist auch der Primärschlüssel des Subtypen.', 1, N'tanja', CAST(N'2014-24-09 01:41:12.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (4, N'Die Andere Möglichkeit ist alle Attribute mit in den Supertypen zu tuen.', 1, N'van', CAST(N'2014-24-09 19:33:26.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (5, N'Dann gibt es aber doch ziemlich viele Null-Werte?!?', 1, N'toni', CAST(N'2014-26-09 09:52:11.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (6, N'Deswegen werden ja auch eher alle Attribute aus dem Supertypen, jeweils in die Subtypen übernommen.', 1, N'jakob', CAST(N'2014-30-09 10:10:19.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (7, N'Hat einer die Lösung zu Aufgabe 3.1?', 3, N'fly', CAST(N'2013-03-11 07:30:15.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (8, N'Kann ich dir in der nächsten Übung geben', 3, N'tanja', CAST(N'2013-05-11 02:33:59.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (9, N'Wie läuft das denn mit dem Testatverwaltungssystem? Also wo finde ich das?', 5, N'schlumpf78', CAST(N'2014-06-11 09:10:42.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (10, N'Schau mal auf der Seite vom Herrn Faßbender.', 5, N'toni', CAST(N'2014-06-11 10:35:15.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (11, N'Ich glaube unter TIWS-Links.', 5, N'tanja', CAST(N'2014-08-11 01:55:11.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (12, N'Du kannst dich mit deine MatrikelNummer anmelden.', 5, N'van', CAST(N'2014-08-11 09:09:23.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (13, N'Fällt das DB-Praktikum nächste Woche aus?', 2, N'driver', CAST(N'2014-08-11 10:28:37.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (14, N'Nein, nächste Woche ist ganz normal Praktikum.', 2, N'ritz', CAST(N'2014-08-11 23:17:34.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (15, N'Hat einer die Vorlesungsmitschrift von gestern? Ich hab anscheindend irgendwas falsch abgeschrieben…', 4, N'anno-nym', CAST(N'2013-11-11 11:11:11.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (16, N'Hier…', 4, N'tanja', CAST(N'2013-11-11 02:09:39.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (17, N'Danke!', 4, N'anno-nym', CAST(N'2013-11-11 09:10:10.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (18, N'Hier mal die Lösung zum letzten TIWS Praktikum.', 5, N'toni', CAST(N'2014-10-11 12:04:24.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (19, N'Null und nichtig!', 5, N'remmy', CAST(N'2014-12-11 11:45:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (20, N'Surrogate und andere Hobbies', 2, N'remmy', CAST(N'2014-10-11 23:15:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (21, N'Krähenfüße... weiss ich nicht', 14, N'tanja', CAST(N'2014-10-11 14:05:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (22, N'Nein, da geht´s um das Modell, Du Vogel ^^', 14, N'patex', CAST(N'2014-10-11 14:11:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (23, N'Ich ziehe meine Aussage zurück', 5, N'remmy', CAST(N'2014-12-11 11:58:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (24, N'wer nutzt Ubuntu?', 11, N'fly', CAST(N'2013-01-05 09:31:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (25, N'hier ich, 14.04', 11, N'schlumpf78', CAST(N'2014-29-04 18:44:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (26, N'Übungsklausur zwo drei vier!', 13, N'remmy', CAST(N'2014-12-11 20:01:00.000' AS DateTime))
INSERT [dbo].[Beiträge] ([ID], [Mitteilung], [DiskussionsID], [Benutzer], [Änderungsdatum]) VALUES (27, N'Datei zum Download', 12, N'ritz', CAST(N'2014-12-11 23:20:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Beiträge] OFF
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'anno-nym', N'heinz', N'', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'anno@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'dirtyharry', N'heinz', N'fassbender', N'973dcfd9ad5a56f529a054365ff1df32', N'fassbender@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'driver', N'fabian', N'fahrer', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'fahrer@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'fly', N'Marty', N'McFly', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'fly@future.com')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'hoever', N'Georg', N'Höver', N'973dcfd9ad5a56f529a054365ff1df32', N'hoever@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'jakob', NULL, N'strauch', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'strauch@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'patex', N'Klaus', N'Kleber', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'kleber@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'remmy', N'Marcel', N'Remmy', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'remmy@fh-aachen.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'ritz', N'Thomas', N'Ritz', N'973dcfd9ad5a56f529a054365ff1df32', N'ritz@fh-aachen.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'schlumpf78', N'martin', N'hammel', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'hugo@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'tanja', N'tanja', N'trampel', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'tanja@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'toni', N'Antonio', N'Tonmann', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'toni@gmxx.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'trauti', N'', N'Trautwein', N'973dcfd9ad5a56f529a054365ff1df32', N'trautwein@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'van', N'Vanessa', N'Burkhardt', N'dcff086d61b7fd7a019d2758c2ca4e6b', N'burkhardt@hochschule.de')
INSERT [dbo].[Benutzer] ([Nickname], [Vorname], [Nachname], [Passwort], [Email]) VALUES (N'zipper', N'', N'Siepmann', N'973dcfd9ad5a56f529a054365ff1df32', N'siep@hochschule.de')
SET IDENTITY_INSERT [dbo].[Diskussionen] ON 

INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (1, N'Frage zur DB-Vorlesung vom 14.11.', 3, 2)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (2, N'Praktikum?', 5, 2)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (3, N'Chen-Modell', 38, 2)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (4, N'TIWS-Vorlesung', 3, 8)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (5, N'Testate für TIWS-Praktikum', 6, 8)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (6, N'Windows 2012', 1, 20)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (7, N'Linux Distributionen', 42, 19)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (8, N'Anwesenheitspflicht', 23, 17)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (9, N'Pont-Viertel', 0, 14)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (10, N'Wieso Microsoft', 6, 20)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (11, N'Wieso Linux', 5, 19)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (12, N'Lösungen', 40, 15)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (13, N'Aufgaben', 18, 15)
INSERT [dbo].[Diskussionen] ([ID], [Titel], [AnzahlSichtungen], [ForumID]) VALUES (14, N'Crow´s Foot??', 25, 2)
SET IDENTITY_INSERT [dbo].[Diskussionen] OFF
SET IDENTITY_INSERT [dbo].[Dokumente] ON 

INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (1, N'Praktikum', NULL, N'P1.pdf', CAST(N'2011-23-10 14:27:28.000' AS DateTime), N'van', 8)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (2, N'Vorlesung', NULL, N'Folien Datenbank Managementsysteme.pdf', CAST(N'2012-12-10 01:28:36.000' AS DateTime), N'ritz', 2)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (3, N'Vorlesung', NULL, N'Mitschrift-10-10-2011.pdf', CAST(N'2013-12-11 02:08:03.000' AS DateTime), N'tanja', 10)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (4, N'Übung', NULL, N'Übung1.pdf', CAST(N'2014-11-11 10:15:43.000' AS DateTime), N'driver', 11)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (5, N'Praktikum', NULL, N'TIWSP2Lösung.pdf', CAST(N'2014-10-11 12:03:51.000' AS DateTime), N'toni', 10)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (6, N'Übung', NULL, N'Mitschrift-Übung1.pdf', CAST(N'2014-08-10 15:42:12.000' AS DateTime), N'van', 11)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (7, N'Praktikum', NULL, N'Lösungen-PP.pdf', CAST(N'2014-10-07 11:34:19.000' AS DateTime), N'patex', 3)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (8, N'Vorlesung', NULL, N'ARBK-Vorlesung.pdf', CAST(N'2014-29-09 18:51:33.000' AS DateTime), N'fly', 12)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (11, N'Vorlesung', NULL, N'Ubuntu_Logo.png', CAST(N'2013-05-01 20:01:00.000' AS DateTime), N'schlumpf78', 16)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (12, N'Sonstiges', NULL, N'Katzenbild.jpg', CAST(N'2014-12-11 11:31:00.000' AS DateTime), N'tanja', 15)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (13, N'Sonstiges', NULL, N'Hundebild.jpg', CAST(N'2014-12-11 11:36:00.000' AS DateTime), N'tanja', 15)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (14, N'Übung', NULL, N'Übungsklausur.pdf', CAST(N'2013-03-09 08:00:00.000' AS DateTime), N'remmy', 10)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (15, N'Übung', NULL, N'ÜbungsklausurLösung.pdf', CAST(N'2013-31-12 23:59:00.000' AS DateTime), N'remmy', 10)
INSERT [dbo].[Dokumente] ([ID], [Kategorie], [Datei], [Titel], [Bereitstellungsdatum], [Benutzer], [ModulID]) VALUES (16, N'Praktikum', NULL, N'Testatbogen.eps', CAST(N'2014-11-08 14:45:00.000' AS DateTime), N'ritz', 10)
SET IDENTITY_INSERT [dbo].[Dokumente] OFF
INSERT [dbo].[DokumenteHeftenAnBeiträge] ([BeitragsID], [DokumentenID]) VALUES (1, 4)
INSERT [dbo].[DokumenteHeftenAnBeiträge] ([BeitragsID], [DokumentenID]) VALUES (16, 3)
INSERT [dbo].[DokumenteHeftenAnBeiträge] ([BeitragsID], [DokumentenID]) VALUES (18, 5)
INSERT [dbo].[DokumenteHeftenAnBeiträge] ([BeitragsID], [DokumentenID]) VALUES (26, 14)
INSERT [dbo].[DokumenteHeftenAnBeiträge] ([BeitragsID], [DokumentenID]) VALUES (26, 15)
INSERT [dbo].[DokumenteHeftenAnBeiträge] ([BeitragsID], [DokumentenID]) VALUES (27, 16)
SET IDENTITY_INSERT [dbo].[Foren] ON 

INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (1, N'Module', NULL)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (2, N'Datenbanken', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (3, N'Objektorientierte Programmierung', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (4, N'Graphische Datenverarbeitung', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (5, N'Mathe I', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (6, N'Mathe II', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (7, N'Betriebssysteme', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (8, N'Theoretische Informatik', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (9, N'Grundlagen der Informatik', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (10, N'Grundlagen Physik und Etechnik', 1)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (11, N'Sonstige Veranstaltungen', NULL)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (12, N'Programmierpraktikum', 11)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (13, N'Industriepraktikum', 11)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (14, N'Studentenleben', NULL)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (15, N'Biete / Suche', NULL)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (16, N'Fragen zur Vorlesung und Übung', 2)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (17, N'Fragen zum Praktikum', 2)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (18, N'Allgemeine Fragen zum Praktikum', 2)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (19, N'Open Source Betriebssysteme', 7)
INSERT [dbo].[Foren] ([ID], [Bezeichnung], [OberforumID]) VALUES (20, N'Proprietäre Betriebssysteme', 7)
SET IDENTITY_INSERT [dbo].[Foren] OFF
INSERT [dbo].[Mitarbeiter] ([Nickname], [RaumNr], [Aufgabenbereich]) VALUES (N'fly', N'999', N'Zukunftsforschung und Vergangenheitsbewältigung')
INSERT [dbo].[Mitarbeiter] ([Nickname], [RaumNr], [Aufgabenbereich]) VALUES (N'jakob', N'112', N'Forschungsprojekt, Praktika')
INSERT [dbo].[Mitarbeiter] ([Nickname], [RaumNr], [Aufgabenbereich]) VALUES (N'remmy', N'1337', N'Übungen und Praktika')
SET IDENTITY_INSERT [dbo].[Module] ON 

INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (1, N'Grundlagen der Informatik und höhere Programmiersprache', 513, N'zipper', 9)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (2, N'Programmier-Praktikum', 517, N'trauti', 12)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (3, N'Physik und Grundlagen der Etechnik', 518, N'hoever', 10)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (4, N'Technisches Englisch', 521, N'hoever', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (5, N'Höhere Mathematik 2 für Inf', 524, N'hoever', 6)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (6, N'Digitaltechnik / Technische Informatik', 525, N'zipper', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (7, N'Algorithmen und Datenstrukturen', 526, N'hoever', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (8, N'Kommunikationstechniken', 521, N'trauti', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (9, N'Theoretische Informatik und Wissensbasierte Systeme', 535, N'dirtyharry', 8)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (10, N'Datenbanken', 536, N'ritz', 2)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (11, N'Architektur von Rechnersystemen und Betriebssystemkonzepte', 537, N'dirtyharry', 7)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (12, N'Grundlagen der Computernetze', 546, N'ritz', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (13, N'Objektorientierte Softwareentwicklung', 540, N'dirtyharry', 3)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (14, N'Verteilte Systeme', 541, N'dirtyharry', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (15, N'Bildverarbeitung', 555, N'dirtyharry', 4)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (16, N'Betriebssysteme', 556, N'trauti', 19)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (17, N'Software-Engineering', 557, N'ritz', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (18, N'Wissenschaftliches Arbeiten', 530, N'ritz', NULL)
INSERT [dbo].[Module] ([ID], [Bezeichnung], [FachNummer], [Verantwortlicher], [ForumID]) VALUES (19, N'BWL für Ingenieure', 551, N'ritz', 20)
SET IDENTITY_INSERT [dbo].[Module] OFF
INSERT [dbo].[Professoren] ([Nickname], [AkademischerTitel]) VALUES (N'dirtyharry', N'Prof. Dr. rer. nat.')
INSERT [dbo].[Professoren] ([Nickname], [AkademischerTitel]) VALUES (N'hoever', N'Prof. Dr. Dr. rer. nat.')
INSERT [dbo].[Professoren] ([Nickname], [AkademischerTitel]) VALUES (N'ritz', N'Prof. Dr. Ing.')
INSERT [dbo].[Professoren] ([Nickname], [AkademischerTitel]) VALUES (N'trauti', N'Prof. Dr. Ing.')
INSERT [dbo].[Professoren] ([Nickname], [AkademischerTitel]) VALUES (N'zipper', N'Prof. Dr. Ing.')
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'anno-nym', 102401, CAST(N'2012-12-09 00:00:00.000' AS DateTime))
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'driver', 3006716, CAST(N'2014-01-10 00:00:00.000' AS DateTime))
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'patex', 3007812, CAST(N'2013-12-09 00:00:00.000' AS DateTime))
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'remmy', 3024309, CAST(N'2013-26-09 00:00:00.000' AS DateTime))
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'schlumpf78', 111222, CAST(N'2013-25-03 00:00:00.000' AS DateTime))
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'tanja', 224572, CAST(N'2014-25-08 00:00:00.000' AS DateTime))
INSERT [dbo].[Studenten] ([Nickname], [Matrikel], [EinschreibeDatum]) VALUES (N'toni', 347711, CAST(N'2010-10-08 00:00:00.000' AS DateTime))
/****** Object:  Index [UQ__Benutzer__33F4B129]    Script Date: 18.11.2014 14:20:58 ******/
ALTER TABLE [dbo].[Benutzer] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Studenten__37C5420D]    Script Date: 18.11.2014 14:20:58 ******/
ALTER TABLE [dbo].[Studenten] ADD UNIQUE NONCLUSTERED 
(
	[Matrikel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Beiträge]  WITH CHECK ADD FOREIGN KEY([Benutzer])
REFERENCES [dbo].[Benutzer] ([Nickname])
GO
ALTER TABLE [dbo].[Beiträge]  WITH CHECK ADD FOREIGN KEY([DiskussionsID])
REFERENCES [dbo].[Diskussionen] ([ID])
GO
ALTER TABLE [dbo].[Diskussionen]  WITH CHECK ADD FOREIGN KEY([ForumID])
REFERENCES [dbo].[Foren] ([ID])
GO
ALTER TABLE [dbo].[Dokumente]  WITH CHECK ADD FOREIGN KEY([Benutzer])
REFERENCES [dbo].[Benutzer] ([Nickname])
GO
ALTER TABLE [dbo].[Dokumente]  WITH CHECK ADD FOREIGN KEY([ModulID])
REFERENCES [dbo].[Module] ([ID])
GO
ALTER TABLE [dbo].[DokumenteHeftenAnBeiträge]  WITH CHECK ADD FOREIGN KEY([BeitragsID])
REFERENCES [dbo].[Beiträge] ([ID])
GO
ALTER TABLE [dbo].[DokumenteHeftenAnBeiträge]  WITH CHECK ADD FOREIGN KEY([DokumentenID])
REFERENCES [dbo].[Beiträge] ([ID])
GO
ALTER TABLE [dbo].[Foren]  WITH CHECK ADD FOREIGN KEY([OberforumID])
REFERENCES [dbo].[Foren] ([ID])
GO
ALTER TABLE [dbo].[Mitarbeiter]  WITH CHECK ADD FOREIGN KEY([Nickname])
REFERENCES [dbo].[Benutzer] ([Nickname])
GO
ALTER TABLE [dbo].[Module]  WITH CHECK ADD FOREIGN KEY([ForumID])
REFERENCES [dbo].[Foren] ([ID])
GO
ALTER TABLE [dbo].[Module]  WITH CHECK ADD FOREIGN KEY([Verantwortlicher])
REFERENCES [dbo].[Professoren] ([Nickname])
GO
ALTER TABLE [dbo].[Professoren]  WITH CHECK ADD FOREIGN KEY([Nickname])
REFERENCES [dbo].[Benutzer] ([Nickname])
GO
ALTER TABLE [dbo].[Studenten]  WITH CHECK ADD FOREIGN KEY([Nickname])
REFERENCES [dbo].[Benutzer] ([Nickname])
GO
ALTER TABLE [dbo].[Benutzer]  WITH CHECK ADD CHECK  ((len([Passwort])>=(6)))
GO
ALTER TABLE [dbo].[Dokumente]  WITH CHECK ADD CHECK  (([Kategorie]='Sonstiges' OR [Kategorie]='Praktikum' OR [Kategorie]='Übung' OR [Kategorie]='Vorlesung'))
GO
ALTER TABLE [dbo].[Module]  WITH CHECK ADD CHECK  (([FachNummer]>=(500) AND [FachNummer]<(1000)))
GO
