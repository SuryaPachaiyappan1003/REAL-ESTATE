SMART REAL ESTATE PROPERTY RENTAL & SALES MANAGEMENT SYSTEM
PROJECT DOCUMENTATION
ABSTRACT
The Smart Real Estate Property Rental & Sales Management System is a MySQL-based database application designed to manage property owners, customers, agents, property listings, bookings, rentals, sales, payments, maintenance requests, and customer reviews.
The project demonstrates relational database concepts such as normalization, primary keys, foreign keys, joins, views, stored procedures, functions, triggers, transactions, indexes, and advanced SQL features. The system improves efficiency, reduces manual work, and provides accurate reports for property management.
________________________________________
TABLE OF CONTENTS

1.	Introduction
2.	Existing System
3.	Proposed System
4.	Objectives
5.	Scope
6.	Software Requirements
7.	Hardware Requirements
8.	System Modules
9.	Database Design
10.	ER Diagram
11.	Data Dictionary
12.	SQL Implementation
13.	Testing
14.	Outputs
15.	Advantages
16.	Limitations
17.	Future Enhancements
18.	Conclusion
19.	Bibliography
________________________________________
CHAPTER 1 – INTRODUCTION
The real estate industry involves buying, selling, and renting residential and commercial properties. Managing these activities manually is time-consuming and prone to errors. This project provides a centralized database system to efficiently manage all real estate operations using MySQL.
________________________________________
CHAPTER 2 – EXISTING SYSTEM
•	Manual record maintenance
•	Paper-based documentation
•	Difficult property search
•	Time-consuming reporting
•	Duplicate records
•	Higher risk of data loss
________________________________________
CHAPTER 3 – PROPOSED SYSTEM
The proposed system automates the complete property management process by maintaining digital records of owners, customers, agents, properties, bookings, rentals, sales, payments, and maintenance requests.
PROJECT WORKFLOW
Admin creates users.
↓
Owners register properties.
↓
Agents manage property listings.
↓
Customers search available properties.
↓
Customers book a property.
↓
Payment is completed.
↓
Property is sold or rented.
↓
Agent commission is generated.
↓
Reports are generated.
________________________________________
CHAPTER 4 – OBJECTIVES
•	Maintain owner details
•	Manage customer information
•	Store property details
•	Record bookings and sales
•	Generate payment reports
•	Maintain rental agreements
•	Manage maintenance requests
•	Improve data accuracy
________________________________________
CHAPTER 5 – SCOPE
•	Property Listing
•	Property Rental
•	Property Sales
•	Agent Management
•	Customer Management
•	Payment Management
•	Reports
•	Reviews
________________________________________
CHAPTER 6 – SOFTWARE REQUIREMENTS
Operating System : Windows 10/11
Database : MySQL 8.0
IDE : MySQL Workbench
Documentation : Microsoft Word
________________________________________
CHAPTER 7 – HARDWARE REQUIREMENTS
Processor : Intel Core i3 or above
RAM : 4 GB
Hard Disk : 20 GB
Keyboard
Mouse


CHAPTER 8 – MODULES
1.	User Management
2.	Owner Management
3.	Agent Management
4.	Customer Management
5.	Property Management
6.	Booking Management
7.	Rental Management
8.	Sales Management
9.	Payment Management
10.	Maintenance Management
11.	Review Management
12.	Report Management
________________________________________
CHAPTER 9 – DATABASE DESIGN
Master Tables
•	RE_Region
•	RE_State
•	RE_City
•	RE_Area
•	RE_PropertyType
•	RE_PropertyStatus
•	RE_Amenity
•	RE_PaymentMethod

Transaction Tables
•	RE_User
•	RE_Owner
•	RE_Agent
•	RE_Customer
•	RE_Property
•	RE_PropertyImage
•	RE_PropertyAmenity
•	RE_Booking
•	RE_Rental
•	RE_Sale
•	RE_Payment
•	RE_Commission
•	RE_Maintenance
•	RE_Review
________________________________________
CHAPTER 10 – ER DIAGRAM

 

CHAPTER 11 – DATA DICTIONARY
Include:
•	Table Name
•	Column Name
•	Data Type
•	Size
•	Constraint
•	Description
Create a data dictionary for each table.
________________________________________
CHAPTER 12 – SQL IMPLEMENTATION
Include:
•	Database Creation
•	Table Creation
•	Insert Statements
•	Select Queries
•	Joins
•	Aggregate Functions
•	Views
•	Stored Procedures
•	Functions
•	Triggers
•	Transactions
•	Event Scheduler
•	Cursor
•	Window Functions
•	CTE
•	JSON Functions
________________________________________
CHAPTER 13 – TESTING
Test Case | Expected Result | Actual Result | Status
Example:
•	Login → Success → Pass
•	Property Booking → Success → Pass
•	Payment Entry → Success → Pass


CHAPTER 14 – OUTPUTS
Insert screenshots of:
•	Database
•	Tables
•	Insert Output
•	Select Output
•	Procedures
•	Functions
•	Triggers
•	Views
•	Reports
________________________________________

CHAPTER 15 – ADVANTAGES
•	Easy property management
•	Secure database
•	Fast searching
•	Accurate reports
•	Reduced paperwork
•	Improved efficiency
________________________________________
CHAPTER 16 – LIMITATIONS

•	Works on a local database
•	No online payment gateway
•	No GIS integration
•	No mobile application
________________________________________

