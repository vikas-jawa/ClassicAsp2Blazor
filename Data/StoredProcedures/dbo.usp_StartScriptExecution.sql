-- 'CREATE OR ALTER' Works in SQL Server 2016 SP1 and newer.

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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