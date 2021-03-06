using Newtonsoft.Json;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Web.Http.Cors;

namespace OtlobPlus.Models
{
    public class UserController : ApiController
    {
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
       // Regex emailval = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
        //Regex numval = new Regex(@"[\d]");
        //Regex textval = new Regex(@"^[a-zA-Z]*$");
        //Regex dateval = new Regex(@"^([0]?[1-9]|[1|2][0-9]|[3][0|1])[./-]([0]?[1-9]|[1][0-2])[./-]([0-9]{4}|[0-9]{2})$");
        


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage Orders()
        {
            try
            {
                Entities entity = new Entities();

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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage Items()
        {
            try
            {
                Entities entity = new Entities();
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage Order(int? orderID)
        {
            try
            {
                Entities entity = new Entities();
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



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        public HttpResponseMessage OrderbyID(App_Start.myorders emp)
        {
            try
            {
                Entities entity = new Entities();
                var OrdersbyID = entity.getOrderByUserID(emp.UserID);
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
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage AllRestaurant()
        {
            try
            {
                Entities entity = new Entities();

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
        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        public HttpResponseMessage createuser(App_Start.newUser emp)
        {
            try
            {
                Entities entity = new Entities();
                int created = entity.AddnewUser(emp.FirstName, emp.LastName, emp.dateOfBirth, emp.Password);
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        public HttpResponseMessage loginuser(App_Start.loginuser emp)//[FromBody] createmodel model
        {
            try
            {
                Entities entity = new Entities();
                var logedin = entity.isPasswordAuthenticated(emp.UserID, emp.Password).FirstOrDefault().Value;
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]

        public HttpResponseMessage AllItems()
        {
            try
            {
                Entities entity = new Entities();

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


        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]

        public HttpResponseMessage returnUser(App_Start.userclass emp)
        {
            try
            {
                Entities entity = new Entities();
                var Items = entity.getUser(emp.UserID).ElementAt(0);
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



        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        public HttpResponseMessage getyourID(App_Start.returnid emp)
        {
            try
            {
                Entities entity = new Entities();
                var ids = entity.returnUserID(emp.Password);
                var json = JsonConvert.SerializeObject(ids);
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpPost]
        public HttpResponseMessage CreateOrder(App_Start.orderdetails emp)//[FromBody] createmodel model
        {
            try
            {
                Entities entity = new Entities();
                int NewOrder = entity.AddnewOrder(emp.RestaurantID, emp.UserID, emp.OrderPrice, emp.StatusID, emp.CreationDate, emp.ModifiedDate, emp.isDeleted, emp.adminID, emp.Fees);
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage CheckAdmin(int UserID)
        {
            try
            {
                Entities entity = new Entities();
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage UpdateStatusby(int OrderID, int StatusID)
        {
            try
            {
                Entities entity = new Entities();
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

        [EnableCors(origins: "*", headers: "*", methods: "*")]
        [HttpGet]
        public HttpResponseMessage OrderbyorderID(int OrderID)
        {
            try
            {
                Entities entity = new Entities();
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