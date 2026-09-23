/* 
   Description: Data Definition queries for the Ocean Life Public Aquarium database.
   Creates the database tables, defines primary and foreign key relationships,
   and inserts the sample data into tables. 
   Authors: Cihangir Reza Can and Kelli Muldoon
   OSU CS340 Portfolio Project deliverables
   Project Group 40
*/

-- Citation for ON DELETE CASCADE
-- Date: 08/12/2026
-- Source: MySQLTutorial.org - MySQL ON DELETE CASCADE
-- Used as a reference for implementing ON DELETE CASCADE
-- URL: https://www.mysqltutorial.org/mysql-basics/mysql-on-delete-cascade/

-- AI Citation
-- Tool: Microsoft Copilot
-- Prompt: Review DDL file against grading guidelines to catch any errors. 
-- Final logic reviewed and modified by authors.

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS `EmployeeFeedings`;
DROP TABLE IF EXISTS `FeedingEvents`;
DROP TABLE IF EXISTS `Employees`;
DROP TABLE IF EXISTS `Feeds`;
DROP TABLE IF EXISTS `Animals`;


-- -------------------------------------------------------
-- Table: Animals
-- -------------------------------------------------------
DROP TABLE IF EXISTS `Animals`;
-- Creates the Animals table
CREATE TABLE IF NOT EXISTS `Animals` (
    `animalID`   INT         NOT NULL AUTO_INCREMENT,
    `animalName` VARCHAR(50) NOT NULL,
    `species`    VARCHAR(50) NOT NULL,
    PRIMARY KEY (`animalID`)
);

-- Insert the data of animals into the Animals table.
INSERT INTO `Animals` (`animalName`, `species`)
VALUES('Gismo' , 'Bottlenose Dolphin'      ),
      ('Clover', 'Leopard Seal'            ),
      ('Milo'  , 'Green Lanternshark'      ),
      ('Kiki'  , 'East Pacific Red Octopus'),
      ('Daisy' , 'Green Sea Turtle'        );


-- -------------------------------------------------------
-- Table: Feeds
-- -------------------------------------------------------
DROP TABLE IF EXISTS `Feeds`;
-- Creates the Feeds table
CREATE TABLE IF NOT EXISTS `Feeds` (
    `feedID`      INT          NOT NULL AUTO_INCREMENT,
    `feedName`    VARCHAR(50)  NOT NULL,
    `description` VARCHAR(145) NOT NULL,
    PRIMARY KEY (`feedID`)
);

-- Insert the data of feeds into the Feeds table.
INSERT INTO `Feeds` (`feedName`, `description`)
VALUES ('Brine Shrimp Blend',             'A protein rich feed for carnivore animals.'                    ),
       ('Frozen Fish and Supplement Mix', 'A protein, vitamin and mineral rich feed for omnivore animals.'),
       ('Plant Flake',                    'A fiber rich feed for herbivore animals.'                      );


-- -------------------------------------------------------
-- Table: Employees
-- -------------------------------------------------------
DROP TABLE IF EXISTS `Employees`;
-- Creates the Employees table
-- Has the data about individual workers. Which are ID, first name, last name, age and employment type.
-- Source used for ENUM https://www.geeksforgeeks.org/sql/enumerator-enum-in-mysql/
CREATE TABLE IF NOT EXISTS `Employees`(
    `employeeID`       INT         NOT NULL AUTO_INCREMENT,
    `firstName`        VARCHAR(50) NOT NULL,
    `lastName`         VARCHAR(50) NOT NULL,
    `age`              INT         NOT NULL,
    `employmentStatus` ENUM('Part-time', 'Full-time', 'As-needed') NOT NULL,
    PRIMARY KEY (`employeeID`)
);

-- Insert the data of employees into the Employees table.
INSERT INTO `Employees` (`firstName`, `lastName`, `age`, `employmentStatus`)
VALUES ('Steve'    , 'Irwin'  , 45, 'Full-time'),
       ('Robert'   , 'Jackson', 22, 'Part-time'),
       ('Elizabeth', 'Raynes' , 35, 'Full-time'),
       ('Mary'     , 'Jones'  , 20, 'Part-time');


