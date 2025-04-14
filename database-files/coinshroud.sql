CREATE DATABASE IF NOT EXISTS coinshroud_platform;
USE coinshroud_platform;

CREATE TABLE Projects(
    projectID VARCHAR(36) PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    status ENUM('active', 'pending', 'completed', 'suspended') DEFAULT 'active',
    quantity BIGINT
);

CREATE TABLE Developers(
    developerID VARCHAR(36) PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Investors(
    investorID VARCHAR(36) PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Average_Persons(
    userID VARCHAR(36) PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Wallet(
    walletID VARCHAR(36) PRIMARY KEY,
    balance FLOAT NOT NULL DEFAULT 0,
    investorID VARCHAR(36),
    userID VARCHAR(36),
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE AveragePersonWallet(
    walletID VARCHAR(36) PRIMARY KEY,
    balance FLOAT NOT NULL DEFAULT 0,
    userID VARCHAR(36),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE Portfolio(
    portfolioID VARCHAR(36) PRIMARY KEY,
    value FLOAT NOT NULL DEFAULT 0,
    holdings TEXT,
    investorID VARCHAR(36),
    userID VARCHAR(36),
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE Transactions(
    transactionID VARCHAR(36) PRIMARY KEY,
    buy DECIMAL(18,8),
    sell DECIMAL(18,8),
    userID VARCHAR(36),
    investorID VARCHAR(36),
    projectID VARCHAR(36),
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE Withdrawals(
    withdrawalID VARCHAR(36) PRIMARY KEY,
    amount DECIMAL(18,8) NOT NULL,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    investorID VARCHAR(36),
    userID VARCHAR(36),
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY(userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE Governing_Bodies(
    governingID VARCHAR(36) PRIMARY KEY,
    name TEXT
);

CREATE TABLE Regulators(
    regulatorID VARCHAR(36) PRIMARY KEY,
    agency VARCHAR(100) NOT NULL,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    governingID VARCHAR(36),
    FOREIGN KEY (governingID) REFERENCES Governing_Bodies(governingID)
);

CREATE TABLE Compliance_Report(
    reportID VARCHAR(36) PRIMARY KEY,
    isCompliant BOOLEAN DEFAULT TRUE,
    reportDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    regulatorID VARCHAR(36),
    projectID VARCHAR(36),
    FOREIGN KEY (regulatorID) REFERENCES Regulators(regulatorID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE Education(
    educationID VARCHAR(36),
    information TEXT NOT NULL
);

CREATE TABLE Develops(
    developerID VARCHAR(36),
    projectID VARCHAR(36),
    PRIMARY KEY (developerID, projectID),
    FOREIGN KEY (developerID) REFERENCES Developers(developerID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE Invests(
    investorID VARCHAR(36),
    projectID VARCHAR(36),
    PRIMARY KEY (investorID, projectID),
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE AvgInvests(
    userID VARCHAR(36),
    projectID VARCHAR(36),
    PRIMARY KEY (userID, projectID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);


-- Insert Projects
INSERT INTO Projects (projectID, FName, LName, status, quantity) VALUES
('proj-001', 'Bitcoin', 'Core', 'active', 21000000),
('proj-002', 'Ethereum', 'Platform', 'active', 120000000),
('proj-003', 'Solana', 'Chain', 'active', 500000000),
('proj-004', 'Cardano', 'Protocol', 'pending', 45000000),
('proj-005', 'Polkadot', 'Network', 'completed', 1000000000);

-- Insert Developers
INSERT INTO Developers (developerID, FName, LName, email) VALUES
('dev-001', 'John', 'Smith', 'john.smith@blockchain.dev'),
('dev-002', 'Emma', 'Johnson', 'emma.johnson@cryptodev.io'),
('dev-003', 'Michael', 'Chen', 'michael.chen@devcrypto.com'),
('dev-004', 'Sophia', 'Rodriguez', 'sophia.r@blockcoding.net'),
('dev-005', 'Alex', 'Kim', 'alexkim@devchain.tech');

-- Insert Investors
INSERT INTO Investors (investorID, FName, LName, email) VALUES
('inv-001', 'Robert', 'Williams', 'robert.williams@cryptoinvest.com'),
('inv-002', 'Jennifer', 'Garcia', 'j.garcia@venturecap.io'),
('inv-003', 'David', 'Miller', 'david.miller@blockventures.fund'),
('inv-004', 'Sarah', 'Brown', 'sarah.brown@investchain.com'),
('inv-005', 'James', 'Davis', 'james.davis@capitalcrypto.io');

-- Insert Average Persons
INSERT INTO Average_Persons (userID, FName, LName, email) VALUES
('user-001', 'Patricia', 'Jones', 'patricia.jones@gmail.com'),
('user-002', 'Thomas', 'Wilson', 'thomas.wilson@yahoo.com'),
('user-003', 'Elizabeth', 'Martinez', 'elizabeth.m@outlook.com'),
('user-004', 'Christopher', 'Anderson', 'chris.anderson@hotmail.com'),
('user-005', 'Jessica', 'Taylor', 'jessica.taylor@gmail.com');

-- Insert Wallet for Investors
INSERT INTO Wallet (walletID, balance, investorID, userID) VALUES
('wallet-001', 12.58943267, 'inv-001', NULL),
('wallet-002', 45.92781634, 'inv-002', NULL),
('wallet-003', 5.76429835, 'inv-003', NULL),
('wallet-004', 0.98734561, 'inv-004', NULL),
('wallet-005', 24.63579102, 'inv-005', NULL);

-- Insert Wallet for Average Persons
INSERT INTO Wallet (walletID, balance, investorID, userID) VALUES
('wallet-006', 1.24567890, NULL, 'user-001'),
('wallet-007', 0.58764321, NULL, 'user-002'),
('wallet-008', 3.21674938, NULL, 'user-003'),
('wallet-009', 0.12983745, NULL, 'user-004'),
('wallet-010', 2.74628195, NULL, 'user-005');

-- Insert AveragePersonWallet
INSERT INTO AveragePersonWallet (walletID, balance, userID) VALUES
('apw-001', 1.35789246, 'user-001'),
('apw-002', 0.42657981, 'user-002'),
('apw-003', 2.87543216, 'user-003'),
('apw-004', 0.19853746, 'user-004'),
('apw-005', 1.64285739, 'user-005');

-- Insert Portfolio
INSERT INTO Portfolio (portfolioID, value, holdings, investorID, userID) VALUES
('port-001', 250000.75, '{"proj-001": 2.5, "proj-002": 15.3, "proj-003": 500}', 'inv-001', NULL),
('port-002', 500000.25, '{"proj-002": 45.8, "proj-004": 10000}', 'inv-002', NULL),
('port-003', 125000.50, '{"proj-001": 1.2, "proj-003": 300, "proj-005": 2500}', 'inv-003', NULL),
('port-004', 75000.00, '{"proj-001": 0.8, "proj-002": 8.5}', NULL, 'user-001'),
('port-005', 35000.25, '{"proj-003": 400, "proj-005": 1200}', NULL, 'user-002');

-- Insert Transactions
INSERT INTO Transactions (transactionID, buy, sell, userID, investorID, projectID) VALUES
('trans-001', 0.25000000, NULL, NULL, 'inv-001', 'proj-001'),
('trans-002', 5.75000000, NULL, NULL, 'inv-002', 'proj-002'),
('trans-003', NULL, 0.15000000, NULL, 'inv-003', 'proj-001'),
('trans-004', 150.00000000, NULL, 'user-001', NULL, 'proj-003'),
('trans-005', NULL, 75.00000000, 'user-002', NULL, 'proj-003'),
('trans-006', 1.20000000, NULL, NULL, 'inv-004', 'proj-002'),
('trans-007', NULL, 500.00000000, NULL, 'inv-005', 'proj-005'),
('trans-008', 0.05000000, NULL, 'user-003', NULL, 'proj-001');

-- Insert Withdrawals
INSERT INTO Withdrawals (withdrawalID, amount, status, date, investorID, userID) VALUES
('with-001', 2.50000000, 'approved', '2025-04-01 10:30:00', 'inv-001', NULL),
('with-002', 10.00000000, 'pending', '2025-04-02 14:45:00', 'inv-002', NULL),
('with-003', 5.25000000, 'rejected', '2025-04-03 09:15:00', 'inv-003', NULL),
('with-004', 0.75000000, 'approved', '2025-04-04 16:20:00', NULL, 'user-001'),
('with-005', 1.50000000, 'pending', '2025-04-05 11:05:00', NULL, 'user-002');

-- Insert Governing Bodies
INSERT INTO Governing_Bodies (governingID, name) VALUES
('gov-001', 'Securities and Exchange Commission'),
('gov-002', 'Financial Conduct Authority'),
('gov-003', 'European Securities and Markets Authority'),
('gov-004', 'Monetary Authority of Singapore'),
('gov-005', 'Japan Financial Services Agency');

-- Insert Regulators
INSERT INTO Regulators (regulatorID, agency, FName, LName, governingID) VALUES
('reg-001', 'SEC', 'William', 'Jackson', 'gov-001'),
('reg-002', 'FCA', 'Margaret', 'Thompson', 'gov-002'),
('reg-003', 'ESMA', 'Richard', 'Martin', 'gov-003'),
('reg-004', 'MAS', 'Emily', 'Wong', 'gov-004'),
('reg-005', 'JFSA', 'Takashi', 'Yamamoto', 'gov-005');

-- Insert Compliance Reports
INSERT INTO Compliance_Report (reportID, isCompliant, reportDate, regulatorID, projectID) VALUES
('comp-001', TRUE, '2025-03-10 09:00:00', 'reg-001', 'proj-001'),
('comp-002', TRUE, '2025-03-15 14:30:00', 'reg-002', 'proj-002'),
('comp-003', FALSE, '2025-03-20 11:15:00', 'reg-003', 'proj-003'),
('comp-004', TRUE, '2025-03-25 16:45:00', 'reg-004', 'proj-004'),
('comp-005', FALSE, '2025-03-30 10:30:00', 'reg-005', 'proj-005');

-- Insert Education Resources
INSERT INTO Education (educationID, information) VALUES
('edu-001', 'Introduction to Blockchain: Blockchain technology is a distributed ledger system that maintains a continuously growing list of records called blocks. Each block contains a timestamp and a link to the previous block, forming a chain of blocks, hence the name "blockchain."'),
('edu-002', 'Cryptocurrency Basics: Cryptocurrencies are digital or virtual currencies that use cryptography for security. Unlike traditional currencies issued by governments, cryptocurrencies operate on decentralized networks based on blockchain technology.'),
('edu-003', 'Smart Contracts Explained: Smart contracts are self-executing contracts where the terms of the agreement between buyer and seller are directly written into code. They automatically enforce and execute terms when predetermined conditions are met.'),
('edu-004', 'Investment Strategies: Diversification is key in cryptocurrency investing. Consider allocating your investments across different types of cryptocurrencies and blockchain projects to minimize risk.'),
('edu-005', 'Regulatory Compliance: Understanding the regulatory environment is crucial for cryptocurrency investors and developers. Regulations vary by country and are continuously evolving as governments develop frameworks to address this new technology.');

-- Insert Develops relationships
INSERT INTO Develops (developerID, projectID) VALUES
('dev-001', 'proj-001'),
('dev-001', 'proj-002'),
('dev-002', 'proj-002'),
('dev-002', 'proj-003'),
('dev-003', 'proj-003'),
('dev-003', 'proj-004'),
('dev-004', 'proj-004'),
('dev-004', 'proj-005'),
('dev-005', 'proj-005'),
('dev-005', 'proj-001');

-- Insert Invests relationships
INSERT INTO Invests (investorID, projectID) VALUES
('inv-001', 'proj-001'),
('inv-001', 'proj-002'),
('inv-001', 'proj-003'),
('inv-002', 'proj-002'),
('inv-002', 'proj-004'),
('inv-003', 'proj-001'),
('inv-003', 'proj-003'),
('inv-003', 'proj-005'),
('inv-004', 'proj-002'),
('inv-005', 'proj-005');

-- Insert AvgInvests relationships
INSERT INTO AvgInvests (userID, projectID) VALUES
('user-001', 'proj-001'),
('user-001', 'proj-002'),
('user-002', 'proj-003'),
('user-002', 'proj-005'),
('user-003', 'proj-001'),
('user-004', 'proj-002'),
('user-004', 'proj-004'),
('user-005', 'proj-003'),
('user-005', 'proj-005');



