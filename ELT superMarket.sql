/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PK_Date]
      ,[Date_Name]
      ,[Year]
      ,[Year_Name]
      ,[Quarter]
      ,[Quarter_Name]
      ,[Month]
      ,[Month_Name]
      ,[Week]
      ,[Week_Name]
      ,[Day_Of_Year]
      ,[Day_Of_Year_Name]
      ,[Day_Of_Quarter]
      ,[Day_Of_Quarter_Name]
      ,[Day_Of_Month]
      ,[Day_Of_Month_Name]
      ,[Day_Of_Week]
      ,[Day_Of_Week_Name]
      ,[Week_Of_Year]
      ,[Week_Of_Year_Name]
      ,[Month_Of_Year]
      ,[Month_Of_Year_Name]
      ,[Month_Of_Quarter]
      ,[Month_Of_Quarter_Name]
      ,[Quarter_Of_Year]
      ,[Quarter_Of_Year_Name]
  FROM [Azuq SuperMarket db].[dbo].[DateSales_Dm]

  SELECT *--Convert(date,PK_Date,102)
  From DateSales_Dm



SELECT CONVERT(date,[PK_Date],102) as Pk_Date
      ,[Date_Name]
	   ,convert(date,[Week],102) as Week
	   ,[Week_Name]
      ,convert(date,[Year],102) as Year
      ,[Year_Name]
      ,convert(date,[Quarter],102) as Quarter
      ,[Quarter_Name]
      ,convert(date,[Month],102) as Month
      ,[Month_Name]
      ,[Day_Of_Year]
      ,[Day_Of_Year_Name]
      ,[Day_Of_Quarter]
      ,[Day_Of_Quarter_Name]
      ,[Day_Of_Month]
      ,[Day_Of_Month_Name]
      ,[Day_Of_Week]
      ,[Day_Of_Week_Name]
      ,[Week_Of_Year]
      ,[Week_Of_Year_Name]
      ,[Month_Of_Year]
      ,[Month_Of_Year_Name]
      ,[Month_Of_Quarter]
      ,[Month_Of_Quarter_Name]
      ,[Quarter_Of_Year]
      ,[Quarter_Of_Year_Name]
INTO  DATE_Dm
FROM Time

select * from Time
--creating loweer grain for inventory
select *
from INVENTORY_Fct
where len(VendorID)!=13 

-- checking country and province relation 10, result got so ok
select  ProvinceID
from COUNTRY_Dm
where ProvinceID  in (select  ProvinceID from PROVINCE_Dm)
--now checking store id with departement first checked by len in both tables of storeid, then data
select StoreID
from DEPARTEMENT_Dm
where StoreID  in (select StoreID from STORE_Dm)

--error found and corrected
--checking store with manager
select StoreManager
from STORE_Dm
where StoreManager in (select EmployeeID from EMPLOYEE_Dm)

select len(DepartementName)
from  DEPARTEMENT_Dm
where CountryID in (select CountryID from COUNTRY_Dm)

--checing departement with fact,error found while checking refrence
select DepartementID
from INVENTORY_Fct
where DepartementID not in ( select DepartementID from DEPARTEMENT_Dm)

--got size 13, 12
select len(DepartementID)
from INVENTORY_Fct
--got size 11
select len(DepartementID) from DEPARTEMENT_Dm
--after correction
select DepartementID
from INVENTORY_Fct
where DepartementID  in ( select DepartementID from DEPARTEMENT_Dm)
--correct
select StoreID
from DEPARTEMENT_Dm
where StoreID not in (select StoreID from STORE_Dm)

--checking product, ok with category
select CategoryID
from   PRODUCT_Dm
where CategoryID in (select CategoryID from CATEGORY_Dm)

--checking storelocation,ok
select StockID
from PRODUCT_Dm
where StockID in (select StockID from STOCKLOCATION_Dm)

--stock with country,ok
select CountryID
from STOCKLOCATION_Dm
where CountryID  in (select CountryID from COUNTRY_Dm)

--cube showing error in category Br, and BR error found
select c.CategoryID
from CATEGORY_Dm c inner join PRODUCT_Dm d
on c.CategoryID = d.CategoryID

--select 
select P_Surrogate_key
from SALES_Fact
where P_Surrogate_key  in (select SurrogateKey from PRODUCT_Dm)

--error in vendor now solving it 
select VendorID
from INVENTORY_Fct
where VendorID  in(select VendorID from VENDOR_Dm)
--
select StoreID
from  DEPARTEMENT_Dm
where StoreID not in (select StoreID from STORE_Dm)

select StoreManager
from STORE_Dm
where StoreManager is NULL
where StoreManager not in (select EmployeeID from EMPLOYEE_Dm)

--error in city
select CityName 
from CITY_Dm
where CityName='Toronto'

select  Customer_id
from SALES_Fact
where Customer_id not in (select CustomerID from CUSTOMER_Dm)