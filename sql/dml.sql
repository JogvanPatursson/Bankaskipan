-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGEBANK----------------
-----------------------------------
------------GROUP 06----------------
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
DROP IF EXISTS TRIGGER triggerCheckAccountNumberInsert ON account;
DROP IF EXISTS FUNCTION checkAccountNumber();
DROP IF EXISTS SEQUENCE account_number_sequence;

CREATE SEQUENCE account_number_sequence;

CREATE OR REPLACE FUNCTION checkAccountNumber()
    RETURNS TRIGGER AS
    $$
    DECLARE
        next_account BIGINT;
        crossum BIGINT;
        rest BIGINT;
        acc varchar(11);
    
    BEGIN
        LOOP
            select nextval('account_number_sequence') INTO next_account;
            acc := CONCAT('6969', LPAD(TO_CHAR(next_account, 'FM999999999999999'), 6, '0'));
            crossum :=  5 * to_number(SUBSTR(acc, 1, 1), '9') +
                        4 * to_number(SUBSTR(acc, 2, 1), '9') +
                        3 * to_number(SUBSTR(acc, 3, 1), '9') +
                        2 * to_number(SUBSTR(acc, 4, 1), '9') +
                        7 * to_number(SUBSTR(acc, 5, 1), '9') +
                        6 * to_number(SUBSTR(acc, 6, 1), '9') +
                        5 * to_number(SUBSTR(acc, 7, 1), '9') +
                        4 * to_number(SUBSTR(acc, 8, 1), '9') +
                        3 * to_number(SUBSTR(acc, 9, 1), '9') +
                        2 * to_number(SUBSTR(acc, 10, 1), '9');
            rest := 11 - MOD(crossum, 11);
            EXIT WHEN rest < 10;
        END LOOP;
        NEW.account_id := TO_NUMBER(acc, 'FM9999999999') * 10 + rest;
        RETURN NEW;
    END
    $$
    LANGUAGE 'plpgsql';

CREATE TRIGGER triggerCheckAccountNumberInsert
    BEFORE INSERT
    ON account
    FOR EACH ROW
    EXECUTE PROCEDURE checkAccountNumber();


------Check Personnal Number-------
DROP IF EXISTS TRIGGER triggerCheckPeronalNumberInsert ON Person
DROP IF EXISTS FUNCTION check checkPersonalNumber();
CREATE OR REPLACE FUNCTION checkPersonalNumber()
    RETURNS TRIGGER AS
    $$
    DECLARE
        OLD RECORD := NEW;
        checked_personal_number_id BIGINT;
        modulus BIGINT;
        check_text VARCHAR(9);
    BEGIN
        check_text := LPAD(TO_CHAR(OLD.personal_number_id, 'FM999999999'), 9, '0');

        checked_personal_number_id :=   (3 * to_number(SUBSTR(check_text, 1, 1), '9') +
                                        2 * to_number(SUBSTR(check_text, 2, 1), '9') +
                                        7 * to_number(SUBSTR(check_text, 3, 1), '9') +
                                        6 * to_number(SUBSTR(check_text, 4, 1), '9') +
                                        5 * to_number(SUBSTR(check_text, 5, 1), '9') +
                                        4 * to_number(SUBSTR(check_text, 6, 1), '9') +
                                        3 * to_number(SUBSTR(check_text, 7, 1), '9') +
                                        2 * to_number(SUBSTR(check_text, 8, 1), '9') +
                                        1 * to_number(SUBSTR(check_text, 9, 1), '9'));

        modulus := MOD(checked_personal_number_id, 11);                  
        IF modulus = 0 THEN
        NEW.personal_number_id = OLD.personal_number_id;
        RETURN NEW;
        ELSE
            RETURN NULL;
        END IF;
    END;
    $$
    LANGUAGE 'plpgsql';


CREATE TRIGGER triggerCheckPeronalNumberInsert
    BEFORE INSERT
    ON personalNumber
    FOR EACH ROW
    EXECUTE PROCEDURE checkPersonalNumber();

-----------------------------------
-----Stored Procedure Transfer-----
-----------------------------------

DROP SEQUENCE transaction_sequence;
CREATE SEQUENCE transaction_sequence;


CREATE OR REPLACE PROCEDURE transfers(account_id_1_variable BIGINT, account_id_2_variable BIGINT, amount_variable real) 
AS
$$
DECLARE
    balance_check BIGINT;
    new_trans_id_1 BIGINT;
    new_trans_id_2 BIGINT;
