using System;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Bankaskipan.Models
{
    public class Person
    {
        public long userId { get; set; }
        [Key]
        public long person_id { get; set; }

        public string first_name { get; set; }

        public string last_name { get; set; }

        public DateTime date_of_birth { get; set; }

        public string address { get; set; }

        public List<Person> relatives { get; set; }

        public List<Account> accounts { get; set; }

        public string relative { get; set; }
    }
}
