CREATE DATABASE IF NOT EXISTS coinshroud_platform;
USE coinshroud_platform;

CREATE TABLE Projects(
    projectID INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT NOT NULL,
    status ENUM('active', 'pending', 'completed', 'suspended') DEFAULT 'active',
    price BIGINT,
    quantity BIGINT
);

CREATE TABLE Developers(
    developerID INT AUTO_INCREMENT PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Investors(
    investorID INT AUTO_INCREMENT PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL,
    agency TEXT NOT NULL
);

CREATE TABLE Average_Persons(
    userID INT AUTO_INCREMENT PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Wallet(
    walletID INT AUTO_INCREMENT PRIMARY KEY,
    balance FLOAT NOT NULL DEFAULT 0,
    investorID INT,
    userID INT,
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE Portfolio(
    portfolioID INT AUTO_INCREMENT PRIMARY KEY,
    value FLOAT NOT NULL DEFAULT 0,
    holdings TEXT,
    investorID INT,
    userID INT,
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE Transactions(
    transactionID INT AUTO_INCREMENT PRIMARY KEY,
    buy DECIMAL(18,8),
    sell DECIMAL(18,8),
    userID INT,
    investorID INT,
    projectID INT,
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE Withdrawals(
    withdrawalID INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(18,8) NOT NULL,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    investorID INT,
    userID INT,
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY(userID) REFERENCES Average_Persons(userID)
);

CREATE TABLE Governing_Bodies(
    governingID INT AUTO_INCREMENT PRIMARY KEY,
    name TEXT
);

CREATE TABLE Regulators(
    regulatorID INT AUTO_INCREMENT PRIMARY KEY,
    agency VARCHAR(100) NOT NULL,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    governingID INT,
    FOREIGN KEY (governingID) REFERENCES Governing_Bodies(governingID)
);

CREATE TABLE IF NOT EXISTS compliance_rules(
    c_id INT AUTO_INCREMENT PRIMARY KEY,
    compliance_rules TEXT NOT NULL
);

CREATE TABLE Compliance_Report(
    reportID INT AUTO_INCREMENT PRIMARY KEY,
    isCompliant BOOLEAN DEFAULT TRUE,
    reportDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    regulatorID INT,
    projectID INT,
    FOREIGN KEY (regulatorID) REFERENCES Regulators(regulatorID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE Education(
    educationID INT AUTO_INCREMENT PRIMARY KEY,
    information TEXT NOT NULL
);

CREATE TABLE Develops(
    developerID INT,
    projectID INT,
    PRIMARY KEY (developerID, projectID),
    FOREIGN KEY (developerID) REFERENCES Developers(developerID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE Invests(
    investorID INT,
    projectID INT,
    PRIMARY KEY (investorID, projectID),
    FOREIGN KEY (investorID) REFERENCES Investors(investorID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);

CREATE TABLE AvgInvests(
    userID INT,
    projectID INT,
    PRIMARY KEY (userID, projectID),
    FOREIGN KEY (userID) REFERENCES Average_Persons(userID),
    FOREIGN KEY(projectID) REFERENCES Projects(projectID)
);
-- Insert Projects
INSERT INTO Projects (name, status, price, quantity) VALUES
    ('BitcoinMax', 'active', 47000000000, 5000),
    ('EthereumPro', 'active', 3200000000, 25000),
    ('SolanaSphere', 'active', 120000000, 150000),
    ('CardanoEdge', 'pending', 55000000, 75000),
    ('PolkadotMatrix', 'active', 15000000, 200000),
    ('RippleWave', 'completed', 80000000, 450000),
    ('DogecoinRocket', 'active', 12000000, 850000),
    ('ChainlinkNode', 'pending', 22000000, 65000),
    ('AvalancheFlow', 'active', 35000000, 38000),
    ('AlgorandSmart', 'completed', 40000000, 120000),
    ('TezosToken', 'active', 8000000, 220000),
    ('StellarLumens', 'suspended', 32000000, 190000),
    ('MoneroPrivate', 'active', 160000000, 28000),
    ('CosmosCentral', 'pending', 18000000, 95000),
    ('Neo3Digital', 'active', 65000000, 42000),
    ('VeChainSupply', 'completed', 10000000, 320000),
    ('FilecoinStorage', 'active', 48000000, 56000),
    ('DecentralandMeta', 'active', 6000000, 580000),
    ('TheGraphIndex', 'pending', 14000000, 250000),
    ('ArweaveStore', 'active', 28000000, 78000),
    ('ElrondNetwork', 'suspended', 75000000, 34000),
    ('HederaHash', 'active', 30000000, 145000),
    ('IoTeXChain', 'active', 9000000, 270000),
    ('OntologyTrust', 'pending', 17000000, 180000),
    ('ZilliqaShard', 'active', 12000000, 310000),
    ('NanoFast', 'completed', 5000000, 425000),
    ('HeliumHNT', 'active', 25000000, 85000),
    ('ThorchainSwap', 'active', 58000000, 46000),
    ('WavesProtocol', 'pending', 20000000, 135000),
    ('DashPay', 'active', 110000000, 22000),
    ('ZcashPrivacy', 'active', 140000000, 18000),
    ('EnjinNFT', 'completed', 19000000, 290000),
    ('IconNetwork', 'active', 11000000, 350000),
    ('QtumSmart', 'suspended', 15000000, 210000),
    ('DigiByteTech', 'active', 3000000, 720000),
    ('SiacoinCloud', 'pending', 4000000, 850000),
    ('RevainReview', 'active', 7000000, 390000),
    ('StatusMobile', 'completed', 13000000, 240000),
    ('LiskPlatform', 'active', 16000000, 175000),
    ('BancorExchange', 'active', 21000000, 130000);


INSERT INTO Investors (FName, LName, email, agency) VALUES
    ('Danielle', 'Johnson', 'jeffreydoyle@hotmail.com', 'Mcclain, Miller and Henderson'),
    ('Anthony', 'Robinson', 'jennifermiles@robinson-lawrence.com', 'Wolfe LLC'),
    ('Joshua', 'Lewis', 'daviscolin@yahoo.com', 'Baker, Williams and Stevens'),
    ('David', 'Nielsen', 'maria95@lee.com', 'Wyatt Inc'),
    ('Norman', 'Chavez', 'mitchellclark@yahoo.com', 'Zuniga, Wong and Lynch'),
    ('George', 'Daniel', 'ogray@hawkins.com', 'Underwood LLC'),
    ('Richard', 'Jones', 'dianafoster@hotmail.com', 'Thomas-Taylor'),
    ('Julie', 'Ryan', 'icox@hotmail.com', 'Davis-Williams'),
    ('Daniel', 'Burton', 'cruzcaitlin@yahoo.com', 'King, Tran and Dunlap'),
    ('Erin', 'Wilson', 'daniel62@yahoo.com', 'Mckay Ltd'),
    ('Jose', 'Mason', 'harrellkenneth@romero.com', 'Ashley, Nielsen and Sellers'),
    ('Carol', 'Burns', 'natasha43@allen.com', 'Dennis Inc'),
    ('Tiffany', 'Patel', 'donnaarroyo@baker.biz', 'Hickman Ltd'),
    ('Hannah', 'Marquez', 'samuel87@gmail.com', 'Walker LLC'),
    ('Andrew', 'Spencer', 'jonescrystal@jones.com', 'Palmer LLC'),
    ('Elizabeth', 'Lewis', 'esanchez@lee-davis.biz', 'Henderson-Owens'),
    ('Jessica', 'Nunez', 'powellmatthew@wright.net', 'Taylor-White'),
    ('Steven', 'Baxter', 'jmorton@williams.com', 'House and Sons'),
    ('Gabriel', 'Tucker', 'kbarrera@smith-myers.info', 'Henderson-Bernard'),
    ('Wendy', 'Peters', 'jamesrobinson@gmail.com', 'Fitzgerald, Brown and Edwards'),
    ('Brendan', 'Woods', 'yuchristopher@jones.com', 'Wilson-Zamora'),
    ('John', 'Wheeler', 'ksandoval@stewart.com', 'Baker and Sons'),
    ('Emily', 'Evans', 'smithchristine@hotmail.com', 'Jones and Sons'),
    ('William', 'Anderson', 'suarezmike@gmail.com', 'Bass-Warner'),
    ('Cheryl', 'Archer', 'sarah12@wilson-rodriguez.net', 'Nelson PLC'),
    ('Jason', 'Cooper', 'dking@gmail.com', 'Henderson, Hill and Smith'),
    ('Kellie', 'Walsh', 'joycearnold@yahoo.com', 'Smith, Jones and Ware'),
    ('Rebecca', 'Gardner', 'russellwilliams@yahoo.com', 'Nolan and Sons'),
    ('Evelyn', 'Estrada', 'vdickson@gmail.com', 'Hancock and Sons'),
    ('Nicole', 'Johnson', 'vpham@gmail.com', 'Moore-Haynes'),
    ('Patrick', 'Williams', 'jamessellers@yahoo.com', 'Hoover-Savage'),
    ('Jeffrey', 'Keller', 'joshua14@yahoo.com', 'Hicks, Frazier and Anthony'),
    ('Mark', 'Johnson', 'beverlyterrell@gmail.com', 'Carlson LLC'),
    ('Jessica', 'Edwards', 'mlam@williams-graham.net', 'Mcdaniel, Bentley and Mclaughlin'),
    ('James', 'Reynolds', 'elizabeth14@hotmail.com', 'Estrada-Nguyen'),
    ('Heidi', 'Spencer', 'yortega@adkins.biz', 'Bass, Torres and Clark'),
    ('Kristi', 'Lawson', 'rramos@gmail.com', 'Kennedy, Santana and Flynn'),
    ('Gene', 'Miller', 'cardenaskaren@hotmail.com', 'Walker-Gonzalez'),
    ('Andrew', 'Sanchez', 'gibsonolivia@hotmail.com', 'Higgins Group'),
    ('Troy', 'Sanchez', 'osbornejeffery@holmes.com', 'Anderson-Marshall');

-- Insert Average Persons
INSERT INTO Average_Persons (FName, LName, email) VALUES
    ('Amanda', 'Hansen', 'usalazar@hotmail.com'),
    ('Ronald', 'Meadows', 'juliawells@yahoo.com'),
    ('Karen', 'Larsen', 'rsims@yahoo.com'),
    ('Chris', 'Mitchell', 'luis81@gmail.com'),
    ('Edward', 'Reyes', 'calebrussell@owens.biz'),
    ('Rebecca', 'Silva', 'wwoods@molina-castaneda.biz'),
    ('Amanda', 'Navarro', 'brobinson@johnson-rogers.biz'),
    ('Jennifer', 'Pittman', 'meadowsbrittany@johnson.info'),
    ('Hunter', 'Green', 'shawnrogers@yahoo.com'),
    ('Joshua', 'Bean', 'mary70@hotmail.com'),
    ('Amber', 'Cooke', 'debraharrington@hotmail.com'),
    ('Billy', 'Johnson', 'maryhowell@martinez.com'),
    ('Anne', 'Robinson', 'gary91@gmail.com'),
    ('Tami', 'Rodriguez', 'barbara66@gonzalez.com'),
    ('Curtis', 'Barton', 'reedross@jones-holland.com'),
    ('Melissa', 'Short', 'oyu@zimmerman-graham.net'),
    ('Tammy', 'Nelson', 'ugraham@hotmail.com'),
    ('Joseph', 'Christian', 'nicole37@bishop.com'),
    ('Hunter', 'Lewis', 'joshua94@hotmail.com'),
    ('Alejandro', 'Vaughan', 'jenniferfreeman@vaughn.info'),
    ('Shane', 'Smith', 'richardsanchez@hotmail.com'),
    ('Bonnie', 'Kennedy', 'jbarajas@yahoo.com'),
    ('Michael', 'Chavez', 'jerry35@gmail.com'),
    ('Julia', 'Tapia', 'javierwashington@lawrence.com'),
    ('Marissa', 'Phillips', 'kevinerickson@gmail.com'),
    ('Joshua', 'Mccann', 'danamullins@gmail.com'),
    ('Monique', 'Andrews', 'lalexander@gmail.com'),
    ('Johnny', 'Hensley', 'moralescharles@parks.com'),
    ('Christopher', 'Wright', 'kimberlyjames@yahoo.com'),
    ('Kenneth', 'Chapman', 'ashley09@hotmail.com'),
    ('Cory', 'Farmer', 'donna23@arnold.com'),
    ('Ricky', 'Norris', 'antonio44@hotmail.com'),
    ('Michele', 'Jones', 'kristin93@wilson-walker.com'),
    ('Rebekah', 'Serrano', 'martinkyle@holloway.info'),
    ('Haley', 'Lyons', 'mkim@gmail.com'),
    ('Pamela', 'Navarro', 'davissuzanne@hotmail.com'),
    ('Brenda', 'Smith', 'hinesgregory@hotmail.com'),
    ('Denise', 'Moon', 'fwalters@harrison.com'),
    ('Manuel', 'Garcia', 'robert74@landry.info'),
    ('Christopher', 'King', 'ahancock@booth.net');

-- Insert Developers
INSERT INTO Developers (FName, LName, email) VALUES
    ('Michael', 'Avila', 'harrisandrea@yahoo.com'),
    ('Samuel', 'Wolfe', 'dudleychelsea@mckinney.net'),
    ('Alexander', 'Russell', 'murraydavid@jimenez.com'),
    ('William', 'Hill', 'jsanchez@gmail.com'),
    ('Patrick', 'Weeks', 'hillkristy@morgan-french.com'),
    ('Lori', 'Campbell', 'cgrimes@hotmail.com'),
    ('Todd', 'Cook', 'mcantu@hotmail.com'),
    ('John', 'Reyes', 'floresthomas@yahoo.com'),
    ('Paul', 'Alvarado', 'ihanna@sanford.info'),
    ('Cory', 'Lozano', 'robertpena@jones.com'),
    ('Cindy', 'Sanders', 'melissa86@sims-clay.info'),
    ('Monique', 'Johnson', 'crystalmccall@francis.com'),
    ('Kathleen', 'Padilla', 'tjackson@williams.com'),
    ('Michael', 'Jordan', 'yknight@jackson.org'),
    ('Monica', 'Harvey', 'jdurham@murray.info'),
    ('Jonathan', 'Smith', 'erica21@yahoo.com'),
    ('Sierra', 'Huerta', 'dvaughn@yahoo.com'),
    ('James', 'Cruz', 'youngashley@hotmail.com'),
    ('Kenneth', 'Lyons', 'khill@osborne.info'),
    ('Marissa', 'Leach', 'jeffery39@byrd-le.com'),
    ('Courtney', 'Berger', 'kristina09@oconnor-davis.com'),
    ('Mark', 'Perry', 'kristinwalter@schmidt-mcintyre.com'),
    ('Jonathan', 'Summers', 'julie51@yahoo.com'),
    ('Sydney', 'Taylor', 'zcoffey@diaz.net'),
    ('David', 'Richardson', 'xcarson@gmail.com'),
    ('Emily', 'Ruiz', 'deborahreid@yahoo.com'),
    ('Regina', 'Turner', 'taylorsophia@yahoo.com'),
    ('Wendy', 'Wilson', 'paulwatson@horton.com'),
    ('Nicole', 'Pena', 'rcrosby@gmail.com'),
    ('Hannah', 'Robinson', 'melissagarcia@hotmail.com'),
    ('Michael', 'Winters', 'sandersjames@gmail.com'),
    ('Stacy', 'Holloway', 'darleneharper@williams.com'),
    ('Vanessa', 'Buchanan', 'gallegosangela@robinson.com'),
    ('Kristina', 'Carlson', 'vanessafernandez@gmail.com'),
    ('Daniel', 'Delacruz', 'howardkristina@morris.biz'),
    ('Alicia', 'Reese', 'gstrickland@hotmail.com'),
    ('Daniel', 'Gordon', 'stephen00@boone-simmons.com'),
    ('Tracy', 'Browning', 'morriseddie@hill.org'),
    ('Amy', 'Nguyen', 'bwagner@gmail.com'),
    ('Laura', 'Wilson', 'ohayes@morgan-chavez.biz');

-- NOTE: Projects table's insert stays the same as it already uses INT ids

-- Insert Wallet
-- Using the auto-increment for walletID and referencing numeric investorID and userID
INSERT INTO Wallet (balance, investorID, userID) VALUES
    (7977.31, 1, NULL),
    (3685.2, NULL, 2),
    (1939.33, 3, NULL),
    (5703.63, NULL, 4),
    (1692.17, 5, NULL),
    (7403.08, NULL, 6),
    (684.43, 7, NULL),
    (3623.02, NULL, 8),
    (8294.63, 9, NULL),
    (7915.68, NULL, 10),
    (2427.11, 11, NULL),
    (6821.59, NULL, 12),
    (314.22, 13, NULL),
    (4285.26, NULL, 14),
    (1125.42, 15, NULL),
    (9749.76, NULL, 16),
    (7219.36, 17, NULL),
    (4407.49, NULL, 18),
    (3229.61, 19, NULL),
    (8180.36, NULL, 20),
    (4662.64, 21, NULL),
    (2643.24, NULL, 22),
    (2987.11, 23, NULL),
    (4841.05, NULL, 24),
    (3712.55, 25, NULL),
    (1021.33, NULL, 26),
    (5380.18, 27, NULL),
    (1305.65, NULL, 28),
    (8225.28, 29, NULL),
    (7362.44, NULL, 30),
    (2823.94, 31, NULL),
    (3253.49, NULL, 32),
    (4350.35, 33, NULL),
    (8786.56, NULL, 34),
    (822.59, 35, NULL),
    (3601.33, NULL, 36),
    (5721.44, 37, NULL),
    (4991.35, NULL, 38),
    (8183.45, 39, NULL),
    (8708.9, NULL, 40);

-- Insert Portfolio
INSERT INTO Portfolio (value, holdings, investorID, userID) VALUES
    (8166.87, 'BTC,ETH,USDT', 1, NULL),
    (4444.15, 'BTC,SOL,ADA', NULL, 1),
    (14216.96, 'BTC,ETH,USDT', 3, NULL),
    (20452.84, 'BTC,SOL,ADA', NULL, 4),
    (2315.37, 'ETH,DOGE', 5, NULL),
    (21292.46, 'BTC,ETH', NULL, 6),
    (7929.87, 'DOT,XRP', 7, NULL),
    (14778.15, 'DOT,XRP', NULL, 8),
    (20071.58, 'BTC,ETH', 9, NULL),
    (6457.19, 'BTC,SOL,ADA', NULL, 10),
    (12240.61, 'ETH,DOGE', 11, NULL),
    (18324.79, 'BTC,ETH,USDT', NULL, 12),
    (24740.63, 'ETH,DOGE', 13, NULL),
    (3987.87, 'DOT,XRP', NULL, 14),
    (19357.06, 'DOT,XRP', 15, NULL),
    (1274.56, 'BTC,SOL,ADA', NULL, 16),
    (3868.65, 'BTC,SOL,ADA', 17, NULL),
    (20424.36, 'BTC,SOL,ADA', NULL, 18),
    (16357.01, 'BTC,ETH', 19, NULL),
    (7881.88, 'ETH,DOGE', NULL, 20),
    (17542.54, 'BTC,SOL,ADA', 21, NULL),
    (1658.43, 'DOT,XRP', NULL, 22),
    (6777.44, 'ETH,DOGE', 23, NULL),
    (9129.68, 'BTC,ETH', NULL, 24),
    (1800.63, 'BTC,ETH', 25, NULL),
    (6860.06, 'BTC,ETH', NULL, 26),
    (12285.74, 'BTC,SOL,ADA', 27, NULL),
    (858.69, 'ETH,DOGE', NULL, 28),
    (7559.0, 'BTC,ETH', 29, NULL),
    (18666.63, 'DOT,XRP', NULL, 30),
    (18862.56, 'BTC,ETH,USDT', 31, NULL),
    (24598.95, 'BTC,ETH', NULL, 32),
    (4465.31, 'BTC,ETH,USDT', 33, NULL),
    (9904.55, 'BTC,ETH,USDT', NULL, 34),
    (18173.92, 'DOT,XRP', 35, NULL),
    (13324.27, 'BTC,SOL,ADA', NULL, 36),
    (24581.74, 'DOT,XRP', 37, NULL),
    (20657.23, 'BTC,ETH,USDT', NULL, 38),
    (24223.84, 'ETH,DOGE', 39, NULL),
    (22763.9, 'BTC,SOL,ADA', NULL, 40);

-- Insert Withdrawals
INSERT INTO Withdrawals (amount, status, date, investorID, userID) VALUES
    (1456.89272736, 'rejected', '2024-02-03 00:00:00', 1, NULL),
    (7616.70332856, 'approved', '2024-10-17 00:00:00', NULL, 2),
    (4024.20269521, 'pending', '2024-03-23 00:00:00', 3, NULL),
    (4785.27110312, 'pending', '2024-02-12 00:00:00', NULL, 4),
    (5776.25262584, 'rejected', '2024-09-25 00:00:00', 5, NULL),
    (2511.02358553, 'rejected', '2024-01-26 00:00:00', NULL, 6),
    (4924.70414523, 'rejected', '2024-02-03 00:00:00', 7, NULL),
    (3297.04344023, 'rejected', '2024-02-27 00:00:00', NULL, 8),
    (4657.21870039, 'rejected', '2024-10-31 00:00:00', 9, NULL),
    (6321.2268526, 'pending', '2024-02-17 00:00:00', NULL, 10),
    (5546.59430774, 'approved', '2024-02-15 00:00:00', 11, NULL),
    (6001.23168591, 'pending', '2024-07-15 00:00:00', NULL, 12),
    (349.24126135, 'rejected', '2024-06-26 00:00:00', 13, NULL),
    (2169.10629011, 'pending', '2024-04-13 00:00:00', NULL, 14),
    (5615.87725273, 'approved', '2024-11-17 00:00:00', 15, NULL),
    (6306.50081296, 'pending', '2024-11-21 00:00:00', NULL, 16),
    (4054.82475929, 'approved', '2024-06-13 00:00:00', 17, NULL),
    (3636.34613033, 'approved', '2024-07-13 00:00:00', NULL, 18),
    (3107.08072518, 'approved', '2024-03-30 00:00:00', 19, NULL),
    (3096.46147585, 'approved', '2024-11-04 00:00:00', NULL, 20),
    (95.18102162, 'approved', '2024-07-28 00:00:00', 21, NULL),
    (1659.34163247, 'approved', '2024-07-02 00:00:00', NULL, 22),
    (4134.04174624, 'rejected', '2024-07-21 00:00:00', 23, NULL),
    (6063.78546121, 'approved', '2024-10-26 00:00:00', NULL, 24),
    (6177.51023936, 'pending', '2024-12-10 00:00:00', 25, NULL),
    (2031.11350116, 'approved', '2024-03-23 00:00:00', NULL, 26),
    (3996.17661304, 'pending', '2024-08-27 00:00:00', 27, NULL),
    (3000.62288651, 'pending', '2024-08-26 00:00:00', NULL, 28),
    (6882.62348517, 'pending', '2024-10-09 00:00:00', 29, NULL),
    (4540.46695626, 'pending', '2024-01-22 00:00:00', NULL, 30),
    (7890.87440657, 'pending', '2024-03-17 00:00:00', 31, NULL),
    (1390.75619084, 'pending', '2024-10-08 00:00:00', NULL, 32),
    (3418.65900175, 'rejected', '2024-10-24 00:00:00', 33, NULL),
    (6715.87041824, 'rejected', '2024-08-22 00:00:00', NULL, 34),
    (4216.47802227, 'approved', '2024-03-30 00:00:00', 35, NULL),
    (4077.21932846, 'pending', '2024-01-12 00:00:00', NULL, 36),
    (103.51420758, 'approved', '2024-11-19 00:00:00', 37, NULL),
    (1539.67750559, 'approved', '2024-09-03 00:00:00', NULL, 38),
    (5671.66747435, 'pending', '2024-11-23 00:00:00', 39, NULL),
    (4551.55370512, 'approved', '2024-04-23 00:00:00', NULL, 40);

-- Insert Governing Bodies
INSERT INTO Governing_Bodies (name) VALUES
    ('Crypto Regulatory Commission 1'),
    ('Crypto Regulatory Commission 2'),
    ('Crypto Regulatory Commission 3'),
    ('Crypto Regulatory Commission 4'),
    ('Crypto Regulatory Commission 5'),
    ('Crypto Regulatory Commission 6'),
    ('Crypto Regulatory Commission 7'),
    ('Crypto Regulatory Commission 8'),
    ('Crypto Regulatory Commission 9'),
    ('Crypto Regulatory Commission 10'),
    ('Crypto Regulatory Commission 11'),
    ('Crypto Regulatory Commission 12'),
    ('Crypto Regulatory Commission 13'),
    ('Crypto Regulatory Commission 14'),
    ('Crypto Regulatory Commission 15'),
    ('Crypto Regulatory Commission 16'),
    ('Crypto Regulatory Commission 17'),
    ('Crypto Regulatory Commission 18'),
    ('Crypto Regulatory Commission 19'),
    ('Crypto Regulatory Commission 20'),
    ('Crypto Regulatory Commission 21'),
    ('Crypto Regulatory Commission 22'),
    ('Crypto Regulatory Commission 23'),
    ('Crypto Regulatory Commission 24'),
    ('Crypto Regulatory Commission 25'),
    ('Crypto Regulatory Commission 26'),
    ('Crypto Regulatory Commission 27'),
    ('Crypto Regulatory Commission 28'),
    ('Crypto Regulatory Commission 29'),
    ('Crypto Regulatory Commission 30'),
    ('Crypto Regulatory Commission 31'),
    ('Crypto Regulatory Commission 32'),
    ('Crypto Regulatory Commission 33'),
    ('Crypto Regulatory Commission 34'),
    ('Crypto Regulatory Commission 35'),
    ('Crypto Regulatory Commission 36'),
    ('Crypto Regulatory Commission 37'),
    ('Crypto Regulatory Commission 38'),
    ('Crypto Regulatory Commission 39'),
    ('Crypto Regulatory Commission 40');

-- Insert Regulators
-- Using sequential IDs and fixing references to governingID
INSERT INTO Regulators (agency, FName, LName, governingID) VALUES
    ('OCC', 'Bob', 'Taylor', 1),
    ('OCC', 'Henry', 'Young', 2),
    ('OCC', 'Bob', 'Johnson', 3),
    ('CFTC', 'Jack', 'Clark', 4),
    ('CFTC', 'Henry', 'Smith', 5),
    ('OCC', 'Bob', 'Clark', 6),
    ('CFTC', 'Catherine', 'King', 7),
    ('SEC', 'Jack', 'Allen', 8),
    ('FINRA', 'Alice', 'Allen', 9),
    ('CFTC', 'Grace', 'Hall', 10),
    ('OCC', 'Henry', 'Clark', 11),
    ('OCC', 'Alice', 'King', 12),
    ('FINRA', 'Henry', 'Johnson', 13),
    ('SEC', 'Bob', 'Brown', 14),
    ('CFTC', 'Henry', 'Young', 15),
    ('SEC', 'Grace', 'Smith', 16),
    ('CFTC', 'Alice', 'King', 17),
    ('FINRA', 'Elena', 'Clark', 18),
    ('OCC', 'David', 'Taylor', 19),
    ('SEC', 'Catherine', 'Clark', 20),
    ('OCC', 'Bob', 'Smith', 21),
    ('CFTC', 'Catherine', 'Johnson', 22),
    ('FINRA', 'Alice', 'Young', 23),
    ('OCC', 'Elena', 'Allen', 24),
    ('SEC', 'Grace', 'Brown', 25),
    ('OCC', 'David', 'Lee', 26),
    ('FINRA', 'Henry', 'King', 27),
    ('FINRA', 'Ivy', 'Johnson', 28),
    ('CFTC', 'Henry', 'Johnson', 29),
    ('CFTC', 'Henry', 'Young', 30),
    ('FINRA', 'Alice', 'King', 31),
    ('CFTC', 'Grace', 'Smith', 32),
    ('FINRA', 'Ivy', 'Clark', 33),
    ('FINRA', 'David', 'Lee', 34),
    ('CFTC', 'Elena', 'Smith', 35),
    ('CFTC', 'Grace', 'Smith', 36),
    ('OCC', 'Elena', 'Young', 37),
    ('CFTC', 'Elena', 'Smith', 38),
    ('CFTC', 'Catherine', 'Clark', 39),
    ('CFTC', 'Elena', 'Lee', 40);

-- Compliance Rules table doesn't need changes since it already uses INT id

-- Insert Compliance Report with INT IDs
INSERT INTO Compliance_Report (isCompliant, reportDate, regulatorID, projectID) VALUES
    (False, '2024-06-15 00:00:00', 1, 1),
    (True, '2024-11-19 00:00:00', 2, 2),
    (False, '2024-05-24 00:00:00', 3, 3),
    (True, '2024-11-23 00:00:00', 4, 4),
    (False, '2024-03-25 00:00:00', 5, 5),
    (False, '2024-02-02 00:00:00', 6, 6),
    (False, '2024-07-01 00:00:00', 7, 7),
    (True, '2024-03-29 00:00:00', 8, 8),
    (False, '2024-11-21 00:00:00', 9, 9),
    (True, '2024-08-11 00:00:00', 10, 10),
    (False, '2024-03-23 00:00:00', 11, 11),
    (False, '2024-12-27 00:00:00', 12, 12),
    (True, '2024-02-16 00:00:00', 13, 13),
    (False, '2024-11-02 00:00:00', 14, 14),
    (True, '2024-11-18 00:00:00', 15, 15),
    (True, '2024-08-15 00:00:00', 16, 16),
    (True, '2024-03-26 00:00:00', 17, 17),
    (False, '2024-12-31 00:00:00', 18, 18),
    (True, '2024-11-04 00:00:00', 19, 19),
    (True, '2024-01-24 00:00:00', 20, 20),
    (True, '2024-03-27 00:00:00', 21, 21),
    (False, '2024-07-21 00:00:00', 22, 22),
    (False, '2024-12-14 00:00:00', 23, 23),
    (True, '2024-04-15 00:00:00', 24, 24),
    (True, '2024-12-01 00:00:00', 25, 25),
    (True, '2024-11-25 00:00:00', 26, 26),
    (False, '2024-04-25 00:00:00', 27, 27),
    (False, '2024-10-27 00:00:00', 28, 28),
    (False, '2024-09-15 00:00:00', 29, 29),
    (False, '2024-08-17 00:00:00', 30, 30),
    (False, '2024-09-23 00:00:00', 31, 31),
    (True, '2024-03-21 00:00:00', 32, 32),
    (True, '2024-03-30 00:00:00', 33, 33),
    (False, '2024-10-30 00:00:00', 34, 34),
    (True, '2024-04-18 00:00:00', 35, 35),
    (True, '2024-12-27 00:00:00', 36, 36),
    (True, '2024-06-20 00:00:00', 37, 37),
    (True, '2024-11-19 00:00:00', 38, 38),
    (True, '2024-12-02 00:00:00', 39, 39),
    (True, '2024-06-24 00:00:00', 40, 40);

-- Update Education to use INT ID
INSERT INTO Education (information) VALUES
    ('Investing in cryptocurrency has become increasingly popular, especially among younger and tech-savvy individuals who are looking for alternatives to traditional stocks and bonds. At its core, cryptocurrency is digital money built on blockchain technology—a decentralized system that allows people to exchange value without needing a bank or middleman. The most well-known cryptocurrencies include Bitcoin and Ethereum, but there are thousands of others, each with different use cases, communities, and levels of risk.

Unlike traditional investments, crypto markets operate 24/7 and can experience dramatic price swings in short periods. For example, the value of a token could double overnight or drop by half. That volatility creates opportunities for gains but also increases the chances of loss. This is why most financial advisors recommend only investing a small portion of your portfolio in crypto, especially if you are just starting out.

Before investing, it is crucial to research each project understand what problem it aims to solve, who s behind it, and whether it has real-world utility. Avoid buying coins just because they are trending on social media. Instead, focus on tokens with strong fundamentals, active development teams, and transparent roadmaps. Its also important to use trusted exchanges and to store your crypto securely ideally in a personal wallet, not just an app because hacks and phishing attacks are common.

Finally, crypto investing should be approached with a long-term mindset. While some people get lucky with quick profits, most successful investors treat crypto as a gradual learning journey. Diversify your holdings, stay updated on regulations and news, and never invest more money than you can afford to lose. Remember: in crypto, education is your best asset.');

