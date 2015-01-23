using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Website;
using System.Data.SqlClient;

namespace Praktikum_4_XML_and_doc_oriented_db
{
    public class Modul
    {
        public Modul()
        { }
        public Modul(int subNum, string description, string guarantor, string profName)
        {
            this.subNum = subNum;
            this.description = description;
            this.guarantor = guarantor;
            this.profName = profName;
        }
        public int subNum {get; set;}
        public string description { get; set; }
        public string guarantor { get; set; }
        public string profName { get; set; }


        internal static List<Modul> getModulByUser(string nickname)
        {
            var result = new List<Modul>();
            var entry = new SqlEntry();

            var reader = entry.getReader(query + nickname + query2);

            while (reader.Read())
            {
                var modul = new Modul
                {
                    description = reader["Bezeichnung"].ToString()
                };
                result.Add(modul);
            }
            return result;
        }
        private static string query = "SELECT Module.Bezeichnung FROM Module " +
                      "WHERE Module.Verantwortlicher = '";
        private static string query2 = "' ORDER BY Module.ID ";
    }

    public class ModuleDB
    {
        public List<Modul> getModul()
        {
            try
            {
                //Connect to DataBase
                var entry = new SqlEntry();
                var reader = entry.getReader(queryString);
                var moduleListe = new List<Modul>();

                //Read results and store it as a list of Moduls
                while(reader.Read())
                {
                    var guarantor = reader["Nickname"].ToString();
                    var profName = reader["AkademischerTitel"].ToString() + " " + reader["Nachname"];
                    moduleListe.Add(new Modul((int)reader["FachNummer"], reader["Bezeichnung"].ToString(),
                        guarantor, profName));
                }
                return moduleListe;
                
            }   catch(SqlException e)
            {
                throw;
            }
        }

        private string queryString = "SELECT Module.FachNummer, Module.Bezeichnung, Professoren.AkademischerTitel, Benutzer.Nachname, Benutzer.Nickname " +
                       "FROM Module " +
                       "INNER JOIN Professoren ON Professoren.Nickname = Module.Verantwortlicher " +
                       "INNER JOIN Benutzer ON Module.Verantwortlicher = Benutzer.Nickname " +
                       "ORDER BY Module.FachNummer ";
    }
}