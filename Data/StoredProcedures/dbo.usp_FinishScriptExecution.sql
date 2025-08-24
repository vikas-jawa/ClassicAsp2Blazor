-- 'CREATE OR ALTER' Works in SQL Server 2016 SP1 and newer.

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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