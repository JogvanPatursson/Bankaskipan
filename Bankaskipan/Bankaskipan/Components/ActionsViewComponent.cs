using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Bankaskipan.Models;

namespace Bankaskipan.Components
{
    public class ActionsViewComponent : ViewComponent
    {
        public IViewComponentResult Invoke(Bankaskipan.Models.Action action)
        {
            return View(action);
        }
    }
}
