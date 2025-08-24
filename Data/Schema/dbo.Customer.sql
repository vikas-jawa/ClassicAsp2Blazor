SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NULL,
	[LastName] [nvarchar](100) NULL,
	[Address] [nvarchar](250) NULL,
	[Telephone] [nvarchar](50) NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]
GO