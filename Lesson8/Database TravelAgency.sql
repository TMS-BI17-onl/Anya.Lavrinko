
CREATE DATABASE TravelAgency
USE TravelAgency;
	
DROP TABLE IF EXISTS DimClients CREATE TABLE
	DimClients(
	    ClientId    INT Identity (1,1),
		FirstName   NVARCHAR(50) NOT NULL,
		LastName    NVARCHAR(50) NOT NULL,
		TypeClient  NVARCHAR(15),
		Passport    UNIQUEIDENTIFIER NOT NULL,--didn't create as a separate constraint, is it correct?
		PhoneNumber NVARCHAR(20),
		Address     NVARCHAR(150),
		BirthDate   DATE,
		CONSTRAINT PK_ClientId_DimClients PRIMARY KEY (ClientId),
	    CONSTRAINT UQ_Passport_DimClients UNIQUE (Passport)
		--I see these 2 as Keys (Pk,UQ) in the structure , but there is nothong in Constraints, is it OK? 
       );
DROP TABLE IF EXISTS DimManagers CREATE TABLE
	DimManagers(
	    ManagerId   INT Identity (1,1),
		FirstName   NVARCHAR(50) NOT NULL,
		LastName    NVARCHAR(50) NOT NULL,
		Position    NVARCHAR(50),
		Passport    UNIQUEIDENTIFIER NOT NULL,
		PhoneNumber NVARCHAR(20),
		Email       NVARCHAR(25),
		Territory   NVARCHAR(50),
		CONSTRAINT PK_ManagerId_DimManagers PRIMARY KEY (ManagerId),
	    CONSTRAINT UQ_Passport_DimManagers UNIQUE (Passport)
       );
DROP TABLE IF EXISTS DimHotels CREATE TABLE 
	DimHotels(
	    HotelID      INT Identity (1,1),
		HotelName    NVARCHAR(50) NOT NULL,
		HotelType    NVARCHAR(15),
		Country      NVARCHAR(25) NOT NULL,
		City         NVARCHAR(25) NOT NULL,
		Address      NVARCHAR(150),
		LocationType NVARCHAR(15),
		RoomType     NVARCHAR(15),
		FoodType     NVARCHAR(15),
		Price        MONEY,
		CONSTRAINT PK_HotelID_DimHotels PRIMARY KEY (HotelID),
        CONSTRAINT CK_Price_DimHotels CHECK(Price>=0)
       );
DROP TABLE IF EXISTS DimAirFlights CREATE TABLE
	DimAirFlights(
	    AviaID        INT Identity (1,1),
		Departure     DATETIME NOT NULL,
		Arrival       DATETIME NOT NULL,
		CityDeparture NVARCHAR(25) NOT NULL,
		CityArrival   NVARCHAR(25) NOT NULL,
		Baggage       NVARCHAR(10),
		FlightNumber  NVARCHAR(10),
		CONSTRAINT PK_AviaID_DimAirFlight PRIMARY KEY (AviaID),
       );
DROP TABLE IF EXISTS DimFctSales CREATE TABLE
	DimFctSales(
	    SalesID       INT Identity (1,1),
		ClientID      INT,
		ManagerID     INT,
		HotelID       INT,
		AviaID        INT,
		SalesDate     DATE NOT NULL CONSTRAINT DF_SalesDate_DimFctSales DEFAULT GETDATE(),
		StartDate     DATE NOT NULL,
		EndDate       DATE NOT NULL,
		Discount      INT,
		Price         Money,
		CONSTRAINT PK_SalesId_FctSales PRIMARY KEY (SalesId),
	    CONSTRAINT CK_Discount_FctSales CHECK (Discount>=0),
		CONSTRAINT CK_Price_FctSales CHECK (Price>=0)
		
       );
ALTER TABLE DimFctSales
ADD CONSTRAINT FK_ClientId_FctSales FOREIGN KEY (ClientID) 
		           REFERENCES dbo.DimClients (ClientID),
		CONSTRAINT FK_FK_ManagerId_FctSales FOREIGN KEY (ManagerId)
		           REFERENCES dbo.DimManagers (ManagerID),
		CONSTRAINT FK_HotelId_FctSales FOREIGN KEY (HotelId)
		           REFERENCES dbo.DimHotels (HotelId),
		CONSTRAINT FK_AviaId_FctSales FOREIGN KEY (AviaId)
		           REFERENCES dbo.DimAirFlights (AviaId)
ON UPDATE CASCADE
ON DELETE CASCADE
;-- not sure if it is correct with cascades, because there are lot of FK here



