--==============================================================================
-- Table ScriptExecutionHistory contains the script execution history
--    => As scripts run, this table will be updated and keep record 
--       of executed scripts
--    => the each script should follow the naming convention
--       YYYYMMDDHHmmss_<scriptName> where the first part (before _)
--       is [ScriptTimeStamp] value. This will determine what scripts to run.
--    => [ExecutionStatus] has three possible values: Success/Failed/InProgress
--==============================================================================


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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

GO