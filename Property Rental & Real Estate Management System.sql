CREATE DATABASE RealEstateDB;

USE RealEstateDB;

-- Step 2: Create RE_Region Table

CREATE TABLE RE_Region 
(
    RegionID INT AUTO_INCREMENT PRIMARY KEY,
    RegionName VARCHAR(50) NOT NULL UNIQUE,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    AddedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    AddedBy VARCHAR(50) NOT NULL
);

-- Insert Records

INSERT INTO RE_Region (RegionName, AddedBy)

VALUES
('North','Admin'),
('South','Admin'),
('East','Admin'),
('West','Admin'),
('Central','Admin');

-- Step 3: Create RE_State Table

CREATE TABLE RE_State
(
    StateID INT AUTO_INCREMENT PRIMARY KEY,
    RegionID INT NOT NULL,
    StateName VARCHAR(50) NOT NULL UNIQUE,
    Status ENUM('Active','Inactive') DEFAULT 'Active',
    AddedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    AddedBy VARCHAR(50),

    CONSTRAINT FK_State_Region
    FOREIGN KEY (RegionID)
    REFERENCES RE_Region(RegionID)
);

-- Insert Records

INSERT INTO RE_State (RegionID, StateName, AddedBy) 

VALUES
(2,'Tamil Nadu','Admin'),
(2,'Kerala','Admin'),
(2,'Karnataka','Admin'),
(2,'Andhra Pradesh','Admin'),
(2,'Telangana','Admin'),
(1,'Delhi','Admin'),
(1,'Punjab','Admin'),
(4,'Maharashtra','Admin'),
(4,'Gujarat','Admin'),
(3,'West Bengal','Admin');

-- Step 4: Create RE_City Table

CREATE TABLE RE_City
(
    CityID INT AUTO_INCREMENT PRIMARY KEY,
    StateID INT NOT NULL,
    CityName VARCHAR(50) NOT NULL,
    Status ENUM('Active','Inactive') DEFAULT 'Active',
    AddedOn DATETIME DEFAULT CURRENT_TIMESTAMP,
    AddedBy VARCHAR(50),

    CONSTRAINT FK_City_State
    FOREIGN KEY(StateID)
    REFERENCES RE_State(StateID)
);

-- Insert Records

INSERT INTO RE_City(StateID, CityName, AddedBy) 
VALUES
(1,'Chennai','Admin'),
(1,'Coimbatore','Admin'),
(1,'Madurai','Admin'),
(2,'Kochi','Admin'),
(2,'Thiruvananthapuram','Admin'),
(3,'Bengaluru','Admin'),
(3,'Mysuru','Admin'),
(8,'Mumbai','Admin'),
(8,'Pune','Admin'),
(10,'Kolkata','Admin');

-- Step 5: Create RE_Area Table

CREATE TABLE RE_Area
(
    AreaID INT AUTO_INCREMENT PRIMARY KEY,
    CityID INT NOT NULL,
    AreaName VARCHAR(100) NOT NULL,
    Pincode VARCHAR(10) NOT NULL,
    Status ENUM('Active','Inactive') DEFAULT 'Active',

    CONSTRAINT FK_Area_City
    FOREIGN KEY(CityID)
    REFERENCES RE_City(CityID)
);

-- Insert Records

INSERT INTO RE_Area(CityID,AreaName,Pincode) 
VALUES
(1,'Anna Nagar','600040'),
(1,'Velachery','600042'),
(1,'T Nagar','600017'),
(2,'RS Puram','641002'),
(2,'Saibaba Colony','641011'),
(6,'Whitefield','560066'),
(6,'Electronic City','560100'),
(8,'Andheri','400053'),
(8,'Bandra','400050'),
(10,'Salt Lake','700091');

-- Step 6: Create RE_PropertyType Table

CREATE TABLE RE_PropertyType
(
    PropertyTypeID INT AUTO_INCREMENT PRIMARY KEY,
    PropertyTypeName VARCHAR(50) NOT NULL UNIQUE,
    Status ENUM('Active','Inactive') DEFAULT 'Active'
);

-- Insert Records

INSERT INTO RE_PropertyType(PropertyTypeName) 
VALUES
('Apartment'),
('Villa'),
('Independent House'),
('Commercial Office'),
('Residential Plot'),
('Farm House'),
('Studio Apartment'),
('Duplex House'),
('Warehouse'),
('Shop');

