using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Praktikum_2_MVC.Models;

namespace Praktikum_2_MVC.Controllers
{
    public class ModuleController : Controller
    {
        //
        // GET: /Module/
        public ActionResult Index()
        {
            var db = new Praktikum_2_MVC.Models.ModuleDB();
            List<Praktikum_2_MVC.Models.Modul> module = null;
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
            var summ = Praktikum_2_MVC.Models.ProfSummary.Load(prof);
            return View(summ);
        }
	}
}