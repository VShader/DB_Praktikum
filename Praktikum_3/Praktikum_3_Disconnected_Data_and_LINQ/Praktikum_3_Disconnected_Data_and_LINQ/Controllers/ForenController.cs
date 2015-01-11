using Praktikum_3_Disconnected_Data_and_LINQ.Models.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Praktikum_3_Disconnected_Data_and_LINQ.Controllers
{
    public class ForenController : Controller
    {
        // GET: Foren
        public ActionResult Index(int id=0)
        {
            var db = new Models.Linq.DataClasses1DataContext();
            IQueryable<Foren> foren = null;
            IQueryable<Foren> aktuellesForum = null;
            IQueryable<Diskussionen> diskussionen = null;
            if(id == 0)
            {
                foren = from p in db.Forens
                        where p.OberforumID == null
                        select  p ;
            }
            else
            {
                foren = from p in db.Forens
                        where p.OberforumID == id
                        select p ;
                aktuellesForum = from p in db.Forens
                                 where p.ID == id
                                 select p;
                diskussionen = from p in db.Diskussionens
                               where p.ForumID == aktuellesForum.First().ID
                               select p;
            }
            var data = new UnterForenUndDiskussionen { Foren = foren.AsEnumerable()};
            if (aktuellesForum != null) 
            { 
                data.ForumAktuell = aktuellesForum.First();
                data.Diskussionen = diskussionen.AsEnumerable();
            }
            
            
            return View(data);
        }


        public ActionResult NeueDiskussion(int id = 1)
        {
            ViewBag.forumID = id;
            ViewBag.success = false;
            return View();
        }

        [HttpPost]
        public ActionResult NeueDiskussion(int id, string benutzer, string diskussionstitel, string mitteilung)
        {
            if(id <= 0)  {   Redirect("~/Foren");    }
            ViewBag.forumID = id;
            ViewBag.success = true;

            var db = new DataClasses1DataContext();

            var diskussion = new Diskussionen { Titel = diskussionstitel, ForumID = id };
            db.Diskussionens.InsertOnSubmit(diskussion);
            try 
	        {	        
		        db.SubmitChanges();
	        }
	        catch (Exception)
	        {
	        }

            var getDiskussionID = from p in db.Diskussionens
                                  where p.Titel == diskussionstitel
                                  select p.ID;
            var beitrag = new Beiträge   {   Benutzer=benutzer, Mitteilung=mitteilung, Änderungsdatum=DateTime.Now, 
                DiskussionsID=getDiskussionID.First()};
            db.Beiträges.InsertOnSubmit(beitrag);
            try
            {
                db.SubmitChanges();
            }
            catch (Exception)
            {
            }
                        
            return View();
        }
    }
}