-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGEBANK----------------
-----------------------------------
------------GROUP 7----------------
-----------------------------------

-----------------------------------
--------Trigger Functions----------
-----------------------------------


-------Check Account Number--------

/*
A function to insert a row into account is called.
Before inserting row into Account, a trigger calls the trigger function.
The trigger function takes the values from the account insert function,
and calculates the account number and checks if it is valid.
If it is valid it inserts the values from the account insert function into the account table.
*****If it is not valid it returns false????


*/
DROP TRIGGER triggerCheckAccountNumberInsert ON account;
DROP FUNCTION checkAccountNumber();
DROP SEQUENCE account_number_sequence;

CREATE SEQUENCE account_number_sequence;


CREATE OR REPLACE FUNCTION checkAccountNumber()
    RETURNS TRIGGER AS
    $$
    DECLARE
        next_account integer;
        tvorsum integer;
        rest integer;
        acc varchar(11);
    
    BEGIN
        LOOP
            --select account_number_sequence.nextval INTO next_account;
            acc := CONCAT('6969', LPAD(to_char(next_account, '9'), 4, '0'));
            tvorsum :=  5 * to_number(SUBSTR(acc, 1, 1), '9') +
                        4 * to_number(SUBSTR(acc, 2, 1), '9') +
                        3 * to_number(SUBSTR(acc, 3, 1), '9') +
                        2 * to_number(SUBSTR(acc, 4, 1), '9') +
                        7 * to_number(SUBSTR(acc, 5, 1), '9') +
                        6 * to_number(SUBSTR(acc, 6, 1), '9') +
                        5 * to_number(SUBSTR(acc, 7, 1), '9') +
                        4 * to_number(SUBSTR(acc, 8, 1), '9') +
                        3 * to_number(SUBSTR(acc, 9, 1), '9') +
                        2 * to_number(SUBSTR(acc, 10, 1), '9');
            rest := 11 - MOD(tvorsum, 11);
            EXIT WHEN rest < 10;
            NEW.account_id := TO_NUMBER(acc) * 10 + rest;
        END LOOP;

        --IF NEW.account_id < 100 THEN
            INSERT INTO account(account_id, account_type, balance)
            VALUES (NEW.account_id, NEW.account_type, NEW.balance);
        --    RETURN NEW;
        --ELSE
        --    RETURN NULL;
    END
    $$
    LANGUAGE 'plpgsql';

CREATE TRIGGER triggerCheckAccountNumberInsert
    BEFORE INSERT
    ON account
    FOR EACH ROW
    EXECUTE PROCEDURE checkAccountNumber();



-----------------------------------
-----Stored Procedure Transfer-----
-----------------------------------
DROP TRIGGER triggerTransactions ON transactions;
DROP SEQUENCE transaction_sequence;

CREATE SEQUENCE transaction_sequence;

CREATE TRIGGER trigger_transaction_insert
    BEFORE INSERT ON transactions
    FOR EACH ROW
    BEGIN

    END;

CREATE TRIGGER transaction_salo_insert
    AFTER INSERT
    FOR EACH ROW
    BEGIN
        UPDATE account
        SET balance = balance + NEW.amount;
    END;

CREATE OR REPLACE PROCEDURE transfer(account_id_1_variable integer, account_id_2_variable integer, upphaed integer) 
IS
    temp_account integer(12, 0);
BEGIN
    SELECT account_number INTO temp_account
    FROM account
    WHERE account_number = account_id_1_variable
    FOR UPDATE;

    SELECT account_number INTO temp_account
    FROM account
    WHERE account_number = account_id_2_variable
    FOR UPDATE;

    INSERT INTO transactions
    (account, amount)
    VALUES
    (account_id_1_variable, -upphaed);

    INSERT INTO transactions
    (account, amount)
    VALUES
    (account_id_2_variable, upphaed);

    commit;

END;


-----------------------------------
--------Select Functions-----------
-----------------------------------


--Get all transactions of customer--
CREATE OR REPLACE PROCEDURE getAllTransactions(account_id_variable varchar(255))
    RETURNS TABLE(transaction_id_variable integer, transaction_type_variable varchar(255), transaction_time_variable timestamp, transaction_amount_variable real)
    AS
    $$
    BEGIN
        SELECT *
        FROM Transactions
        WHERE transaction_id = (
            SELECT transaction_id
            FROM AccountPerformsTransaction
            WHERE account_id = (
                SELECT account_id
                FROM Account
                WHERE account_id = account_id_variable(
                )
            )
        );
    END;
    $$
    LANGUAGE 'plpgsql';

