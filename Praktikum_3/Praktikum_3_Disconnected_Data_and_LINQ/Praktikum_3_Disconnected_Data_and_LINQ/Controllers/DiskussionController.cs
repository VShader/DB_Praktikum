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
        public ActionResult Index()
        {
            return View();
        }
    }
}