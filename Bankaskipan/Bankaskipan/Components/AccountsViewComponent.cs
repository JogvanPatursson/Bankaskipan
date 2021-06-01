using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Bankaskipan.Models;

namespace Bankaskipan.Components
{
    public class AccountsViewComponent : ViewComponent
    {
        private List<Account> accounts;
        private DBConnection dbConnection = new DBConnection();

        public AccountsViewComponent()
        {
            
        }

        public IViewComponentResult Invoke(string name)
        {
            accounts = dbConnection.getAccounts(name);

            return View(accounts);
        }
    }

    
}
