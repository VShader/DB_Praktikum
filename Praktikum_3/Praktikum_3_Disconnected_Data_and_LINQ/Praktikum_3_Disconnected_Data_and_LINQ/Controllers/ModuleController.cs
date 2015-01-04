using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Praktikum_3_Disconnected_Data_and_LINQ.Models;

namespace Praktikum_3_Disconnected_Data_and_LINQ.Controllers
{
    public class ModuleController : Controller
    {
        //
        // GET: /Module/
        public ActionResult Index()
        {
            var db = new Praktikum_3_Disconnected_Data_and_LINQ.ModuleDB();
            List<Praktikum_3_Disconnected_Data_and_LINQ.Modul> module = null;
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
            var summ = Praktikum_3_Disconnected_Data_and_LINQ.ProfSummary.Load(prof);
            return View(summ);
        }
	}
}