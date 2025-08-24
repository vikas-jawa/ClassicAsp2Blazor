SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- CREATE TABLE __ScriptExecutionHistory
IF NOT EXISTS (
    SELECT 1
    FROM sys.objects
    WHERE object_id = OBJECT_ID(N'[dbo].[__ScriptExecutionHistory]')
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[__ScriptExecutionHistory] (
        [ExecutionId] INT IDENTITY(1,1) PRIMARY KEY,
        [ScriptTimeStamp] NVARCHAR(255) NOT NULL,
        [ScriptName] NVARCHAR(255) NOT NULL,
        [ScriptVersion] NVARCHAR(50) NULL,
        [ExecutionStatus] NVARCHAR(50) NOT NULL,
        [ErrorMessage] NVARCHAR(MAX) NULL,
        [ExecutedBy] NVARCHAR(100) NOT NULL,
        [ExecutionStartTime] DATETIME NOT NULL DEFAULT(GETDATE()),
        [ExecutionEndTime] DATETIME NULL,
        [DurationSeconds] INT NULL
    );
END
GO


-- CREATE PROCEDURE [usp_StartScriptExecution] to insert start execution

CREATE OR ALTER PROCEDURE [dbo].[usp_StartScriptExecution]
    @ScriptTimeStamp NVARCHAR(255),
    @ScriptName NVARCHAR(255),
    @ScriptVersion NVARCHAR(50) = NULL,
    @ExecutedBy NVARCHAR(100),
    @ExecutionId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[__ScriptExecutionHistory]
        ([ScriptTimeStamp], [ScriptName], [ScriptVersion],
         [ExecutionStatus], [ErrorMessage], [ExecutedBy],
         [ExecutionStartTime])
    VALUES
        (@ScriptTimeStamp, @ScriptName, @ScriptVersion,
         'Running', NULL, @ExecutedBy, GETDATE());

    SET @ExecutionId = SCOPE_IDENTITY(); -- Return new ID
END;
GO

-- CREATE PROCEDURE [usp_StartScriptExecution] to update on finish execution

CREATE OR ALTER PROCEDURE [dbo].[usp_FinishScriptExecution]
    @ExecutionId INT,
    @ExecutionStatus NVARCHAR(50),
    @ErrorMessage NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StartTime DATETIME;
    SELECT @StartTime = ExecutionStartTime
    FROM [dbo].[__ScriptExecutionHistory]
    WHERE ExecutionId = @ExecutionId;

    UPDATE [dbo].[__ScriptExecutionHistory]
    SET ExecutionStatus = @ExecutionStatus,
        ErrorMessage = @ErrorMessage,
        ExecutionEndTime = GETDATE(),
        DurationSeconds = DATEDIFF(SECOND, @StartTime, GETDATE())
    WHERE ExecutionId = @ExecutionId;
END;
GO


--==============================================================================
-- -- SAMPLE CODE
-- DECLARE @ExecutionId INT;

-- -- Step 1: Start
-- EXEC [dbo].[usp_StartScriptExecution]
--     @ScriptTimeStamp = '20250810180500',
--     @ScriptName = 'UpdateCustomerTable',
--     @ScriptVersion = 'v1.2',
--     @ExecutedBy = SYSTEM_USER,
--     @ExecutionId = @ExecutionId OUTPUT;

-- -- Simulate work
-- WAITFOR DELAY '00:00:05'; -- Example delay

-- -- Step 2: Finish
-- EXEC [dbo].[usp_FinishScriptExecution]
--     @ExecutionId = @ExecutionId,
--     @ExecutionStatus = 'Success',
--     @ErrorMessage = NULL;
--==============================================================================