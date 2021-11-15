using Newtonsoft.Json;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Web.Http.Cors;

namespace Otlob_.Controllers
{

    public class User : ApiController
    {
        
        Regex emailval = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
        Regex numval = new Regex(@"[\d]");
        Regex textval = new Regex(@"^[a-zA-Z]*$");
        Regex dateval = new Regex(@"^([0]?[1-9]|[1|2][0-9]|[3][0|1])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$");


        [EnableCors(origins: "*", headers: "*", methods: "*")]



        [HttpGet]
        public HttpResponseMessage Orders()
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var Orders = entity.getallOrders();
                var json = JsonConvert.SerializeObject(Orders);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }

        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage Items()
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var Items = entity.getItems();
                var json = JsonConvert.SerializeObject(Items);
                var response = this.Request.CreateResponse(HttpStatusCode.OK, json);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }

        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage Order(int? orderID)
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var Order = entity.getOrder(orderID);
                var json = JsonConvert.SerializeObject(Order);
                var response = this.Request.CreateResponse(HttpStatusCode.OK, json);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }


        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage OrderbyID(int UserID)
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var OrdersbyID = entity.getOrderByUserID(UserID);
                var json = JsonConvert.SerializeObject(OrdersbyID);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage AllRestaurant()
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();

                var Users = entity.getRestaurants();
                var json = JsonConvert.SerializeObject(Users);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpPost]
        public HttpResponseMessage createuser(string FirstName, string LastName, DateTime dateOfBirth, string Password, int? TypeID)
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                int created = entity.AddnewUser(FirstName, LastName, dateOfBirth, Password);
                var json = JsonConvert.SerializeObject(created);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpPost]
        public HttpResponseMessage loginuser(int UserID, string Password)//[FromBody] createmodel model
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var logedin = entity.isPasswordAuthenticated(UserID, Password).FirstOrDefault().Value;
                var json = JsonConvert.SerializeObject(logedin);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;

            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /*
        public class createmodel
        {
            string FirstName { get; set; }
            string LastName { get; set; }
            DateTime dateOfBirth { get; set; }
            string Password { get; set; }
            int TypeID { get; set; }
        }
        */
        //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]

        public HttpResponseMessage AllItems()
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();

                var Items = entity.getItems();
                var json = JsonConvert.SerializeObject(Items);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }



        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpPost]
        public HttpResponseMessage CreateOrder(int RestaurantID, int UserID, float OrderPrice, int StatusID, DateTime CreationDate, DateTime? ModifiedDate, bool? isDeleted, int? adminID, float Fees)//[FromBody] createmodel model
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                int NewOrder = entity.AddnewOrder(RestaurantID, UserID, OrderPrice, StatusID, CreationDate, ModifiedDate, isDeleted, adminID, Fees);
                var json = JsonConvert.SerializeObject(NewOrder);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage CheckAdmin(int UserID)
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var adminID = entity.isAdminID(UserID).FirstOrDefault().Value;
                var json = JsonConvert.SerializeObject(adminID);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }
        }

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage UpdateStatusby(int OrderID, int StatusID)
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var byUpdatestatus = entity.updateStatus(OrderID, StatusID);
                var json = JsonConvert.SerializeObject(byUpdatestatus);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK);
            }

        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        [EnableCors(origins: "", headers: "", methods: "*")]
        [HttpGet]
        public HttpResponseMessage OrderbyorderID(int OrderID)
        {
            try
            {
                OtlobPlus1 entity = new OtlobPlus1();
                var byOrderID = entity.getOrder(OrderID);
                var json = JsonConvert.SerializeObject(byOrderID);
                var response = this.Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, Encoding.UTF8, "application/json");
                return response;
            }

            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }
        }
    }
}

