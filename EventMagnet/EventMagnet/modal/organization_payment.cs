//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EventMagnet.modal
{
    using System;
    using System.Collections.Generic;
    
    public partial class organization_payment
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public organization_payment()
        {
            this.billings1 = new HashSet<billing>();
        }
    
        public int id { get; set; }
        public string payment_method { get; set; }
        public decimal payment_fee { get; set; }
        public string fpx_bank_name { get; set; }
        public string card_number { get; set; }
        public string tng_number { get; set; }
        public string paypal_email { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<billing> billings1 { get; set; }
    }
}