BEGIN
    --Update balance of first bank account
    UPDATE account
    SET balance = balance - amount_variable
    WHERE account_id = account_id_1_variable;

    SELECT balance
    INTO balance_check
    FROM account
    WHERE account_id = account_id_1_variable;

    --Update balance of second bank account
    UPDATE account
    SET balance = balance + amount_variable
    WHERE account_id = account_id_2_variable;

    --Add record of transaction for first bank account
    INSERT INTO transactions
    (transaction_id, transaction_type, transaction_time, transaction_amount)
    VALUES
    (DEFAULT, 'Outgoing', CURRENT_TIMESTAMP, -amount_variable) RETURNING transaction_id INTO new_trans_id_1;

    INSERT INTO accountperformstransaction
    (account_id, transaction_id)
    VALUES
    (account_id_1_variable, new_trans_id_1);
    
    --Add record of transaction for second bank account
    INSERT INTO transactions
    (transaction_id, transaction_type, transaction_time, transaction_amount)
    VALUES
    (DEFAULT, 'Incoming', CURRENT_TIMESTAMP, amount_variable) RETURNING transaction_id INTO new_trans_id_2;

    INSERT INTO accountperformstransaction
    (account_id, transaction_id)
    VALUES
    (account_id_2_variable, new_trans_id_2);
    
    IF balance_check < 0
    THEN
        ROLLBACK; 
    ELSE
        commit;
    END IF;
END;
$$
LANGUAGE 'plpgsql';

-----------------------------------
--------Select Functions-----------
-----------------------------------


--Get all transactions of customer--
CREATE OR REPLACE FUNCTION getAllTransactions(account_id_variable BIGINT)
    RETURNS TABLE(transaction_id_variable BIGINT, transaction_type_variable varchar(255), transaction_time_variable timestamp, transaction_amount_variable real)
    AS
    $$
    DECLARE
        transactions_record RECORD;
    BEGIN
        FOR transactions_record IN (
            SELECT transaction_id, transaction_type, transaction_time, transaction_amount
            FROM Transactions
            WHERE transaction_id = (
                SELECT transaction_id
                FROM AccountPerformsTransaction
                WHERE account_id = (
                    SELECT account_id
                    FROM Account
                    WHERE account_id = account_id_variable
                )
            )
        ) LOOP
            transaction_id_variable := transactions_record.transaction_id;
            transaction_type_variable := transactions_record.transaction_type;
            transaction_time_variable := transactions_record.transaction_time;
            transaction_amount_variable := transactions_record.transaction_amount;

            RETURN NEXT;
        END LOOP;
    END;
    $$
    LANGUAGE 'plpgsql';

--Show all accounts of person--
DROP FUNCTION showAllAccounts(customer_id_variable BIGINT);
CREATE OR REPLACE FUNCTION showAllAccounts(customer_id_variable BIGINT)
    RETURNS TABLE(account_id_variable BIGINT, balance_variable REAL)
    AS
    $$
    DECLARE
        account_record RECORD;
    BEGIN
        FOR account_record IN (
            SELECT account_id, balance
            FROM Account
            WHERE account_id IN (
                SELECT account_id
                FROM CustomerHasAccount
                WHERE customer_id = customer_id_variable)
        ) LOOP 
            account_id_variable := account_record.account_id;
            balance_variable := account_record.balance;

            RETURN NEXT;
        END LOOP;
    END;
    $$
    LANGUAGE 'plpgsql';

--Show all spouses, and children of customer--
CREATE OR REPLACE FUNCTION showAllRelatives(customer_id_variable BIGINT)
    RETURNS TABLE(customer_1_id_variable BIGINT, person_first_name_variable VARCHAR(255), person_last_name_variable VARCHAR(255), customer_2_id_variable BIGINT)
    AS
    $$
    DECLARE
        relatives_record RECORD;
    BEGIN
        FOR relatives_record IN (
            SELECT customer_1_id, person_first_name, person_last_name, customer_2_id
            FROM relatives
            WHERE customer_1_id = customer_id_variable
        ) LOOP
            customer_1_id_variable := relatives_record.customer_1_id;
            person_first_name_variable := relatives_record.person_first_name;
            person_last_name_variable := relatives_record.person_last_name;
            customer_2_id_variable := relatives_record.customer_2_id;

            RETURN NEXT;
        END LOOP;
    END;
    $$
    LANGUAGE 'plpgsql';



