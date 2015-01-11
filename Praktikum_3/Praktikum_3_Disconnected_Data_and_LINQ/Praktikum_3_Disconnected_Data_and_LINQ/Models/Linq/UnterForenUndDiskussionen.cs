using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Praktikum_3_Disconnected_Data_and_LINQ.Models.Linq
{
    public class UnterForenUndDiskussionen
    {
        public Foren ForumAktuell { get; set; }
        public IEnumerable<Foren> Foren { get; set; }
        public IEnumerable<Diskussionen> Diskussionen { get; set; }
    }
}