using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Website;

namespace Praktikum_3_Disconnected_Data_and_LINQ
{
    public class ProfSummary
    {
        public string Nickname { get; set; }
        public string ProfName { get; set; }
        public List<ForumBeitrag> Beiträge { get; set; }
        public List<Dokument> Dokumente { get; set; }
        public List<Modul> Module { get; set; }

        public static ProfSummary Load(string nickname)
        {
            var entry = new SqlEntry();
            var reader = entry.getReader(queryString + nickname + "'");
            reader.Read();
            var name = reader["AkademischerTitel"].ToString() +" " + reader["Nachname"].ToString();
            var result = new ProfSummary
                             {
                                 Nickname = nickname,
                                 ProfName = name,
                                 Beiträge = ForumBeitrag.getBeitragByUser(nickname),
                                 Dokumente = Dokument.getDokumentByUser(nickname),
                                 Module = Modul.getModulByUser(nickname)
                                 //...
                             };
            
            return result;
        }
        private static string queryString = "SELECT Professoren.AkademischerTitel, Benutzer.Nachname " +
                      "FROM Benutzer " +
                      "INNER JOIN Professoren ON Professoren.Nickname = Benutzer.Nickname " +
                      "WHERE Benutzer.Nickname = '";
    }

    public class ForumBeitrag
    {
        public string description { get; set; }
        public string message { get; set; }
        public DateTime changedAt { get; set; }
        public static List<ForumBeitrag> getBeitragByUser(string nickname)
        {
            var result = new List<ForumBeitrag>();
            var entry = new SqlEntry();

            var reader = entry.getReader(query + nickname + query2);

            while (reader.Read())
            {
                var forumBeitrag = new ForumBeitrag
                {
                    description = reader["Bezeichnung"].ToString(),
                    message = reader["Mitteilung"].ToString(),
                    changedAt = (DateTime)reader["Änderungsdatum"]
                };
                result.Add(forumBeitrag);
            }
            return result;
        }
        private static string query = "SELECT Foren.ID, Foren.Bezeichnung, Beiträge.Mitteilung, Beiträge.Änderungsdatum " +
                      "FROM Foren " +
                      "INNER JOIN Diskussionen " +
                      "ON Foren.ID = Diskussionen.ForumID " +
                      "INNER JOIN Beiträge " +
                      "ON Diskussionen.ID = Beiträge.DiskussionsID " +
                      "WHERE Beiträge.Benutzer = '";
        private static string query2 = "' ORDER BY Foren.ID, Beiträge.Änderungsdatum DESC ";
    }

    public class Dokument
    {
        public string Titel { get; set; }
        public DateTime Bereitstellung { get; set; }

        public static List<Dokument> getDokumentByUser(string nickname)
        {
            var result = new List<Dokument>();
            var entry = new SqlEntry();

            var reader = entry.getReader(query + nickname + "'");

            while (reader.Read())
            {
                var dokument = new Dokument
                                   {
                                       Bereitstellung = (DateTime) reader["Bereitstellungsdatum"],
                                       Titel = reader["Titel"].ToString()
                                   };
                result.Add(dokument);
            }
            return result;
        }
        private static string query = "SELECT d.Titel, d.Bereitstellungsdatum, p.Nickname FROM Dokumente d "+
            "JOIN Benutzer b ON d.Benutzer = b.Nickname JOIN Professoren p ON b.Nickname = p.Nickname WHERE p.Nickname ='";
    }

}