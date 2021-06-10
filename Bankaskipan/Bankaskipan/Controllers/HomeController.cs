using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Bankaskipan.Models;

namespace Bankaskipan.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Index(LoginForm formValues)
        {
            string userId = formValues.UserId;
            return RedirectToAction("Person", "Customer", new { userId = userId });
        }
    }
}