--Show all accounts of person--
CREATE OR REPLACE PROCEDURE showAllAccounts(person_id_variable varchar(255))
    RETURN TABLE(account_id_variable integer)
    AS
    $$
    BEGIN
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
    END;
    $$
    LANGUAGE 'plpgsql';

--Show all spouses, and children of customer--
CREATE OR REPLACE PROCEDURE showAllSpousesOrChildren(customer_id_variable varchar(255))
    RETURN TABLE(child_or_spouse_id_variable integer)
    AS
    $$
    BEGIN
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
    END;
    $$
    LANGUAGE 'plpgsql';
    

--Show all accounts of child--    
CREATE OR REPLACE PROCEDURE showAllAccountsOfChild(child_id_variable varchar(255))
    RETURN TABLE(account_id_variable integer)
    AS
    $$
    BEGIN
        SELECT account_id
        FROM CustomerHasAccount
        WHERE customer_id = child_id_variable;
    END;
    $$
    LANGUAGE 'plpgsql';


--Show all accounts of spouse--
CREATE OR REPLACE PROCEDURE showAllAccountsOfSpouse(spouse_2_id_variable varchar(255))
    RETURN TABLE(account_id_variable integer)
    AS
    $$
    BEGIN
        SELECT account_id
        FROM CustomerHasAccount
        WHERE customer_id = spouse_2_id_variable;
    END;
    $$
    LANGUAGE 'plpgsql';

/*
--Login--
CREATE OR REPLACE PROCEDURE userLogin(personal_number_id_variable number, )
    RETURN  AS
    $$
    BEGIN
        SELECT 
    END
    $$
    LANGUAGE 'plpgsql';
*/
--Check if sufficient funds--
/*
CREATE OR REPLACE PROCEDURE checkIfSufficientFunds(account_id_variable number, amount_variable number)
    RETURN boolean
    AS
    $$
    BEGIN
        IF(amount_variable >= (SELECT balance
            FROM Account
            WHERE account_id = account_id_variable))
            RETURN 1
        ELSE
            RETURN 0
        END IF;
    END
    $$
    LANGUAGE 'plpgsql';
*/
------------------------------------
------------------------------------
------------------------------------
/*
CREATE OR REPLACE PROCEDURE checkbankaccount(account_id_variable number)
    AS
    $$
    BEGIN

    END
    $$

*/

/*
--Check if number a positive number--
CREATE OR REPLACE PROCEDURE checkIfPositive(number_variable number)
    RETURNS BIT AS
    $$
    BEGIN
        IF(number_variable > 0)
            RETURN 1
        ELSE
            RETURN 0
    END
    $$
    LANGUAGE 'plpgsql';
*/
/*
--Transfer money--
CREATE OR REPLACE PROCEDURE transferMoney(account_id_1_variable integer, account_id_2_variable integer, amount_variable real )
    AS
    $$
    BEGIN
        UPDATE Account
        SET balance = balance - amount_variable
        WHERE account_id = account_id_1_variable;
        
        UPDATE Account
        SET balance = balance + amount_variable
        WHERE account_id = account_id_2_variable;

        INSERT INTO Transactions(   transaction_id,
                                    transaction_type,
                                    transaction_time,
                                    transaction_amount)
        VALUES( account_id_1_variable,
                'normal?',
                CURRENT_TIMESTAMP,
                -amount_variable);

        INSERT INTO Transactions(   transaction_id,
                                    transaction_type,
                                    transaction_time,
                                    transaction_amount)
        VALUES( account_id_2_variable,
                'normal?',
                CURRENT_TIMESTAMP,
                amount_variable);

        COMMIT;
    END
    
    $$
    LANGUAGE 'plpgsql';
*/


----------------------------------
----------Insert Functions--------
----------------------------------

