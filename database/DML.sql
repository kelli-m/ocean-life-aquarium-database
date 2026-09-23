/*
Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
These queries support basic CRUD operations.
Queries are written as stored procedures to be called from the Flask application.

Authors: Cihangir Reza Can and Kelli Muldoon

Stored procedure parameters beginning with p_ contain values supplied
by the Flask application.
*/

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- RESEt procedure ADAPTED FROM OSU SUMMER 2026 CS 340 Project Step 4 Draft Version: Add RESET stored procedure (SP) 
-- and SELECTs for all entities (Group on Ed Discussions) Example Stored Procedure sp_moviedb.sql 


-- =====================================================
-- ANIMALS
-- =====================================================
-- Read all animals
SELECT animalID, animalName, species
FROM Animals;

-- Insert Animal
DROP PROCEDURE IF EXISTS sp_insert_animal;
DELIMITER //
CREATE PROCEDURE sp_insert_animal (
    IN p_animalName VARCHAR(50),
    IN p_species VARCHAR(50),
    OUT p_newAnimalID INT
)
BEGIN
    INSERT INTO Animals (animalName, species)
    VALUES (p_animalName, p_species);

    SET p_newAnimalID = LAST_INSERT_ID();
END //
DELIMITER ;

-- Update Animal
DROP PROCEDURE IF EXISTS sp_update_animal;
DELIMITER //
CREATE PROCEDURE sp_update_animal (
    IN p_animalID INT,
    IN p_animalName VARCHAR(50),
    IN p_species VARCHAR(50)
)
BEGIN
    UPDATE Animals
    SET animalName = p_animalName,
        species = p_species
    WHERE animalID = p_animalID;
END //
DELIMITER ;

