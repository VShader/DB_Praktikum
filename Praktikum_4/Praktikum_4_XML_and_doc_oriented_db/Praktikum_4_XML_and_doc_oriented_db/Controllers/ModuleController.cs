using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Praktikum_4_XML_and_doc_oriented_db.Models;

namespace Praktikum_4_XML_and_doc_oriented_db.Controllers
{
    public class ModuleController : Controller
    {
        //
        // GET: /Module/
        public ActionResult Index()
        {
            var db = new Praktikum_4_XML_and_doc_oriented_db.ModuleDB();
            List<Praktikum_4_XML_and_doc_oriented_db.Modul> module = null;
            try
            {
                module = db.getModul();
            }   catch(Exception e)
            {

            }
            return View(module);
        }

        public ActionResult ProfSummary(string prof)
        {
            var summ = Praktikum_4_XML_and_doc_oriented_db.ProfSummary.Load(prof);
            return View(summ);
        }
	}
}