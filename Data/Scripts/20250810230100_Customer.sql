SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- CREATE TABLE Customer

IF NOT EXISTS (
    SELECT 1
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[Customer]')
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[Customer](
        [Id] INT IDENTITY(1,1) NOT NULL,
        [FirstName] NVARCHAR(100) NULL,
        [LastName] NVARCHAR(100) NULL,
        [Address] NVARCHAR(250) NULL,
        [Telephone] NVARCHAR(50) NULL,
        [Active] BIT NOT NULL
    ) ON [PRIMARY];
END
GO


-- CREATE PROCEDURE [usp_AddCustomer] to add Customer

CREATE OR ALTER PROCEDURE [dbo].[usp_AddCustomer]
    @FirstName NVARCHAR(100) = NULL,
    @LastName NVARCHAR(100) = NULL,
    @Address NVARCHAR(250) = NULL,
    @Telephone NVARCHAR(50) = NULL,
    @Active BIT = 1,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Customer] (FirstName, LastName, Address, Telephone, Active)
    VALUES (@FirstName, @LastName, @Address, @Telephone, @Active);

    SET @NewId = SCOPE_IDENTITY();
END
GO