-- Delete Animal
DROP PROCEDURE IF EXISTS sp_delete_animal;
DELIMITER //
CREATE PROCEDURE sp_delete_animal (
    IN p_animalID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error! Animal not deleted.' AS Result;
    END;
    START TRANSACTION;
    DELETE FROM Animals
    WHERE animalID = p_animalID;
    COMMIT;
    SELECT 'Animal deleted successfully.' AS Result;
END //
DELIMITER ;

-- =====================================================
-- EMPLOYEES
-- =====================================================
-- Read all employees
SELECT employeeID, firstName, lastName, age, employmentStatus
FROM Employees;

-- Insert Employee
DROP PROCEDURE IF EXISTS sp_insert_employee;
DELIMITER //
CREATE PROCEDURE sp_insert_employee (
    IN p_firstName VARCHAR(50),
    IN p_lastName VARCHAR(50),
    IN p_age INT,
    IN p_employmentStatus VARCHAR(20),
    OUT p_newEmployeeID INT
)
BEGIN
    INSERT INTO Employees (
        firstName,
        lastName,
        age,
        employmentStatus
    )
    VALUES (
        p_firstName,
        p_lastName,
        p_age,
        p_employmentStatus
    );
    SET p_newEmployeeID = LAST_INSERT_ID();
END //
DELIMITER ;

-- Update Employee
DROP PROCEDURE IF EXISTS sp_update_employee;
DELIMITER //
CREATE PROCEDURE sp_update_employee (
    IN p_employeeID INT,
    IN p_firstName VARCHAR(50),
    IN p_lastName VARCHAR(50),
    IN p_age INT,
    IN p_employmentStatus VARCHAR(20)
)
BEGIN
    UPDATE Employees
    SET firstName = p_firstName,
        lastName = p_lastName,
        age = p_age,
        employmentStatus = p_employmentStatus
    WHERE employeeID = p_employeeID;
END //
DELIMITER ;

-- Delete Employee
DROP PROCEDURE IF EXISTS sp_delete_employee;
DELIMITER //
CREATE PROCEDURE sp_delete_employee (
    IN p_employeeID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error! Employee not deleted.' AS Result;
    END;
    START TRANSACTION;
    DELETE FROM Employees
    WHERE employeeID = p_employeeID;
    COMMIT;
    SELECT 'Employee deleted successfully.' AS Result;
END //
DELIMITER ;

-- =====================================================
-- FEEDS
-- =====================================================
-- Read all feeds
SELECT feedID, feedName, description
FROM Feeds;

-- Insert Feed
DROP PROCEDURE IF EXISTS sp_insert_feed;
DELIMITER //
CREATE PROCEDURE sp_insert_feed (
    IN p_feedName VARCHAR(50),
    IN p_description VARCHAR(145),
    OUT p_newFeedID INT
)
BEGIN
    INSERT INTO Feeds (feedName, description)
    VALUES (p_feedName, p_description);
    SET p_newFeedID = LAST_INSERT_ID();
END //
DELIMITER ;

-- Update Feed
DROP PROCEDURE IF EXISTS sp_update_feed;
DELIMITER //
CREATE PROCEDURE sp_update_feed (
    IN p_feedID INT,
    IN p_feedName VARCHAR(50),
    IN p_description VARCHAR(145)
)
BEGIN
    UPDATE Feeds
    SET feedName = p_feedName,
        description = p_description
    WHERE feedID = p_feedID;
END //
DELIMITER ;

-- Delete Feed
DROP PROCEDURE IF EXISTS sp_delete_feed;
DELIMITER //
CREATE PROCEDURE sp_delete_feed (
    IN p_feedID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error! Feed not deleted.' AS Result;
    END;
    START TRANSACTION;
    DELETE FROM Feeds
    WHERE feedID = p_feedID;
    COMMIT;
    SELECT 'Feed deleted successfully.' AS Result;
END //
DELIMITER ;

-- =====================================================
-- FEEDING EVENTS
-- =====================================================
-- Read all feeding events
SELECT
    FeedingEvents.feedingEventID,
    FeedingEvents.feedEventTime,
    Animals.animalID,
    Animals.animalName,
    Feeds.feedID,
    Feeds.feedName
FROM FeedingEvents
INNER JOIN Animals
    ON FeedingEvents.animalID = Animals.animalID
INNER JOIN Feeds
    ON FeedingEvents.feedID = Feeds.feedID;


-- Insert Feeding Event
DROP PROCEDURE IF EXISTS sp_insert_feeding_event;
DELIMITER //

CREATE PROCEDURE sp_insert_feeding_event (
    IN p_feedEventTime DATETIME,
    IN p_animalID INT,
    IN p_feedID INT,
    OUT p_newFeedingEventID INT
)
BEGIN
    INSERT INTO FeedingEvents (
        feedEventTime,
        animalID,
        feedID
    )
    VALUES (
        p_feedEventTime,
        p_animalID,
        p_feedID
    );

    SET p_newFeedingEventID = LAST_INSERT_ID();
END //
DELIMITER ;


-- Update Feeding Event
DROP PROCEDURE IF EXISTS sp_update_feeding_event;
DELIMITER //

CREATE PROCEDURE sp_update_feeding_event (
    IN p_feedingEventID INT,
    IN p_feedEventTime DATETIME,
    IN p_animalID INT,
    IN p_feedID INT
)
BEGIN
    UPDATE FeedingEvents
    SET feedEventTime = p_feedEventTime,
        animalID = p_animalID,
        feedID = p_feedID
    WHERE feedingEventID = p_feedingEventID;
END //
DELIMITER ;


-- =====================================================
-- EMPLOYEE FEEDINGS
-- =====================================================
-- Read all employee feeding assignments
SELECT
    EmployeeFeedings.employeeFeedingID,
    Employees.employeeID,
    CONCAT(
        Employees.firstName,
        ' ',
        Employees.lastName
    ) AS employeeName,
    FeedingEvents.feedingEventID,
    FeedingEvents.feedEventTime,
    Animals.animalName,
    Feeds.feedName
FROM EmployeeFeedings
INNER JOIN Employees
    ON EmployeeFeedings.employeeID = Employees.employeeID
INNER JOIN FeedingEvents
    ON EmployeeFeedings.feedingEventID =
       FeedingEvents.feedingEventID
INNER JOIN Animals
    ON FeedingEvents.animalID = Animals.animalID
INNER JOIN Feeds
    ON FeedingEvents.feedID = Feeds.feedID;

-- Insert Employee Feeding Assignment
DROP PROCEDURE IF EXISTS sp_insert_employee_feeding;
DELIMITER //

CREATE PROCEDURE sp_insert_employee_feeding (
    IN p_employeeID INT,
    IN p_feedingEventID INT,
    OUT p_newEmployeeFeedingID INT
)
BEGIN
    INSERT INTO EmployeeFeedings (
        employeeID,
        feedingEventID
    )
    VALUES (
        p_employeeID,
        p_feedingEventID
    );

    SET p_newEmployeeFeedingID = LAST_INSERT_ID();
END //
DELIMITER ;

-- Update Employee Feeding Assignment
DROP PROCEDURE IF EXISTS sp_update_employee_feeding;
DELIMITER //

CREATE PROCEDURE sp_update_employee_feeding (
    IN p_employeeFeedingID INT,
    IN p_employeeID INT,
    IN p_feedingEventID INT
)
BEGIN
    UPDATE EmployeeFeedings
    SET employeeID = p_employeeID,
        feedingEventID = p_feedingEventID
    WHERE employeeFeedingID = p_employeeFeedingID;
END //
DELIMITER ;

-- Delete Feeding Event
DROP PROCEDURE IF EXISTS sp_delete_feeding_event;
DELIMITER //
CREATE PROCEDURE sp_delete_feeding_event (
    IN p_feedingEventID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error! Feeding event not deleted.' AS Result;
    END;

    START TRANSACTION;

    DELETE FROM FeedingEvents
    WHERE feedingEventID = p_feedingEventID;

    COMMIT;

    SELECT 'Feeding event deleted successfully.' AS Result;
END //
DELIMITER ;


-- Delete Employee Feeding Assignment
DROP PROCEDURE IF EXISTS sp_delete_employee_feeding;
DELIMITER //
CREATE PROCEDURE sp_delete_employee_feeding (
    IN p_employeeFeedingID INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;

        SELECT
            'Error! Employee feeding assignment not deleted.'
            AS Result;
    END;

    START TRANSACTION;

    DELETE FROM EmployeeFeedings
    WHERE employeeFeedingID = p_employeeFeedingID;

    COMMIT;

    SELECT
        'Employee feeding assignment deleted successfully.'
        AS Result;
END //
DELIMITER ;

-- =====================================================
-- RESET DATABASE PROCEDURE
-- =====================================================
DROP PROCEDURE IF EXISTS sp_load_aquariumdb;
DELIMITER //
CREATE PROCEDURE sp_load_aquariumdb()
BEGIN
    -- Create database and use it
    -- uncomment these if NOT using CS340 database
    -- CREATE DATABASE IF NOT EXISTS `aquarium`;
    -- USE `aquarium`;

    -- Change settings temporarily (for foreign keys and saving)
    SET FOREIGN_KEY_CHECKS = 0;
    SET AUTOCOMMIT = 0;


    DROP TABLE IF EXISTS `Animals`;
    -- Creates the Animals table (if it exists replaces it).
    -- Has the data about individual animals. Which are ID, name, species
    CREATE TABLE IF NOT EXISTS `Animals` (
        `animalID`   INT        NOT NULL AUTO_INCREMENT,
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

   
    DROP TABLE IF EXISTS `Feeds`;
    -- Creates the Feeds table (if it exists replaces it).
    -- Has the data about feeds for animals. Which are ID, feed name, feeds description.
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


    DROP TABLE IF EXISTS `Employees`;
    -- Creates the Employees table (if it exists replaces it).
    -- Has the data about individual workers. Which are ID, first name, last name, age and employment type.
    -- Source used for ENUM https://www.geeksforgeeks.org/sql/enumerator-enum-in-mysql/
    CREATE TABLE IF NOT EXISTS `Employees`(
        `employeeID` INT         NOT NULL AUTO_INCREMENT,
        `firstName`  VARCHAR(50) NOT NULL,
        `lastName`   VARCHAR(50) NOT NULL,
        `age`        INT         NOT NULL,
        `employmentStatus` ENUM('Part-time', 'Full-time', 'As-needed') NOT NULL,
        PRIMARY KEY (`employeeID`)
    );

    -- Insert the data of employees into the Employees table.
    INSERT INTO `Employees` (`firstName`, `lastName`, `age`, `employmentStatus`)
    VALUES ('Steve'    , 'Irwin'  , 45, 'Full-time'),
           ('Robert'   , 'Jackson', 22, 'Part-time'),
           ('Elizabeth', 'Raynes' , 35, 'Full-time'),
           ('Mary'     , 'Jones'  , 20, 'Part-time');
    


    DROP TABLE IF EXISTS `FeedingEvents`;
    -- Creates the FeedingEvents table (if it exists replaces it).
    -- Has the data about feeding events. Which are ID, feed event time, animal fed and fed used.
    CREATE TABLE IF NOT EXISTS `FeedingEvents`(
        `feedingEventID` INT      NOT NULL AUTO_INCREMENT,
        `feedEventTime`  DATETIME NOT NULL,
        `animalID`       INT      NOT NULL,
        `feedID`         INT 	  NOT NULL,
        PRIMARY KEY (`feedingEventID`),
        CONSTRAINT `FK_FeedingEvents_animalID` FOREIGN KEY (`animalID`) 
        REFERENCES `Animals`(`animalID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `FK_FeedingEvents_feedID`   FOREIGN KEY (`feedID`)   
        REFERENCES `Feeds`(`feedID`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

    -- Insert the data of feeding events into the FeedingEvents table.
    INSERT INTO `FeedingEvents` (`feedEventTime`, `animalID`, `feedID`)
    VALUES ('2026-07-21 09:20:00', 1, 2),
           ('2026-07-21 10:15:00', 2, 1),
           ('2026-07-21 10:40:00', 3, 1),
           ('2026-07-21 11:00:00', 4, 2),
           ('2026-07-21 11:00:00', 5, 3);


    DROP TABLE IF EXISTS `EmployeeFeedings`;
    -- Creates the EmployeeFeedings table (if it exists replaces it).
    -- Creates the junction table for feedingEvents and employees tables.
    -- Has the data about which employee participated in the feeding event. Which are
    -- ID, employee id, feeding event id.
    CREATE TABLE IF NOT EXISTS `EmployeeFeedings`(
        `employeeFeedingID` INT NOT NULL AUTO_INCREMENT,
        `employeeID`        INT NOT NULL,
        `feedingEventID`    INT NOT NULL,
        PRIMARY KEY (`employeeFeedingID`),
    
        CONSTRAINT `FK_EmployeeFeedings_employeeID` FOREIGN KEY (`employeeID`)
        REFERENCES `Employees`(`employeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `FK_EmployeeFeedings_feedingEventID` FOREIGN KEY (`feedingEventID`) 
        REFERENCES `FeedingEvents`(`feedingEventID`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

    -- Insert the data of employee feddings into the EmployeeFeedings table.
    INSERT INTO `EmployeeFeedings` (`employeeID`, `feedingEventID`)
    VALUES (1, 1),
           (2, 1),
           (1, 2),
           (3, 3),
           (4, 3),
           (4, 4),
           (2, 5);

    -- Change settings back to the original state (for foreign keys and saving)
    COMMIT;
    SET FOREIGN_KEY_CHECKS = 1;
    SET AUTOCOMMIT = 1;
END //

DELIMITER ;
-- Use the following statement to call SP to load the aquarium database.
-- This will reset the schema back to the original state.
-- CALL sp_load_aquariumdb();