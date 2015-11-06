SET ANSI_NULLS ON
GO;

SET QUOTED_IDENTIFIER ON
GO;

SET ANSI_PADDING ON
GO;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GameUsageReport')
DROP TABLE [dbo].[GameUsageReport];
GO;

CREATE TABLE [dbo].[GameUsageReport](
    [Id] [int] IDENTITY(1,1) NOT NULL,
    [ProfileID] [varchar](256) NOT NULL,
    [SessionStart] [varchar](256) NOT NULL,
    [Duration] [varchar](256) NOT NULL,
    [State] [varchar](256) NOT NULL,
    [SrcIPAddress] [varchar](256) NOT NULL,
    [GameType] [varchar](256) NOT NULL,
    [Multiplayer] [varchar](256) NOT NULL,
    [EndRank] [varchar](256) NOT NULL,
    [WeaponsUsed] [varchar](256) NOT NULL,
    [UsersInteractedWith] [varchar](256) NOT NULL,
    CONSTRAINT [PK_GameUsageReport] PRIMARY KEY CLUSTERED 
	(
	    [Id] ASC
	)
 )
GO;

