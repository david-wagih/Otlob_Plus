USE [Emplyees]
GO
/****** Object:  StoredProcedure [dbo].[Updating]    Script Date: 8/22/2021 10:09:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Updating]
	   @ID int,
	   @employeeID int,
	   @FirstName	varchar(255),
	   @LastName	varchar(255),
	   @Address VARCHAR(255),
	   @Gender VARCHAR(255),
	   @Phone int,
	   @Salary int,
	   @dateOfBirth date,
	   @EnryDate date,
	   @Email VARCHAR(255),
	   @Sector VARCHAR(255)
  
AS 
BEGIN 
 
UPDATE Employees
SET  Address = @Address,
     Phone = @Phone, 
     Email = @Email,
     Salary = @Salary
WHERE  ID = @ID
END
