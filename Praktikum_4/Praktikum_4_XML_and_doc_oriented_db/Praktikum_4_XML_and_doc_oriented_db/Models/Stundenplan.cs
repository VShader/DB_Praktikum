using System;
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
            //var days =
            //    from day in doc.Descendants("stundenplan")
            //    select new { tag = day.Attribute("Tag"), block = day.Descendants("Block") };
            
            var timeTables = 
                from timeTable in doc.Descendants("stundenplan")
                select timeTable;

            var days =
                from day in timeTables.Descendants("Tag")
                select day;

            var tagList = new List<Tag>();
            foreach(var day in days)
            {
                var blocks =
                    from block in day.Descendants("Block")
                    select block;

                var blockList = new List<Block>();
                foreach(var block in blocks)
                {
                    string zeit = "";
                    int fachNr = 0;
                    string typ = "";
                    if (block.Attribute("Zeit") != null)
                    {
                        zeit = block.Attribute("Zeit").Value;
                    }
                    if(block.Attribute("FachNr") != null)
                    {
                        fachNr = Convert.ToInt32(block.Attribute("FachNr").Value);
                    }
                    if (block.Attribute("Typ") != null)
                    {
                        typ = block.Attribute("Typ").Value;
                    }
                    blockList.Add(new Block
                    {
                        Zeit = zeit,
                        Veranstaltung = block.Value,
                        Typ = typ,
                        FachNr = fachNr
                    });
                }
                tagList.Add(new Tag
                {
                    Name = day.Attribute("Name").Value,
                    Blöcke = blockList
                });
            }

            //var tage = new List<Tag>();
            //foreach (var day in days)
            //{
            //    tage.Add(new Tag { Name = day.tag.ToString(), Blöcke = (List<Block>)day.block });
            //}

            DateTime aktualisiert;
            try
            {
                aktualisiert = DateTime.Parse(timeTables.FirstOrDefault().Value);
            }
            catch (Exception) { aktualisiert = DateTime.Now; }

            return new Stundenplan 
                { 
                    Aktualisiert = aktualisiert,
                    FachSemester = Convert.ToInt32(timeTables.FirstOrDefault().Attribute("FachSemester").Value),
                    Studiengang = timeTables.FirstOrDefault().Attribute("Studiengang").Value,
                    Tage = tagList
                };
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