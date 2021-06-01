using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Bankaskipan.Models
{
    public class Action
    {
        public double Amount { get; set; }
        public string Type { get; set; }
        public string FromAccount { get; set; }
        public string ToAccount { get; set; }
    }
}
