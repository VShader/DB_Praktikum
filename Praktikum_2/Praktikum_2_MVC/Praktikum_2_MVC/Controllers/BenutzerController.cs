using Praktikum_2_MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Praktikum_2_MVC.Controllers
{
    public class BenutzerController : Controller
    {
        //
        // GET: /Benutzer/
        public ActionResult Index()
        {
            var db = new BenutzerDB();
            var benutzer = db.getBenutzer();
            return View(benutzer);
        }

        public ActionResult Erstellen()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Erstellen(Benutzer user, string repeatPw)
        {
            return View(user);
        }
	}
}