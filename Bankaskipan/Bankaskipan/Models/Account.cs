using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Bankaskipan.Models
{
    public class Account
    {
        public long account_id { get; set; }
        public float balance { get; set; }
        public string type { get; set; }
        public List<Transaction> transactions { get; set; }
    }
}