-- -------------------------------------------------------
-- Table: FeedingEvents
-- -------------------------------------------------------
DROP TABLE IF EXISTS `FeedingEvents`;
-- Creates the FeedingEvents table
-- Has the data about feeding events. Which are ID, feed event time, animal fed and feed used.
CREATE TABLE IF NOT EXISTS `FeedingEvents`(
    `feedingEventID` INT      NOT NULL AUTO_INCREMENT,
    `feedEventTime`  DATETIME NOT NULL,
    `animalID`       INT      NOT NULL,
    `feedID`         INT      NOT NULL,
    PRIMARY KEY (`feedingEventID`),
    CONSTRAINT `FK_FeedingEvents_animalID` FOREIGN KEY (`animalID`)
        REFERENCES `Animals`(`animalID`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `FK_FeedingEvents_feedID` FOREIGN KEY (`feedID`)
        REFERENCES `Feeds`(`feedID`) ON DELETE CASCADE ON UPDATE NO ACTION
);

-- Insert the data of feeding events into the FeedingEvents table.
-- SELECT statements retrieve the primary-key IDs used as foreign-key values.
INSERT INTO `FeedingEvents` (`feedEventTime`, `animalID`, `feedID`)
VALUES ('2026-07-21 09:20:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Gismo'), (SELECT `feedID` FROM Feeds WHERE `feedName` = 'Frozen Fish and Supplement Mix')),
       ('2026-07-21 10:15:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Clover'), (SELECT `feedID` FROM Feeds WHERE `feedName` = 'Brine Shrimp Blend')),
       ('2026-07-21 10:40:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Milo'), (SELECT `feedID` FROM Feeds WHERE `feedName` = 'Brine Shrimp Blend')),
       ('2026-07-21 11:00:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Kiki'), (SELECT `feedID` FROM Feeds WHERE `feedName` = 'Frozen Fish and Supplement Mix')),
       ('2026-07-21 11:00:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Daisy'), (SELECT `feedID` FROM Feeds WHERE `feedName` = 'Plant Flake'));


-- -------------------------------------------------------
-- Table: EmployeeFeedings
-- -------------------------------------------------------
DROP TABLE IF EXISTS `EmployeeFeedings`;
-- Creates the EmployeeFeedings table.
-- Creates the junction table for FeedingEvents and Employees tables.
-- Has the data about which employee participated in the feeding event.
CREATE TABLE IF NOT EXISTS `EmployeeFeedings`(
    `employeeFeedingID` INT NOT NULL AUTO_INCREMENT,
    `employeeID`        INT NOT NULL,
    `feedingEventID`    INT NOT NULL,
    PRIMARY KEY (`employeeFeedingID`),
    UNIQUE (`employeeID`, `feedingEventID`),

    CONSTRAINT `FK_EmployeeFeedings_employeeID` FOREIGN KEY (`employeeID`)
        REFERENCES `Employees`(`employeeID`) ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT `FK_EmployeeFeedings_feedingEventID` FOREIGN KEY (`feedingEventID`)
        REFERENCES `FeedingEvents`(`feedingEventID`) ON DELETE CASCADE ON UPDATE NO ACTION
);

-- Insert the data of employee feedings into the EmployeeFeedings table.
-- SELECT statements retrieve the primary-key IDs used as foreign-key values.
INSERT INTO `EmployeeFeedings` (`employeeID`, `feedingEventID`)
VALUES ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Steve' and `lastName` = 'Irwin' and `age` = 45 and `employmentStatus` = 'Full-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 09:20:00' and Animals.animalName='Gismo')),

       ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Robert' and `lastName` = 'Jackson' and `age` = 22 and `employmentStatus` = 'Part-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 09:20:00' and Animals.animalName='Gismo')),

       ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Steve' and `lastName` = 'Irwin' and `age` = 45 and `employmentStatus` = 'Full-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 10:15:00' and Animals.animalName='Clover')),

       ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Elizabeth' and `lastName` = 'Raynes' and `age` = 35 and `employmentStatus` = 'Full-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 10:40:00' and Animals.animalName='Milo')),

       ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Mary' and `lastName` = 'Jones' and `age` = 20 and `employmentStatus` = 'Part-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 10:40:00' and Animals.animalName='Milo')),

       ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Mary' and `lastName` = 'Jones' and `age` = 20 and `employmentStatus` = 'Part-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 11:00:00' and Animals.animalName='Kiki')),

       ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Robert' and `lastName` = 'Jackson' and `age` = 22 and `employmentStatus` = 'Part-time'),
        (SELECT FeedingEvents.feedingEventID FROM FeedingEvents JOIN Animals ON FeedingEvents.animalID = Animals.animalID WHERE FeedingEvents.feedEventTime = '2026-07-21 11:00:00' and Animals.animalName='Daisy'));


-- Change settings back to the original state
SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
SET AUTOCOMMIT = 1;