----------------------------------
----------Insert Functions--------
----------------------------------

--Calculate interest and update balance--
CREATE OR REPLACE PROCEDURE calculateInterest()
AS
$$
DECLARE
    account_row RECORD;
    interest_rate_variable REAL;
    new_balance REAL;
BEGIN
    UPDATE account a
    SET balance = a.balance + a.balance * t.interest_rate_value
    FROM accountType t
    WHERE a.account_type_id = t.account_type_id;

END;
$$
LANGUAGE 'plpgsql';

CREATE OR REPLACE PROCEDURE createAccount(customer_id_variable BIGINT, account_type_variable varchar(255), balance_variable REAL)
AS
$$
DECLARE
    account_id_temp BIGINT;
BEGIN
    INSERT INTO account(account_id, account_type, balance)
    VALUES(DEFAULT, account_type_variable, balance_variable)
    RETURNING account_id INTO account_id_temp;

    INSERT INTO customerhasaccount(customer_id, account_id)
    VALUES(customer_id_variable, account_id_temp);
    COMMIT;
END
$$
LANGUAGE 'plpgsql';

--Account--
CREATE OR REPLACE PROCEDURE insertIntoAccount(account_type_variable varchar(255), balance_variable real)
    AS
    $$
    BEGIN
        INSERT INTO Account(
            account_id,
            account_type,
            balance)
        Values(DEFAULT, account_type_variable, balance_variable);
        COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';