-- Step 7: Create RE_PropertyStatus Table

CREATE TABLE RE_PropertyStatus
(
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(30) UNIQUE
);

-- Insert Records

INSERT INTO RE_PropertyStatus(StatusName) 
VALUES
('Available'),
('Booked'),
('Sold'),
('Rented'),
('Under Maintenance');

-- Step 8: Create RE_Amenity Table

CREATE TABLE RE_Amenity
(
    AmenityID INT AUTO_INCREMENT PRIMARY KEY,
    AmenityName VARCHAR(50) UNIQUE,
    Status ENUM('Active','Inactive') DEFAULT 'Active'
);

-- Insert Records

INSERT INTO RE_Amenity(AmenityName) 
VALUES
('Swimming Pool'),
('Gym'),
('Car Parking'),
('Lift'),
('Power Backup'),
('CCTV'),
('Children Park'),
('Club House'),
('Garden'),
('24x7 Security');

-- Step 9: Create RE_PaymentMethod Table

CREATE TABLE RE_PaymentMethod
(
    PaymentMethodID INT AUTO_INCREMENT PRIMARY KEY,
    PaymentMethodName VARCHAR(40) UNIQUE
);

-- Insert Records

INSERT INTO RE_PaymentMethod(PaymentMethodName) 
VALUES
('Cash'),
('UPI'),
('Credit Card'),
('Debit Card'),
('Net Banking'),
('Cheque'),
('RTGS'),
('NEFT');


-- Table 1: RE_User

CREATE TABLE RE_User
(
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Gender ENUM('Male','Female','Other'),
    DOB DATE,
    Email VARCHAR(100) UNIQUE,
    Mobile VARCHAR(15) UNIQUE,
    Password VARCHAR(255) NOT NULL,
    UserRole ENUM('Admin','Owner','Agent','Customer') NOT NULL,
    Status ENUM('Active','Inactive') DEFAULT 'Active',
    AddedOn DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: RE_Owner

CREATE TABLE RE_Owner
 (
    OwnerID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Address VARCHAR(200),
    CityID INT,
    AadhaarNo VARCHAR(20) UNIQUE,
    PANNo VARCHAR(20) UNIQUE,
    
    FOREIGN KEY (UserID)
        REFERENCES RE_User (UserID),
    
    FOREIGN KEY (CityID)
        REFERENCES RE_City (CityID)
);

-- Table 3: RE_Agent 

CREATE TABLE RE_Agent
(
    AgentID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    LicenseNo VARCHAR(50) UNIQUE,
    Experience INT,
    CommissionPercent DECIMAL(5,2),

    FOREIGN KEY(UserID)
    REFERENCES RE_User(UserID)
);

-- Table 4: RE_Customer

CREATE TABLE RE_Customer
(
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT NOT NULL,
    Occupation VARCHAR(50),
    AnnualIncome DECIMAL(12,2),

    FOREIGN KEY(UserID)
    REFERENCES RE_User(UserID)
);

-- Table 5: RE_Property

CREATE TABLE RE_Property
(
    PropertyID INT AUTO_INCREMENT PRIMARY KEY,

    OwnerID INT NOT NULL,

    AgentID INT,

    PropertyTypeID INT NOT NULL,

    StatusID INT NOT NULL,

    AreaID INT NOT NULL,

    PropertyTitle VARCHAR(150),

    Address VARCHAR(250),

    Bedrooms INT,

    Bathrooms INT,

    AreaSqft DECIMAL(10,2),

    PropertyPrice DECIMAL(15,2),

    RentPerMonth DECIMAL(12,2),

    BuildYear YEAR,

    Description TEXT,

    AddedOn DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(OwnerID)
    REFERENCES RE_Owner(OwnerID),

    FOREIGN KEY(AgentID)
    REFERENCES RE_Agent(AgentID),

    FOREIGN KEY(PropertyTypeID)
    REFERENCES RE_PropertyType(PropertyTypeID),

    FOREIGN KEY(StatusID)
    REFERENCES RE_PropertyStatus(StatusID),

    FOREIGN KEY(AreaID)
    REFERENCES RE_Area(AreaID)
);

-- Table 6: RE_PropertyImage
 
 CREATE TABLE RE_PropertyImage
(
    ImageID INT AUTO_INCREMENT PRIMARY KEY,

    PropertyID INT,

    ImageURL VARCHAR(255),

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID)
);

