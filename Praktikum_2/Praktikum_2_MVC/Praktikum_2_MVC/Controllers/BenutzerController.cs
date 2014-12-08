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
            var errorList = new List<string>();
            if(string.IsNullOrEmpty(user.nickname))
            {
                errorList.Add("Benutzername benötigt");
            }
            if(string.IsNullOrEmpty(user.email))
            {
                errorList.Add("E-Mail benötigt");
            }
            if(string.IsNullOrEmpty(user.password) || string.IsNullOrEmpty(repeatPw) || !user.password.Equals(repeatPw))
            {
                errorList.Add("Passwort passt nicht zur Wiederholung");
            }
            if(user.einschreibeDatum.Year < 1900)
            {
                errorList.Add("Muss vor 1900 eingeschrieben sein");
            }

            if (errorList.Count == 0)
            {
                user.password = Crypto.Hash(user.password, "md5");
                user.createInDB();
                ViewBag.Created = true;
            }   else
            {
                ViewBag.ErrorList = errorList;
            }
            return View(user);
        }
	}
}