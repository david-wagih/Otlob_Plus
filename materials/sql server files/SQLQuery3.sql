USE [Emplyees]
GO
/****** Object:  StoredProcedure [dbo].[Deleting]    Script Date: 8/22/2021 10:08:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Deleting] 
    @ID int
AS 
BEGIN 
DELETE
FROM   Employees
WHERE  ID = @ID
 
END