-- Table 7: RE_PropertyAmenity

CREATE TABLE RE_PropertyAmenity
(
    PropertyAmenityID INT AUTO_INCREMENT PRIMARY KEY,

    PropertyID INT,

    AmenityID INT,

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID),

    FOREIGN KEY(AmenityID)
    REFERENCES RE_Amenity(AmenityID)
);
 
 -- Table 8: RE_Booking
 
 CREATE TABLE RE_Booking
(
    BookingID INT AUTO_INCREMENT PRIMARY KEY,

    CustomerID INT,

    PropertyID INT,

    BookingDate DATE,

    BookingAmount DECIMAL(12,2),

    BookingStatus ENUM
    ('Pending','Confirmed','Cancelled'),

    FOREIGN KEY(CustomerID)
    REFERENCES RE_Customer(CustomerID),

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID)
);

-- Table 9: RE_Rental

CREATE TABLE RE_Rental
(
    RentalID INT AUTO_INCREMENT PRIMARY KEY,

    PropertyID INT,

    CustomerID INT,

    RentAmount DECIMAL(12,2),

    SecurityDeposit DECIMAL(12,2),

    LeaseStart DATE,

    LeaseEnd DATE,

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID),

    FOREIGN KEY(CustomerID)
    REFERENCES RE_Customer(CustomerID)
);

-- Table 10: RE_Sale
 
 CREATE TABLE RE_Sale
(
    SaleID INT AUTO_INCREMENT PRIMARY KEY,

    PropertyID INT,

    CustomerID INT,

    SalePrice DECIMAL(15,2),

    SaleDate DATE,

    RegistrationNumber VARCHAR(100),

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID),

    FOREIGN KEY(CustomerID)
    REFERENCES RE_Customer(CustomerID)
);

-- Table 11: RE_Payment

CREATE TABLE RE_Payment
(
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,

    BookingID INT,

    PaymentMethodID INT,

    Amount DECIMAL(12,2),

    PaymentDate DATE,

    PaymentStatus ENUM
    ('Pending','Success','Failed'),

    FOREIGN KEY(BookingID)
    REFERENCES RE_Booking(BookingID),

    FOREIGN KEY(PaymentMethodID)
    REFERENCES RE_PaymentMethod(PaymentMethodID)
);

-- Table 12: RE_Commission

CREATE TABLE RE_Commission
(
    CommissionID INT AUTO_INCREMENT PRIMARY KEY,

    AgentID INT,

    SaleID INT,

    CommissionAmount DECIMAL(12,2),

    PaidDate DATE,

    FOREIGN KEY(AgentID)
    REFERENCES RE_Agent(AgentID),

    FOREIGN KEY(SaleID)
    REFERENCES RE_Sale(SaleID)
);

-- Table 13: RE_Maintenance
 
 CREATE TABLE RE_Maintenance
(
    MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,

    PropertyID INT,

    CustomerID INT,

    Complaint TEXT,

    ComplaintDate DATE,

    Status ENUM
    ('Open','In Progress','Closed'),

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID),

    FOREIGN KEY(CustomerID)
    REFERENCES RE_Customer(CustomerID)
);

-- Table 14: RE_Review

CREATE TABLE RE_Review
(
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,

    PropertyID INT,

    CustomerID INT,

    Rating INT CHECK(Rating BETWEEN 1 AND 5),

    Review TEXT,

    ReviewDate DATE,

    FOREIGN KEY(PropertyID)
    REFERENCES RE_Property(PropertyID),

    FOREIGN KEY(CustomerID)
    REFERENCES RE_Customer(CustomerID)
);

-- 1. RE_User

INSERT INTO RE_User
(FirstName, LastName, Gender, DOB, Email, Mobile, Password, UserRole)
VALUES
('Arun','Kumar','Male','1998-05-10','arun@gmail.com','9876543210','Arun@123','Owner'),
('Priya','Sharma','Female','1997-09-18','priya@gmail.com','9876543211','Priya@123','Customer'),
('Rahul','Verma','Male','1995-11-20','rahul@gmail.com','9876543212','Rahul@123','Agent'),
('Sneha','Reddy','Female','1999-03-25','sneha@gmail.com','9876543213','Sneha@123','Customer'),
('Karthik','Raj','Male','1996-07-12','karthik@gmail.com','9876543214','Karthik@123','Admin');

