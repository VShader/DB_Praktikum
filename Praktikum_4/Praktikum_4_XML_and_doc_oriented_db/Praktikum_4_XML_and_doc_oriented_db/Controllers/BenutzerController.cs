﻿using Praktikum_4_XML_and_doc_oriented_db.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace Praktikum_4_XML_and_doc_oriented_db.Controllers
{
    public class BenutzerController : Controller
    {
        public ActionResult Index(string buchstabe = "")
        {
            var dataSet = new Models.DataSet1TableAdapters.BenutzerrollenTableAdapter();
            Models.DataSet1.BenutzerrollenDataTable benutzer;
            if(buchstabe.Length == 0){  benutzer = dataSet.GetData();   }   
            else   
            {   
                benutzer = dataSet.GetDataByBuchstabe(buchstabe);
                ViewBag.buchstabe = buchstabe;
            }

            return View(benutzer);
        }

                // GET: /Benutzer/
        public ActionResult Uebersicht()
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
                errorList.Add("Muss nach 1900 eingeschrieben sein");
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

        public ActionResult RollenChart()
        {
            var dataSet = new Models.DataSet1TableAdapters.BenutzerrollenTableAdapter();
            var tabelle = dataSet.GetData();

            int anzahlMitarbeiter = 0;
            int anzahlProf = 0;
            int anzahlStudent = 0;
            foreach(var item in tabelle)
            {
                if (item.Rolle == "Mitarbeiter") { ++anzahlMitarbeiter; }
                else if (item.Rolle == "Professor") { ++anzahlProf; }
                else if (item.Rolle == "Student") { ++anzahlStudent; }
            }
            List<int> anzahl = new List<int> {  anzahlMitarbeiter, anzahlProf, anzahlProf };
            return View(anzahl);
        }
	}
}