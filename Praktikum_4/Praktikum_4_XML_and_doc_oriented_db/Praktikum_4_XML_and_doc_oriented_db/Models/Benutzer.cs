using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using Website;

namespace Praktikum_4_XML_and_doc_oriented_db.Models
{
    public class Benutzer
    {
        public Benutzer()
        { }
        public Benutzer(string nickname, string password)
        {
            this.nickname = nickname;
            this.password = password;
        }
        public Benutzer(string nickname, string vorname, string nachname, string password, string email)
            : this(nickname, password)
        {
            this.vorname = vorname;
            this.nachname = nachname;
            this.email = email;
        }

        public string nickname { get; set; }
        public string vorname { get; set;}
        public string nachname { get; set; }
        public string password { get; set; }
        public string email { get; set; }

        public void createInDB()
        {
            try
            {
                var entry = new SqlEntry();
                entry.insertInto(queryString + nickname + "', '" + vorname + "', '" + nachname + "', '" + password + "', '" + email + "')");
            }   catch(SqlException e)
            { throw; }
        }
        private string queryString = "INSERT INTO Benutzer(Nickname, Vorname, Nachname, Passwort, Email) VALUES('";
    }

    public class Student : Benutzer
    {
        public Student()
        { }
        public Student(string nickname, string vorname, string nachname, string password, string email, ushort matrikelnumber, DateTime einschreibeDatum) 
             : base(nickname, vorname, nachname, password, email)
        {
            this.matrikelnumber = matrikelnumber;
            this.einschreibeDatum = einschreibeDatum;
        }

        public ushort matrikelnumber { get; set; }
        public DateTime einschreibeDatum { get; set; }

        public void createInDB()
        {
            try
            {
                base.createInDB();
                var entry = new SqlEntry();
                entry.insertInto(queryString + nickname + "', '" + matrikelnumber + "', '" + einschreibeDatum + "')");
            }   catch(SqlException e)
            { }
        }
        private string queryString = "INSERT INTO Studenten(Nickname, Matrikel, EinschreibeDatum) VALUES('";
    }

    public class BenutzerDB
    {
        public List<Benutzer> getBenutzer()
        {
            try
            {
                //Connect to DataBase
                var entry = new SqlEntry();
                var reader = entry.getReader(getAllUsersQueryString);
                var benutzerListe = new List<Benutzer>();

                //Read results and store it as a list of Moduls
                while(reader.Read())
                {
                    var email = reader["Nickname"].ToString();
                    benutzerListe.Add(new Benutzer(reader["Nickname"].ToString(), reader["Vorname"].ToString(),
                        reader["Nachname"].ToString(), reader["Passwort"].ToString(), reader["Email"].ToString()));
                }
                return benutzerListe;
                
            }   catch(SqlException e)
            {
                throw;
            }
        }

        public void createBenutzer(Benutzer user, string repeatPw)
        {
            if(!user.password.Equals(repeatPw))
            {
                throw new BenutzerPasswordException();
            }   else
            {
                try
                {
                
                }   catch(SqlException e)
                {
                    throw;
                }
            }
        }

        public Boolean authenticateBenutzer(Benutzer user)
        {
            try
            {
                var entry = new SqlEntry();
                var dbPassword = (string)entry.getScalar(loginQueryString + "'" + user.nickname + "'"); 
                if(dbPassword == null)
                { 
                    //<p>User doesn't exsist!!!</p>
                    //userName = "";
                    throw new BenutzerDontExistException();
                }   else if(string.Compare(Crypto.Hash(user.password, "md5").ToString(), dbPassword,true)!=0)
                {
                    //<p>Wrong Password!!!</p>
                    throw new BenutzerPasswordException();
                }
            }   catch(SqlException e)
            {
                //<p>Anmelden zur Zeit nicht möglich bitte versuchen Sie es sp&aumlter wieder.</p>
            }
            return true;
        }

        private string getAllUsersQueryString = "SELECT * FROM Benutzer ORDER BY Nachname";
        private string loginQueryString = "SELECT Benutzer.Passwort " +
                      "FROM Benutzer WHERE Benutzer.Nickname=";
    }

    public class BenutzerDontExistException : Exception
    {

    }
    public class BenutzerPasswordException : Exception
    {

    }
    public class BenutzerAlreadyExistException : Exception
    {

    }
}