-- 2. RE_Owner

INSERT INTO RE_Owner
(UserID, Address, CityID, AadhaarNo, PANNo)
VALUES
(1,'Anna Nagar, Chennai',1,'123456789012','ABCDE1234F'),
(5,'Velachery, Chennai',1,'123456789013','ABCDE1235F');

-- 3. RE_Agent

INSERT INTO RE_Agent
(UserID, LicenseNo, Experience, CommissionPercent)
VALUES
(3,'LIC1001',5,2.50);

-- 4. RE_Customer

INSERT INTO RE_Customer
(UserID,
 Occupation, 
 AnnualIncome)
VALUES
(2,'Software Engineer',850000),
(4,'Doctor',1200000);

-- 5. RE_Property

INSERT INTO RE_Property
(
OwnerID,
AgentID,
PropertyTypeID,
StatusID,
AreaID,
PropertyTitle,
Address,
Bedrooms,
Bathrooms,
AreaSqft,
PropertyPrice,
RentPerMonth,
BuildYear,
Description
)
VALUES
(1,1,2,1,1,
'Luxury Villa',
'Anna Nagar',
4,
3,
2500,
12000000,
45000,
2022,
'Fully Furnished'),

(2,1,1,1,2,
'Modern Apartment',
'Velachery',
2,
2,
1200,
6500000,
22000,
2021,
'Near Metro');

-- 6. RE_PropertyImage

INSERT INTO RE_PropertyImage
(PropertyID,
ImageURL)
VALUES
(1,'villa1.jpg'),
(2,'apartment1.jpg');

-- 7. RE_PropertyAmenity

INSERT INTO RE_PropertyAmenity
(PropertyID,
AmenityID)
VALUES
(1,1),
(1,2),
(1,3),
(2,3),
(2,4);

-- 8. RE_Booking

INSERT INTO RE_Booking
(CustomerID,
PropertyID,
BookingDate,
BookingAmount,
BookingStatus)
VALUES
(1,1,'2026-06-10',500000,'Confirmed'),
(2,2,'2026-06-15',200000,'Pending');

-- 9. RE_Rental

INSERT INTO RE_Rental
(
PropertyID,
CustomerID,
RentAmount,
SecurityDeposit,
LeaseStart,
LeaseEnd
)
VALUES
(2,2,22000,50000,'2026-07-01','2027-06-30');

-- 10. RE_Sale

INSERT INTO RE_Sale
(
PropertyID,
CustomerID,
SalePrice,
SaleDate,
RegistrationNumber
)
VALUES
(1,1,12000000,'2026-06-18','TN202600001');

-- 11. RE_Payment

INSERT INTO RE_Payment
(
BookingID,
PaymentMethodID,
Amount,
PaymentDate,
PaymentStatus
)
VALUES
(1,2,500000,'2026-06-10','Success'),
(2,3,200000,'2026-06-15','Pending');

-- 12. RE_Commission

INSERT INTO RE_Commission
(
AgentID,
SaleID,
CommissionAmount,
PaidDate
)
VALUES
(1,1,300000,'2026-06-20');

-- 13. RE_Maintenance

INSERT INTO RE_Maintenance
(
PropertyID,
CustomerID,
Complaint,
ComplaintDate,
Status
)
VALUES
(2,2,'Water leakage in bathroom','2026-07-15','Open');

-- 14. RE_Review

INSERT INTO RE_Review
(
PropertyID,
CustomerID,
Rating,
Review,
ReviewDate
)
VALUES
(1,1,5,'Excellent Property','2026-06-25'),
(2,2,4,'Good Location','2026-07-20');




/*1. VIEW
View 1 – Available Properties */

CREATE VIEW VW_AvailableProperties AS
    SELECT 
        p.PropertyID,
        p.PropertyTitle,
        pt.PropertyTypeName,
        ps.StatusName,
        p.PropertyPrice,
        p.RentPerMonth
    FROM
        RE_Property p
            INNER JOIN
        RE_PropertyType pt ON p.PropertyTypeID = pt.PropertyTypeID
            INNER JOIN
        RE_PropertyStatus ps ON p.StatusID = ps.StatusID
    WHERE
        ps.StatusName = 'Available';

-- Execute

SELECT * FROM VW_AvailableProperties;

-- View 2 – Customer Booking Details

