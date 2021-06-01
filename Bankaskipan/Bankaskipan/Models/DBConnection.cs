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

		public Person getPersonWithRelatives(string name)
        {
			connection.Open();
			NpgsqlCommand cmd = new NpgsqlCommand("SELECT * FROM person WHERE person_first_name = @name;", connection);
			cmd.Parameters.AddWithValue("name", name);

			NpgsqlDataReader reader = cmd.ExecuteReader();

			Person person = null;

			// Get person
			if (reader.HasRows) {
				while (reader.Read())
				{
					person = new Person()
					{
						person_id = (int)reader["person_id"],
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
				cmd = new NpgsqlCommand("SELECT p1.* FROM person p1, person p2, spouse s WHERE p1.person_id = s.spouse_2_id AND s.spouse_1_id = p2.person_id AND p2.person_first_name = @name;", connection);
				cmd.Parameters.AddWithValue("name", person.first_name);

				reader = cmd.ExecuteReader();

				if (reader.HasRows)
				{
					while (reader.Read())
					{
						person.relatives.Add(new Person()
						{
							person_id = (int)reader["person_id"],
							first_name = (string)reader["person_first_name"],
							last_name = (string)reader["person_last_name"]
						});
					}
				}

				connection.Close();
				connection.Open();
				cmd = new NpgsqlCommand("SELECT p1.* FROM person p1, person p2, parent pa WHERE p1.person_id = pa.child_id AND pa.parent_id = p2.person_id AND p2.person_first_name = @name;", connection);
				cmd.Parameters.AddWithValue("name", person.first_name);

				reader = cmd.ExecuteReader();

				if (reader.HasRows)
				{
					while (reader.Read())
					{
						person.relatives.Add(new Person()
						{
							person_id = (int)reader["person_id"],
							first_name = (string)reader["person_first_name"],
							last_name = (string)reader["person_last_name"]
						});
					}
				}

				connection.Close();
			}

			return person;
        }

		public List<Account> getAccounts(string name)
        {
			connection.Open();
			
			List<Account> accounts = new List<Account>();

			NpgsqlCommand cmd = new NpgsqlCommand(	"SELECT a.* "+
													"FROM account a, customerhasaccount has, customer c, person p " +
													"WHERE a.account_id = has.account_id " +
													"AND has.customer_id = c.customer_id " +
													"AND c.person_id = p.person_id " +
													"AND p.person_first_name = @name; ", connection);
			
			
			cmd.Parameters.AddWithValue("name", name);

			NpgsqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
				while (reader.Read())
				{
					accounts.Add(new Account() { account_id = (int)reader["account_id"] });
				}
            }

			return accounts;
        }

		public Account getAccount(int account)
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
					tempAccount.account_id = (int)reader["account_id"];
					tempAccount.balance = (double)(System.Single)reader["balance"];
					tempAccount.type = (string)reader["account_type"];
					//accounts.Add(new Account() { account_id = (int)reader["account_id"] });
				}
			}

			connection.Close();
			connection.Open();

			cmd = new NpgsqlCommand("SELECT t.* FROM transaction t, accountperformstransaction p, account a WHERE t.transaction_id = p.transaction_id AND p.account_id = a.account_id AND a.account_id = @account;", connection);
			cmd.Parameters.AddWithValue("account", account);
			reader = cmd.ExecuteReader();

			if (reader.HasRows)
			{
				while (reader.Read())
				{
					transactions.Add(new Transaction() { transaction_id = (int)reader["transaction_id"], type = (string)reader["transaction_type"], amount = (double)(System.Single)reader["transaction_amount"] });
				}
			}

			tempAccount.transactions = transactions;

			connection.Close();

			return tempAccount;
		}
	}
}