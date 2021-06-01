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

		public IActionResult Person(string name)
        {
			Person person = dbConnection.getPersonWithRelatives(name);

			ViewBag.Person = person;

			person.accounts = dbConnection.getAccounts(name);

			return View("MainProfile", person);
        }

		public IActionResult Relative(string person, string relative)
        {
			Person tempPerson = dbConnection.getPersonWithRelatives(person);

			tempPerson.relative = relative;

			ViewBag.Person = tempPerson;
			ViewBag.Relative = relative;

			return View("Relative", tempPerson);
        }

		public IActionResult Account(string person, string accountId)
        {
			Account account;

			account = dbConnection.getAccount(Int32.Parse(accountId));

			ViewBag.Account = account;

			return Person(person);
        }

		public IActionResult RelativeAccount(string main, string relative, string accountId)
		{
			Person person = dbConnection.getPersonWithRelatives(main);

			person.relative = relative;

			ViewBag.Person = person;
			ViewBag.Relative = relative;

			return View("Relative", person);
		}

		public IActionResult Action(string person, string accountId, string type)
		{
			Bankaskipan.Models.Action action = new Bankaskipan.Models.Action() { Type = type };

			ViewBag.Action = action;

			return Account(person, accountId);
        }
	}
}