CREATE VIEW VW_CustomerBooking AS
SELECT
u.FirstName,
b.BookingID,
b.BookingDate,
b.BookingAmount,
b.BookingStatus
FROM RE_Booking b
INNER JOIN RE_Customer c
ON b.CustomerID=c.CustomerID
INNER JOIN RE_User u
ON c.UserID=u.UserID;

-- Execute

SELECT * FROM VW_CustomerBooking;

-- 2. STORED PROCEDURES

-- Procedure 1 – Display All Properties

DELIMITER $$

CREATE PROCEDURE SP_AllProperties()
BEGIN

SELECT *
FROM RE_Property;

END$$

DELIMITER ;

-- Execute

CALL SP_AllProperties();

-- Procedure 2 – Search Property by Price

-- Customer Searches for Property and price

DELIMITER $$

CREATE PROCEDURE SP_SearchProperty
(
IN MinPrice DECIMAL(12,2)
)

BEGIN

SELECT *
FROM RE_Property
WHERE PropertyPrice>=MinPrice;

END$$

DELIMITER ;

-- Execute

CALL SP_SearchProperty(5000000);

-- Procedure 3 – Property Count

DELIMITER $$

CREATE PROCEDURE SP_TotalProperty()

BEGIN

SELECT COUNT(*) AS TotalProperty
FROM RE_Property;

END$$

DELIMITER ;

-- Execute

CALL SP_TotalProperty();

-- PROCEDURE 4 : Add New Property

-- Add a New Property

DELIMITER $$

CREATE PROCEDURE SP_AddProperty
(
IN P_OwnerID INT,
IN P_AgentID INT,
IN P_PropertyTypeID INT,
IN P_StatusID INT,
IN P_AreaID INT,
IN P_PropertyTitle VARCHAR(150),
IN P_Address VARCHAR(250),
IN P_Bedrooms INT,
IN P_Bathrooms INT,
IN P_AreaSqft DECIMAL(10,2),
IN P_PropertyPrice DECIMAL(15,2),
IN P_RentPerMonth DECIMAL(12,2),
IN P_BuildYear YEAR,
IN P_Description TEXT
)
BEGIN

INSERT INTO RE_Property
(
OwnerID,
AgentID,
PropertyTypeID,
StatusID,
AreaID,
PropertyTitle,
Address,
Bedrooms,
Bathrooms,
AreaSqft,
PropertyPrice,
RentPerMonth,
BuildYear,
Description
)

VALUES
(
P_OwnerID,
P_AgentID,
P_PropertyTypeID,
P_StatusID,
P_AreaID,
P_PropertyTitle,
P_Address,
P_Bedrooms,
P_Bathrooms,
P_AreaSqft,
P_PropertyPrice,
P_RentPerMonth,
P_BuildYear,
P_Description
);

END$$

DELIMITER ;

CALL SP_AddProperty
(
1,1,2,1,1,
'Premium Villa',
'Anna Nagar, Chennai',
4,3,2500,
15000000,
50000,
2024,
'Luxury Villa with Swimming Pool'
);



-- 3. FUNCTIONS
-- Function 1 – GST Calculation

DELIMITER $$

CREATE FUNCTION FN_GST
(
Amount DECIMAL(12,2)
)

RETURNS DECIMAL(12,2)

DETERMINISTIC

BEGIN

RETURN Amount*0.18;

END$$

DELIMITER ;

-- Execute

SELECT 
    PropertyPrice, FN_GST(PropertyPrice) AS GST
FROM
    RE_Property;

-- Function 2 – Commission

-- Agent Commission Calculation

DELIMITER $$

CREATE FUNCTION FN_Commission
(
SaleAmount DECIMAL(12,2)
)

RETURNS DECIMAL(12,2)

DETERMINISTIC

BEGIN

RETURN SaleAmount*0.02;

END$$

DELIMITER ;

-- Execute

SELECT
SalePrice,
FN_Commission(SalePrice)
FROM RE_Sale;

-- 4. TRIGGERS

-- Trigger 1 – Before Insert

-- Automatically set property title in uppercase.

DELIMITER $$

CREATE TRIGGER TR_BeforeInsertProperty

BEFORE INSERT

ON RE_Property

FOR EACH ROW

BEGIN

SET NEW.PropertyTitle=
UPPER(NEW.PropertyTitle);

END$$

DELIMITER ;

-- Trigger 2 – After Insert

-- Store payment audit information.

