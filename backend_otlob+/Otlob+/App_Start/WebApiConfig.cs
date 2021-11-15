using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

namespace Otlob_
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{Method}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
        }
    }
}
