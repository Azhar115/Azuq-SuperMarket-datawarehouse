/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ProvinceID]
      ,[ProvinceName]
      ,[CityID]
  FROM [Azuq SuperMarket db].[dbo].[PROVINCE_Dm]
  select CityID
  from PROVINCE_Dm
  where CityID in (select CityID from CITY_Dm)