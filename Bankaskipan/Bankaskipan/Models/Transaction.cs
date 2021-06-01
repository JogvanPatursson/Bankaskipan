using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Bankaskipan.Models
{
    public class Transaction
    {
        [Key]
        public long transaction_id { get; set; }
        public string type { get; set; }
        public DateTime transaction_time { get; set; }
        public double amount { get; set; }
    }
}
