-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGEBANK----------------
-----------------------------------
------------GROUP 7----------------
-----------------------------------

----------Create Tables------------

--Create Zipcode table--
DROP TABLE IF EXISTS Zipcode;
CREATE TABLE Zipcode(
    zipcode BIGINT NOT NULL PRIMARY KEY,
    town varchar(255) NOT NULL
    );

--Create Personal Number table--
DROP TABLE IF EXISTS PersonalNumber;
CREATE TABLE PersonalNumber(
    personal_number_id BIGINT NOT NULL PRIMARY KEY
    );

--Create Person table--
DROP TABLE IF EXISTS Person;
CREATE TABLE Person(
    person_id BIGINT NOT NULL PRIMARY KEY,
    person_first_name varchar(255) NOT NULL,
    person_last_name varchar(255) NOT NULL,
    date_of_birth timestamp NOT NULL,
    street_name varchar(255) NOT NULL,
    street_number BIGINT NOT NULL,
    apartment_number BIGINT,
    zipcode BIGINT NOT NULL,
    personal_number_id BIGINT NOT NULL,
    CONSTRAINT fk_zipcode
        FOREIGN KEY(zipcode)
            REFERENCES zipcode(zipcode),
    CONSTRAINT fk_personal_number
        FOREIGN KEY(personal_number_id)
            REFERENCES PersonalNumber(personal_number_id)
    );

--Create Parent table--
DROP TABLE IF EXISTS Parent;
CREATE TABLE Parent(
    parent_id BIGINT NOT NULL,
    child_id BIGINT NOT NULL,
    
    CONSTRAINT fk_parent
        FOREIGN KEY(parent_id)
            REFERENCES Person(person_id),
    CONSTRAINT fk_child
        FOREIGN KEY(child_id)
            REFERENCES Person(person_id)
    );

--Create Spouse table--
DROP TABLE IF EXISTS Spouse;
CREATE TABLE Spouse(
    spouse_1_id BIGINT NOT NULL,
    spouse_2_id BIGINT NOT NULL,
    CONSTRAINT fk_spouse_1
        FOREIGN KEY(spouse_1_id)
            REFERENCES Person(person_id),
    CONSTRAINT fk_spouse_2
        FOREIGN KEY(spouse_2_id)
            REFERENCES Person(person_id)
);

--Create Customer table--
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer(
    customer_id BIGINT NOT NULL PRIMARY KEY,
    customer_type varchar(255) NOT NULL,
    person_id BIGINT NOT NULL,
    CONSTRAINT fk_person
        FOREIGN KEY(person_id)
            REFERENCES Person(person_id)
);

--Create Account table--
DROP TABLE IF EXISTS Account;
CREATE TABLE Account(
    account_id BIGINT NOT NULL PRIMARY KEY,
    account_type varchar(255) NOT NULL,
    balance real NOT NULL
);

--Create Customer Has Account table--
DROP TABLE IF EXISTS CustomerHasAccount;
CREATE TABLE CustomerHasAccount(
    customer_id BIGINT NOT NULL,
    account_id BIGINT NOT NULL,
    CONSTRAINT fk_customer
        FOREIGN KEY(customer_id)
            REFERENCES Person(person_id),
    CONSTRAINT fk_account
        FOREIGN KEY(account_id)
            REFERENCES Account(account_id)
);

--Create Employee table--
DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee(
    employee_id BIGINT NOT NULL PRIMARY KEY,
    employee_name varchar(255) NOT NULL,
    employee_salary BIGINT NOT NULL,
    person_id BIGINT NOT NULL,
    CONSTRAINT fk_person
        FOREIGN KEY(person_id)
            REFERENCES Person(person_id)
);

--Create Cash Draft table--
DROP TABLE IF EXISTS CashDraft;
CREATE TABLE CashDraft(
    cash_draft_id BIGINT NOT NULL PRIMARY KEY,
    transaction_date timestamp NOT NULL,
    transaction_amount real NOT NULL
);

--Create Employee Performs Cash Draft table--
DROP TABLE IF EXISTS EmployeePerformsCashDraft;
CREATE TABLE EmployeePerformsCashDraft(
    employee_id BIGINT NOT NULL,
    cash_draft_id BIGINT NOT NULL,
    CONSTRAINT fk_employee
        FOREIGN KEY(employee_id)
            REFERENCES Employee(employee_id),
    CONSTRAINT fk_cashdraft
        FOREIGN KEY(cash_draft_id)
            REFERENCES CashDraft(cash_draft_id)
);

--Create Transactions table--
DROP TABLE IF EXISTS Transactions;
CREATE TABLE Transactions(
    transaction_id SERIAL NOT NULL PRIMARY KEY,
    transaction_type varchar(255) NOT NULL,
    transaction_time timestamp NOT NULL,
    transaction_amount real NOT NULL
);

--Create Transaction Stored In Cash Draft table--
DROP TABLE IF EXISTS TransactionStoredInCashDraft;
CREATE TABLE TransactionStoredInCashDraft(
    cash_draft_id BIGINT NOT NULL,
    transaction_id BIGINT NOT NULL,
    CONSTRAINT fk_cashdraft
        FOREIGN KEY(cash_draft_id)
            REFERENCES CashDraft(cash_draft_id),
    CONSTRAINT fk_transaction
        FOREIGN KEY(transaction_id)
            REFERENCES Transactions(transaction_id)
);

--Create Account Performs Transaction table--
DROP TABLE IF EXISTS AccountPerformsTransaction;
CREATE TABLE AccountPerformsTransaction(
    account_id BIGINT NOT NULL,
    transaction_id BIGINT NOT NULL,
    CONSTRAINT fk_account
        FOREIGN KEY(account_id)
            REFERENCES Account(account_id),
    CONSTRAINT fk_transaction
        FOREIGN KEY(transaction_id)
            REFERENCES Transactions(transaction_id)
);

--Create Account Type table--
DROP TABLE IF EXISTS AccountType;
CREATE TABLE AccountType(
    account_type_id BIGINT NOT NULL,
    interest_rate_name varchar(255) NOT NULL,
    interest_rate_value real NOT NULL,
    account_id BIGINT NOT NULL

--Create Bank table--
DROP TABLE IF EXISTS Bank;
CREATE TABLE Bank(
    bank_id BIGINT PRIMARY KEY,
    bank_name VARCHAR(255) UNIQUE NOT NULL,
    bank_registration_number BIGINT UNIQUE NOT NULL
);

--Create Bank Has Account table--
DROP TABLE IF EXISTS BankHasAccount;
CREATE TABLE BankHasAccount(
    bank_id BIGINT NOT NULL,
    account_id BIGINT NOT NULL,
    CONSTRAINT fk_bank
        FOREIGN KEY(bank_id)
            REFERENCES Bank(bank_id),
    CONSTRAINT fk_account
        FOREIGN KEY(account_id)
            REFERENCES account(account_id)
);

DROP TABLE IF EXISTS BankReceivesCashDraft;
CREATE TABLE BankReceivesCashDraft(
    bank_id BIGINT NOT NULL,
    cash_draft_id BIGINT NOT NULL,
    CONSTRAINT fk_bank
        FOREIGN KEY(bank_id)
            REFERENCES Bank(bank_id),
    CONSTRAINT fk_cashdraft
        FOREIGN KEY(cash_draft_id)
            REFERENCES CashDraft(cash_draft_id)
);

--Create a View for getting total balances
CREATE OR REPLACE VIEW TotalBalances AS 
    SELECT account_type, SUM(balance) AS sum
    FROM account
    GROUP BY account_type;