USE [Emplyees]
GO
/****** Object:  StoredProcedure [dbo].[CRUD]    Script Date: 8/22/2021 9:01:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[CRUD] (@ID            int,
                                          @employeeID     int,
                                          @FisrtName     VARCHAR(255),
                                          @LastName      VARCHAR(255),
                                          @Address       VARCHAR(255),
										  @Gender        VARCHAR(255),
										  @Phone         int,
										  @Salary        int,
										  @dateOfBirth   date,
										  @EnryDate      date,
										  @Email         VARCHAR(255),
										  @Sector        VARCHAR(255),
                                          @StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO employees
                        (ID,
                         employeeID,
                         FirstName,
                         LastName,
                         Address,
						 Gender,
						 Phone,
						 Salary,
						 dateOfBirth,
						 EnryDate,
						 Email,
						 Sector)
            VALUES     ( @ID,            
                         @employeeID,
                         @FisrtName    ,
                         @LastName      ,
                         @Address       ,
		                 @Gender       ,
		                 @Phone         ,
				         @Salary        ,
						@dateOfBirth   ,
						@EnryDate      ,
						 @Email         ,
						@Sector       

						 )
        END

      IF @StatementType = 'Select'
        BEGIN
            SELECT *
            FROM   employees
        END

      IF @StatementType = 'Update'
        BEGIN
            UPDATE employees
            SET    Address = @Address,
                   Phone = @Phone,
                   Salary = @Salary,
                   Email = @Email,
				   Sector = @Sector

            WHERE  id = @id
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM employees
            WHERE  id = @id
        END
  END