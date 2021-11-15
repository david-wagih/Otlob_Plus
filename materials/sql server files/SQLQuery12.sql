USE [Emplyees]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[Creating]
		@ID = 1,
		@employeeID = 1,
		@FirstName = N'David',
		@LastName = N'Wagih',
		@Address = N'nasr city',
		@Gender = N'Male',
		@Phone = 01000642254,
		@Salary = 20000,
		@dateOfBirth = '2000-01-01',
		@EntryDate = '2021-08-21',
		@Email = N'davidwagih62@gmail.com',
		@Sector = N'IT'

SELECT	'Return Value' = @return_value

GO
