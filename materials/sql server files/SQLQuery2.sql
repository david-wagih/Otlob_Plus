USE [Emplyees]
GO
/****** Object:  StoredProcedure [dbo].[Creating]    Script Date: 8/22/2021 10:17:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Creating]
	   @ID int,
	   @employeeID int,
	   @FirstName	varchar(255),
	   @LastName	varchar(255),
	   @Address VARCHAR(255),
	   @Gender VARCHAR(255),
	   @Phone int,
	   @Salary int,
	   @dateOfBirth date,
	   @EntryDate date,
	   @Email VARCHAR(255),
	   @Sector VARCHAR(255)
	 
AS
BEGIN
INSERT INTO EMP(
	   ID,
	   employeeID,
	   FirstName,
	   LastName,
	   Address,
	   Gender,
	   Phone,
	   Salary,
	   dateOfBirth,
	   EntryDate,
	   Email,
	   Sector	   
	   )
    VALUES (
	   @ID ,
	   @employeeID ,
	   @FirstName	,
	   @LastName	,
	   @Address ,
	   @Gender ,
	   @Phone ,
	   @Salary ,
	   @dateOfBirth ,
	   @EntryDate ,
	   @Email ,
	   @Sector)
 
END