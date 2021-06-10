------------------------------
--------Populate Data---------
------------------------------

--Populate Bank--
INSERT INTO Bank VALUES(1, 'Dogebank', 6969);

--Populate Account Type--
INSERT INTO AccountType VALUES(DEFAULT, 'Checking', 0.02);
INSERT INTO AccountType VALUES(DEFAULT, 'Savings', 0.08);
INSERT INTO AccountType VALUES(DEFAULT, 'Bank Balance Account', 0);

--Populate Bank Account--
INSERT INTO Account VALUES(DEFAULT, 3, 1000000000);
INSERT INTO BankHasAccount VALUES(1, 69690000016);

--Populate Zipcode--
INSERT INTO Zipcode VALUES(100, 'Torshavn');
INSERT INTO Zipcode VALUES(160, 'Argir');
INSERT INTO Zipcode VALUES(175, 'Kirkjubø');
INSERT INTO Zipcode VALUES(188, 'Hoyvík');
INSERT INTO Zipcode VALUES(666, 'Gøtueiði');
INSERT INTO Zipcode VALUES(700, 'Klaksvík');


--Populate Personal Number--
INSERT INTO PersonalNumber VALUES(261290057);
INSERT INTO PersonalNumber VALUES(150995140);
INSERT INTO PersonalNumber VALUES(160101237);

INSERT INTO PersonalNumber VALUES(122456900);
INSERT INTO PersonalNumber VALUES(456789455);
INSERT INTO PersonalNumber VALUES(444333332);

INSERT INTO PersonalNumber VALUES(535724105);

INSERT INTO PersonalNumber VALUES(117420043);
INSERT INTO PersonalNumber VALUES(991112006);
INSERT INTO PersonalNumber VALUES(241204006);
INSERT INTO PersonalNumber VALUES(241204103);
INSERT INTO PersonalNumber VALUES(160589248);

INSERT INTO PersonalNumber VALUES(696969698);

--Populate Person--
INSERT INTO Person VALUES(DEFAULT, 'Hjálmar', 'Heminkrans', CURRENT_TIMESTAMP::timestamp, 'Fjøruvegur', 33, NULL, 188, 261290057);
INSERT INTO Person VALUES(DEFAULT, 'Eyðna', 'Heminkrans', CURRENT_TIMESTAMP::timestamp, 'Fjøruvegur', 33, NULL, 188, 150995140);
INSERT INTO Person VALUES(DEFAULT, 'Benjamin', 'Hjálmarsson', CURRENT_TIMESTAMP::timestamp, 'Fjøruvegur', 33, NULL, 188, 160101237);

INSERT INTO Person VALUES(DEFAULT, 'Hemmingur', 'Baraldarrunnur', CURRENT_TIMESTAMP::timestamp, 'við Ovaru Kai', 1, NULL, 160, 122456900);
INSERT INTO Person VALUES(DEFAULT, 'Karla Magna', 'Gregorsdóttir', CURRENT_TIMESTAMP::timestamp, 'í Doktaragrund', 6, NULL, 100, 456789455);
INSERT INTO Person VALUES(DEFAULT, 'Martina', 'Hemmingsdóttir', CURRENT_TIMESTAMP::timestamp, 'í Doktaragrund', 6, NULL, 100, 444333332);

INSERT INTO Person VALUES(DEFAULT, 'Gunntjaldur', 'við Móruvatn', CURRENT_TIMESTAMP::timestamp, 'Móruvatnsvegur', 46, NULL, 700, 535724105);

INSERT INTO Person VALUES(DEFAULT, 'Absalon', 'Jøkularklettur', CURRENT_TIMESTAMP::timestamp, 'Morkranersargøta', 3, NULL, 666, 117420043);
INSERT INTO Person VALUES(DEFAULT, 'Vilhelmina', 'í Hvítanesi', CURRENT_TIMESTAMP::timestamp, 'Morkranersargøta', 3, NULL, 666, 991112006);
INSERT INTO Person VALUES(DEFAULT, 'Frida', 'Absalonsdóttir', CURRENT_TIMESTAMP::timestamp, 'Morkranersargøta', 3, NULL, 666, 241204006);
INSERT INTO Person VALUES(DEFAULT, 'Fríi', 'Absalonsson', CURRENT_TIMESTAMP::timestamp, 'Morkranersargøta', 3, NULL, 666, 241204103);
INSERT INTO Person VALUES(DEFAULT, 'Skrædla', 'Absalonsdóttir', CURRENT_TIMESTAMP::timestamp, 'Morkranersargøta', 3, NULL, 666, 160589248);

INSERT INTO Person VALUES(DEFAULT, 'Gírikur', 'McGvagg', CURRENT_TIMESTAMP::timestamp, 'Pengagøta', 1, NULL, 100, 696969698);

--Populate Customer--
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 1);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 2);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 3);

INSERT INTO Customer VALUES(DEFAULT, 'Normal', 4);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 5);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 6);

INSERT INTO Customer VALUES(DEFAULT, 'Normal', 7);

INSERT INTO Customer VALUES(DEFAULT, 'Normal', 8);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 9);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 10);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 11);
INSERT INTO Customer VALUES(DEFAULT, 'Normal', 12);

--Populate Employee--
INSERT INTO Employee VALUES(DEFAULT, 'Employee Name', 30000, 13);

--Populate Parent--
INSERT INTO Parent VALUES(1, 3);
INSERT INTO Parent VALUES(2, 3);
INSERT INTO Parent VALUES(4, 6);
INSERT INTO Parent VALUES(5, 6);
INSERT INTO Parent VALUES(8, 10);
INSERT INTO Parent VALUES(8, 11);
INSERT INTO Parent VALUES(8, 12);
INSERT INTO Parent VALUES(9, 10);
INSERT INTO Parent VALUES(9, 11);
INSERT INTO Parent VALUES(9, 12);

--Populate Spouse--
INSERT INTO Spouse VALUES(1, 2);
INSERT INTO Spouse VALUES(8, 9);

--Populate Account--
CALL createAccount(1, 1, 1000);
CALL createAccount(1, 2, 5000);
CALL createAccount(2, 1, 1000);
CALL createAccount(2, 2, 5000);
CALL createAccount(3, 1, 1000);

CALL createAccount(4, 1, 1000);
CALL createAccount(5, 1, 1000);
CALL createAccount(6, 1, 1000);

CALL createAccount(7, 1, 1000);
CALL createAccount(7, 2, 75000);

CALL createAccount(8, 1, 1000);
CALL createAccount(8, 2, 6500);
CALL createAccount(9, 1, 1000);
CALL createAccount(9, 2, 88000);
CALL createAccount(10, 1, 1000);
CALL createAccount(11, 1, 1000);
CALL createAccount(12, 1, 1000);

--Populate Customer Has Account--
