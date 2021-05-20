-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGEBANK----------------
-----------------------------------
------------GROUP 7----------------
-----------------------------------

----------Create Tables------------

--Create Person table--
CREATE TABLE Person(
    person_id integer NOT NULL PRIMARY KEY,
    person_first_name varchar(255) NOT NULL,
    person_last_name varchar(255) NOT NULL,
    date_of_birth timestamp NOT NULL,
    street_name varchar(255) NOT NULL,
    street_number integer NOT NULL,
    apartment_number integer,
    zipcode integer NOT NULL,
    personal_number_id integer NOT NULL
    );

--Create Zipcode table--
CREATE TABLE Zipcode(
    zipcode integer NOT NULL PRIMARY KEY,
    town varchar(255) NOT NULL
    );

--Create Personal Number table--
CREATE TABLE PersonalNumber(
    personal_number_id integer NOT NULL PRIMARY KEY
    );

--Create Parent table--
CREATE TABLE Parent(
    parent_id integer NOT NULL,
    child_id integer NOT NULL
    );

--Create Spouse table--
CREATE TABLE Spouse(
    spouse_1_id integer NOT NULL,
    spouse_2_id integer NOT NULL
);

--Create Customer table--
CREATE TABLE Customer(
    customer_id integer NOT NULL PRIMARY KEY,
    customer_type varchar(255) NOT NULL,
    person_id integer NOT NULL
);

--Create Customer Has Account table--
CREATE TABLE CustomerHasAccount(
    customer_id integer NOT NULL,
    account_id integer NOT NULL
);

--Create Employee table--
CREATE TABLE Employee(
    employee_id integer NOT NULL PRIMARY KEY,
    employee_name varchar(255) NOT NULL,
    employee_salary integer NOT NULL,
    person_id integer NOT NULL
);

--Create Employee Performs Cash Draft table--
CREATE TABLE EmployeePerformsCashDraft(
    employee_id integer NOT NULL,
    cash_draft_id integer NOT NULL
);

--Create Cash Draft table--
CREATE TABLE CashDraft(
    cash_draft_id integer NOT NULL PRIMARY KEY,
    transaction_date timestamp NOT NULL,
    transaction_amount real NOT NULL
);

--Create Transaction Stored In Cash Draft table--
CREATE TABLE TransactionStoredInCashDraft(
    cash_draft_id integer NOT NULL,
    transaction_id integer NOT NULL
);

--Create Transaction table--
CREATE TABLE Transaction(
    transaction_id integer NOT NULL PRIMARY KEY,
    transaction_type varchar(255) NOT NULL,
    transaction_time timestamp NOT NULL,
    transaction_amount real NOT NULL
);

--Create Account table--
CREATE TABLE Account(
    account_id integer NOT NULL PRIMARY KEY,
    account_type varchar(255) NOT NULL,
    balance real NOT NULL
);

--Create Account Performs Transaction table--
CREATE TABLE AccountPerformsTransaction(
    account_id integer NOT NULL,
    transaction_id integer NOT NULL
);

--Create Account Type  table--
CREATE TABLE AccountType(
    account_type_id integer NOT NULL,
    interest_rate_name varchar(255) NOT NULL,
    interest_rate_value real NOT NULL,
    account_id integer NOT NULL
);

--Create table--