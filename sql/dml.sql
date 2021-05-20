-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGEBANK----------------
-----------------------------------
------------GROUP 7----------------
-----------------------------------

-----------Functions---------------


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
CREATE OR REPLACE FUNCTION showAllAccounts(person_id_variable varchar(255))
    SELECT account_id
    FROM Account
    WHERE account_id = (
        SELECT account_id
        FROM CustomerHasAccount
        WHERE customer_id = (
            SELECT customer_id
            FROM Customer
            WHERE person_id = person_id_variable;
        )
    )

--Show all spouses, and children of customer--
CREATE OR REPLACE FUNCTION showAllSpousesOrChildren(customer_id_variable varchar(255))
    SELECT child_id
    FROM Parent
    WHERE parent_id = (
        SELECT customer_id
        FROM Customer
        WHERE customer_id = customer_id_variable
    )
    UNION
    SELECT spouse_2_id
    FROM Spouse
    WHERE spouse_1_id = (
        SELECT customer_id
        FROM Customer
        WHERE customer_id = customer_id_variable;
    )

--Show all accounts of child--
CREATE OR REPLACE FUNCTION showAllAccountsOfChild(child_id_variable varchar(255))
    SELECT account_id
    FROM CustomerHasAccount
    WHERE customer_id = child_id_variable;

--Show all accounts of spouse--
CREATE OR REPLACE FUNCTION showAllAccountsOfSpouse(spouse_2_id_variable varchar(255))
    SELECT account_id
    FROM CustomerHasAccount
    WHERE customer_id = spouse_2_id_variable;

--Login--
CREATE OR REPLACE FUNCTION userLogin(personal_number_id_variable number, )
    SELECT 

--Check if sufficient funds--
CREATE OR REPLACE FUNCTION checkIfSufficientFunds(account_id_variable number, amount_variable number)
    RETURNS BIT
    AS
    BEGIN
        IF(amount_variable >= (SELECT balance
            FROM Account
            WHERE account_id = account_id_variable))
            RETURN 1
        ELSE
            RETURN 0
    END

--Check if number a positive number--
CREATE OR REPLACE FUNCTION checkIfPositive(number_variable number)
    RETURNS BIT
    AS
    BEGIN
        IF(number_variable > 0)
            RETURN 1
        ELSE
            RETURN 0
    END

--Transfer money--
CREATE OR REPLACE FUNCTION transferMoney(account_id_1_variable number, account_id_2_variable number, amount_variable number )
    UPDATE Account
    SET balance = balance - amount_variable
    WHERE account_id = account_id_1_variable;
    
    UPDATE Account
    SET balance = balance + amount_variable
    WHERE account_id = account_id_2_variable;

--Deposit money--
CREATE OR REPLACE FUNCTION depositMoney(account_id_variable number, amount_variable number)
    IF (checkIfPositive(amount_variable) == 1)
        UPDATE Account
        SET balance = balance + amount_variable
        WHERE account_id = account_id_variable

    ELSE
        --Something?

--Withdraw money--
CREATE OR REPLACE FUNCTION withdrawMoney(account_id_variable number, amount_variable number)
    IF (checkIfPositive(amount_variable) == 1)
        UPDATE Account
        SET balance = balance - amount_variable
        WHERE account_id = account_id_variable
    ELSE
        --Something?

----------Insert Functions--------

--Account--
INSERT INTO Account(account_id, account_type, balance)
Values()

--AccountPerformsTransaction--
INSERT INTO AccountPerformsTransaction(account_id, transaction_id)
Values()

--AccountType--
INSERT INTO AccountType(account_type_id, interest_rate_name, interest_rate_value, account_id)
Values()

--CashDraft--
INSERT INTO CashDraft(cash_draft_id, transaction_date, transaction_amount)
Values()

--Customer--
INSERT INTO Customer(customer_id, customer_type, person_id)
Values()

--CustomerHasAccount--
INSERT INTO CustomerHasAccount(customer_id, account_id)
Values()

--Employee--
INSERT INTO Employee(employee_id, employee_name, employee_salaray, person_id)
Values()

--EmployeePerformsCashDraft--
INSERT INTO EmployeePerformsCashDraft(employee_id, cash_draft_id)
Values()

--Parent--
INSERT INTO Parent(parent_id, child_id)
Values()

--Person--
INSERT INTO Person(person_id, person_first_name, person_last_name, date_of_birth, street_name, street_number, apartment_number, zipcode, perosn_number_id)
VALUES ()

--PersonalNumber--
INSERT INTO PersonalNumber(personal_number_id)
VALUES ()

--Spouse--
INSERT INTO Spouse(spouse_1_id, spouse_2_id)
Values()

--Transaction--
INSERT INTO Transaction(transaction_id, transaction_type, transaction_time, transaction_amount)
Values()

--TransactionStoredInCashDraft--
INSERT INTO TransactionStoredInCashDraft(cash_draft_id, transaction_id)
Values()

--Zipcode--
INSERT INTO Zipcode(zipcode, town)
Values()