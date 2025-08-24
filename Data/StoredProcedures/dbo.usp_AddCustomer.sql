SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_AddCustomer]
    @FirstName NVARCHAR(100) = NULL,
    @LastName NVARCHAR(100) = NULL,
    @Address NVARCHAR(250) = NULL,
    @Telephone NVARCHAR(50) = NULL,
    @Active BIT = TRUE,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Customer] (FirstName, LastName, Address, Telephone, Active)
    VALUES (@FirstName, @LastName, @Address, @Telephone, @Active);

    SET @NewId = SCOPE_IDENTITY();
END
GO

--==============================================================================
-- -- SAMPLE CODE
-- DECLARE @Id INT;
-- EXEC [dbo].[usp_AddCustomer]
--     @FirstName = 'John',
--     @LastName = 'Doe',
--     @Address = '123 Main St',
--     @Telephone = '123-456-7890',
--     @Active = 1,
--     @NewId = @Id OUTPUT;

-- SELECT @Id AS NewCustomerId;
--==============================================================================