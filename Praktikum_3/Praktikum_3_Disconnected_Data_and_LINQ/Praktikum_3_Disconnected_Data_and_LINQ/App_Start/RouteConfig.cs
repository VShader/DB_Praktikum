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
            //    name: "BenutzerUebersicht",
            //    url: "Benutzer/Uebersicht/{id}",
            //    defaults: new { controller = "Benutzer", action = "Uebersicht", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "BenutzerRollenChart",
            //    url: "Benutzer/RollenChart/{id}",
            //    defaults: new { controller = "Benutzer", action = "RollenChart", id = UrlParameter.Optional }
            //);

            //routes.MapRoute(
            //    name: "Benutzer",
            //    url: "Benutzer/{buchstabe}",
            //    defaults: new { controller = "Benutzer", action = "Index", buchstabe = "" }
            //);


            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );

        }
    }
}
