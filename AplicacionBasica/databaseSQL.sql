USE [master]
GO
/****** Object:  Database [pruebas]    Script Date: 24/09/2015 09:34:46 p. m. ******/
CREATE DATABASE [pruebas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'pruebas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\pruebas.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'pruebas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\pruebas_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [pruebas] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [pruebas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [pruebas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [pruebas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [pruebas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [pruebas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [pruebas] SET ARITHABORT OFF 
GO
ALTER DATABASE [pruebas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [pruebas] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [pruebas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [pruebas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [pruebas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [pruebas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [pruebas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [pruebas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [pruebas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [pruebas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [pruebas] SET  DISABLE_BROKER 
GO
ALTER DATABASE [pruebas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [pruebas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [pruebas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [pruebas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [pruebas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [pruebas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [pruebas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [pruebas] SET RECOVERY FULL 
GO
ALTER DATABASE [pruebas] SET  MULTI_USER 
GO
ALTER DATABASE [pruebas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [pruebas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [pruebas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [pruebas] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'pruebas', N'ON'
GO
USE [pruebas]
GO
/****** Object:  StoredProcedure [dbo].[usuario_detalle]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usuario_detalle]
	@idUsuario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select * from [User] where id = @idUsuario
END

GO
/****** Object:  StoredProcedure [dbo].[usuario_eliminar]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Wendy Robles>
-- Create date: <22-09-2015>
-- Description:	<Store procedure que elimina un registro de usuario>
-- =============================================
CREATE PROCEDURE [dbo].[usuario_eliminar]
	-- Add the parameters for the stored procedure here
	@idUsuario int =0
	
AS
BEGIN
	
	SET NOCOUNT ON;
	DELETE FROM [User] WHERE id= @idUsuario
END

GO
/****** Object:  StoredProcedure [dbo].[usuario_guardar]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usuario_guardar]
	@id int = 0
	, @user nvarchar(20)
	, @firstName nvarchar(100)
	, @lastName nvarchar(100)
	, @telephone nvarchar(15)
	, @email nvarchar(200)
	, @rol int
	, @usuarioId int = 0 OUTPUT
as
begin
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select @usuarioId = id from [User] where id = @id

	if @usuarioId is null
		begin
			insert into [User] ([user], firstName, lastName, telephone, email, rol) 
			values (@user, @firstName, @lastName, @telephone, @email, @rol)
			select @usuarioId = SCOPE_IDENTITY()
		end
	else
		begin
			update [User] set
			[user] = @user
			, firstname = @firstName
			, lastName = @lastName
			, telephone = @telephone
			, email = @email
			, rol = @rol
			where id = @id
			select @usuarioId = @id
		end
end

GO
/****** Object:  StoredProcedure [dbo].[usuario_listado]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usuario_listado] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select * from [User]
END

GO
/****** Object:  Table [dbo].[course]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NULL,
	[credits] [int] NULL,
 CONSTRAINT [PK_course] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idStudent] [int] NULL,
	[idCourse] [int] NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[iduser] [int] NOT NULL,
	[carrer] [nvarchar](200) NOT NULL,
	[financialAid] [bit] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 24/09/2015 09:34:46 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user] [nvarchar](20) NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[lastName] [nvarchar](100) NOT NULL,
	[telephone] [nvarchar](15) NOT NULL,
	[email] [nvarchar](200) NOT NULL,
	[rol] [int] NOT NULL,
 CONSTRAINT [PK_User_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (1, N'Wendy', N'Wendy', N'Robles', N'36363636', N'wen@mail.com', 2)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (2, N'mcervantes', N'Miguel', N'Cervantes', N'(55) 4682-5689', N'miguel@mail.com', 1)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (3, N'ngarza', N'Noemi', N'Garza', N'510 333-3333', N'ngarza@mail.com', 3)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (4, N'csantillan', N'Carla', N'Santillan', N'510 444-4444', N'csantillan@mail.com', 1)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (5, N'gdominguez', N'Guillermo', N'Dominguez', N'510 555-5555', N'gdominguez@mail.com', 1)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (6, N'ahernandez', N'Alicia', N'Hernandez', N'510 666-6666', N'ahernandez@mail.com', 1)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (7, N'dcarrasco', N'Daniela', N'Carrasco', N'510 777-7777', N'dcarrasco@mail.com', 2)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (9, N'efernandez', N'Emma', N'Fernandez', N'510 888-8888', N'efernandez@mail.com', 3)
INSERT [dbo].[User] ([id], [user], [firstName], [lastName], [telephone], [email], [rol]) VALUES (10, N'fespinoza', N'Francisco', N'Espinoza', N'510 999-9999', N'fespinoza@mail.com', 2)
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_course] FOREIGN KEY([idCourse])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_course]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Student] FOREIGN KEY([idStudent])
REFERENCES [dbo].[Student] ([id])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Student]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_User] FOREIGN KEY([iduser])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
USE [master]
GO
ALTER DATABASE [pruebas] SET  READ_WRITE 
GO
