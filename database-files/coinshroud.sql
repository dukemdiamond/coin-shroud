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
    developerID VARCHAR(36) PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Investors(
    investorID VARCHAR(36) PRIMARY KEY,
    FName TEXT NOT NULL,
    LName TEXT NOT NULL,
    email VARCHAR(100) NOT NULL,
    agency TEXT NOT NULL
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
    transactionID INT AUTOINCREMENT PRIMARY KEY ,
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

CREATE TABLE Compliance_Rules(
    c_id INT AUTO_INCREMENT PRIMARY KEY,
    compliance_rules TEXT NOT NULL
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


-- Insert Investors
INSERT INTO Investors (investorID, FName, LName, email, agency) VALUES
                                                                    ('inv-001', 'Danielle', 'Johnson', 'jeffreydoyle@hotmail.com', 'Mcclain, Miller and Henderson'),
                                                                    ('inv-002', 'Anthony', 'Robinson', 'jennifermiles@robinson-lawrence.com', 'Wolfe LLC'),
                                                                    ('inv-003', 'Joshua', 'Lewis', 'daviscolin@yahoo.com', 'Baker, Williams and Stevens'),
                                                                    ('inv-004', 'David', 'Nielsen', 'maria95@lee.com', 'Wyatt Inc'),
                                                                    ('inv-005', 'Norman', 'Chavez', 'mitchellclark@yahoo.com', 'Zuniga, Wong and Lynch'),
                                                                    ('inv-006', 'George', 'Daniel', 'ogray@hawkins.com', 'Underwood LLC'),
                                                                    ('inv-007', 'Richard', 'Jones', 'dianafoster@hotmail.com', 'Thomas-Taylor'),
                                                                    ('inv-008', 'Julie', 'Ryan', 'icox@hotmail.com', 'Davis-Williams'),
                                                                    ('inv-009', 'Daniel', 'Burton', 'cruzcaitlin@yahoo.com', 'King, Tran and Dunlap'),
                                                                    ('inv-010', 'Erin', 'Wilson', 'daniel62@yahoo.com', 'Mckay Ltd'),
                                                                    ('inv-011', 'Jose', 'Mason', 'harrellkenneth@romero.com', 'Ashley, Nielsen and Sellers'),
                                                                    ('inv-012', 'Carol', 'Burns', 'natasha43@allen.com', 'Dennis Inc'),
                                                                    ('inv-013', 'Tiffany', 'Patel', 'donnaarroyo@baker.biz', 'Hickman Ltd'),
                                                                    ('inv-014', 'Hannah', 'Marquez', 'samuel87@gmail.com', 'Walker LLC'),
                                                                    ('inv-015', 'Andrew', 'Spencer', 'jonescrystal@jones.com', 'Palmer LLC'),
                                                                    ('inv-016', 'Elizabeth', 'Lewis', 'esanchez@lee-davis.biz', 'Henderson-Owens'),
                                                                    ('inv-017', 'Jessica', 'Nunez', 'powellmatthew@wright.net', 'Taylor-White'),
                                                                    ('inv-018', 'Steven', 'Baxter', 'jmorton@williams.com', 'House and Sons'),
                                                                    ('inv-019', 'Gabriel', 'Tucker', 'kbarrera@smith-myers.info', 'Henderson-Bernard'),
                                                                    ('inv-020', 'Wendy', 'Peters', 'jamesrobinson@gmail.com', 'Fitzgerald, Brown and Edwards'),
                                                                    ('inv-021', 'Brendan', 'Woods', 'yuchristopher@jones.com', 'Wilson-Zamora'),
                                                                    ('inv-022', 'John', 'Wheeler', 'ksandoval@stewart.com', 'Baker and Sons'),
                                                                    ('inv-023', 'Emily', 'Evans', 'smithchristine@hotmail.com', 'Jones and Sons'),
                                                                    ('inv-024', 'William', 'Anderson', 'suarezmike@gmail.com', 'Bass-Warner'),
                                                                    ('inv-025', 'Cheryl', 'Archer', 'sarah12@wilson-rodriguez.net', 'Nelson PLC'),
                                                                    ('inv-026', 'Jason', 'Cooper', 'dking@gmail.com', 'Henderson, Hill and Smith'),
                                                                    ('inv-027', 'Kellie', 'Walsh', 'joycearnold@yahoo.com', 'Smith, Jones and Ware'),
                                                                    ('inv-028', 'Rebecca', 'Gardner', 'russellwilliams@yahoo.com', 'Nolan and Sons'),
                                                                    ('inv-029', 'Evelyn', 'Estrada', 'vdickson@gmail.com', 'Hancock and Sons'),
                                                                    ('inv-030', 'Nicole', 'Johnson', 'vpham@gmail.com', 'Moore-Haynes'),
                                                                    ('inv-031', 'Patrick', 'Williams', 'jamessellers@yahoo.com', 'Hoover-Savage'),
                                                                    ('inv-032', 'Jeffrey', 'Keller', 'joshua14@yahoo.com', 'Hicks, Frazier and Anthony'),
                                                                    ('inv-033', 'Mark', 'Johnson', 'beverlyterrell@gmail.com', 'Carlson LLC'),
                                                                    ('inv-034', 'Jessica', 'Edwards', 'mlam@williams-graham.net', 'Mcdaniel, Bentley and Mclaughlin'),
                                                                    ('inv-035', 'James', 'Reynolds', 'elizabeth14@hotmail.com', 'Estrada-Nguyen'),
                                                                    ('inv-036', 'Heidi', 'Spencer', 'yortega@adkins.biz', 'Bass, Torres and Clark'),
                                                                    ('inv-037', 'Kristi', 'Lawson', 'rramos@gmail.com', 'Kennedy, Santana and Flynn'),
                                                                    ('inv-038', 'Gene', 'Miller', 'cardenaskaren@hotmail.com', 'Walker-Gonzalez'),
                                                                    ('inv-039', 'Andrew', 'Sanchez', 'gibsonolivia@hotmail.com', 'Higgins Group'),
                                                                    ('inv-040', 'Troy', 'Sanchez', 'osbornejeffery@holmes.com', 'Anderson-Marshall');

-- Insert Average Persons
INSERT INTO Average_Persons (userID, FName, LName, email) VALUES
                                                              ('user-001', 'Amanda', 'Hansen', 'usalazar@hotmail.com'),
                                                              ('user-002', 'Ronald', 'Meadows', 'juliawells@yahoo.com'),
                                                              ('user-003', 'Karen', 'Larsen', 'rsims@yahoo.com'),
                                                              ('user-004', 'Chris', 'Mitchell', 'luis81@gmail.com'),
                                                              ('user-005', 'Edward', 'Reyes', 'calebrussell@owens.biz'),
                                                              ('user-006', 'Rebecca', 'Silva', 'wwoods@molina-castaneda.biz'),
                                                              ('user-007', 'Amanda', 'Navarro', 'brobinson@johnson-rogers.biz'),
                                                              ('user-008', 'Jennifer', 'Pittman', 'meadowsbrittany@johnson.info'),
                                                              ('user-009', 'Hunter', 'Green', 'shawnrogers@yahoo.com'),
                                                              ('user-010', 'Joshua', 'Bean', 'mary70@hotmail.com'),
                                                              ('user-011', 'Amber', 'Cooke', 'debraharrington@hotmail.com'),
                                                              ('user-012', 'Billy', 'Johnson', 'maryhowell@martinez.com'),
                                                              ('user-013', 'Anne', 'Robinson', 'gary91@gmail.com'),
                                                              ('user-014', 'Tami', 'Rodriguez', 'barbara66@gonzalez.com'),
                                                              ('user-015', 'Curtis', 'Barton', 'reedross@jones-holland.com'),
                                                              ('user-016', 'Melissa', 'Short', 'oyu@zimmerman-graham.net'),
                                                              ('user-017', 'Tammy', 'Nelson', 'ugraham@hotmail.com'),
                                                              ('user-018', 'Joseph', 'Christian', 'nicole37@bishop.com'),
                                                              ('user-019', 'Hunter', 'Lewis', 'joshua94@hotmail.com'),
                                                              ('user-020', 'Alejandro', 'Vaughan', 'jenniferfreeman@vaughn.info'),
                                                              ('user-021', 'Shane', 'Smith', 'richardsanchez@hotmail.com'),
                                                              ('user-022', 'Bonnie', 'Kennedy', 'jbarajas@yahoo.com'),
                                                              ('user-023', 'Michael', 'Chavez', 'jerry35@gmail.com'),
                                                              ('user-024', 'Julia', 'Tapia', 'javierwashington@lawrence.com'),
                                                              ('user-025', 'Marissa', 'Phillips', 'kevinerickson@gmail.com'),
                                                              ('user-026', 'Joshua', 'Mccann', 'danamullins@gmail.com'),
                                                              ('user-027', 'Monique', 'Andrews', 'lalexander@gmail.com'),
                                                              ('user-028', 'Johnny', 'Hensley', 'moralescharles@parks.com'),
                                                              ('user-029', 'Christopher', 'Wright', 'kimberlyjames@yahoo.com'),
                                                              ('user-030', 'Kenneth', 'Chapman', 'ashley09@hotmail.com'),
                                                              ('user-031', 'Cory', 'Farmer', 'donna23@arnold.com'),
                                                              ('user-032', 'Ricky', 'Norris', 'antonio44@hotmail.com'),
                                                              ('user-033', 'Michele', 'Jones', 'kristin93@wilson-walker.com'),
                                                              ('user-034', 'Rebekah', 'Serrano', 'martinkyle@holloway.info'),
                                                              ('user-035', 'Haley', 'Lyons', 'mkim@gmail.com'),
                                                              ('user-036', 'Pamela', 'Navarro', 'davissuzanne@hotmail.com'),
                                                              ('user-037', 'Brenda', 'Smith', 'hinesgregory@hotmail.com'),
                                                              ('user-038', 'Denise', 'Moon', 'fwalters@harrison.com'),
                                                              ('user-039', 'Manuel', 'Garcia', 'robert74@landry.info'),
                                                              ('user-040', 'Christopher', 'King', 'ahancock@booth.net');

-- Insert Developers
INSERT INTO Developers (developerID, FName, LName, email) VALUES
                                                              ('dev-001', 'Michael', 'Avila', 'harrisandrea@yahoo.com'),
                                                              ('dev-002', 'Samuel', 'Wolfe', 'dudleychelsea@mckinney.net'),
                                                              ('dev-003', 'Alexander', 'Russell', 'murraydavid@jimenez.com'),
                                                              ('dev-004', 'William', 'Hill', 'jsanchez@gmail.com'),
                                                              ('dev-005', 'Patrick', 'Weeks', 'hillkristy@morgan-french.com'),
                                                              ('dev-006', 'Lori', 'Campbell', 'cgrimes@hotmail.com'),
                                                              ('dev-007', 'Todd', 'Cook', 'mcantu@hotmail.com'),
                                                              ('dev-008', 'John', 'Reyes', 'floresthomas@yahoo.com'),
                                                              ('dev-009', 'Paul', 'Alvarado', 'ihanna@sanford.info'),
                                                              ('dev-010', 'Cory', 'Lozano', 'robertpena@jones.com'),
                                                              ('dev-011', 'Cindy', 'Sanders', 'melissa86@sims-clay.info'),
                                                              ('dev-012', 'Monique', 'Johnson', 'crystalmccall@francis.com'),
                                                              ('dev-013', 'Kathleen', 'Padilla', 'tjackson@williams.com'),
                                                              ('dev-014', 'Michael', 'Jordan', 'yknight@jackson.org'),
                                                              ('dev-015', 'Monica', 'Harvey', 'jdurham@murray.info'),
                                                              ('dev-016', 'Jonathan', 'Smith', 'erica21@yahoo.com'),
                                                              ('dev-017', 'Sierra', 'Huerta', 'dvaughn@yahoo.com'),
                                                              ('dev-018', 'James', 'Cruz', 'youngashley@hotmail.com'),
                                                              ('dev-019', 'Kenneth', 'Lyons', 'khill@osborne.info'),
                                                              ('dev-020', 'Marissa', 'Leach', 'jeffery39@byrd-le.com'),
                                                              ('dev-021', 'Courtney', 'Berger', 'kristina09@oconnor-davis.com'),
                                                              ('dev-022', 'Mark', 'Perry', 'kristinwalter@schmidt-mcintyre.com'),
                                                              ('dev-023', 'Jonathan', 'Summers', 'julie51@yahoo.com'),
                                                              ('dev-024', 'Sydney', 'Taylor', 'zcoffey@diaz.net'),
                                                              ('dev-025', 'David', 'Richardson', 'xcarson@gmail.com'),
                                                              ('dev-026', 'Emily', 'Ruiz', 'deborahreid@yahoo.com'),
                                                              ('dev-027', 'Regina', 'Turner', 'taylorsophia@yahoo.com'),
                                                              ('dev-028', 'Wendy', 'Wilson', 'paulwatson@horton.com'),
                                                              ('dev-029', 'Nicole', 'Pena', 'rcrosby@gmail.com'),
                                                              ('dev-030', 'Hannah', 'Robinson', 'melissagarcia@hotmail.com'),
                                                              ('dev-031', 'Michael', 'Winters', 'sandersjames@gmail.com'),
                                                              ('dev-032', 'Stacy', 'Holloway', 'darleneharper@williams.com'),
                                                              ('dev-033', 'Vanessa', 'Buchanan', 'gallegosangela@robinson.com'),
                                                              ('dev-034', 'Kristina', 'Carlson', 'vanessafernandez@gmail.com'),
                                                              ('dev-035', 'Daniel', 'Delacruz', 'howardkristina@morris.biz'),
                                                              ('dev-036', 'Alicia', 'Reese', 'gstrickland@hotmail.com'),
                                                              ('dev-037', 'Daniel', 'Gordon', 'stephen00@boone-simmons.com'),
                                                              ('dev-038', 'Tracy', 'Browning', 'morriseddie@hill.org'),
                                                              ('dev-039', 'Amy', 'Nguyen', 'bwagner@gmail.com'),
                                                              ('dev-040', 'Laura', 'Wilson', 'ohayes@morgan-chavez.biz');

-- Insert Projects
INSERT INTO Projects (projectID, name, status, price, quantity) VALUES
                                                                    ('proj-001', 'Show', 'active', 519610, 778572),
                                                                    ('proj-002', 'Beyond', 'completed', 4208603, 235053),
                                                                    ('proj-003', 'Form', 'pending', 1819583, 710570),
                                                                    ('proj-004', 'Late', 'active', 7178673, 34326),
                                                                    ('proj-005', 'Form', 'active', 1671945, 230258),
                                                                    ('proj-006', 'Reduce', 'pending', 8578454, 632262),
                                                                    ('proj-007', 'Especially', 'active', 9516129, 209496),
                                                                    ('proj-008', 'House', 'suspended', 3798379, 472029),
                                                                    ('proj-009', 'Claim', 'completed', 209031, 796667),
                                                                    ('proj-010', 'Right', 'pending', 7190293, 357778),
                                                                    ('proj-011', 'Wind', 'completed', 2708513, 226772),
                                                                    ('proj-012', 'Matter', 'completed', 1814803, 98251),
                                                                    ('proj-013', 'Audience', 'suspended', 1722631, 377417),
                                                                    ('proj-014', 'Benefit', 'completed', 4537923, 847335),
                                                                    ('proj-015', 'Theory', 'active', 7807870, 563275),
                                                                    ('proj-016', 'Bed', 'active', 6450753, 83627),
                                                                    ('proj-017', 'Better', 'completed', 6167228, 606397),
                                                                    ('proj-018', 'Lay', 'pending', 1266941, 49050),
                                                                    ('proj-019', 'Big', 'pending', 4955124, 84667),
                                                                    ('proj-020', 'Size', 'pending', 1794522, 399591),
                                                                    ('proj-021', 'Single', 'completed', 7706962, 667563),
                                                                    ('proj-022', 'Hotel', 'completed', 2828882, 389162),
                                                                    ('proj-023', 'Task', 'completed', 3614944, 703729),
                                                                    ('proj-024', 'Case', 'completed', 1297935, 639720),
                                                                    ('proj-025', 'Only', 'pending', 9061380, 765544),
                                                                    ('proj-026', 'As', 'pending', 2841438, 485714),
                                                                    ('proj-027', 'Peace', 'suspended', 4628972, 971342),
                                                                    ('proj-028', 'Or', 'pending', 5540561, 884794),
                                                                    ('proj-029', 'Or', 'active', 3942788, 862722),
                                                                    ('proj-030', 'Girl', 'active', 5392423, 421651),
                                                                    ('proj-031', 'Religious', 'completed', 1210460, 222231),
                                                                    ('proj-032', 'Can', 'completed', 3667281, 688277),
                                                                    ('proj-033', 'Item', 'suspended', 6737601, 928657),
                                                                    ('proj-034', 'Health', 'suspended', 2496987, 278746),
                                                                    ('proj-035', 'Tv', 'pending', 4237722, 782177),
                                                                    ('proj-036', 'Reduce', 'completed', 9907725, 450245),
                                                                    ('proj-037', 'Yeah', 'suspended', 6173292, 230974),
                                                                    ('proj-038', 'Social', 'pending', 8648432, 518488),
                                                                    ('proj-039', 'Land', 'active', 890481, 903931),
                                                                    ('proj-040', 'Trip', 'active', 2664251, 658924);



