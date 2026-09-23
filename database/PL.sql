-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Delete Animal from Animals table
-- #############################
DROP PROCEDURE IF EXISTS sp_deleteAnimal;

DELIMITER //
CREATE PROCEDURE sp_deleteAnimal(
	IN p_animalID INT
)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM Animals WHERE Animals.animalID = p_animalID;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in Animals table for id: ', p_animalID);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Delete Employee from Employees table
-- #############################
DROP PROCEDURE IF EXISTS sp_deleteEmployee;

DELIMITER //
CREATE PROCEDURE sp_deleteEmployee(
	IN p_employeeID INT
)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM Employees WHERE Employees.employeeID = p_employeeID;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in Employees table for id: ', p_employeeID);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Delete employee feeding from Employee Feedings table
-- #############################
DROP PROCEDURE IF EXISTS sp_deleteEmployeeFeeding;

DELIMITER //
CREATE PROCEDURE sp_deleteEmployeeFeeding(
	IN p_employeeFeedingID INT
)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM EmployeeFeedings WHERE EmployeeFeedings.employeeFeedingID = p_employeeFeedingID;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in Employee Feeding table for id: ', p_employeeFeedingID);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Delete Feed from Feeds table
-- #############################
DROP PROCEDURE IF EXISTS sp_deleteFeed;

DELIMITER //
CREATE PROCEDURE sp_deleteFeed(
	IN p_feedID INT
)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM Feeds WHERE Feeds.feedID = p_feedID;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in Feeds table for id: ', p_feedID);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Delete Feeding Event from Feeding Events table
-- #############################
DROP PROCEDURE IF EXISTS sp_deleteFeedingEvent;

DELIMITER //
CREATE PROCEDURE sp_deleteFeedingEvent(
	IN p_feedingEventID INT
)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM FeedingEvents WHERE FeedingEvents.feedingEventID = p_feedingEventID;

        -- ROW_COUNT() returns the number of rows affected by the preceding statement.
        IF ROW_COUNT() = 0 THEN
            set error_message = CONCAT('No matching record found in Feeding Events table for id: ', p_feedingEventID);
            -- Trigger custom error, invoke EXIT HANDLER
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
        END IF;

    COMMIT;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Insert Animal to Animals table
-- #############################
DROP PROCEDURE IF EXISTS sp_insertAnimal;

DELIMITER //
CREATE PROCEDURE sp_insertAnimal(
    IN  p_animalName  VARCHAR(50),
    IN  p_species     VARCHAR(50),
    OUT p_newAnimalID INT)
BEGIN
    INSERT INTO Animals (animalName, species)
    VALUES (p_animalName, p_species);

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_newAnimalID;
    -- Display the ID of the last inserted animal.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created animal:
        -- CALL sp_insertAnimal('Theresa', 'Evans', @new_id);
        -- SELECT @new_id AS 'New Animal ID';
END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Insert Employee to Employees table
-- #############################
DROP PROCEDURE IF EXISTS sp_insertEmployee;