-- Create Audit Table

CREATE TABLE RE_PaymentAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    PaymentID INT,
    Amount DECIMAL(12 , 2 ),
    AuditDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Trigger

DELIMITER $$

CREATE TRIGGER TR_AfterPayment

AFTER INSERT

ON RE_Payment

FOR EACH ROW

BEGIN

INSERT INTO RE_PaymentAudit
(PaymentID,Amount)

VALUES
(NEW.PaymentID,
NEW.Amount);

END$$

DELIMITER ;

-- Trigger 3 – Before Update

DELIMITER $$

CREATE TRIGGER TR_BeforePriceUpdate

BEFORE UPDATE

ON RE_Property

FOR EACH ROW

BEGIN

IF NEW.PropertyPrice<0 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Invalid Price';

END IF;

END$$

DELIMITER ;

-- Trigger 4 – Before Delete

DELIMITER $$

CREATE TRIGGER TR_NoDeleteSoldProperty

BEFORE DELETE

ON RE_Property

FOR EACH ROW

BEGIN

IF OLD.StatusID=3 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Sold Property Cannot Be Deleted';

END IF;

END$$

DELIMITER ;

-- Trigger 5 – Auto Change Property Status to "Booked"

-- Automatic Property Status Update

DELIMITER $$

CREATE TRIGGER TR_AfterBooking

AFTER INSERT
ON RE_Booking

FOR EACH ROW

BEGIN

UPDATE RE_Property

SET StatusID = 2

WHERE PropertyID = NEW.PropertyID;

END$$

DELIMITER ;

-- Trigger 6 – Auto Change Property Status to "Sold"

-- Automatic Property Status Update

DELIMITER $$

CREATE TRIGGER TR_AfterSale

AFTER INSERT
ON RE_Sale

FOR EACH ROW

BEGIN

UPDATE RE_Property

SET StatusID = 3

WHERE PropertyID = NEW.PropertyID;

END$$

DELIMITER ;

-- Trigger 7 – Validate Booking Amount


-- Book a Property
 
 DELIMITER $$

CREATE TRIGGER TR_CheckBookingAmount

BEFORE INSERT
ON RE_Booking

FOR EACH ROW

BEGIN

IF NEW.BookingAmount <= 0 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Booking Amount Must Be Greater Than Zero';

END IF;

END$$

DELIMITER ;

-- Trigger 8 – Validate Rent Amount

-- Payment Processing

DELIMITER $$

CREATE TRIGGER TR_CheckRent

BEFORE INSERT
ON RE_Rental

FOR EACH ROW

BEGIN

IF NEW.RentAmount < 5000 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Minimum Rent Amount is Rs.5000';

END IF;

END$$

DELIMITER ;

-- Trigger 9 – Payment Audit
-- Create Audit Table


-- Trigger

DELIMITER $$

CREATE TRIGGER TR_PaymentAudit

AFTER INSERT
ON RE_Payment

FOR EACH ROW

BEGIN

INSERT INTO RE_PaymentAudit
(
PaymentID,
Amount,
PaymentDate
)

VALUES
(
NEW.PaymentID,
NEW.Amount,
NEW.PaymentDate
);

END$$

DELIMITER ;

-- Trigger 10 – Property Delete Backup
-- Backup Table

CREATE TABLE RE_PropertyBackup

AS

SELECT *

FROM RE_Property

WHERE 1=2;

-- Trigger

DELIMITER $$

CREATE TRIGGER TR_BackupProperty

BEFORE DELETE
ON RE_Property

FOR EACH ROW

BEGIN

INSERT INTO RE_PropertyBackup

SELECT *

FROM RE_Property

WHERE PropertyID = OLD.PropertyID;

END$$

DELIMITER ;

-- Trigger 11 – Validate Review Rating

DELIMITER $$

CREATE TRIGGER TR_CheckRating

BEFORE INSERT
ON RE_Review

FOR EACH ROW

BEGIN

IF NEW.Rating < 1 OR NEW.Rating > 5 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Rating Must Be Between 1 and 5';

END IF;

END$$

DELIMITER ;

-- Trigger 12 – Auto Set Booking Date

DELIMITER $$

CREATE TRIGGER TR_BookingDate

BEFORE INSERT
ON RE_Booking

FOR EACH ROW

BEGIN

SET NEW.BookingDate = CURDATE();

END$$

DELIMITER ;

