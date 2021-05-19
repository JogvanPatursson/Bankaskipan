-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGECOIN----------------
-----------------------------------
------------GROUP 7----------------
-----------------------------------

--Get all transactions of customer--
CREATE OR REPLACE FUNCTION getAllTransactions(personal_number_id_variable varchar(255))
    SELECT *
    FROM Transactions
    WHERE transaction_id = (
        SELECT transaction_id
        FROM AccountPerformsTransaction
        WHERE account_id = (
            SELECT account_id
            FROM Account
            WHERE account_id = (
                SELECT account_id
                FROM CustomerHasAccount
                WHERE customer_id = (
                    SELECT customer_id
                    FROM Customer
                    WHERE person_id = (
                        SELECT person_id
                        FROM Person
                        WHERE personal_number_id = (
                            SELECT personal_number_id
                            FROM PersonalNumber
                            WHERE personal_number_id = personal_number_id_variable;
                        )

                    )
                )
            )
        )
    )

--Show all accounts of person--
CREATE OR REPLACE FUNCTION showAllAccounts(personal_number_id_variable varchar(255))