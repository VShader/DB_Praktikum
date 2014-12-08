using Praktikum_2_MVC.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
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
            return View(new Student());
        }

        [HttpPost]
        public ActionResult Erstellen(Student user, string repeatPw)
        {
            if(user.nickname.Length != 0 && user.email.Length != 0 &&  user.password.Equals(repeatPw) && user.einschreibeDatum.Year >= 1900)
            {
                user.password = Crypto.Hash(user.password, "md5");
            }
            user.createInDB();
            return View(user);
        }
	}
}