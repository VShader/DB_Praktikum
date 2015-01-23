using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Praktikum_4_XML_and_doc_oriented_db.Models;

namespace Praktikum_4_XML_and_doc_oriented_db.Controllers
{
    public class StundenplanController : Controller
    {
        // GET: Stundenplan
        public ActionResult Index()
        {
            var stundenplan = Stundenplan.GetMockupDaten();
            return View(stundenplan);
        }
    }
}