CHAPTER 17 – FUTURE ENHANCEMENTS
•	Mobile App
•	Online Payments
•	Google Maps Integration
•	Email Notifications
•	SMS Alerts
•	AI Property Recommendations
•	Power BI Dashboard
________________________________________
CHAPTER 18 – CONCLUSION

The Smart Real Estate Property Rental & Sales Management System successfully
manages property listings, customers, owners, agents, rentals, sales, and payments using MySQL.
The project demonstrates both basic and advanced SQL concepts and provides an efficient solution for real estate data management.

CHAPTER 19 – BIBLIOGRAPHY
1.	MySQL 8.0 Reference Manual
2.	MySQL Workbench Documentation
3.	SQL Language Reference
4.	Database System Concepts – Silberschatz, Korth & Sudarshan
5.	College Notes and Study Materials


SMART REAL ESTATE PROPERTY RENTAL & SALES MANAGEMENT SYSTEM      PROJECT DOCUMENTATION

                                                                      Scenario

Scenario 1: Register a New Property Owner
Logic
1.	Admin receives owner details. 
2.	Check whether the owner already exists. 
3.	If not, insert the record into RE_Owner. 
4.	Generate a unique Owner ID. 
5.	Display a success message. 
Tables Used: RE_Owner
________________________________________
Scenario 2: Add a New Property
Logic
1.	Owner submits property details. 
2.	Verify that the Property Type, Area, and Owner exist. 
3.	Insert the property into RE_Property. 
4.	Set Property Status = Available. 
5.	Property is listed for customers. 
Tables Used: RE_Property, RE_PropertyType, RE_Area, RE_PropertyStatus, RE_Owner
________________________________________
Scenario 3: Upload Property Images
Logic
1.	Select an existing property. 
2.	Upload one or more images. 
3.	Save image details in RE_PropertyImage. 
4.	Display the images on the property page. 
Tables Used: RE_Property, RE_PropertyImage
________________________________________
Scenario 4: Assign Amenities to a Property
Logic
1.	Select a property. 
2.	Choose amenities (Parking, Gym, Lift, etc.). 
3.	Insert records into RE_PropertyAmenity. 
4.	Display amenities when customers view the property. 
Tables Used: RE_Property, RE_Amenity, RE_PropertyAmenity
________________________________________
Scenario 5: Customer Searches for Properties
Logic
1.	Customer enters city, area, budget, and property type. 
2.	System filters only available properties. 
3.	Display matching results. 
Tables Used: RE_Property, RE_City, RE_Area, RE_PropertyType, RE_PropertyStatus
________________________________________
Scenario 6: Customer Books a Property
Logic
1.	Customer selects an available property. 
2.	Check that the property is not already booked. 
3.	Create a booking in RE_Booking. 
4.	Update property status to Booked. 
Tables Used: RE_Customer, RE_Property, RE_Booking
Trigger Idea: Automatically change property status to Booked after booking.
________________________________________
Scenario 7: Approve Rental Agreement
Logic
1.	Admin reviews the booking. 
2.	If approved, create a rental record. 
3.	Update property status to Rented. 
4.	Store rental start date and monthly rent. 
Tables Used: RE_Booking, RE_Rental, RE_Property
________________________________________
Scenario 8: Complete Property Sale
Logic
1.	Customer purchases the property. 
2.	Verify payment. 
3.	Insert sale details into RE_Sale. 
4.	Update property status to Sold. 
Tables Used: RE_Sale, RE_Property, RE_Customer
Trigger Idea: Prevent selling an already sold property.
________________________________________
Scenario 9: Process Customer Payment
Logic
1.	Customer chooses a payment method. 
2.	Verify the booking or sale. 
3.	Store payment details. 
4.	Mark payment as successful. 
Tables Used: RE_Payment, RE_PaymentMethod
________________________________________
Scenario 10: Calculate Agent Commission
Logic
1.	Retrieve the completed sale or rental. 
2.	Calculate commission using a percentage. 
3.	Save the commission record. 
Tables Used: RE_Commission, RE_Agent, RE_Sale
Function Idea:
Commission = Sale Amount × Commission Rate / 100
________________________________________
Scenario 11: Register a Maintenance Request
Logic
1.	Customer reports a maintenance issue. 
2.	Create a maintenance request. 
3.	Assign a status (Pending/In Progress/Completed). 
4.	Update when work is completed. 
Tables Used: RE_Maintenance
________________________________________
Scenario 12: Customer Reviews a Property
Logic
1.	Customer submits a rating and comments. 
2.	Verify that the customer completed a booking, rental, or sale. 
3.	Store the review. 
Tables Used: RE_Review, RE_Customer, RE_Property
________________________________________
Scenario 13: Prevent Duplicate Bookings
Logic
1.	Before inserting into RE_Booking, check the property's status. 
2.	If the property is already Booked, Rented, or Sold, reject the booking. 
3.	Otherwise, allow the booking. 
Trigger Used: BEFORE INSERT
________________________________________
Scenario 14: Automatic Status Update
Logic
1.	When a sale is completed, automatically change the property status to Sold. 
2.	When a rental is approved, automatically change the property status to Rented. 
3.	When a booking is cancelled, automatically change the property status back to Available. 
Trigger Used: AFTER INSERT / AFTER UPDATE
________________________________________
Scenario 15: Generate Monthly Business Report
Logic
1.	Calculate: 
o	Total Properties 
o	Total Bookings 
o	Total Rentals 
o	Total Sales 
o	Total Revenue 
o	Total Agent Commission 
2.	Display the report for the selected month. 
Tables Used: RE_Property, RE_Booking, RE_Rental, RE_Sale, RE_Payment, RE_Commission

