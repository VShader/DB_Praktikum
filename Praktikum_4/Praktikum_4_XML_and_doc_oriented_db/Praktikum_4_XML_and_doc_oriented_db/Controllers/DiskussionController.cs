using Praktikum_4_XML_and_doc_oriented_db.Models.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Praktikum_4_XML_and_doc_oriented_db.Controllers
{
    public class DiskussionController : Controller
    {
        // GET: Diskussion
        public ActionResult Index(int id = 0)
        {
            var db = new Models.Linq.DataClasses1DataContext();
            if(Session["Diskussion"+id] == null)
            {
                Session["Diskussion" + id] = true;
                db.DiskussionGesichtet(id);
            }
            IQueryable<Beiträge> beitrag = null;
            try
            {
                ViewBag.DiskussionsID = id;
                beitrag = from p in db.Beiträges
                        where p.DiskussionsID == id
                        orderby p.Änderungsdatum
                        select p;

                var diskussionen = from p in db.Diskussionens
                                where p.ID == beitrag.First().DiskussionsID
                                select new { p.ForumID, p.Titel };

                ViewBag.ForenID = diskussionen.First().ForumID;
                ViewBag.Title = diskussionen.First().Titel;
                if (beitrag.Count() == 0) { ViewBag.ERROR = "Daten können nicht angezeigt werden"; }
            }
            catch(Exception e)
            {
                ViewBag.ERROR = "Daten können nicht angezeigt werden";
                Response.Redirect("~/Foren");
            }

            return View(beitrag);
        }


        public ActionResult Antworten(int id = 1)
        {
            ViewBag.diskussionID = id;
            ViewBag.success = false;
            return View();
        }


        [HttpPost]
        public ActionResult Antworten(int id, string mitteilung)
        {
            if(id <= 0 || mitteilung.Length == 0)  {   ViewBag.success=false;    }
            else
            {
                ViewBag.diskussionID = id;
                ViewBag.success = true;

                string nickname = (string)Session["Nickname"];

                var db = new DataClasses1DataContext();
                var beitrag = new Beiträge   {   Benutzer=nickname, Mitteilung=mitteilung, 
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