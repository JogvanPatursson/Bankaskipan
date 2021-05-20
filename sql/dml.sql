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
    BEGIN
        UPDATE Account
        SET balance = balance + amount_variable
        WHERE account_id = account_id_variable
    END

    ELSE
        --Something?

--Withdraw money--
CREATE OR REPLACE FUNCTION withdrawMoney(account_id_variable number, amount_variable number)
    IF (checkIfPositive(amount_variable) == 1)
    BEGIN
        UPDATE Account
        SET balance = balance - amount_variable
        WHERE account_id = account_id_variable
    END

    ELSE
        --Something?

----------Insert Functions--------

CREATE OR REPLACE FUNCTION ()
    RETURN void AS
    $$

    $$
    LANGUAGE 'plpgsql';

--Account--
CREATE OR REPLACE FUNCTION insertIntoAccount(account_id_variable integer, account_type_variable varchar(255), balance_variable real)
    RETURNS void AS
    $$
    BEGIN
        INSERT INTO Account(
            account_id,
            account_type,
            balance)
        Values(account_id_variable, account_type_variable, balance_variable);
        END
    $$
    LANGUAGE 'plpgsql';

--AccountPerformsTransaction--
CREATE OR REPLACE FUNCTION insertIntoAccountPerformsTransaction(account_id_variable integer, transaction_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO AccountPerformsTransaction(
        account_id,
        transaction_id)
    Values(account_id_variable, transaction_id_variable)
    $$
    LANGUAGE 'plpgsql';



--AccountType--
CREATE OR REPLACE FUNCTION insertIntoAccountType(account_type_id_variable integer, interest_rate_name_variable varchar(255), interest_rate_value_variable real, account_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO AccountType(
        account_type_id,
        interest_rate_name,
        interest_rate_value,
        account_id)
    Values(account_type_id_variable, interest_rate_name_variable, interest_rate_value_variable, account_id_variable)
    $$
    LANGUAGE 'plpgsql';


--CashDraft--
CREATE OR REPLACE FUNCTION insertIntoCashDraft(cash_draft_id_variable integer, transaction_date_variable timestamp, transaction_amount_variable real)
    RETURN void AS
    $$
    INSERT INTO CashDraft(
        cash_draft_id,
        transaction_date,
        transaction_amount)
    Values(cash_draft_id_variable, transaction_date_variable, transaction_amount_variable)
    $$
    LANGUAGE 'plpgsql';


--Customer--
CREATE OR REPLACE FUNCTION insertIntoCustomer(customer_id_variable integer, customer_type_variable varchar(255), person_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO Customer(
        customer_id,
        customer_type,
        person_id)
    Values(customer_id_variable, customer_type_variable, person_id_variable)
    $$
    LANGUAGE 'plpgsql';


--CustomerHasAccount--
CREATE OR REPLACE FUNCTION insertIntoCustomerHasAccount(customer_id_variable integer, account_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO CustomerHasAccount(
        customer_id,
        account_id)
    Values(customer_id_variable, account_id_variable)
    $$
    LANGUAGE 'plpgsql';


--Employee--
CREATE OR REPLACE FUNCTION insertIntoEmployee(employee_id_variable integer, employee_name_variable varchar(255), employee_salary_variable real, person_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO Employee(
        employee_id,
        employee_name,
        employee_salary,
        person_id)
    Values(employee_id_variable, employee_name_variable, employee_salary_variable, person_id_variable)
    $$
    LANGUAGE 'plpgsql';


--EmployeePerformsCashDraft--
CREATE OR REPLACE FUNCTION insertIntoEmployeePerformsCashDraft(employee_id_variable integer, cash_draft_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO EmployeePerformsCashDraft(
        employee_id,
        cash_draft_id)
    Values(employee_id_variable, cash_draft_id_variable)
    $$
    LANGUAGE 'plpgsql';


--Parent--
CREATE OR REPLACE FUNCTION insertIntoParent(parent_id_variable integer, child_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO Parent(
        parent_id,
        child_id)
    Values(parent_id_variable, child_id_variable)
    $$
    LANGUAGE 'plpgsql';


--Person--
CREATE OR REPLACE FUNCTION insertIntoPerson(person_id_variable integer, person_first_name_variable varchar(255), person_last_name_variable varchar(255), date_of_birth_variable timestamp, street_name_variable varchar(255), street_number_variable integer, apartment_number_variable integer, zipcode_variable integer, person_number_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO Person(
        person_id,
        person_first_name,
        person_last_name,
        date_of_birth,
        street_name,
        street_number,
        apartment_number,
        zipcode,
        person_number_id)
    VALUES (person_id_variable, person_first_name_variable, person_last_name_variable, date_of_birth_variable, street_name_variable, street_number_variable, apartment_number_variable, zipcode_variable, person_number_id_variable)
    $$
    LANGUAGE 'plpgsql';


--PersonalNumber--
CREATE OR REPLACE FUNCTION insertIntoPersonalNumber(personal_number_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO PersonalNumber(
        personal_number_id)
    VALUES (personal_number_id_variable)
    $$
    LANGUAGE 'plpgsql';


--Spouse--
CREATE OR REPLACE FUNCTION insertIntoSpouse(spouse_1_id_variable integer, spouse_2_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO Spouse(
        spouse_1_id,
        spouse_2_id)
    Values(spouse_1_id_variable, spouse_2_id_variable)
    $$
    LANGUAGE 'plpgsql';


--Transaction--
CREATE OR REPLACE FUNCTION insertIntoTransactions(transaction_id_variable integer, transaction_type_variable varchar(255), transaction_time_variable timestamp,transaction_amount_variable real)
    RETURN void AS
    $$
    INSERT INTO Transactions(
        transaction_id,
        transaction_type,
        transaction_time,
        transaction_amount)
    Values(transaction_id_variable, transaction_type_variable, transaction_time_variable, transaction_amount_variable)
    $$
    LANGUAGE 'plpgsql';


--TransactionStoredInCashDraft--
CREATE OR REPLACE FUNCTION insertIntoTransactionStoredInCashDraft(cash_draft_id_variable integer, transaction_id_variable integer)
    RETURN void AS
    $$
    INSERT INTO TransactionStoredInCashDraft(
        cash_draft_id,
        transaction_id)
    Values(cash_draft_id_variable, transaction_id_variable)
    $$
    LANGUAGE 'plpgsql';


--Zipcode--
CREATE OR REPLACE FUNCTION insertIntoZipcode(zipcode_variable integer, town_variable varchar(255))
    RETURN void AS
    $$
    INSERT INTO Zipcode(
        zipcode,
        town)
    Values(zipcode_variable, town_variable)
    $$
    LANGUAGE 'plpgsql';
