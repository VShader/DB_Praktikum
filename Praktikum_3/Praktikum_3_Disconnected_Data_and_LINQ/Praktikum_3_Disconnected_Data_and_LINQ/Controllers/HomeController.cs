using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Praktikum_3_Disconnected_Data_and_LINQ.Models;

namespace Praktikum_3_Disconnected_Data_and_LINQ.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login(Boolean logout=false)
        {
            if(logout == true)
            {
                Session["authenticated"] = null;
            }
            return View();
        }
        [HttpPost]
        public ActionResult Login(Benutzer user)
        {
            var db = new BenutzerDB();
            try
            {
                if (db.authenticateBenutzer(user))
                {
                    Session["authenticated"] = "ok";
                }
            }   catch(BenutzerDontExistException)
            {
                return View();
            }   catch(BenutzerPasswordException)
            {
                return View();
            }
            return View();
        }
	}
}