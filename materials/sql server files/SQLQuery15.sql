CREATE PROCEDURE Masterinsertupdatedelete (@ID            int,
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
            INSERT INTO EMP
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
            FROM   EMP
        END

      IF @StatementType = 'Update'
        BEGIN
            UPDATE EMP
            SET    Address = @Address,
                   Phone = @Phone,
                   Salary = @Salary,
                   Email = @Email,
				   Sector = @Sector

            WHERE  id = @id
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM EMP
            WHERE  id = @id
        END
  END