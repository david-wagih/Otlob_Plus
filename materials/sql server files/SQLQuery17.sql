USE [Emplyees]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[Masterinsertupdatedelete]
		@ID = 7,
		@employeeID = 2,
		@FisrtName = N'david',
		@LastName = N'wagih',
		@Address = N'nasrcity',
		@Gender = N'male',
		@Phone = 01000642254,
		@Salary = 20000,
		@dateOfBirth = 2000-01-01,
		@EnryDate = 2021-08-22,
		@Email = N'davidwagih62@gmail.com',
		@Sector = N'IT',
		@StatementType = N'insert'

SELECT	'Return Value' = @return_value

GO
