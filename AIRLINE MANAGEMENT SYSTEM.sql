CREATE DATABASE AirlineReservationDB;

USE AirlineReservationDB;


-- 1. AIRPORT

CREATE TABLE Airport
(
    AirportID INT AUTO_INCREMENT PRIMARY KEY,
    AirportCode VARCHAR(10) NOT NULL UNIQUE,
    AirportName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active'
        CHECK(Status IN ('Active','Inactive'))
);


-- 2. AIRCRAFT


CREATE TABLE Aircraft
(
    AircraftID INT AUTO_INCREMENT PRIMARY KEY,
    AircraftCode VARCHAR(20) NOT NULL UNIQUE,
    AircraftName VARCHAR(100) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Manufacturer VARCHAR(50) NOT NULL,
    Capacity INT NOT NULL CHECK(Capacity > 0),
    Status VARCHAR(20) DEFAULT 'Available'
        CHECK(Status IN ('Available','Maintenance','Unavailable'))
);


-- 3. FLIGHT STATUS


CREATE TABLE FlightStatus
(
    StatusID INT AUTO_INCREMENT PRIMARY KEY,
    StatusName VARCHAR(30) NOT NULL UNIQUE,
    Description VARCHAR(100)
);


-- 4. SEAT CLASS

CREATE TABLE SeatClass
(
    ClassID INT AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(100)
);


-- 5. PAYMENT METHOD


CREATE TABLE PaymentMethod
(
    MethodID INT AUTO_INCREMENT PRIMARY KEY,
    MethodName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(100)
);

 -- 6.Example (Passenger Table)

