using System;

namespace App_Start
{
    public class orderdetails
    {
       public  int RestaurantID { get; set; }
         public int UserID { get; set; }
        public float OrderPrice { get; set; }
        public int StatusID { get; set; }
        public DateTime CreationDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public bool isDeleted { get; set; }
        public int? adminID { get; set; }
        public float Fees { get; set; }
    }
}