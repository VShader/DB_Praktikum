using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Praktikum_3_Disconnected_Data_and_LINQ
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Dokumente",
                url: "Dokumente/{kategorie}",
                defaults: new { controller = "Dokumente", action = "Index", kategorie = "Vorlesung" }
            );

            routes.MapRoute(
                name: "ProfSummary",
                url: "Module/ProfSummary/{prof}",
                defaults: new { controller = "Module", action = "ProfSummary", prof = "" }
            );

            //routes.MapRoute(
            //    name: "BenutzerListe",
            //    url: "Benutzer/BenutzerListe/{buchstabe}",
            //    defaults: new { controller = "Benutzer", action = "BenutzerListe", buchstabe = "A" }
            //);

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

        }
    }
}
