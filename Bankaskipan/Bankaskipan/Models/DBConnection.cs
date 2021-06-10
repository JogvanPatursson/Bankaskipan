using Npgsql;
using Renci.SshNet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Bankaskipan.Models
{
	public class DBConnection
	{
		private NpgsqlConnection connection;

		public DBConnection()
        {
			ConnectToDB();
        }

		public void ConnectToDB()
		{
			var sshServer = "setur.cloud.fo";
			var sshUserName = "brandur";
			var sshPassword = "brandur";
			var databaseServer = "localhost";
			var databaseUserName = "postgres";
			var databasePassword = "brandur";

			NpgsqlConnectionStringBuilder csb = new NpgsqlConnectionStringBuilder
			{
				Host = "localhost",
				Port = 5432,
				Database = "dogebank",
				Username = databaseUserName,
				CommandTimeout = 1024,
				Timeout = 1024,
				NoResetOnClose = true,
				IntegratedSecurity = true,
				Password = databasePassword
			};


			connection = new NpgsqlConnection(csb.ConnectionString);
			//using var connection = new NpgsqlConnection("Host=localhost;Database=dogebank;Port=5432;Username=brandur;Password=brandur;");
			//connection.Open();

			/*var (sshClient, localPort) = ConnectSsh(sshServer, sshUserName, sshPassword, databaseServer: databaseServer);
			using (sshClient)
			{
				NpgsqlConnectionStringBuilder csb = new NpgsqlConnectionStringBuilder
				{
					Host = "localhost",
					Port = 5432,
					Database = "bank",
					Username = databaseUserName,
					CommandTimeout = 1024,
					Timeout = 1024,
					NoResetOnClose = true,
					IntegratedSecurity = true,
					Password = databasePassword
				};


				connection = new NpgsqlConnection(csb.ConnectionString);
				//using var connection = new NpgsqlConnection("Host=localhost;Database=dogebank;Port=5432;Username=brandur;Password=brandur;");
				connection.Open();
			}*/
		}

		public static (SshClient SshClient, uint Port) ConnectSsh(string sshHostName, string sshUserName, string sshPassword = null,
					string sshKeyFile = null, string sshPassPhrase = null, int sshPort = 22007, string databaseServer = "localhost", int databasePort = 22007)
		{
			// check arguments
			if (string.IsNullOrEmpty(sshHostName))
				throw new ArgumentException($"{nameof(sshHostName)} must be specified.", nameof(sshHostName));
			if (string.IsNullOrEmpty(sshHostName))
				throw new ArgumentException($"{nameof(sshUserName)} must be specified.", nameof(sshUserName));
			if (string.IsNullOrEmpty(sshPassword) && string.IsNullOrEmpty(sshKeyFile))
				throw new ArgumentException($"One of {nameof(sshPassword)} and {nameof(sshKeyFile)} must be specified.");
			if (string.IsNullOrEmpty(databaseServer))
				throw new ArgumentException($"{nameof(databaseServer)} must be specified.", nameof(databaseServer));

			// define the authentication methods to use (in order)
			var authenticationMethods = new List<AuthenticationMethod>();
			if (!string.IsNullOrEmpty(sshKeyFile))
			{
				authenticationMethods.Add(new PrivateKeyAuthenticationMethod(sshUserName,
					new PrivateKeyFile(sshKeyFile, string.IsNullOrEmpty(sshPassPhrase) ? null : sshPassPhrase)));
			}
			if (!string.IsNullOrEmpty(sshPassword))
			{
				authenticationMethods.Add(new PasswordAuthenticationMethod(sshUserName, sshPassword));
			}

			// connect to the SSH server
			var sshClient = new SshClient(new ConnectionInfo(sshHostName, sshPort, sshUserName, authenticationMethods.ToArray()));
			sshClient.Connect();

			// forward a local port to the database server and port, using the SSH server
			var forwardedPort = new ForwardedPortLocal("localhost", 6789, databaseServer, (uint)databasePort);
			sshClient.AddForwardedPort(forwardedPort);
			forwardedPort.Start();

			return (sshClient, forwardedPort.BoundPort);
		}

		public Person getPersonWithRelatives(string userId)
        {
			connection.Open();
			NpgsqlCommand cmd = new NpgsqlCommand("SELECT person_first_name, person_last_name FROM person, customer WHERE person.person_id = customer.person_id AND customer.customer_id = @userId;", connection);
			cmd.Parameters.AddWithValue("userId", long.Parse(userId));

			NpgsqlDataReader reader = cmd.ExecuteReader();

			Person person = null;

			// Get person
			if (reader.HasRows) {
				while (reader.Read())
				{
					person = new Person()
					{
						userId = long.Parse(userId),
						first_name = (string)reader["person_first_name"],
						last_name = (string)reader["person_last_name"]
					};
					person.relatives = new List<Person>();
				}
			}

			connection.Close();
			connection.Open();

			if (person == null)
            {
				person = new Person()
				{
					first_name = "No person selected or exists"
				};
            } else
            {
				cmd = new NpgsqlCommand("SELECT showAllRelatives(@userId);", connection);
				cmd.Parameters.AddWithValue("userId", person.userId);

				reader = cmd.ExecuteReader();

				if (reader.HasRows)
				{
					while (reader.Read())
					{
						var row = (Object[])reader["showallrelatives"];

						person.relatives.Add(new Person()
						{
							first_name = (string)row[1],
							last_name = (string)row[2],
							userId = (long)row[3]
						});;
					}
				}

				connection.Close();
			}

			return person;
        }

		public List<Account> getAccounts(string userId)
        {
			connection.Open();
			
			List<Account> accounts = new List<Account>();

			NpgsqlCommand cmd = new NpgsqlCommand(	"SELECT showAllAccounts(@userId) ", connection);
			cmd.Parameters.AddWithValue("userId", long.Parse(userId));

			NpgsqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
				while (reader.Read())
				{
					var row = (Object[])reader["showAllAccounts"];

					accounts.Add(new Account() { account_id = (long)row[0] });
				}
            }

			connection.Close();

			return accounts;
        }

		public Account getAccount(long account)
		{
					
			NpgsqlCommand cmd;
			NpgsqlDataReader reader;
			List<Transaction> transactions = new List<Transaction>();

			Account tempAccount = new Account();

			connection.Open();

			cmd = new NpgsqlCommand("SELECT * FROM account WHERE account_id = @account", connection);
			cmd.Parameters.AddWithValue("account", account);
			reader = cmd.ExecuteReader();

			if (reader.HasRows)
			{
				while (reader.Read())
				{
					tempAccount.account_id = (long)reader["account_id"];
					tempAccount.balance = (float)reader["balance"];
				}
			}

			connection.Close();
			connection.Open();

			cmd = new NpgsqlCommand("SELECT getAllTransactions(@account);", connection);
			cmd.Parameters.AddWithValue("account", account);
			reader = cmd.ExecuteReader();

			if (reader.HasRows)
			{
				while (reader.Read())
				{
					var row = (Object[])reader["getAllTransactions"];

					transactions.Add(new Transaction() { transaction_id = (long)row[0], type = (string)row[1], transaction_time = (System.DateTime)row[2], amount = (float)row[3] });
				}
			}

			tempAccount.transactions = transactions;

			connection.Close();

			return tempAccount;
		}

		public void Deposit(ActionViewModel action)
        {
			connection.Open();

			NpgsqlCommand cmd = new NpgsqlCommand("CALL deposit(@fromAccount, @amount);", connection);
			cmd.Parameters.AddWithValue("fromAccount", long.Parse(action.Action.FromAccount));
			cmd.Parameters.AddWithValue("amount", (float)action.Action.Amount);

			cmd.ExecuteReader();

			connection.Close();
		}

		public void Withdraw(ActionViewModel action)
		{
			connection.Open();

			NpgsqlCommand cmd = new NpgsqlCommand("CALL withdraw(@fromAccount, @amount);", connection);
			cmd.Parameters.AddWithValue("fromAccount", long.Parse(action.Action.FromAccount));
			cmd.Parameters.AddWithValue("amount", (float)action.Action.Amount);

			cmd.ExecuteReader();

			connection.Close();
		}

		public void Transfer(ActionViewModel action)
		{
			connection.Open();

			NpgsqlCommand cmd = new NpgsqlCommand("CALL transfers(@fromAccount, @toAccount, @amount);", connection);
			cmd.Parameters.AddWithValue("fromAccount", long.Parse(action.Action.FromAccount));
			cmd.Parameters.AddWithValue("toAccount", long.Parse(action.Action.ToAccount));
			cmd.Parameters.AddWithValue("amount", (float)action.Action.Amount);

			cmd.ExecuteReader();

			connection.Close();
		}
	}
}