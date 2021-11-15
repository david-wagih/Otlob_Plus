USE [Otlob+]
GO
/****** Object:  Table [dbo].[Restaurants]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurants](
	[RestaurantID] [int] IDENTITY(1,1) NOT NULL,
	[RestaurantName] [nvarchar](50) NOT NULL,
	[RestaurantLocation] [varchar](255) NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_Restaurants] PRIMARY KEY CLUSTERED 
(
	[RestaurantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OStatus]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OStatus](
	[StatusID] [int] NOT NULL,
	[Status] [varchar](10) NOT NULL,
 CONSTRAINT [PK_OStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[dateOfBirth] [date] NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[TypeID] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Items]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[ItemName] [nvarchar](50) NOT NULL,
	[ItemPrice] [float] NOT NULL,
	[RestaurantID] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_Itemes] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[ItemID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Quantity] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[RestaurantID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderPrice] [float] NOT NULL,
	[StatusID] [int] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[isDeleted] [bit] NOT NULL,
	[adminID] [int] NULL,
	[Fees] [float] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[userView]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[userView]
AS
SELECT        dbo.OrderItem.OrderID, dbo.Restaurants.RestaurantName, dbo.Items.ItemName, dbo.OrderItem.Quantity, dbo.Orders.CreationDate, dbo.Orders.OrderPrice, dbo.Orders.Fees
FROM            dbo.Users INNER JOIN
                         dbo.Orders ON dbo.Users.UserID = dbo.Orders.adminID AND dbo.Users.UserID = dbo.Orders.UserID INNER JOIN
                         dbo.OrderItem ON dbo.Orders.OrderID = dbo.OrderItem.OrderID INNER JOIN
                         dbo.Items ON dbo.OrderItem.ItemID = dbo.Items.ItemID INNER JOIN
                         dbo.Restaurants ON dbo.Orders.RestaurantID = dbo.Restaurants.RestaurantID AND dbo.Items.RestaurantID = dbo.Restaurants.RestaurantID INNER JOIN
                         dbo.OStatus ON dbo.Orders.StatusID = dbo.OStatus.StatusID
GO
/****** Object:  View [dbo].[adminview]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[adminview]
AS
SELECT        dbo.Orders.OrderID, dbo.Users.UserID, dbo.Restaurants.RestaurantName, dbo.Items.ItemName, dbo.Items.ItemPrice, dbo.Orders.OrderPrice, dbo.OStatus.Status
FROM            dbo.Orders INNER JOIN
                         dbo.OrderItem ON dbo.Orders.OrderID = dbo.OrderItem.OrderID INNER JOIN
                         dbo.Restaurants ON dbo.Orders.RestaurantID = dbo.Restaurants.RestaurantID INNER JOIN
                         dbo.Users ON dbo.Orders.adminID = dbo.Users.UserID AND dbo.Orders.UserID = dbo.Users.UserID INNER JOIN
                         dbo.OStatus ON dbo.Orders.StatusID = dbo.OStatus.StatusID INNER JOIN
                         dbo.Items ON dbo.OrderItem.ItemID = dbo.Items.ItemID AND dbo.Restaurants.RestaurantID = dbo.Items.RestaurantID
GO
/****** Object:  View [dbo].[reportview]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[reportview]
AS
SELECT        dbo.Orders.OrderID, dbo.Restaurants.RestaurantName, dbo.OStatus.Status, dbo.Items.ItemName, dbo.Items.ItemPrice, dbo.Orders.RestaurantID, dbo.Orders.UserID, dbo.Orders.OrderPrice, dbo.Orders.CreationDate, 
                         dbo.Orders.ModifiedDate, dbo.Orders.isDeleted, dbo.Orders.adminID
FROM            dbo.Items INNER JOIN
                         dbo.OrderItem ON dbo.Items.ItemID = dbo.OrderItem.ItemID INNER JOIN
                         dbo.Orders ON dbo.OrderItem.OrderID = dbo.Orders.OrderID INNER JOIN
                         dbo.OStatus ON dbo.Orders.StatusID = dbo.OStatus.StatusID INNER JOIN
                         dbo.Restaurants ON dbo.Orders.RestaurantID = dbo.Restaurants.RestaurantID
GO
/****** Object:  Table [dbo].[Type]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[TypeID] [int] NOT NULL,
	[Type] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Items] ON 
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [ItemPrice], [RestaurantID], [isDeleted], [isActive]) VALUES (1, N'Pizza BBQ', 35.75, 1, 1, 1)
GO
INSERT [dbo].[Items] ([ItemID], [ItemName], [ItemPrice], [RestaurantID], [isDeleted], [isActive]) VALUES (2, N'chicken macdo', 35, 2, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Items] OFF
GO
INSERT [dbo].[OrderItem] ([ItemID], [OrderID], [Quantity]) VALUES (1, 1, 5)
GO
INSERT [dbo].[OrderItem] ([ItemID], [OrderID], [Quantity]) VALUES (2, 1, 6)
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [RestaurantID], [UserID], [OrderPrice], [StatusID], [CreationDate], [ModifiedDate], [isDeleted], [adminID], [Fees]) VALUES (1, 1, 1, 50, 1, CAST(N'2021-05-04T00:00:00.000' AS DateTime), CAST(N'2021-04-05T00:00:00.000' AS DateTime), 0, 1, 20.5)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[OStatus] ([StatusID], [Status]) VALUES (1, N'Pending')
GO
INSERT [dbo].[OStatus] ([StatusID], [Status]) VALUES (2, N'Confirmed')
GO
INSERT [dbo].[OStatus] ([StatusID], [Status]) VALUES (3, N'Delivered')
GO
INSERT [dbo].[OStatus] ([StatusID], [Status]) VALUES (4, N'Rejected')
GO
SET IDENTITY_INSERT [dbo].[Restaurants] ON 
GO
INSERT [dbo].[Restaurants] ([RestaurantID], [RestaurantName], [RestaurantLocation], [isDeleted], [isActive]) VALUES (1, N'KFC', N'Abbas', 0, 1)
GO
INSERT [dbo].[Restaurants] ([RestaurantID], [RestaurantName], [RestaurantLocation], [isDeleted], [isActive]) VALUES (2, N'Macdonald''s', N'Makram', 0, 1)
GO
SET IDENTITY_INSERT [dbo].[Restaurants] OFF
GO
INSERT [dbo].[Type] ([TypeID], [Type]) VALUES (1, N'Admin')
GO
INSERT [dbo].[Type] ([TypeID], [Type]) VALUES (2, N'Customer')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [dateOfBirth], [Password], [TypeID]) VALUES (1, N'David', N'Wagih', CAST(N'2000-01-01' AS Date), N'12345', 1)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[Items]  WITH CHECK ADD  CONSTRAINT [FK_Items_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Items] CHECK CONSTRAINT [FK_Items_Restaurants]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Items1] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Items] ([ItemID])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Items1]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Orders]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_OStatus] FOREIGN KEY([StatusID])
REFERENCES [dbo].[OStatus] ([StatusID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_OStatus]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Restaurants] FOREIGN KEY([RestaurantID])
REFERENCES [dbo].[Restaurants] ([RestaurantID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Restaurants]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users1] FOREIGN KEY([adminID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users1]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Type] FOREIGN KEY([TypeID])
REFERENCES [dbo].[Type] ([TypeID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Type]
GO
/****** Object:  StoredProcedure [dbo].[AddnewOrder]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddnewOrder] 
@RestaurantID int ,
@UserID int,
@OrderPrice float,
@StatusID int,
@CreationDate datetime,
@ModifiedDate datetime,
@isDeleted bit,
@adminID int,
@Fees float
AS
BEGIN
INSERT INTO Orders(
	   RestaurantID,
	   UserID,
	   OrderPrice,
	   StatusID,
	   CreationDate,
	   ModifiedDate,
	   isDeleted,
	   adminID,
	   Fees
	 )
    VALUES (
@RestaurantID  ,
@UserID ,
@OrderPrice,
@StatusID,
@CreationDate ,
@ModifiedDate,
@isDeleted,
@adminID,
@Fees

)
END
GO
/****** Object:  StoredProcedure [dbo].[AddnewUser]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddnewUser] 
	   @FirstName nvarchar(50),
	   @LastName  nvarchar(50),
	   @dateOfBirth date,
	   @Password nVARCHAR(50)

AS
BEGIN

INSERT INTO Users(
	   FirstName,
	   LastName,
	   dateOfBirth,
	   Password

	 )
    VALUES (
	   @FirstName ,
	   @LastName	,
	   @dateOfBirth	,
	   @Password 


)
END
GO
/****** Object:  StoredProcedure [dbo].[getallOrders]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getallOrders]
	

AS
BEGIN
SELECT * FROM [dbo].[OrderView]

END
GO
/****** Object:  StoredProcedure [dbo].[getallUsers]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getallUsers] 

AS
BEGIN
	SELECT * FROM [dbo].[Users]
END
GO
/****** Object:  StoredProcedure [dbo].[getItems]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getItems]


AS
BEGIN
	SELECT [ItemID] FROM [dbo].[Items] 
	WHERE [isDeleted] = 0 AND ([isActive] = 1)
END
GO
/****** Object:  StoredProcedure [dbo].[getOrder]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getOrder]
	@OrderID int
AS
BEGIN
	SELECT * FROM [dbo].[OrderView] where OrderID =  @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[getOrderByUserID]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getOrderByUserID] 
	@UserID int
AS
BEGIN
	SELECT [OrderID] FROM [dbo].[Orders] WHERE @UserID = UserID
END
GO
/****** Object:  StoredProcedure [dbo].[getOrderStatus]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getOrderStatus]
@OrderID int
AS
BEGIN
	SELECT  [StatusID] FROM [dbo].[Orders] WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[getRestaurants]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getRestaurants]


AS
BEGIN
	SELECT [RestaurantID] FROM  [dbo].[Restaurants]
	WHERE [isDeleted] = 0 AND ([isActive] = 1)
END
GO
/****** Object:  StoredProcedure [dbo].[getUser]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUser]
	@UserID int

AS
BEGIN
	SELECT * FROM [dbo].[Users] WHERE UserID = @UserID
END
GO
/****** Object:  StoredProcedure [dbo].[isOrderDeleted]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[isOrderDeleted]
@OrderID int
AS
BEGIN
	if((SELECT [isDeleted] FROM [dbo].[Orders] WHERE @OrderID = OrderID) = 1 )
	BEGIN
		RETURN 1
	END
	ELSE
	BEGIN
		Return 0
	END
END
GO
/****** Object:  StoredProcedure [dbo].[isPasswordAuthenticated]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[isPasswordAuthenticated] 
@UserId int,
@Password nvarchar(50)
AS
BEGIN   
	if( @Password LIKE (SELECT [Password] FROM Users WHERE @UserId = UserID))
	BEGIN
		RETURN 1
	END
	ELSE
	BEGIN
		Return 0
	END


	
END

GO
/****** Object:  StoredProcedure [dbo].[updateStatus]    Script Date: 9/6/2021 2:03:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updateStatus] 
	@OrderID int,
	@StatusID int
AS
BEGIN
	UPDATE  Orders
		set StatusID = @StatusID

	WHERE @OrderID = OrderID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Orders"
            Begin Extent = 
               Top = 160
               Left = 36
               Bottom = 290
               Right = 206
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderItem"
            Begin Extent = 
               Top = 15
               Left = 252
               Bottom = 128
               Right = 422
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Restaurants"
            Begin Extent = 
               Top = 166
               Left = 499
               Bottom = 296
               Right = 690
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 19
               Left = 502
               Bottom = 149
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OStatus"
            Begin Extent = 
               Top = 10
               Left = 809
               Bottom = 106
               Right = 979
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Items"
            Begin Extent = 
               Top = 135
               Left = 856
               Bottom = 265
               Right = 1026
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         A' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'adminview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'lias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'adminview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'adminview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "OrderItem"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 151
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 7
               Left = 475
               Bottom = 206
               Right = 671
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "OStatus"
            Begin Extent = 
               Top = 204
               Left = 697
               Bottom = 300
               Right = 867
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Restaurants"
            Begin Extent = 
               Top = 33
               Left = 786
               Bottom = 163
               Right = 977
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Items"
            Begin Extent = 
               Top = 6
               Left = 25
               Bottom = 220
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'reportview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'reportview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'reportview'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Users"
            Begin Extent = 
               Top = 16
               Left = 0
               Bottom = 238
               Right = 244
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Orders"
            Begin Extent = 
               Top = 2
               Left = 301
               Bottom = 261
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderItem"
            Begin Extent = 
               Top = 10
               Left = 486
               Bottom = 129
               Right = 672
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Items"
            Begin Extent = 
               Top = 6
               Left = 628
               Bottom = 172
               Right = 859
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Restaurants"
            Begin Extent = 
               Top = 11
               Left = 943
               Bottom = 141
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "OStatus"
            Begin Extent = 
               Top = 176
               Left = 530
               Bottom = 272
               Right = 700
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'userView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'userView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'userView'
GO