DELIMITER //
CREATE PROCEDURE sp_insertEmployee(
    IN  p_firstName VARCHAR(50),
    IN  p_lastName VARCHAR(50),
    IN  p_age INT,
    IN  p_employmentStatus VARCHAR(20),
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

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_newEmployeeID;
    -- Display the ID of the last inserted employee.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created employee:
        -- CALL sp_insertEmployee('Theresa', 'Evans', 34, 'Part-time' @new_id);
        -- SELECT @new_id AS 'New Employee ID';
END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Insert Employee Feeding to EmployeeFeedings table
-- #############################
DROP PROCEDURE IF EXISTS sp_insertEmployeeFeeding;

DELIMITER //
CREATE PROCEDURE sp_insertEmployeeFeeding (
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

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_newEmployeeFeedingID;
    -- Display the ID of the last inserted Empoyee Feeding.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created feeding event:
        -- CALL sp_insertFeed('1', '2', @new_id);
        -- SELECT @new_id AS 'New Employee Feeding ID';
END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Insert Feed to Feeds table
-- #############################
DROP PROCEDURE IF EXISTS sp_insertFeed;

DELIMITER //
CREATE PROCEDURE sp_insertFeed (
    IN  p_feedName VARCHAR(50),
    IN  p_description VARCHAR(145),
    OUT p_newFeedID INT
)
BEGIN
    INSERT INTO Feeds (feedName, description)
    VALUES (p_feedName, p_description);

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_newFeedID;
    -- Display the ID of the last inserted feed.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created feed:
        -- CALL sp_insertFeed('Moss Flake', 'Mineral and fiber rich feed', @new_id);
        -- SELECT @new_id AS 'New Feed ID';
END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Insert Feeding Event to FeedingEvents table
-- #############################
DROP PROCEDURE IF EXISTS sp_insertFeedingEvent;

DELIMITER //
CREATE PROCEDURE sp_insertFeedingEvent (
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

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_newFeedingEventID;
    -- Display the ID of the last inserted Feeding Event.
    SELECT LAST_INSERT_ID() AS 'new_id';

    -- Example of how to get the ID of the newly created feeding event:
        -- CALL sp_insertFeed('2026-08-10 14:00:00', '2', '3', @new_id);
        -- SELECT @new_id AS 'New Feeding Event ID';
END //
DELIMITER ;

-- PROJECT GROUP 40 - STEP 4 DRAFT 
-- DATA DEFINITION LANGUAGE STORED PROCEDURE
-- KELLI MULDOON
-- REZA CAN CIHANGIR
-- ADAPTED FROM OSU SUMMER 2026 CS 340 Project Step 4 Draft Version: Add RESET stored procedure (SP) 
-- and SELECTs for all entities (Group on Ed Discussions) Example Stored Procedure sp_moviedb.sql 

-- Uses MariaDB exported from engineering servers (classmysql.engr.oregonstate.edu)  
-- OSU CS340 Intro to Databases
-- Aquarium DB for Project Group 40

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

    -- -------------------------------------------------------
    -- Table: Animals
    -- -------------------------------------------------------
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

    -- -------------------------------------------------------
    -- Table: Feeds
    -- -------------------------------------------------------   
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
    
    -- -------------------------------------------------------
    -- Table: Employees
    -- -------------------------------------------------------   
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
    
    -- -------------------------------------------------------
    -- Table: FeedingEvents
    -- -------------------------------------------------------   
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
        REFERENCES `Animals`(`animalID`) ON DELETE CASCADE ON UPDATE NO ACTION,
        CONSTRAINT `FK_FeedingEvents_feedID`   FOREIGN KEY (`feedID`)   
        REFERENCES `Feeds`(`feedID`) ON DELETE CASCADE ON UPDATE NO ACTION
    );

    -- Insert the data of feeding events into the FeedingEvents table.
    INSERT INTO `FeedingEvents` (`feedEventTime`, `animalID`, `feedID`)
    VALUES ('2026-07-21 09:20:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Gismo' ), 
                                   (SELECT `FeedID`   FROM Feeds   WHERE `feedName`   = 'Frozen Fish and Supplement Mix')),
           ('2026-07-21 10:15:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Clover'),
                                   (SELECT `FeedID`   FROM Feeds   WHERE `feedName`   = 'Brine Shrimp Blend'            )),
           ('2026-07-21 10:40:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Milo'  ),
                                   (SELECT `FeedID`   FROM Feeds   WHERE `feedName`   = 'Brine Shrimp Blend'            )),
           ('2026-07-21 11:00:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Kiki'  ),
                                   (SELECT `FeedID`   FROM Feeds   WHERE `feedName`   = 'Frozen Fish and Supplement Mix')),
           ('2026-07-21 11:00:00', (SELECT `animalID` FROM Animals WHERE `animalName` = 'Daisy' ), 
                                   (SELECT `FeedID`   FROM Feeds   WHERE `feedName`   = 'Plant Flake'                   ));

    -- -------------------------------------------------------
    -- Table: EmployeeFeedings
    -- ------------------------------------------------------- 
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
        UNIQUE (`employeeID`, `feedingEventID`),
    
        CONSTRAINT `FK_EmployeeFeedings_employeeID` FOREIGN KEY (`employeeID`)
        REFERENCES `Employees`(`employeeID`) ON DELETE CASCADE ON UPDATE NO ACTION,
        CONSTRAINT `FK_EmployeeFeedings_feedingEventID` FOREIGN KEY (`feedingEventID`) 
        REFERENCES `FeedingEvents`(`feedingEventID`) ON DELETE CASCADE ON UPDATE NO ACTION
    );

    -- Insert the data of employee feddings into the EmployeeFeedings table.
    INSERT INTO `EmployeeFeedings` (`employeeID`, `feedingEventID`)
    VALUES  ((SELECT `employeeID` FROM `Employees` WHERE `firstName` = 'Steve' and `lastName` = 'Irwin' and `age` = 45 and `employmentStatus` = 'Full-time'),
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

    -- Change settings back to the original state (for foreign keys and saving)
    SET FOREIGN_KEY_CHECKS=1;
    COMMIT;
END //

DELIMITER ;
-- Use the following statement to call SP to load the aquarium database.
-- This will reset the schema back to the original state.
-- CALL sp_load_aquariumdb();

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Update Animal from Animals table
-- #############################
DROP PROCEDURE IF EXISTS sp_updateAnimal;

DELIMITER //
CREATE PROCEDURE sp_updateAnimal(
	IN p_animalID INT,
    	IN p_animalName VARCHAR(50),
    	IN p_species VARCHAR(50)
)
BEGIN
	UPDATE Animals
        SET Animals.animalName = p_animalName,
        Animals.species = p_species
        WHERE Animals.animalID = p_animalID;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Update employee from Employees table
-- #############################
DROP PROCEDURE IF EXISTS sp_updateEmployee;

DELIMITER //
CREATE PROCEDURE sp_updateEmployee(
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

-- Citation for Use of AI Tools
-- Date: 12/08/2026
-- Tool: Google Gemini
-- Prompt: Don't let it throw an error if user enters a duplicate 
-- AI Source: https://gemini.google.com/

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Update employee feeding from EmployeeFeedings table
-- #############################
DROP PROCEDURE IF EXISTS sp_updateEmployeeFeeding;

DELIMITER //
CREATE PROCEDURE sp_updateEmployeeFeeding(
    IN p_employeeFeedingID INT,
    IN p_employeeID INT,
    IN p_feedingEventID INT
)
BEGIN
    -- Check if the exact employeeID and feedingEventID already exist for a *different* record
    IF EXISTS (
        SELECT 1 
        FROM EmployeeFeedings 
        WHERE employeeID = p_employeeID 
          AND feedingEventID = p_feedingEventID 
          AND employeeFeedingID <> p_employeeFeedingID
    ) THEN
        -- Option A: Signal a custom error back to the application
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate entry: This employee is already assigned to this feeding event.';
        
    ELSE
        -- Safe to update
        UPDATE EmployeeFeedings
        SET employeeID = p_employeeID,
            feedingEventID = p_feedingEventID
        WHERE employeeFeedingID = p_employeeFeedingID;
    END IF;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Update feed from Feeds table
-- #############################
DROP PROCEDURE IF EXISTS sp_updateFeed;

DELIMITER //
CREATE PROCEDURE sp_updateFeed(
    IN p_feedID INT,
    IN p_feedName VARCHAR(50),
    IN p_description VARCHAR(145)
)
BEGIN
    UPDATE Feeds
    SET feedName = p_feedName,
    description  = p_description
    WHERE feedID = p_feedID;

END //
DELIMITER ;

-- Citation for the following code:
-- Date: 12/08/2026
-- Copied and adapted from OSU Summer 2026 CS340 Intro to databases
-- Module Week 8 - DB Performance and Query Optimization + Project Development
-- (Explain Degree of Originality): Copied/pasted and adapted the starter code
-- Source URL: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=26923368

-- Description: Data Manipulation Queries for the Ocean Life Public Aquarium database.
-- These queries support basic CRUD operations.
-- Queries are written as stored procedures to be called from the Flask application.
-- Authors: Cihangir Reza Can and Kelli Muldoon
-- Stored procedure parameters beginning with p_ contain values supplied
-- by the Flask application.

-- Citation for Use of AI Tools
-- Date: 08/06/2026
-- Tool: Microsoft 365 Copilot
-- Prompt: Provided the AI CRUD sql code, table definitions, and starter stored procedure examples.
-- Requested generation and review of MySQL stored procedures for the Ocean Life Public Aquarium database.
-- Promoted to generate procedures that use select statements for foreign keys for employee feeding and feeding event tables.
-- Requested review for correctness, and SQL injection vulnerabilities.
-- AI Source: https://m365.cloud.microsoft/chat?fromcode=cmmyr718qsb

-- #############################
-- Update feeding event from FeedingEvents table
-- #############################
DROP PROCEDURE IF EXISTS sp_updateFeedingEvent;

DELIMITER //
CREATE PROCEDURE sp_updateFeedingEvent(
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