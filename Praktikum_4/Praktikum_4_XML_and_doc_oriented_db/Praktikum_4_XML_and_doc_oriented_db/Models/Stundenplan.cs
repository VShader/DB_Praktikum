﻿using System;
using System.Collections.Generic;
using System.Xml.Linq;
using System.Linq;

namespace Praktikum_4_XML_and_doc_oriented_db.Models
{
    public class Stundenplan
    {
        public int FachSemester { get; set; }
        public DateTime Aktualisiert { get; set; }
        public string Studiengang { get; set; }
        public List<Tag> Tage { get; set; }

        public Stundenplan()
        {
            Tage = new List<Tag>();
        }

        public Stundenplan(object tag)
        {
            Aktualisiert = DateTime.Now;
            FachSemester = 1;
            Studiengang = "databases for novice";
        }

        public static Stundenplan GetMockupDaten()
        {
            string[] zeiten = { "08:15", "10:15", "12:15", "14:15", "15:45", "17:15" };
            string[] tage = { "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag" };

            var result = new Stundenplan
                             {
                                 Aktualisiert = DateTime.Now,
                                 FachSemester = 1,
                                 Studiengang = "databases for novice",
                             };

            // montag
            foreach(var t in tage)
            {
                var tag = new Tag {Name = t, Blöcke = new List<Block>()};
                
                foreach (var zeit in zeiten)
                {
                    tag.Blöcke.Add(new Block
                    {
                        Zeit = zeit,
                        FachNr = 973,
                        Typ = "V",
                        Veranstaltung = "databases for professionals"
                    });
                }

                result.Tage.Add(tag);
            }

            return result;
        }
        
        public static Stundenplan get()
        {
            var doc = XDocument.Load(@"E:\FH-Aachen\3. Semester\DB\DB_Praktikum\Praktikum_4\Praktikum_4_XML_and_doc_oriented_db\Praktikum_4_XML_and_doc_oriented_db\Models\Stundenplan.xml");
            var days =
                from day in doc.Descendants("stundenplan")
                select new { tag = day.Attribute("Tag"), block = day.Descendants("Block") };
            //var days =
            //    from day in doc.Descendants("stundenplan")
            //    select day;

            var tage = new List<Tag>();
            foreach (var day in days)
            {
                tage.Add(new Tag { Name = day.tag.ToString(), Blöcke = (List<Block>)day.block });
            }


            return new Stundenplan(days);
        }
    }

    public class Tag
    {
        public string Name { get; set; }
        public List<Block> Blöcke { get; set; }

        public Tag()
        {
            Blöcke = new List<Block>();
        }   
    }

    public class Block
    {
        public string Zeit { get; set; }
        public string Veranstaltung { get; set; }
        public string Typ { get; set; }
        public int FachNr { get; set; }
    }
}