-- Trigger 13 – Prevent Duplicate Sale

DELIMITER $$

CREATE TRIGGER TR_NoDuplicateSale

BEFORE INSERT
ON RE_Sale

FOR EACH ROW

BEGIN

IF EXISTS
(
SELECT 1
FROM RE_Sale
WHERE PropertyID = NEW.PropertyID
)
THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Property Already Sold';

END IF;

END$$

DELIMITER ;

-- Trigger 14 – Auto Close Maintenance

DELIMITER $$

CREATE TRIGGER TR_CloseMaintenance

AFTER UPDATE
ON RE_Maintenance

FOR EACH ROW

BEGIN

IF NEW.Status='Closed' THEN

UPDATE RE_Property

SET StatusID = 1

WHERE PropertyID = NEW.PropertyID;

END IF;

END$$

DELIMITER ;

-- Trigger 15 – Prevent Owner Deletion

DELIMITER $$

CREATE TRIGGER TR_PreventOwnerDelete

BEFORE DELETE
ON RE_Owner

FOR EACH ROW

BEGIN

IF EXISTS
(
SELECT 1
FROM RE_Property
WHERE OwnerID = OLD.OwnerID
)
THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Owner Has Properties. Delete Not Allowed';

END IF;

END$$

DELIMITER ;

-- 5. TRANSACTIONS

START TRANSACTION;

UPDATE RE_Property

SET PropertyPrice=7500000

WHERE PropertyID=1;

SAVEPOINT PriceUpdated;

UPDATE RE_Property

SET RentPerMonth=25000

WHERE PropertyID=2;

ROLLBACK TO PriceUpdated;

COMMIT;

-- 6. INDEX

CREATE INDEX IDX_PropertyPrice

ON RE_Property(PropertyPrice);

CREATE INDEX IDX_UserEmail

ON RE_User(Email);

-- 7. SHOW INDEX

SHOW INDEX
FROM RE_Property;

-- 8. DROP VIEW

DROP VIEW VW_AvailableProperties;

-- 9. DROP PROCEDURE

DROP PROCEDURE SP_AllProperties;

-- 10. DROP FUNCTION

DROP FUNCTION FN_GST;

-- 11. DROP TRIGGER

DROP TRIGGER TR_BeforeInsertProperty;

-- 1. EVENT SCHEDULER
-- Enable Event Scheduler 

SET GLOBAL event_scheduler = ON;

-- Create Event

--  Automatically delete reviews older than 5 years.

CREATE EVENT EV_DeleteOldReviews

ON SCHEDULE EVERY 1 MONTH

DO

DELETE FROM RE_Review

WHERE ReviewDate < DATE_SUB(CURDATE(),INTERVAL 5 YEAR);

-- View Events

SHOW EVENTS;

-- 2. CURSOR

-- Display all property names using a cursor.

DELIMITER $$

CREATE PROCEDURE SP_DisplayProperties()

BEGIN

DECLARE Finished INT DEFAULT 0;

DECLARE Property_Name VARCHAR(150);

DECLARE PropertyCursor CURSOR FOR

SELECT PropertyTitle
FROM RE_Property;

DECLARE CONTINUE HANDLER
FOR NOT FOUND SET Finished=1;

OPEN PropertyCursor;

PropertyLoop: LOOP

FETCH PropertyCursor
INTO Property_Name;

IF Finished=1 THEN

LEAVE PropertyLoop;

END IF;

SELECT Property_Name;

END LOOP;

CLOSE PropertyCursor;

END$$

DELIMITER ;

-- Execute

CALL SP_DisplayProperties();

-- 3. WINDOW FUNCTION

-- ROW_NUMBER()

SELECT

PropertyTitle,

PropertyPrice,

ROW_NUMBER() OVER
(
ORDER BY PropertyPrice DESC
)
AS Ranking

FROM RE_Property;

-- RANK()

SELECT

PropertyTitle,

PropertyPrice,

RANK() OVER
(
ORDER BY PropertyPrice DESC
)
AS RankNo

FROM RE_Property;

-- DENSE_RANK()

SELECT

PropertyTitle,

PropertyPrice,

DENSE_RANK() OVER
(
ORDER BY PropertyPrice DESC
)
AS DenseRank

FROM RE_Property;

-- 4. COMMON TABLE EXPRESSION (CTE)

WITH ExpensiveProperty AS

