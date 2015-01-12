using Praktikum_3_Disconnected_Data_and_LINQ.Models.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Praktikum_3_Disconnected_Data_and_LINQ.Controllers
{
    public class DiskussionController : Controller
    {
        // GET: Diskussion
        public ActionResult Index(int id = 0)
        {
            ViewBag.DiskussionsID = id;
            var db = new Models.Linq.DataClasses1DataContext();
            IQueryable<Beiträge> beitrag = from p in db.Beiträges 
                                           where p.DiskussionsID == id
                                           orderby p.Änderungsdatum
                                           select p;

            var diskussionen = from p in db.Diskussionens
                               where p.ID == beitrag.First().DiskussionsID
                               select new { p.ForumID, p.Titel};

            ViewBag.ForenID = diskussionen.Single().ForumID;
            ViewBag.Title = diskussionen.Single().Titel;

            return View(beitrag);
        }

        public ActionResult Antworten(int id = 1)
        {
            ViewBag.diskussionID = id;
            ViewBag.success = false;
            return View();
        }

        [HttpPost]
        public ActionResult Antworten(int id, string benutzer, string mitteilung)
        {
            if(id <= 0 || mitteilung.Length == 0)  {   ViewBag.success=false;    }
            else
            {
                ViewBag.diskussionID = id;
                ViewBag.success = true;

                var db = new DataClasses1DataContext();
                var beitrag = new Beiträge   {   Benutzer=benutzer, Mitteilung=mitteilung, 
                    Änderungsdatum=DateTime.Now, DiskussionsID=id    };

                db.Beiträges.InsertOnSubmit(beitrag);
                try
                {
                    db.SubmitChanges();
                }
                catch (Exception)
                {
                }
                        
            }
            return View();
        }
    }
}