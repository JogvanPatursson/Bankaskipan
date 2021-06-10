using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Bankaskipan.Models;

namespace Bankaskipan.Components
{
    public class ActionsModelViewComponent : ViewComponent
    {
        public IViewComponentResult Invoke(ActionViewModel action)
        {
            return View(action);
        }
    }
}