(
SELECT *

FROM RE_Property

WHERE PropertyPrice>5000000
)

SELECT *

FROM ExpensiveProperty;

-- 5. TEMPORARY TABLE

CREATE TEMPORARY TABLE TempProperty

SELECT

PropertyID,

PropertyTitle,

PropertyPrice

FROM RE_Property;

-- View

SELECT *

FROM TempProperty;

-- 6. JSON COLUMN

-- Create table

CREATE TABLE RE_Document

(

DocumentID INT AUTO_INCREMENT PRIMARY KEY,

PropertyID INT,

DocumentDetails JSON,

FOREIGN KEY(PropertyID)

REFERENCES RE_Property(PropertyID)

);

-- Insert JSON

INSERT INTO RE_Document

(PropertyID,DocumentDetails)

VALUES

(

1,

'{

"Owner":"Arun",

"DocumentType":"Sale Deed",

"Approved":"Yes",

"RegistrationNo":"TN12345"

}'

);

-- Read JSON

SELECT

JSON_EXTRACT(DocumentDetails,'$.Owner')

FROM RE_Document;

-- 7. DATE FUNCTIONS

SELECT

CURDATE();

SELECT

NOW();

SELECT

DATEDIFF

(

'2027-01-01',

'2026-01-01'

);

-- 8. STRING FUNCTIONS

-- Uppercase

SELECT

UPPER(PropertyTitle)

FROM RE_Property;

-- Lowercase

SELECT

LOWER(PropertyTitle)

FROM RE_Property;

-- Length

SELECT

PropertyTitle,

LENGTH(PropertyTitle)

FROM RE_Property;

-- Concat

SELECT

CONCAT

(

PropertyTitle,

' - ₹',

PropertyPrice

)

FROM RE_Property;

-- 9. NUMERIC FUNCTIONS

SELECT

ROUND(1256.897,2);

SELECT

CEIL(1256.23);

SELECT

FLOOR(1256.98);

-- 10. REPORT QUERY

-- Property Sales Report

SELECT

p.PropertyTitle,

s.SalePrice,

u.FirstName AS Customer

FROM RE_Sale s

INNER JOIN RE_Property p

ON s.PropertyID=p.PropertyID

INNER JOIN RE_Customer c

ON s.CustomerID=c.CustomerID

INNER JOIN RE_User u

ON c.UserID=u.UserID;

-- 11. Agent Commission Report

SELECT

a.AgentID,

u.FirstName,

c.CommissionAmount

FROM RE_Commission c

INNER JOIN RE_Agent a

ON c.AgentID=a.AgentID

INNER JOIN RE_User u

ON a.UserID=u.UserID;

-- 12. Monthly Booking Report

-- Monthly Business Report

SELECT

MONTH(BookingDate)

AS BookingMonth,

COUNT(*)

AS TotalBooking

FROM RE_Booking

GROUP BY MONTH(BookingDate);


-- 13. Top 5 Expensive Properties

SELECT *

FROM RE_Property

ORDER BY PropertyPrice DESC

LIMIT 5;


-- 14. Available Properties Report

SELECT

PropertyTitle,

PropertyPrice

FROM RE_Property

WHERE StatusID=1;


-- 15. Backup Table

CREATE TABLE RE_Property_Backup

AS

SELECT *

FROM RE_Property;



/*
Example Real-Time Scenario

A customer wants to buy a property.

1.Customer searches for a property.
2.Customer selects a property.
3.Booking details are stored.
4.Payment is completed.
5.Sale record is created.
6.Property status changes from Available to Sold automatically.
7.Agent commission is calculated.
8.Customer receives ownership of the property.
9.How can the system prevent two customers from booking the same property simultaneously?
10.What should happen if a customer tries to book a property that is already sold?
11.How can the system automatically change the property status after a successful booking?
12.How do you calculate an agent's commission after a property sale?
13.How can the system prevent duplicate property registrations?
14.What validation should be performed before adding a new property?
15.How can the system ensure that a property's selling price is greater than zero?
16.How can a customer search for properties within a specific budget?
17.How can the system find all available properties in a selected city?
18.How can the system prevent the deletion of an owner who still owns properties?
19.How can the system automatically record every payment in an audit table?
20.How can you calculate monthly revenue from both property sales and rentals?
21.How can the system identify the top-performing real estate agent?
22.How can the system generate a list of unsold properties?

*/

