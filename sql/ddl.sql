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
    person_id number NOT NULL PRIMARY KEY,
    person_first_name varchar(255) NOT NULL,
    person_last_name varchar(255) NOT NULL,
    date_of_birth datetime NOT NULL,
    street_name varchar(255) NOT NULL,
    street_number number NOT NULL,
    apartment_number number,
    zipcode number NOT NULL,
    personal_number_id number NOT NULL
    );

--Create Zipcode table--
CREATE TABLE Zipcode(
    zipcode number NOT NULL PRIMARY KEY,
    town varchar(255) NOT NULL
    );

--Create Personal Number table--
CREATE TABLE Personal_number(
    personal_number_id number NOT NULL PRIMARY KEY
    );

--Create Parent table--
CREATE TABLE Parent(
    parent_id number NOT NULL,
    child_id number NOT NULL
    );

--Create Spouse table--
CREATE TABLE Spouse(
    spouse_1_id number NOT NULL,
    spouse_2_id number NOT NULL
);

--Create Customer table--
CREATE TABLE Customer(
    customer_id number NOT NULL PRIMARY KEY,
    customer_type varchar(255) NOT NULL,
    person_id number NOT NULL
);

--Create Customer Has Account table--
CREATE TABLE CustomerHasAccount(
    customer_id number NOT NULL,
    account_id number NOT NULL
);

--Create Employee table--
CREATE TABLE Employee(
    employee_id number NOT NULL PRIMARY KEY,
    employee_name varchar(255) NOT NULL,
    employee_salary number NOT NULL,
    person_id number NOT NULL
);

--Create Employee Performs Cash Draft table--
CREATE TABLE EmployeePerformsCashDraft(
    employee number NOT NULL,
    cash_draft_id number NOT NULL
);

--Create Cash Draft table--
CREATE TABLE CashDraft(
    cash_draft_id number NOT NULL PRIMARY KEY,
    transaction_date datetime NOT NULL,
    transaction_amount number NOT NULL
);

--Create Transaction Stored In Cash Draft table--
CREATE TABLE TransactionStoredInCashDraft(
    cash_draft_id number NOT NULL,
    transaction_id number NOT NULL
);

--Create Transaction table--
CREATE TABLE Transaction(
    transaction_id number NOT NULL PRIMARY KEY,
    transaction_type varchar(255) NOT NULL,
    transaction_time datetime NOT NULL,
    transaction_amount number NOT NULL
);

--Create Account table--
CREATE TABLE Account(
    account_id number NOT NULL PRIMARY KEY,
    account_type varchar(255) NOT NULL,
    balance number NOT NULL
);

--Create Account Performs Transaction table--
CREATE TABLE AccountPerformsTransaction(
    account_id number NOT NULL,
    transaction_id number NOT NULL
);

--Create Account Type  table--
CREATE TABLE AccountType(
    account_type_id number NOT NULL,
    interest_rate_name varchar(255) NOT NULL,
    interest_rate_value number NOT NULL,
    account_id number NOT NULL
);

--Create table--