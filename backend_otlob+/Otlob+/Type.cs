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
    
    public partial class Type
    {
        public Type()
        {
            this.Users = new HashSet<User>();
        }
    
        public int TypeID { get; set; }
        public string Type1 { get; set; }
    
        public virtual ICollection<User> Users { get; set; }
    }
}