CREATE TABLE Passenger
(
    PassengerID INT AUTO_INCREMENT PRIMARY KEY,
    PassengerName VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female','Other') NOT NULL,
    Age INT NOT NULL CHECK (Age >= 1),
    Phone VARCHAR(15) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PassportNo VARCHAR(20) NOT NULL UNIQUE,
    Address VARCHAR(200),
    CreatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7.Example (Flight Table with Foreign Keys)

CREATE TABLE Flight
(
    FlightID INT AUTO_INCREMENT PRIMARY KEY,
    FlightNumber VARCHAR(20) NOT NULL UNIQUE,
    FlightName VARCHAR(100) NOT NULL,

    SourceAirportID INT NOT NULL,
    DestinationAirportID INT NOT NULL,

    AircraftID INT NOT NULL,
    StatusID INT NOT NULL,

    DepartureDate DATE NOT NULL,
    DepartureTime TIME NOT NULL,
    ArrivalTime TIME NOT NULL,

    Fare DECIMAL(10,2) NOT NULL CHECK (Fare > 0),

    FOREIGN KEY (SourceAirportID)
        REFERENCES Airport(AirportID),

    FOREIGN KEY (DestinationAirportID)
        REFERENCES Airport(AirportID),

    FOREIGN KEY (AircraftID)
        REFERENCES Aircraft(AircraftID),

    FOREIGN KEY (StatusID)
        REFERENCES FlightStatus(StatusID)
);

-- 8. BOOKING

CREATE TABLE Booking
(
    BookingID INT AUTO_INCREMENT PRIMARY KEY,

    PassengerID INT NOT NULL,

    FlightID INT NOT NULL,

    BookingDate DATE NOT NULL,

    BookingStatus VARCHAR(30)
    DEFAULT 'Booked'
    CHECK(BookingStatus IN
    ('Booked','Cancelled','Completed')),

    FOREIGN KEY(PassengerID)
    REFERENCES Passenger(PassengerID),

    FOREIGN KEY(FlightID)
    REFERENCES Flight(FlightID)
);


-- 9. TICKET


CREATE TABLE Ticket
(
    TicketID INT AUTO_INCREMENT PRIMARY KEY,

    BookingID INT NOT NULL UNIQUE,

    TicketNumber VARCHAR(30)
    NOT NULL UNIQUE,

    ClassID INT NOT NULL,

    SeatNumber VARCHAR(10),

    TicketPrice DECIMAL(10,2)
    NOT NULL CHECK(TicketPrice>0),

    FOREIGN KEY(BookingID)
    REFERENCES Booking(BookingID),

    FOREIGN KEY(ClassID)
    REFERENCES SeatClass(ClassID)
);


-- 10. SEAT ALLOCATION


CREATE TABLE SeatAllocation
(
    AllocationID INT AUTO_INCREMENT PRIMARY KEY,

    FlightID INT NOT NULL,

    TicketID INT NOT NULL,

    SeatNumber VARCHAR(10)
    NOT NULL,

    SeatStatus VARCHAR(20)
    DEFAULT 'Allocated'
    CHECK(SeatStatus IN
    ('Allocated','Available','Blocked')),

    FOREIGN KEY(FlightID)
    REFERENCES Flight(FlightID),

    FOREIGN KEY(TicketID)
    REFERENCES Ticket(TicketID)
);

-- 11. PAYMENT


CREATE TABLE Payment
(
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,

    BookingID INT NOT NULL,

    MethodID INT NOT NULL,

    Amount DECIMAL(10,2)
    NOT NULL CHECK(Amount>0),

    PaymentDate DATE NOT NULL,

    PaymentStatus VARCHAR(20)
    DEFAULT 'Paid'
    CHECK(PaymentStatus IN
    ('Paid','Pending','Refunded')),

    FOREIGN KEY(BookingID)
    REFERENCES Booking(BookingID),

    FOREIGN KEY(MethodID)
    REFERENCES PaymentMethod(MethodID)
);


-- 12. CANCELLATION



CREATE TABLE Cancellation
(
    CancellationID INT AUTO_INCREMENT PRIMARY KEY,

    BookingID INT NOT NULL UNIQUE,

    CancellationDate DATE NOT NULL,

    RefundAmount DECIMAL(10,2)
    DEFAULT 0 CHECK(RefundAmount>=0),

    Reason VARCHAR(200),

    FOREIGN KEY(BookingID)
    REFERENCES Booking(BookingID)
);


-- 1. Airport 

INSERT INTO Airport
(AirportCode, AirportName, City, State, Country, Status)
VALUES
('MAA','Chennai International Airport','Chennai','Tamil Nadu','India','Active'),
('DEL','Indira Gandhi International Airport','Delhi','Delhi','India','Active'),
('BLR','Kempegowda International Airport','Bengaluru','Karnataka','India','Active'),
('HYD','Rajiv Gandhi International Airport','Hyderabad','Telangana','India','Active'),
('COK','Cochin International Airport','Kochi','Kerala','India','Active'),
('CCU','Netaji Subhas Chandra Bose Airport','Kolkata','West Bengal','India','Active'),
('AMD','Sardar Vallabhbhai Patel Airport','Ahmedabad','Gujarat','India','Active'),
('GOI','Goa International Airport','Goa','Goa','India','Active'),
('PNQ','Pune International Airport','Pune','Maharashtra','India','Active'),
('JAI','Jaipur International Airport','Jaipur','Rajasthan','India','Active'),
('TRV','Trivandrum International Airport','Thiruvananthapuram','Kerala','India','Active'),
('IXM','Madurai Airport','Madurai','Tamil Nadu','India','Active'),
('IXE','Mangalore International Airport','Mangalore','Karnataka','India','Active'),
('CJB','Coimbatore International Airport','Coimbatore','Tamil Nadu','India','Active'),
('LKO','Chaudhary Charan Singh Airport','Lucknow','Uttar Pradesh','India','Active');

-- 2. Aircraft 

INSERT INTO Aircraft
(AircraftCode, AircraftName, Model, Manufacturer, Capacity, Status)
VALUES
('AC001','IndiGo A320','A320','Airbus',180,'Available'),
('AC002','Air India B787','B787','Boeing',256,'Available'),
('AC003','SpiceJet B737','B737','Boeing',189,'Available'),
('AC004','Vistara A321','A321','Airbus',220,'Available'),
('AC005','Akasa B737 MAX','737 MAX','Boeing',197,'Available'),
('AC006','Alliance ATR72','ATR72','ATR',72,'Available'),
('AC007','AirAsia A320','A320','Airbus',180,'Available'),
('AC008','Emirates B777','B777','Boeing',396,'Available'),
('AC009','Qatar A350','A350','Airbus',325,'Available'),
('AC010','Singapore A380','A380','Airbus',500,'Available'),
('AC011','Lufthansa A340','A340','Airbus',300,'Maintenance'),
('AC012','British Airways B787','B787','Boeing',250,'Available'),
('AC013','Etihad B777','B777','Boeing',350,'Available'),
('AC014','Thai Airways A330','A330','Airbus',280,'Available'),
('AC015','Malaysia A330','A330','Airbus',290,'Available');

-- 3. FlightStatus 

INSERT INTO FlightStatus
(StatusName, Description)
VALUES
('On Time','Flight is on schedule'),
('Delayed','Flight departure delayed'),
('Cancelled','Flight cancelled'),
('Boarding','Passengers are boarding'),
('Departed','Flight has departed'),
('Arrived','Flight has arrived'),
('Rescheduled','Flight rescheduled'),
('Gate Open','Boarding gate is open'),
('Gate Closed','Boarding gate closed'),
('Security Check','Security process in progress'),
('Final Call','Final boarding announcement'),
('Ready','Flight ready for departure'),
('Taxiing','Aircraft moving on runway'),
('Landed','Flight landed successfully'),
('Maintenance','Aircraft under maintenance');

-- 4. SeatClass 

INSERT INTO SeatClass
(ClassName, Description)
VALUES
('Economy','Standard economy class'),
('Premium Economy','Extra legroom'),
('Business','Business class'),
('First Class','Luxury travel'),
('Economy Flex','Flexible economy'),
('Business Flex','Flexible business'),
('Student','Student fare'),
('Senior Citizen','Senior citizen fare'),
('Military','Military personnel'),
('Corporate','Corporate booking'),
('VIP','VIP class'),
('Crew','Crew members'),
('Infant','Infant ticket'),
('Medical','Medical emergency'),
('Emergency','Emergency reserved');

-- 5. PaymentMethod (15 Records)

INSERT INTO PaymentMethod
(MethodName, Description)
VALUES
('UPI','Unified Payments Interface'),
('Credit Card','Visa or MasterCard'),
('Debit Card','Bank Debit Card'),
('Net Banking','Internet Banking'),
('Cash','Cash Payment'),
('Google Pay','Google Pay'),
('PhonePe','PhonePe Wallet'),
('Paytm','Paytm Wallet'),
('Amazon Pay','Amazon Pay'),
('Razorpay','Razorpay Gateway'),
('PayPal','PayPal'),
('Cheque','Cheque Payment'),
('Wallet','Digital Wallet'),
('EMI','Monthly Installment'),
('Bank Transfer','Direct Bank Transfer');

-- 6. Passenger 

INSERT INTO Passenger
(PassengerName, Gender, Age, Phone, Email, PassportNo, Address)
VALUES
('Surya','Male',23,'9876543210','surya@gmail.com','P10001','Chennai'),
('Priya','Female',22,'9876543211','priya@gmail.com','P10002','Madurai'),
('Karthik','Male',25,'9876543212','karthik@gmail.com','P10003','Coimbatore'),
('Divya','Female',24,'9876543213','divya@gmail.com','P10004','Salem'),
('Ravi','Male',30,'9876543214','ravi@gmail.com','P10005','Trichy'),
('Anu','Female',28,'9876543215','anu@gmail.com','P10006','Erode'),
('Vijay','Male',35,'9876543216','vijay@gmail.com','P10007','Chennai'),
('Meena','Female',27,'9876543217','meena@gmail.com','P10008','Kochi'),
('Arun','Male',29,'9876543218','arun@gmail.com','P10009','Hyderabad'),
('Keerthi','Female',26,'9876543219','keerthi@gmail.com','P10010','Bangalore'),
('Rahul','Male',31,'9876543220','rahul@gmail.com','P10011','Delhi'),
('Nisha','Female',21,'9876543221','nisha@gmail.com','P10012','Pune'),
('Sanjay','Male',32,'9876543222','sanjay@gmail.com','P10013','Ahmedabad'),
('Lavanya','Female',29,'9876543223','lavanya@gmail.com','P10014','Goa'),
('Manoj','Male',33,'9876543224','manoj@gmail.com','P10015','Jaipur');

-- 7.Flight 

INSERT INTO Flight
(FlightNumber, FlightName, SourceAirportID, DestinationAirportID,
AircraftID, StatusID, DepartureDate, DepartureTime, ArrivalTime, Fare)
VALUES
('AI101','Air India Express',1,2,2,1,'2026-07-01','08:00:00','10:30:00',6500.00),
('6E201','IndiGo Express',1,3,1,1,'2026-07-01','09:15:00','10:45:00',4200.00),
('SG301','SpiceJet Connect',3,4,3,2,'2026-07-02','11:00:00','12:30:00',4800.00),
('UK401','Vistara Premium',2,5,4,1,'2026-07-02','06:30:00','09:00:00',7200.00),
('QP501','Akasa Sky',5,1,5,1,'2026-07-03','14:00:00','16:00:00',5100.00),
('9I601','Alliance Air',6,7,6,1,'2026-07-03','07:00:00','09:20:00',3900.00),
('I5781','AirAsia India',8,9,7,1,'2026-07-04','12:15:00','14:00:00',4500.00),
('EK801','Emirates India',2,10,8,2,'2026-07-04','18:30:00','22:00:00',15500.00),
('QR901','Qatar Connect',10,2,9,1,'2026-07-05','05:45:00','09:15:00',14900.00),
('SQ1001','Singapore Airlines',3,11,10,1,'2026-07-05','16:00:00','19:30:00',16800.00),
('LH1101','Lufthansa India',2,12,11,3,'2026-07-06','10:30:00','13:30:00',18200.00),
('BA1201','British Airways',4,13,12,1,'2026-07-06','13:00:00','16:15:00',17100.00),
('EY1301','Etihad Airways',13,14,13,1,'2026-07-07','09:00:00','11:40:00',12500.00),
('TG1401','Thai Airways',14,15,14,1,'2026-07-07','15:00:00','18:10:00',11800.00),
('MH1501','Malaysia Airlines',15,1,15,1,'2026-07-08','20:00:00','23:20:00',13200.00);

-- 8.Booking 

INSERT INTO Booking
(PassengerID, FlightID, BookingDate, BookingStatus)
VALUES
(1,1,'2026-06-25','Booked'),
(2,2,'2026-06-25','Booked'),
(3,3,'2026-06-26','Booked'),
(4,4,'2026-06-26','Booked'),
(5,5,'2026-06-27','Booked'),
(6,6,'2026-06-27','Completed'),
(7,7,'2026-06-28','Booked'),
(8,8,'2026-06-28','Cancelled'),
(9,9,'2026-06-29','Booked'),
(10,10,'2026-06-29','Completed'),
(11,11,'2026-06-30','Cancelled'),
(12,12,'2026-06-30','Booked'),
(13,13,'2026-07-01','Booked'),
(14,14,'2026-07-01','Completed'),
(15,15,'2026-07-02','Booked');

-- 9.Ticket 

INSERT INTO Ticket
(BookingID, TicketNumber, ClassID, SeatNumber, TicketPrice)
VALUES
(1,'TKT10001',1,'A1',6500.00),
(2,'TKT10002',2,'A2',4200.00),
(3,'TKT10003',1,'A3',4800.00),
(4,'TKT10004',3,'B1',7200.00),
(5,'TKT10005',1,'B2',5100.00),
(6,'TKT10006',2,'B3',3900.00),
(7,'TKT10007',1,'C1',4500.00),
(8,'TKT10008',4,'C2',15500.00),
(9,'TKT10009',3,'C3',14900.00),
(10,'TKT10010',2,'D1',16800.00),
(11,'TKT10011',1,'D2',18200.00),
(12,'TKT10012',2,'D3',17100.00),
(13,'TKT10013',3,'E1',12500.00),
(14,'TKT10014',1,'E2',11800.00),
(15,'TKT10015',2,'E3',13200.00);

-- 10.SeatAllocation 

INSERT INTO SeatAllocation
(FlightID, TicketID, SeatNumber, SeatStatus)
VALUES
(1,1,'A1','Allocated'),
(2,2,'A2','Allocated'),
(3,3,'A3','Allocated'),
(4,4,'B1','Allocated'),
(5,5,'B2','Allocated'),
(6,6,'B3','Allocated'),
(7,7,'C1','Allocated'),
(8,8,'C2','Allocated'),
(9,9,'C3','Allocated'),
(10,10,'D1','Allocated'),
(11,11,'D2','Allocated'),
(12,12,'D3','Allocated'),
(13,13,'E1','Allocated'),
(14,14,'E2','Allocated'),
(15,15,'E3','Allocated');


-- 11. Payment 

INSERT INTO Payment
(BookingID, MethodID, Amount, PaymentDate, PaymentStatus)
VALUES
(1,1,6500.00,'2026-06-25','Paid'),
(2,2,4200.00,'2026-06-25','Paid'),
(3,3,4800.00,'2026-06-26','Paid'),
(4,4,7200.00,'2026-06-26','Paid'),
(5,5,5100.00,'2026-06-27','Paid'),
(6,6,3900.00,'2026-06-27','Paid'),
(7,7,4500.00,'2026-06-28','Paid'),
(8,8,15500.00,'2026-06-28','Refunded'),
(9,9,14900.00,'2026-06-29','Paid'),
(10,10,16800.00,'2026-06-29','Paid'),
(11,11,18200.00,'2026-06-30','Refunded'),
(12,12,17100.00,'2026-06-30','Paid'),
(13,13,12500.00,'2026-07-01','Paid'),
(14,14,11800.00,'2026-07-01','Paid'),
(15,15,13200.00,'2026-07-02','Paid');

-- 12. Cancellation 

INSERT INTO Cancellation
(BookingID, CancellationDate, RefundAmount, Reason)
VALUES
(1,'2026-06-26',0.00,'Not Cancelled'),
(2,'2026-06-26',0.00,'Not Cancelled'),
(3,'2026-06-27',0.00,'Not Cancelled'),
(4,'2026-06-27',0.00,'Not Cancelled'),
(5,'2026-06-28',0.00,'Not Cancelled'),
(6,'2026-06-28',0.00,'Journey Completed'),
(7,'2026-06-29',0.00,'Not Cancelled'),
(8,'2026-06-29',12000.00,'Passenger Request'),
(9,'2026-06-30',0.00,'Not Cancelled'),
(10,'2026-06-30',0.00,'Journey Completed'),
(11,'2026-07-01',15000.00,'Flight Cancelled'),
(12,'2026-07-01',0.00,'Not Cancelled'),
(13,'2026-07-02',0.00,'Not Cancelled'),
(14,'2026-07-02',0.00,'Journey Completed'),
(15,'2026-07-03',0.00,'Not Cancelled');


-- Airline Reservation System - SQL Queries (Part 1)
-- Query 1 - Display all airports

SELECT 
    *
FROM
    Airport;

-- Query 2 - Display all aircraft

SELECT 
    *
FROM
    Aircraft;

-- Query 3 - Display all passengers

SELECT 
    *
FROM
    Passenger;

-- Query 4 - Display all flights

SELECT 
    *
FROM
    Flight;

-- Query 5 - Display all bookings

SELECT 
    *
FROM
    Booking;

-- Query 6 - Display all tickets

SELECT 
    *
FROM
    Ticket;

-- Query 7 - Display all payments

SELECT 
    *
FROM
    Payment;

-- Query 8 - Display all cancellations

SELECT 
    *
FROM
    Cancellation;

-- Query 9 - Show passenger names and emails

SELECT 
    PassengerName, Email
FROM
    Passenger;

-- Query 10 - Show all active airports

SELECT 
    *
FROM
    Airport
WHERE
    Status = 'Active';

-- Query 11 - Flights with fare greater than ₹10,000

SELECT 
    FlightNumber, FlightName, Fare
FROM
    Flight
WHERE
    Fare > 10000;

-- Query 12 - Flights between ₹5,000 and ₹10,000

SELECT 
    *
FROM
    Flight
WHERE
    Fare BETWEEN 5000 AND 10000;

-- Query 13 - Passengers whose name starts with 'S'

SELECT 
    *
FROM
    Passenger
WHERE
    PassengerName LIKE 'S%';

-- Query 14 - Passengers from Chennai

SELECT 
    *
FROM
    Passenger
WHERE
    Address = 'Chennai';

-- Query 15 - Sort flights by fare

SELECT 
    FlightNumber, FlightName, Fare
FROM
    Flight
ORDER BY Fare DESC;

 -- Query 16 - Count total passengers

SELECT 
    COUNT(*) AS TotalPassengers
FROM
    Passenger;

-- Query 17 - Maximum ticket price

SELECT 
    MAX(TicketPrice) AS HighestFare
FROM
    Ticket;

 -- Query 18 - Minimum ticket price

SELECT 
    MIN(TicketPrice) AS LowestFare
FROM
    Ticket;

-- Query 19 - Average ticket price

SELECT 
    AVG(TicketPrice) AS AverageFare
FROM
    Ticket;

-- Query 20 - Total revenue collected

SELECT 
    SUM(Amount) AS TotalRevenue
FROM
    Payment
WHERE
    PaymentStatus = 'Paid';


-- Query 21 – Total bookings for each flight

SELECT 
    FlightID, COUNT(*) AS TotalBookings
FROM
    Booking
GROUP BY FlightID;

-- Query 22 – Flights having more than one booking

SELECT 
    FlightID, COUNT(*) AS TotalBookings
FROM
    Booking
GROUP BY FlightID
HAVING COUNT(*) > 1;

-- Query 23 – Total payment by payment status

SELECT 
    PaymentStatus, SUM(Amount) AS TotalAmount
FROM
    Payment
GROUP BY PaymentStatus;

-- Query 24 – Passenger and Booking Details (INNER JOIN)

SELECT
    p.PassengerID,
    p.PassengerName,
    b.BookingID,
    b.BookingDate,
    b.BookingStatus
FROM Passenger p
INNER JOIN Booking b
ON p.PassengerID = b.PassengerID;

-- Query 25 – Passenger and Ticket Details

SELECT 
    p.PassengerName, t.TicketNumber, t.SeatNumber, t.TicketPrice
FROM
    Passenger p
        INNER JOIN
    Booking b ON p.PassengerID = b.PassengerID
        INNER JOIN
    Ticket t ON b.BookingID = t.BookingID;

-- Query 26 – Flight and Aircraft Details

SELECT 
    f.FlightNumber, f.FlightName, a.AircraftName, a.Model
FROM
    Flight f
        INNER JOIN
    Aircraft a ON f.AircraftID = a.AircraftID;

-- Query 27 – Flight Source and Destination Airports

SELECT 
    f.FlightNumber,
    s.AirportName AS SourceAirport,
    d.AirportName AS DestinationAirport
FROM
    Flight f
        INNER JOIN
    Airport s ON f.SourceAirportID = s.AirportID
        INNER JOIN
    Airport d ON f.DestinationAirportID = d.AirportID;

-- Query 28 – Booking with Payment Details

SELECT 
    b.BookingID, 
    b.BookingStatus,
    p.Amount,
    p.PaymentStatus
FROM
    Booking b
        INNER JOIN
    Payment p ON b.BookingID = p.BookingID;

-- Query 29 – LEFT JOIN

-- Display all passengers even if they have no booking.

SELECT 
    p.PassengerName, b.BookingID
FROM
    Passenger p
        LEFT JOIN
    Booking b ON p.PassengerID = b.PassengerID;

-- Query 30 – RIGHT JOIN

-- Display all bookings with passenger names.

SELECT 
    p.PassengerName, b.BookingID
FROM
    Passenger p
        RIGHT JOIN
    Booking b ON p.PassengerID = b.PassengerID;

-- Query 31 – CROSS JOIN
 
 SELECT 
    PassengerName, FlightName
FROM
    Passenger
        CROSS JOIN
    Flight;

-- Query 32 – Flight fare greater than average fare (Subquery)

SELECT 
    *
FROM
    Flight
WHERE
    Fare > (SELECT 
            AVG(Fare)
        FROM
            Flight);

-- Query 33 – Highest payment

SELECT 
    *
FROM
    Payment
WHERE
    Amount = (SELECT 
            MAX(Amount)
        FROM
            Payment);

-- Query 34 – Passengers with booked tickets (EXISTS)

SELECT 
    PassengerName
FROM
    Passenger p
WHERE
    EXISTS( SELECT 
            *
        FROM
            Booking b
        WHERE
            p.PassengerID = b.PassengerID);

-- Query 35 – Flights using IN

SELECT 
    *
FROM
    Flight
WHERE
    AircraftID IN (1 , 2, 3);

-- Query 36 – Flights with fare greater than ANY fare

SELECT 
    *
FROM
    Flight
WHERE
    Fare > ANY (SELECT 
            Fare
        FROM
            Flight
        WHERE
            StatusID = 1);

-- Query 37 – Flights with fare greater than ALL delayed flights

SELECT 
    *
FROM
    Flight
WHERE
    Fare > ALL (SELECT 
            Fare
        FROM
            Flight
        WHERE
            StatusID = 2);

-- Query 38 – UNION

SELECT 
    PassengerName AS Name
FROM
    Passenger 
UNION SELECT 
    FlightName
FROM
    Flight;

-- Query 39 – UNION ALL

SELECT 
    PassengerName AS Name
FROM
    Passenger 
UNION ALL SELECT 
    FlightName
FROM
    Flight;

-- Query 40 – Distinct Booking Status

SELECT DISTINCT
    BookingStatus
FROM
    Booking;
    
   --  Query 41 – ROW_NUMBER()

-- Assign a row number to each passenger.

SELECT PassengerID,
       PassengerName,
       ROW_NUMBER() OVER(ORDER BY PassengerName) AS RowNo
FROM Passenger;

-- Query 42 – RANK()

-- Rank flights based on ticket fare.

SELECT FlightID,
       FlightName,
       Fare,
       RANK() OVER(ORDER BY Fare DESC) AS FlightRank
FROM Flight;

-- Query 43 – DENSE_RANK()

SELECT FlightID,
       FlightName,
       Fare,
       DENSE_RANK() OVER(ORDER BY Fare DESC) AS DenseRank
FROM Flight;

-- Query 44 – NTILE()

-- Divide flights into 4 groups based on fare.

SELECT FlightName,
       Fare,
       NTILE(4) OVER(ORDER BY Fare DESC) AS FareGroup
FROM Flight;

-- Query 45 – LEAD()

-- Show the next flight fare.

SELECT FlightName,
       Fare,
       LEAD(Fare) OVER(ORDER BY Fare) AS NextFare
FROM Flight;

-- Query 46 – LAG()

-- Show the previous flight fare.

SELECT FlightName,
       Fare,
       LAG(Fare) OVER(ORDER BY Fare) AS PreviousFare
FROM Flight;

-- Query 47 – PARTITION BY (Average Fare)

SELECT
    FlightID,
    FlightName,
    StatusID,
    Fare,
    AVG(Fare) OVER(PARTITION BY StatusID) AS AvgFare
FROM Flight;

-- Query 48 – PARTITION BY (ROW_NUMBER)

SELECT
    FlightID,
    FlightName,
    StatusID,
    ROW_NUMBER() OVER(PARTITION BY StatusID ORDER BY Fare DESC) AS RowNo
FROM Flight;

-- Query 49 – Running Total Revenue

SELECT
    PaymentDate,
    Amount,
    SUM(Amount) OVER(ORDER BY PaymentDate) AS RunningRevenue
FROM Payment;


-- Query 50 – CASE Statement

SELECT 
    FlightName,
    Fare,
    CASE
        WHEN Fare >= 15000 THEN 'Luxury'
        WHEN Fare >= 10000 THEN 'Premium'
        WHEN Fare >= 5000 THEN 'Standard'
        ELSE 'Budget'
    END AS FareCategory
FROM
    Flight;

-- Query 51 – Top 5 Expensive Flights

SELECT 
    *
FROM
    Flight
ORDER BY Fare DESC
LIMIT 5;

-- Query 52 – Latest Booking

SELECT *
FROM Booking
ORDER BY BookingDate DESC
LIMIT 1;

-- Query 53 – Total Revenue by Payment Method

SELECT 
    pm.MethodName, SUM(p.Amount) AS TotalRevenue
FROM
    Payment p
        INNER JOIN
    PaymentMethod pm ON p.MethodID = pm.MethodID
GROUP BY pm.MethodName;

-- Query 54 – Flight-wise Booking Count

SELECT 
    f.FlightName, COUNT(b.BookingID) AS TotalBookings
FROM
    Flight f
        LEFT JOIN
    Booking b ON f.FlightID = b.FlightID
GROUP BY f.FlightName;

-- Query 55 – Passenger Travel History

SELECT 
    p.PassengerName, f.FlightName, b.BookingDate, t.TicketNumber
FROM
    Passenger p
        INNER JOIN
    Booking b ON p.PassengerID = b.PassengerID
        INNER JOIN
    Flight f ON b.FlightID = f.FlightID
        INNER JOIN
    Ticket t ON b.BookingID = t.BookingID;

-- Query 56 – Cancelled Bookings

SELECT
    BookingID,
    BookingStatus
FROM Booking
WHERE BookingStatus='Cancelled';

-- Query 57 – Refund Details

SELECT 
    c.BookingID, c.RefundAmount, c.Reason
FROM
    Cancellation c
WHERE
    RefundAmount > 0;

-- Query 58 – Aircraft Capacity Report

SELECT 
    AircraftName, Model, Capacity
FROM
    Aircraft
ORDER BY Capacity DESC;

-- Query 59 – Flight Status Report

SELECT 
    f.FlightName, fs.StatusName
FROM
    Flight f
        INNER JOIN
    FlightStatus fs ON f.StatusID = fs.StatusID;

-- Query 60 – Complete Airline Reservation Report

SELECT 
    p.PassengerName,
    f.FlightName,
    t.TicketNumber,
    t.SeatNumber,
    pay.Amount,
    pay.PaymentStatus
FROM
    Passenger p
        INNER JOIN
    Booking b ON p.PassengerID = b.PassengerID
        INNER JOIN
    Flight f ON b.FlightID = f.FlightID
        INNER JOIN
    Ticket t ON b.BookingID = t.BookingID
        INNER JOIN
    Payment pay ON b.BookingID = pay.BookingID;


-- Procedure 1 – Display All Passengers

DELIMITER $$

CREATE PROCEDURE sp_GetAllPassengers()
BEGIN
    SELECT *
    FROM Passenger;
END $$

DELIMITER ;

CALL sp_GetAllPassengers();

-- Procedure 2 – Search Passenger by ID (IN Parameter)

DELIMITER $$

CREATE PROCEDURE sp_GetPassengerByID
(
    IN p_PassengerID INT
)
BEGIN
    SELECT *
    FROM Passenger
    WHERE PassengerID = p_PassengerID;
END $$

DELIMITER ;

CALL sp_GetPassengerByID(5);

-- Procedure 3 – Display Flights by Status

DELIMITER $$

CREATE PROCEDURE sp_GetFlightsByStatus
(
    IN p_StatusID INT
)
BEGIN
    SELECT *
    FROM Flight
    WHERE StatusID = p_StatusID;
END $$

DELIMITER ;

CALL sp_GetFlightsByStatus(1);

-- Procedure 4 – Total Revenue (OUT Parameter)

DELIMITER $$

CREATE PROCEDURE sp_TotalRevenue
(
    OUT TotalRevenue DECIMAL(10,2)
)
BEGIN
    SELECT SUM(Amount)
    INTO TotalRevenue
    FROM Payment
    WHERE PaymentStatus='Paid';
END $$

DELIMITER ;

CALL sp_TotalRevenue(@Revenue);

SELECT @Revenue;

-- Procedure 5 – Booking Details Using JOIN

DELIMITER $$

CREATE PROCEDURE sp_BookingDetails()
BEGIN

SELECT

p.PassengerName,

f.FlightName,

t.TicketNumber,

pay.Amount

FROM Passenger p

JOIN Booking b
ON p.PassengerID=b.PassengerID

JOIN Flight f
ON b.FlightID=f.FlightID

JOIN Ticket t
ON b.BookingID=t.BookingID

JOIN Payment pay
ON b.BookingID=pay.BookingID;

END $$

DELIMITER ;

CALL sp_BookingDetails();

-- Procedure 6 – Flights Between Fare Range

DELIMITER $$

CREATE PROCEDURE sp_FlightFareRange
(
IN MinFare DECIMAL(10,2),

IN MaxFare DECIMAL(10,2)
)

BEGIN

SELECT *

FROM Flight

WHERE Fare BETWEEN MinFare AND MaxFare;

END $$

DELIMITER ;

CALL sp_FlightFareRange(5000,10000);

-- Procedure 7 – Count Total Flights

DELIMITER $$

CREATE PROCEDURE sp_TotalFlights()
BEGIN

SELECT COUNT(*) AS TotalFlights

FROM Flight;

END $$

DELIMITER ;

CALL sp_TotalFlights();

-- Procedure 8 – IF Condition

DELIMITER $$

CREATE PROCEDURE sp_CheckFare
(
IN FlightFare DECIMAL(10,2)
)

BEGIN

IF FlightFare >=15000 THEN

SELECT 'Luxury Flight' AS Category;

ELSEIF FlightFare>=10000 THEN

SELECT 'Premium Flight' AS Category;

ELSE

SELECT 'Budget Flight' AS Category;

END IF;

END $$

DELIMITER ;

CALL sp_CheckFare(17000);

-- Procedure 9 – Average Ticket Price

DELIMITER $$

CREATE PROCEDURE sp_AverageTicketPrice()
BEGIN

SELECT AVG(TicketPrice) AS AveragePrice

FROM Ticket;

END $$

DELIMITER ;

CALL sp_AverageTicketPrice();

-- Procedure 10 – Passenger Booking Count

DELIMITER $$

CREATE PROCEDURE sp_PassengerBookingCount()
BEGIN

SELECT

PassengerID,

COUNT(*) AS TotalBookings

FROM Booking

GROUP BY PassengerID;

END $$

DELIMITER ;

CALL sp_PassengerBookingCount();

-- Function 1 – Get Passenger Name by Passenger ID

DELIMITER $$

CREATE FUNCTION fn_GetPassengerName
(
    p_PassengerID INT
)
RETURNS VARCHAR(100)
DETERMINISTIC

BEGIN

DECLARE v_Name VARCHAR(100);

SELECT PassengerName
INTO v_Name
FROM Passenger
WHERE PassengerID = p_PassengerID;

RETURN v_Name;

END $$

DELIMITER ;

SELECT fn_GetPassengerName(1);

-- Function 2 – Calculate GST (18%)

DELIMITER $$

CREATE FUNCTION fn_CalculateGST
(
    Amount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN

RETURN Amount * 0.18;

END $$

DELIMITER ;

SELECT fn_CalculateGST(5000);

-- Function 3 – Total Amount with GST

DELIMITER $$

CREATE FUNCTION fn_TotalWithGST
(
    Amount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN

RETURN Amount + (Amount * 0.18);

END $$

DELIMITER ;

SELECT fn_TotalWithGST(5000);

-- Function 4 – Passenger Category by Age

DELIMITER $$

CREATE FUNCTION fn_PassengerCategory
(
    p_Age INT
)
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN

DECLARE Category VARCHAR(30);

IF p_Age < 18 THEN
    SET Category='Child';

ELSEIF p_Age BETWEEN 18 AND 59 THEN
    SET Category='Adult';

ELSE
    SET Category='Senior Citizen';

END IF;

RETURN Category;

END $$

DELIMITER ;

SELECT fn_PassengerCategory(65);

-- Function 5 – Flight Fare Category

DELIMITER $$

CREATE FUNCTION fn_FareCategory
(
    p_Fare DECIMAL(10,2)
)
RETURNS VARCHAR(30)
DETERMINISTIC

BEGIN

DECLARE Category VARCHAR(30);

IF p_Fare >=15000 THEN
    SET Category='Luxury';

ELSEIF p_Fare>=10000 THEN
    SET Category='Premium';

ELSEIF p_Fare>=5000 THEN
    SET Category='Standard';

ELSE
    SET Category='Budget';

END IF;

RETURN Category;

END $$

DELIMITER ;

SELECT fn_FareCategory(16500);

-- Function 6 – Booking Status Description

DELIMITER $$

CREATE FUNCTION fn_BookingStatus
(
    p_Status VARCHAR(30)
)
RETURNS VARCHAR(100)
DETERMINISTIC

BEGIN

RETURN
CASE
WHEN p_Status='Booked' THEN 'Booking Confirmed'
WHEN p_Status='Cancelled' THEN 'Booking Cancelled'
WHEN p_Status='Completed' THEN 'Journey Completed'
ELSE 'Unknown Status'
END;

END $$

DELIMITER ;

SELECT fn_BookingStatus('Booked');

-- Function 7 – Refund Amount After Deduction

DELIMITER $$

CREATE FUNCTION fn_RefundAmount
(
    Amount DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC

BEGIN

RETURN Amount * 0.90;

END $$

DELIMITER ;

SELECT fn_RefundAmount(10000);

-- Function 8 – Flight Duration (Hours)

DELIMITER $$

CREATE FUNCTION fn_FlightDuration
(
    Departure TIME,
    Arrival TIME
)
RETURNS TIME
DETERMINISTIC

BEGIN

RETURN TIMEDIFF(Arrival, Departure);

END $$

DELIMITER ;

SELECT fn_FlightDuration('08:00:00','10:30:00');


-- Function 9 – Count Passenger Bookings

DELIMITER $$

CREATE FUNCTION fn_TotalBookings
(
    p_PassengerID INT
)
RETURNS INT
READS SQL DATA

BEGIN

DECLARE TotalBooking INT;

SELECT COUNT(*)
INTO TotalBooking
FROM Booking
WHERE PassengerID=p_PassengerID;

RETURN TotalBooking;

END $$

DELIMITER ;

SELECT fn_TotalBookings(1);


-- Function 10 – Total Revenue

DELIMITER $$

CREATE FUNCTION fn_TotalRevenue()
RETURNS DECIMAL(12,2)
READS SQL DATA

BEGIN

DECLARE Revenue DECIMAL(12,2);

SELECT SUM(Amount)
INTO Revenue
FROM Payment
WHERE PaymentStatus='Paid';

RETURN Revenue;

END $$

DELIMITER ;

SELECT fn_TotalRevenue();

-- Trigger 1 – Create Audit Table

CREATE TABLE Passenger_Audit
(
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    PassengerID INT,
    PassengerName VARCHAR(100),
    ActionType VARCHAR(30),
    ActionDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Trigger 2 – AFTER INSERT Trigger

-- Whenever a new passenger is added, save it in the audit table.

DELIMITER $$

CREATE TRIGGER trg_Passenger_AfterInsert
AFTER INSERT
ON Passenger
FOR EACH ROW

BEGIN

INSERT INTO Passenger_Audit
(PassengerID, PassengerName, ActionType)

VALUES
(
NEW.PassengerID,
NEW.PassengerName,
'INSERT'
);

END $$

DELIMITER ;

-- Test

INSERT INTO Passenger
(PassengerName,Gender,Age,Phone,Email,PassportNo,Address)
VALUES
('Aravind','Male',27,'9876543299',
'aravind@gmail.com','P10016','Chennai');

-- Trigger 3 – BEFORE INSERT

-- Passenger age must be at least 1.

DELIMITER $$

CREATE TRIGGER trg_Passenger_BeforeInsert

BEFORE INSERT
ON Passenger
FOR EACH ROW

BEGIN

IF NEW.Age<=0 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Invalid Age';

END IF;

END $$

DELIMITER ;

-- Trigger 4 – BEFORE UPDATE

-- Do not allow negative fare.

DELIMITER $$

CREATE TRIGGER trg_Flight_BeforeUpdate

BEFORE UPDATE
ON Flight
FOR EACH ROW

BEGIN

IF NEW.Fare<0 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Fare cannot be negative';

END IF;

END $$

DELIMITER ;

-- Trigger 5 – AFTER UPDATE

-- Create Flight Audit Table

CREATE TABLE Flight_Audit
(
AuditID INT AUTO_INCREMENT PRIMARY KEY,
FlightID INT,
OldFare DECIMAL(10,2),
NewFare DECIMAL(10,2),
UpdatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Trigger

DELIMITER $$

CREATE TRIGGER trg_Flight_AfterUpdate

AFTER UPDATE
ON Flight
FOR EACH ROW

BEGIN

INSERT INTO Flight_Audit
(
FlightID,
OldFare,
NewFare
)

VALUES
(
OLD.FlightID,
OLD.Fare,
NEW.Fare
);

END $$

DELIMITER ;

-- Trigger 6 – BEFORE DELETE

-- Do not delete completed bookings.

DELIMITER $$

CREATE TRIGGER trg_Booking_BeforeDelete

BEFORE DELETE
ON Booking
FOR EACH ROW

BEGIN

IF OLD.BookingStatus='Completed' THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Completed Booking Cannot Delete';

END IF;

END $$

DELIMITER ;

-- Trigger 7 – AFTER DELETE

-- Create Booking Log Table

CREATE TABLE Booking_Delete_Log
(
LogID INT AUTO_INCREMENT PRIMARY KEY,
BookingID INT,
DeletedDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

Trigger

DELIMITER $$

CREATE TRIGGER trg_Booking_AfterDelete

AFTER DELETE
ON Booking
FOR EACH ROW

BEGIN

INSERT INTO Booking_Delete_Log
(
BookingID
)

VALUES
(
OLD.BookingID
);

END $$

DELIMITER ;

-- Trigger 8 – BEFORE INSERT (Payment)

-- Amount should be greater than zero.

DELIMITER $$

CREATE TRIGGER trg_Payment_BeforeInsert

BEFORE INSERT
ON Payment
FOR EACH ROW

BEGIN

IF NEW.Amount<=0 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Payment Amount Invalid';

END IF;

END $$

DELIMITER ;

-- Trigger 9 – AFTER INSERT (Payment)

-- Automatically update booking status.

DELIMITER $$

CREATE TRIGGER trg_Payment_AfterInsert

AFTER INSERT
ON Payment
FOR EACH ROW

BEGIN

UPDATE Booking

SET BookingStatus='Booked'

WHERE BookingID=NEW.BookingID;

END $$

DELIMITER ;

-- Trigger 10 – BEFORE UPDATE (Ticket)

-- Ticket price cannot be less than ₹1000.

DELIMITER $$

CREATE TRIGGER trg_Ticket_BeforeUpdate

BEFORE UPDATE
ON Ticket
FOR EACH ROW

BEGIN

IF NEW.TicketPrice<1000 THEN

SIGNAL SQLSTATE '45000'

SET MESSAGE_TEXT='Ticket Price Too Low';

END IF;

END $$

DELIMITER ;

-- View 1 – Passenger Details

CREATE VIEW vw_PassengerDetails AS

SELECT
PassengerID,
PassengerName,
Gender,
Age,
Phone,
Email,
Address
FROM Passenger;

-- Execute

SELECT * FROM vw_PassengerDetails;

-- View 2 – Flight Details

CREATE VIEW vw_FlightDetails AS

SELECT
FlightNumber,
FlightName,
DepartureDate,
DepartureTime,
ArrivalTime,
Fare
FROM Flight;

-- Execute

SELECT * FROM vw_FlightDetails;

-- View 3 – Passenger Booking Details

CREATE VIEW vw_PassengerBooking AS

SELECT

p.PassengerID,
p.PassengerName,
b.BookingID,
b.BookingDate,
b.BookingStatus

FROM Passenger p

JOIN Booking b

ON p.PassengerID=b.PassengerID;

-- Execute

SELECT * FROM vw_PassengerBooking;


 -- View 4 – Ticket Details

CREATE VIEW vw_TicketDetails AS

SELECT

t.TicketNumber,
t.SeatNumber,
t.TicketPrice,
s.ClassName

FROM Ticket t

JOIN SeatClass s

ON t.ClassID=s.ClassID;

-- Execute

SELECT * FROM vw_TicketDetails;


-- View 5 – Payment Details

CREATE VIEW vw_PaymentDetails AS

SELECT

p.PaymentID,
pm.MethodName,
p.Amount,
p.PaymentStatus,
p.PaymentDate

FROM Payment p

JOIN PaymentMethod pm

ON p.MethodID=pm.MethodID;

-- Execute

SELECT * FROM vw_PaymentDetails;

-- View 6 – Flight Status

CREATE VIEW vw_FlightStatus AS

SELECT

f.FlightNumber,
f.FlightName,
fs.StatusName

FROM Flight f

JOIN FlightStatus fs

ON f.StatusID=fs.StatusID;

-- Execute

SELECT * FROM vw_FlightStatus;

-- View 7 – Flight Route

CREATE VIEW vw_FlightRoute AS

SELECT

f.FlightNumber,

s.AirportName AS Source,

d.AirportName AS Destination

FROM Flight f

JOIN Airport s

ON f.SourceAirportID=s.AirportID

JOIN Airport d

ON f.DestinationAirportID=d.AirportID;

-- Execute

SELECT * FROM vw_FlightRoute;

-- View 8 – Booking Payment Report

CREATE VIEW vw_BookingPayment AS

SELECT

b.BookingID,
p.Amount,
p.PaymentStatus

FROM Booking b

JOIN Payment p

ON b.BookingID=p.BookingID;

-- Execute

SELECT * FROM vw_BookingPayment;
 
-- View 9 – Passenger Travel Report

CREATE VIEW vw_PassengerTravel AS

SELECT

pa.PassengerName,

f.FlightName,

t.SeatNumber,

t.TicketNumber

FROM Passenger pa

JOIN Booking b

ON pa.PassengerID=b.PassengerID

JOIN Flight f

ON b.FlightID=f.FlightID

JOIN Ticket t

ON b.BookingID=t.BookingID;

-- Execute

SELECT * FROM vw_PassengerTravel;

-- View 10 – Complete Airline Report
 
 CREATE VIEW vw_AirlineReport AS

SELECT

pa.PassengerName,

f.FlightName,

t.TicketNumber,

t.SeatNumber,

pay.Amount,

pay.PaymentStatus

FROM Passenger pa

JOIN Booking b

ON pa.PassengerID=b.PassengerID

JOIN Flight f

ON b.FlightID=f.FlightID

JOIN Ticket t

ON b.BookingID=t.BookingID

JOIN Payment pay

ON b.BookingID=pay.BookingID;

-- Execute

SELECT * FROM vw_AirlineReport;

-- 1. Create Index on Passenger Name

CREATE INDEX idx_passenger_name
ON Passenger(PassengerName);

-- Verify

SHOW INDEX FROM Passenger;

-- 2. Create Unique Index on Passenger Email

CREATE UNIQUE INDEX idx_passenger_email
ON Passenger(Email);

-- Verify

SHOW INDEX FROM Passenger;

-- 3. Create Index on Flight Number

CREATE INDEX idx_flight_number
ON Flight(FlightNumber);

-- 4. Create Index on Flight Fare

CREATE INDEX idx_flight_fare
ON Flight(Fare);

-- 5. Composite Index on Flight

CREATE INDEX idx_source_destination
ON Flight(SourceAirportID,DestinationAirportID);

-- 6. Create Index on Booking Date

CREATE INDEX idx_booking_date
ON Booking(BookingDate);

-- 7. Create Index on Booking Status

CREATE INDEX idx_booking_status
ON Booking(BookingStatus);

-- 8. Create Index on Ticket Number

CREATE UNIQUE INDEX idx_ticket_number
ON Ticket(TicketNumber);

-- 9. Create Index on Payment Date

CREATE INDEX idx_payment_date
ON Payment(PaymentDate);

-- 10. Create Index on Payment Status

CREATE INDEX idx_payment_status
ON Payment(PaymentStatus);

-- Show All Indexes
-- Passenger

SHOW INDEX FROM Passenger;

-- Flight

SHOW INDEX FROM Flight;

-- Booking

SHOW INDEX FROM Booking;

-- Ticket

SHOW INDEX FROM Ticket;

-- Payment

SHOW INDEX FROM Payment;

-- Drop an Index

DROP INDEX idx_booking_status
ON Booking;

-- Check Query Performance

-- EXPLAIN

SELECT *
FROM Passenger
WHERE PassengerName='Surya';

-- 1. COMMIT

-- Book a Flight and Commit the Transaction

START TRANSACTION;

INSERT INTO Booking
(PassengerID, FlightID, BookingDate, BookingStatus)
VALUES
(1,5,CURDATE(),'Booked');

INSERT INTO Payment
(BookingID, MethodID, Amount, PaymentDate, PaymentStatus)
VALUES
(LAST_INSERT_ID(),1,5100,CURDATE(),'Paid');

COMMIT;

-- 2. ROLLBACK

-- Cancel the Transaction


START TRANSACTION;

UPDATE Flight
SET Fare=9000
WHERE FlightID=3;

ROLLBACK;

-- Result: The fare returns to its original value.

-- 3. SAVEPOINT

START TRANSACTION;

UPDATE Flight
SET Fare=12000
WHERE FlightID=5;

SAVEPOINT Fare_Update;

UPDATE Flight
SET Fare=15000
WHERE FlightID=5;

ROLLBACK TO Fare_Update;

COMMIT;

-- Result: Flight 5 fare becomes 12000, not 15000.

-- 4. Multiple INSERT with COMMIT

START TRANSACTION;

INSERT INTO Passenger
(PassengerName,Gender,Age,Phone,Email,PassportNo,Address)
VALUES
('Kumar','Male',30,'9876500001',
'kumar@gmail.com','P10020','Chennai');

INSERT INTO Booking
(PassengerID,FlightID,BookingDate,BookingStatus)
VALUES
(16,2,CURDATE(),'Booked');

COMMIT;

-- 5. DELETE with ROLLBACK

START TRANSACTION;

DELETE FROM Booking
WHERE BookingID=5;

ROLLBACK;

-- 6. UPDATE with SAVEPOINT

START TRANSACTION;

UPDATE Payment
SET Amount=10000
WHERE PaymentID=2;

SAVEPOINT Payment_Update;

UPDATE Payment
SET Amount=12000
WHERE PaymentID=2;

ROLLBACK TO Payment_Update;

COMMIT;

-- 7. Booking Cancellation Transaction

START TRANSACTION;

UPDATE Booking
SET BookingStatus='Cancelled'
WHERE BookingID=8;

INSERT INTO Cancellation
(
BookingID,
CancellationDate,
RefundAmount,
Reason
)
VALUES
(
17,
CURDATE(),
12000,
'Passenger Request'
);

COMMIT;

-- 8. Payment Failure

START TRANSACTION;

INSERT INTO Payment
(
BookingID,
MethodID,
Amount,
PaymentDate,
PaymentStatus
)

VALUES
(
5,
2,
5100,
CURDATE(),
'Pending'
);

ROLLBACK;

-- 9. Update Passenger Email

START TRANSACTION;

UPDATE Passenger
SET Email='surya_new@gmail.com'
WHERE PassengerID=1;

COMMIT;



-- Verify Transactions

SELECT * FROM Booking;

SELECT * FROM Payment;

SELECT * FROM Cancellation;

SELECT * FROM Passenger;

SELECT 
    *
FROM
    Flight;

-- 1. Create a New User

CREATE USER 'airlineuser'@'localhost'
IDENTIFIED BY 'Airline@123';

-- 2. View All Users

SELECT User, Host
FROM mysql.user;

-- 3. Grant SELECT Permission

GRANT SELECT
ON AirlineReservationDB.*
TO 'airlineuser'@'localhost';

-- 4. Grant SELECT, INSERT

GRANT SELECT, INSERT
ON AirlineReservationDB.*
TO 'airlineuser'@'localhost';

-- 5. Grant SELECT, INSERT, UPDATE

GRANT SELECT,
      INSERT,
      UPDATE
ON AirlineReservationDB.*
TO 'airlineuser'@'localhost';

-- 6. Grant ALL Privileges

GRANT ALL PRIVILEGES
ON AirlineReservationDB.*
TO 'airlineuser'@'localhost';

-- 7. Apply the Privileges

FLUSH PRIVILEGES;

-- 8. Show User Privileges

SHOW GRANTS
FOR 'airlineuser'@'localhost';

-- 9. Revoke INSERT Permission

REVOKE INSERT
ON AirlineReservationDB.*
FROM 'airlineuser'@'localhost';
 
 -- 10. Revoke UPDATE Permission

REVOKE UPDATE
ON AirlineReservationDB.*
FROM 'airlineuser'@'localhost';


-- 11. Drop User

DROP USER 'airlineuser'@'localhost';

-- Verify

SHOW GRANTS
FOR 'airlineuser'@'localhost';

-- Event 1 – Daily Flight Status Report

SET GLOBAL event_scheduler = ON;

CREATE EVENT ev_DailyFlightReport
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
INSERT INTO Flight_Audit
(
    FlightID,
    OldFare,
    NewFare
)
SELECT
    FlightID,
    Fare,
    Fare
FROM Flight;

-- Event 2 – Delete Old Cancellation Records (After 1 Year)

CREATE EVENT ev_DeleteOldCancellation
ON SCHEDULE EVERY 1 MONTH
DO
DELETE FROM Cancellation
WHERE CancellationDate < DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Event 3 – Mark Past Flights as Arrived

CREATE EVENT ev_UpdateFlightStatus
ON SCHEDULE EVERY 1 DAY
DO
UPDATE Flight
SET StatusID = 6
WHERE DepartureDate < CURDATE()
AND StatusID = 5;

-- View Events

SHOW EVENTS;

-- Drop an Event

DROP EVENT ev_DeleteOldCancellation;

/* Business Scenarios

1.Passenger books a ticket.
2.Flight is cancelled and refund is processed.
3.Seat allocation after booking.
4.Payment success/failure.
5.Passenger cancels booking.
6.Daily revenue report.
7.Most popular flight.
8.Available seats report.
9.Frequent passenger report.
10.Aircraft maintenance report.
11.Airport-wise booking report.
13.Monthly revenue report.
14.Passenger travel history.
15.Booking confirmation process.
16.Refund calculation process.
17.Flight occupancy report.
18.VIP passenger report.
19.Online payment tracking.
20.Complete management dashboard.

*/