--AccountPerformsTransaction--
CREATE OR REPLACE PROCEDURE insertIntoAccountPerformsTransaction(account_id_variable BIGINT, transaction_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO AccountPerformsTransaction(
        account_id,
        transaction_id)
    Values(account_id_variable, transaction_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';

--AccountType--
CREATE OR REPLACE PROCEDURE insertIntoAccountType(interest_rate_name_variable varchar(255), interest_rate_value_variable real, account_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO AccountType(
        account_type_id,
        interest_rate_name,
        interest_rate_value,
        account_id)
    Values(DEFAULT, interest_rate_name_variable, interest_rate_value_variable, account_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--CashDraft--
CREATE OR REPLACE PROCEDURE insertIntoCashDraft(transaction_date_variable timestamp, transaction_amount_variable real)
    AS
    $$
    BEGIN
    INSERT INTO CashDraft(
        cash_draft_id,
        transaction_date,
        transaction_amount)
    Values(DEFAULT, transaction_date_variable, transaction_amount_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Customer--
CREATE OR REPLACE PROCEDURE insertIntoCustomer(customer_type_variable varchar(255), person_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO Customer(
        customer_id,
        customer_type,
        person_id)
    Values(DEFAULT, customer_type_variable, person_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--CustomerHasAccount--
CREATE OR REPLACE PROCEDURE insertIntoCustomerHasAccount(customer_id_variable BIGINT, account_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO CustomerHasAccount(
        customer_id,
        account_id)
    Values(customer_id_variable, account_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Employee--
CREATE OR REPLACE PROCEDURE insertIntoEmployee(employee_name_variable varchar(255), employee_salary_variable real, person_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO Employee(
        employee_id,
        employee_name,
        employee_salary,
        person_id)
    Values(DEFAULT, employee_name_variable, employee_salary_variable, person_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--EmployeePerformsCashDraft--
CREATE OR REPLACE PROCEDURE insertIntoEmployeePerformsCashDraft(employee_id_variable BIGINT, cash_draft_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO EmployeePerformsCashDraft(
        employee_id,
        cash_draft_id)
    Values(employee_id_variable, cash_draft_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Parent--
CREATE OR REPLACE PROCEDURE insertIntoParent(parent_id_variable BIGINT, child_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO Parent(
        parent_id,
        child_id)
    Values(parent_id_variable, child_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Person--
CREATE OR REPLACE PROCEDURE insertIntoPerson(person_first_name_variable varchar(255), person_last_name_variable varchar(255), date_of_birth_variable timestamp, street_name_variable varchar(255), street_number_variable BIGINT, apartment_number_variable BIGINT, zipcode_variable BIGINT, person_number_id_variable BIGINT)
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
        personal_number_id)
    VALUES (DEFAULT, person_first_name_variable, person_last_name_variable, date_of_birth_variable, street_name_variable, street_number_variable, apartment_number_variable, zipcode_variable, person_number_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--PersonalNumber--
CREATE OR REPLACE PROCEDURE insertIntoPersonalNumber(personal_number_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO PersonalNumber(
        personal_number_id)
    VALUES (personal_number_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Spouse--
CREATE OR REPLACE PROCEDURE insertIntoSpouse(spouse_1_id_variable BIGINT, spouse_2_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO Spouse(
        spouse_1_id,
        spouse_2_id)
    Values(spouse_1_id_variable, spouse_2_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Transactions--
CREATE OR REPLACE PROCEDURE insertIntoTransactions(transaction_type_variable varchar(255), transaction_time_variable timestamp,transaction_amount_variable real)
    AS
    $$
    BEGIN
    INSERT INTO Transactions(
        transaction_id,
        transaction_type,
        transaction_time,
        transaction_amount)
    Values(DEFAULT, transaction_type_variable, transaction_time_variable, transaction_amount_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--TransactionStoredInCashDraft--
CREATE OR REPLACE PROCEDURE insertIntoTransactionStoredInCashDraft(cash_draft_id_variable BIGINT, transaction_id_variable BIGINT)
    AS
    $$
    BEGIN
    INSERT INTO TransactionStoredInCashDraft(
        cash_draft_id,
        transaction_id)
    Values(cash_draft_id_variable, transaction_id_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';


--Zipcode--
CREATE OR REPLACE PROCEDURE insertIntoZipcode(zipcode_variable BIGINT, town_variable varchar(255))
    AS
    $$
    BEGIN
    INSERT INTO Zipcode(
        zipcode,
        town)
    Values(zipcode_variable, town_variable);
    COMMIT;
    END;
    $$
    LANGUAGE 'plpgsql';

------------------------------
--------Populate Data---------
------------------------------

--Populate Zipcode--
CALL insertIntoZipcode(100, 'Torshavn');
CALL insertIntoZipcode(160, 'Argir');
CALL insertIntoZipcode(175, 'Kirkjubø');
CALL insertIntoZipcode(188, 'Hoyvík');
CALL insertIntoZipcode();
CALL insertIntoZipcode();


--Populate Personal Number--
CALL insertIntoPersonalNumber(261290057);
CALL insertIntoPersonalNumber(150995140);
CALL insertIntoPersonalNumber(160101233);

CALL insertIntoPersonalNumber(122456900);
CALL insertIntoPersonalNumber(456789455);
CALL insertIntoPersonalNumber(444333332);

CALL insertIntoPersonalNumber(535724105);
CALL insertIntoPersonalNumber(117420043);
CALL insertIntoPersonalNumber(991112006);
CALL insertIntoPersonalNumber(241204006);
CALL insertIntoPersonalNumber(241204103);
CALL insertIntoPersonalNumber(160589248);

--Populate Person--
CALL insertIntoPerson('Hjálmar', 'Heminkrans', CURRENT_TIMESTAMP, 'Fjøruvegur', 33, NULL, 188, 261290057);
CALL insertIntoPerson('Eyðna', 'Heminkrans', CURRENT_TIMESTAMP, 'Fjøruvegur', 33, NULL, 188, 150995140);
CALL insertIntoPerson('Benjamin', 'Hjálmarsson', CURRENT_TIMESTAMP, 'Fjøruvegur', 33, NULL, 188, 160101233);

CALL insertIntoPerson('Hemmingur', 'Baraldarrunnur', CURRENT_TIMESTAMP, 'við Ovaru Kai', 1, NULL, 160, 122456900);
CALL insertIntoPerson('Karla Magna', 'Gregorsdóttir', CURRENT_TIMESTAMP, 'í Doktaragrund', 6, NULL, 100, 456789455);
CALL insertIntoPerson('Martina', 'Hemmingsdóttir', CURRENT_TIMESTAMP, 'í Doktaragrund', 6, NULL, 100, 444333332);

CALL insertIntoPerson('Gunntjaldur', 'við Móruvatn', CURRENT_TIMESTAMP, 'Móruvatnsvegur', 46, NULL, , );

CALL insertIntoPerson('', '', CURRENT_TIMESTAMP, '', , NULL, , );
CALL insertIntoPerson('', '', CURRENT_TIMESTAMP, '', , NULL, , );
CALL insertIntoPerson('', '', CURRENT_TIMESTAMP, '', , NULL, , );
CALL insertIntoPerson('', '', CURRENT_TIMESTAMP, '', , NULL, , );
CALL insertIntoPerson('', '', CURRENT_TIMESTAMP, '', , NULL, , );


