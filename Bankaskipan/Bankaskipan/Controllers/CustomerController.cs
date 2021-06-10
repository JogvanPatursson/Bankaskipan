using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using Bankaskipan.Models;
using System.Collections;

namespace Bankaskipan.Controllers
{
	public class CustomerController : Controller
	{
		private DBConnection dbConnection = new DBConnection();

		public IActionResult Index()
		{
			return View("MainProfile", new Person { first_name = "No person selected" });
		}

		[HttpGet]
		public IActionResult Person(string userId)
        {
			Person person = dbConnection.getPersonWithRelatives(userId);

			ViewBag.Person = person;

			person.accounts = dbConnection.getAccounts(userId);

			return View("MainProfile", person);
        }

		public IActionResult Relative(string userId, string relativeId)
		{
			Person Relative = dbConnection.getPersonWithRelatives(relativeId);

			Relative.accounts = dbConnection.getAccounts(relativeId);

			ViewBag.Relative = Relative;

			return Person(userId);
        }

		public IActionResult Account(string userId, string accountId)
        {
			Account account;

			account = dbConnection.getAccount(long.Parse(accountId));

			ViewBag.Account = account;

			return Person(userId);
        }

		public IActionResult RelativeAccount(string userId, string relativeId, string accountId)
		{
			Account account = dbConnection.getAccount(long.Parse(accountId));

			ViewBag.Account = account;

			return Relative(userId, relativeId);
		}

		public IActionResult Action(string userId, string accountId, string type)
		{
			Models.Action action = new Models.Action() { Type = type };

			ViewBag.Action = action;

			return Account(userId, accountId);
        }

		[HttpPost]
		public IActionResult Action(ActionViewModel newAction)
		{
			string type = newAction.Action.Type;

            switch (type)
            {
				case "Deposit":		dbConnection.Deposit(newAction);	break;
				case "Withdraw":	dbConnection.Withdraw(newAction);	break;
				case "Transfer":	dbConnection.Transfer(newAction);	break;
            }

			return RedirectToAction("Account", new { userId = newAction.UserId, accountId = newAction.AccountId });
		}
	}
}
