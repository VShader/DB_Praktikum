using Praktikum_4_XML_and_doc_oriented_db.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Praktikum_4_XML_and_doc_oriented_db.Controllers
{
    public class DokumenteController : Controller
    {
        public ActionResult Index(string kategorie)
        {
            var dokumenteTableAdapter = new Models.DataSet1TableAdapters.DokumenteTableAdapter();
            var dataset = dokumenteTableAdapter.GetData(kategorie);

            ViewBag.kategorie = kategorie;
            return View(dataset);
        }
	}
}