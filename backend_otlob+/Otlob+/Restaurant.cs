//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Otlob_
{
    using System;
    using System.Collections.Generic;
    
    public partial class Restaurant
    {
        public Restaurant()
        {
            this.Items = new HashSet<Item>();
            this.Orders = new HashSet<Order>();
        }
    
        public int RestaurantID { get; set; }
        public string RestaurantName { get; set; }
        public string RestaurantLocation { get; set; }
        public bool isDeleted { get; set; }
        public bool isActive { get; set; }
    
        public virtual ICollection<Item> Items { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
    }
}