--Account--
CREATE OR REPLACE PROCEDURE insertIntoAccount(account_id_variable integer, account_type_variable varchar(255), balance_variable real)
    AS
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
CREATE OR REPLACE PROCEDURE insertIntoAccountPerformsTransaction(account_id_variable integer, transaction_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO AccountPerformsTransaction(
        account_id,
        transaction_id)
    Values(account_id_variable, transaction_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';

--AccountType--
CREATE OR REPLACE PROCEDURE insertIntoAccountType(account_type_id_variable integer, interest_rate_name_variable varchar(255), interest_rate_value_variable real, account_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO AccountType(
        account_type_id,
        interest_rate_name,
        interest_rate_value,
        account_id)
    Values(account_type_id_variable, interest_rate_name_variable, interest_rate_value_variable, account_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--CashDraft--
CREATE OR REPLACE PROCEDURE insertIntoCashDraft(cash_draft_id_variable integer, transaction_date_variable timestamp, transaction_amount_variable real)
    AS
    $$
    BEGIN
    INSERT INTO CashDraft(
        cash_draft_id,
        transaction_date,
        transaction_amount)
    Values(cash_draft_id_variable, transaction_date_variable, transaction_amount_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Customer--
CREATE OR REPLACE PROCEDURE insertIntoCustomer(customer_id_variable integer, customer_type_variable varchar(255), person_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO Customer(
        customer_id,
        customer_type,
        person_id)
    Values(customer_id_variable, customer_type_variable, person_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--CustomerHasAccount--
CREATE OR REPLACE PROCEDURE insertIntoCustomerHasAccount(customer_id_variable integer, account_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO CustomerHasAccount(
        customer_id,
        account_id)
    Values(customer_id_variable, account_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Employee--
CREATE OR REPLACE PROCEDURE insertIntoEmployee(employee_id_variable integer, employee_name_variable varchar(255), employee_salary_variable real, person_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO Employee(
        employee_id,
        employee_name,
        employee_salary,
        person_id)
    Values(employee_id_variable, employee_name_variable, employee_salary_variable, person_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--EmployeePerformsCashDraft--
CREATE OR REPLACE PROCEDURE insertIntoEmployeePerformsCashDraft(employee_id_variable integer, cash_draft_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO EmployeePerformsCashDraft(
        employee_id,
        cash_draft_id)
    Values(employee_id_variable, cash_draft_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Parent--
CREATE OR REPLACE PROCEDURE insertIntoParent(parent_id_variable integer, child_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO Parent(
        parent_id,
        child_id)
    Values(parent_id_variable, child_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Person--
CREATE OR REPLACE PROCEDURE insertIntoPerson(person_id_variable integer, person_first_name_variable varchar(255), person_last_name_variable varchar(255), date_of_birth_variable timestamp, street_name_variable varchar(255), street_number_variable integer, apartment_number_variable integer, zipcode_variable integer, person_number_id_variable integer)
    AS
    $$
    BEGIN
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
    END
    $$
    LANGUAGE 'plpgsql';


--PersonalNumber--
CREATE OR REPLACE PROCEDURE insertIntoPersonalNumber(personal_number_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO PersonalNumber(
        personal_number_id)
    VALUES (personal_number_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Spouse--
CREATE OR REPLACE PROCEDURE insertIntoSpouse(spouse_1_id_variable integer, spouse_2_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO Spouse(
        spouse_1_id,
        spouse_2_id)
    Values(spouse_1_id_variable, spouse_2_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Transactions--
CREATE OR REPLACE PROCEDURE insertIntoTransactions(transaction_id_variable integer, transaction_type_variable varchar(255), transaction_time_variable timestamp,transaction_amount_variable real)
    AS
    $$
    BEGIN
    INSERT INTO Transactions(
        transaction_id,
        transaction_type,
        transaction_time,
        transaction_amount)
    Values(transaction_id_variable, transaction_type_variable, transaction_time_variable, transaction_amount_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--TransactionStoredInCashDraft--
CREATE OR REPLACE PROCEDURE insertIntoTransactionStoredInCashDraft(cash_draft_id_variable integer, transaction_id_variable integer)
    AS
    $$
    BEGIN
    INSERT INTO TransactionStoredInCashDraft(
        cash_draft_id,
        transaction_id)
    Values(cash_draft_id_variable, transaction_id_variable)
    END
    $$
    LANGUAGE 'plpgsql';


--Zipcode--
CREATE OR REPLACE PROCEDURE insertIntoZipcode(zipcode_variable integer, town_variable varchar(255))
    AS
    $$
    BEGIN
    INSERT INTO Zipcode(
        zipcode,
        town)
    Values(zipcode_variable, town_variable)
    END
    $$
    LANGUAGE 'plpgsql';
