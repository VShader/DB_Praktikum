using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Forum.Models
{
    public class ProfSummary
    {
        public string Nickname { get; set; }
        public List<ForumBeitrag> Beiträge { get; set; }
        public List<Dokument> Dokumente { get; set; }
        public List<Modul> Module { get; set; }

        public static ProfSummary Load(string nickname)
        {
            var result = new ProfSummary
                             {
                                 Nickname = nickname,
                                 Dokumente = Dokument.getDokumentByUser(nickname),
                                 //...
                             };
            
            return result;
        }
    }

    public class ForumBeitrag
    {
        
    }

    public class Dokument
    {
        public string Titel { get; set; }
        public DateTime Bereitstellung { get; set; }

        public static List<Dokument> getDokumentByUser(string nickname)
        {

            var result = new List<Dokument>();

            var connectionString =
                @"-- put Connection String here --";
            var connection = new SqlConnection(connectionString);

            connection.Open();


            var query =
                "SELECT d.Titel, d.Bereitstellungsdatum, p.Nickname FROM Dokumente d JOIN Benutzer b ON d.Benutzer = b.Nickname JOIN Professoren p ON b.Nickname = p.Nickname WHERE p.Nickname = @nickname";

            var command = new SqlCommand(query, connection);

            command.Parameters.AddWithValue("@nickname", nickname);

            var reader = command.ExecuteReader();

           

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
    }

    public class Modul
    {
        
    }

}