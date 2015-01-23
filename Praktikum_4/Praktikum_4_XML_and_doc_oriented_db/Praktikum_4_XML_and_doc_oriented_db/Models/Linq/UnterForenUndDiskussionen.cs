using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Praktikum_4_XML_and_doc_oriented_db.Models.Linq
{
    public class UnterForenUndDiskussionen
    {
        public Foren ForumAktuell { get; set; }
        public IEnumerable<Foren> Foren { get; set; }
        public IEnumerable<Diskussionen> Diskussionen { get; set; }
    }
}