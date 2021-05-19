-----------------------------------
---------SQL DATABASE--------------
-----------------------------------
-----------DOGECOIN----------------
-----------------------------------
------------GROUP 7----------------
-----------------------------------

---------Create tables-----------

--Create Person table--
CREATE TABLE Person(
    person_id int NOT NULL PRIMARY KEY,
    person_first_name varchar NOT NULL,
    person_last_name varchar NOT NULL,
    date_of_birth datetime NOT NULL,
    street_name varchar NOT NULL,
    street_number int NOT NULL,
    apartment_number int,
    zipcode int NOT NULL,
    personal_number_id int NOT NULL
    );

--Create Zipcode table--
CREATE TABLE Zipcode(
    zipcode int NOT NULL PRIMARY KEY,
    town varchar NOT NULL
    );

--Create Personal Number table--
CREATE TABLE Personal_number(
    personal_number_id int NOT NULL PRIMARY KEY
    );

--Create Parent table--
CREATE TABLE Parent(
    parent_id int NOT NULL,
    child_id int NOT NULL
    );

--Create Spouse table--
CREATE TABLE Spouse(
    spouse_1_id int NOT NULL,
    spouse_2_id int NOT NULL
);

--Create Customer table--
CREATE TABLE Customer(
    customer_id int NOT NULL PRIMARY KEY,
    customer_type varchar NOT NULL,
    person_id int NOT NULL
);

--Create Customer Has Account table--
CREATE TABLE CustomerHasAccount(
    customer_id int NOT NULL,
    account_id int NOT NULL
);

--Create Employee table--
CREATE TABLE Employee(
    employee_id int NOT NULL PRIMARY KEY,
    employee_name varchar NOT NULL,
    employee_salary int NOT NULL,
    person_id int NOT NULL
);

--Create Employee Performs Cash Draft table--
CREATE TABLE EmployeePerformsCashDraft(
    employee int NOT NULL,
    cash_draft_id int NOT NULL
);

--Create Cash Draft table--
CREATE TABLE CashDraft(
    cash_draft_id int NOT NULL PRIMARY KEY,
    transaction_date datetime NOT NULL,
    transaction_amount int NOT NULL
);

--Create Transaction Stored In Cash Draft table--
CREATE TABLE TransactionStoredInCashDraft(
    cash_draft_id int NOT NULL,
    transaction_id int NOT NULL
);

--Create Transaction table--
CREATE TABLE Transaction(
    transaction_id int NOT NULL PRIMARY KEY,
    transaction_type varchar NOT NULL,
    transaction_time datetime NOT NULL,
    transaction_amount int NOT NULL
);

--Create Account table--
CREATE TABLE Account(
    account_id int NOT NULL PRIMARY KEY,
    account_type varchar NOT NULL,
    balance int NOT NULL
);

--Create Account Performs Transaction table--
CREATE TABLE AccountPerformsTransaction(
    account_id int NOT NULL,
    transaction_id int NOT NULL
);

--Create Account Type  table--
CREATE TABLE AccountType(
    account_type_id int NOT NULL,
    interest_rate_name varchar NOT NULL,
    interest_rate_value int NOT NULL,
    account_id int NOT NULL
);

--Create table--