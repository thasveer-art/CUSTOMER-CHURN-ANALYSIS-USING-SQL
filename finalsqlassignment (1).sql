use ecomm;
select * from customer_churn;
select count(*) from customer_churn;
Describe customer_churn;

-- Handling Missing Values and Outliers:
-- finding missing value and updating it in ware house to home column
select count(*) as missing_values from customer_churn where warehousetohome is null;

select avg( warehousetohome) as Avg_distance from customer_churn;

select round(avg( warehousetohome)) as Rounded_mean from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set warehousetohome=16s
where warehousetohome is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn where warehousetohome is null;

               -- finding missing value and updating it in HourSpendOnApp
 
 select count(*) as missing_values from customer_churn where HourSpendOnApp is null;

select avg( HourSpendOnApp) as Avg_Hours_spend_onapp from customer_churn;

select round(avg(HourSpendOnApp)) as Rounded_mean from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set HourSpendOnApp=3
where  HourSpendOnApp is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn where HourSpendOnApp is null;

			-- finding missing value and updating it in OrderAmountHikeFromlastYear

 select count(*) as missing_values from customer_churn where OrderAmountHikeFromlastYear is null;

select avg( OrderAmountHikeFromlastYear) as Avg_order_amount_hike from customer_churn;

select round(avg(OrderAmountHikeFromlastYear)) as Rounded_mean from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set OrderAmountHikeFromlastYear=16
where OrderAmountHikeFromlastYear is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn where OrderAmountHikeFromlastYear is null;

			--  finding missing value and updating it in DaySinceLastOrder.
 select count(*) as missing_values from customer_churn where DaySinceLastOrder is null;

select avg(DaySinceLastOrder) as Avg_dayssincelast_order from customer_churn;

select round(avg(DaySinceLastOrder)) as Rounded_mean from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set DaySinceLastOrder=5
where DaySinceLastOrder is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn where DaySinceLastOrder is null;

-- ➢ Impute mode for the following columns: Tenure, CouponUsed, OrderCount.
              --  finding missing value and updating in Tenure,
select count(*) as missing_values from customer_churn 
where tenure is null;

select tenure, count(*) as frequency from customer_churn
where tenure is not null
group by tenure 
order by frequency desc
limit 1;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set tenure=1
where tenure is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn 
where tenure is null;


 --  finding missing value and updating in CouponUsed,
select count(*) as missing_values from customer_churn 
where CouponUsed is null;

select CouponUsed, count(*) as frequency from customer_churn
where CouponUsed is not null
group by CouponUsed 
order by frequency desc
limit 1;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set CouponUsed=1
where CouponUsed is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn 
where CouponUsed is null;

describe customer_churn;

--  finding missing value and updating in OrderCount
select count(*) as missing_values from customer_churn 
where OrderCount is null;

select OrderCount, count(*) as frequency from customer_churn
where OrderCount is not null
group by OrderCount 
order by frequency desc
limit 1;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set OrderCount=2
where OrderCount is null;
SET SQL_SAFE_UPDATES = 1;

select count(*) as missing_values from customer_churn 
where OrderCount is null;

-- Handle outliers in the 'WarehouseToHome'  where values are greater than 100.
select * from customer_churn where WarehouseToHome >100;

SET SQL_SAFE_UPDATES = 0;
Delete from customer_churn 
where  WarehouseToHome >100;
SET SQL_SAFE_UPDATES = 1;

select * from customer_churn where WarehouseToHome >100;

-- Dealing with Inconsistencies:
-- Replace occurrences of “Phone” in the 'PreferredLoginDevice' to'Mobile phone'
select distinct PreferredLoginDevice from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn 
set PreferredLoginDevice='Mobile Phone'
where PreferredLoginDevice='phone';
SET SQL_SAFE_UPDATES = 1;

select distinct PreferredLoginDevice from customer_churn;

-- Replace occurrences of “Mobile” in the 'PreferedOrderCat' to'Mobile phone'
select distinct PreferedOrderCat from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn 
set PreferedOrderCat='Mobile Phone'
where PreferedOrderCat='Mobile';
SET SQL_SAFE_UPDATES = 1;

select distinct PreferedOrderCat from customer_churn;

-- values: Replace "COD" with "Cash on Delivery" and "CC" with "Credit Card" in the PreferredPaymentMode column.
select distinct PreferredPaymentMode
from customer_churn;

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set PreferredPaymentMode="Cash on Delivery"
where PreferredPaymentMode="COD" or PreferredPaymentMode="CC";
SET SQL_SAFE_UPDATES = 1;

select distinct PreferredPaymentMode
from customer_churn;

-- Column Renaming:
-- ➢ Rename the column "PreferedOrderCat" to "PreferredOrderCat".
-- ➢ Rename the column "HourSpendOnApp" to "HoursSpentOnApp".
describe customer_churn;
Alter table customer_churn
Rename column PreferedOrderCat to PreferredOrderCat,
rename column HourSpendOnApp to HoursSpentOnApp;
describe customer_churn;

-- Creating New Columns:
-- Create a new column named ‘ComplaintReceived’ relating to status of column complain

select distinct complain 
from customer_churn;

Alter table customer_churn
Add column ComplaintReceived varchar(3);


SET SQL_SAFE_UPDATES = 0;
update customer_churn
set ComplaintReceived=
  case 
       when complain =1 then 'Yes'
       else 'No'
  end;
  SET SQL_SAFE_UPDATES = 1;
  
  select complain,ComplaintReceived from customer_churn
  limit15;
  
 -- ➢ Create a new column named 'ChurnStatus' related to the status of  column churn
select distinct churn from customer_churn;

Alter table customer_churn
add column ChurnStatus varchar(10);

SET SQL_SAFE_UPDATES = 0;
update customer_churn
set ChurnStatus =
  case 
       when churn =1 then 'Churned'
       else 'Active'
  end;
  SET SQL_SAFE_UPDATES = 1;

select churn,ChurnStatus from 
customer_churn limit 100;

-- Column Dropping:
-- ➢ Drop the columns "Churn" and "Complain" from the table.
Alter table customer_churn 
Drop column Churn,
Drop column Complain;

describe customer_churn;

-- ➢  the count of churned and active customers from the dataset.
select ChurnStatus,count(*) as count from customer_churn group by ChurnStatus;

-- ➢  the average tenure and total cashback amount of customers who churned.
select * from customer_churn;
select avg(tenure) as Avg_tenure from customer_churn;

select sum(cashbackamount ) as totalcashback_amount_of_customers_who_churned from customer_churn where ChurnStatus='churned';

-- ➢  the percentage of churned customers who complained.
describe customer_churn;
select 
round( count(
              case
                when ComplaintReceived='yes' then 1
			  end) *100 /count(*),
		2) as churnedcustomer_complaint_percentage
        from customer_churn
        where ChurnStatus='churned';

-- city tier with the highest number of churned customers whose preferred order category is Laptop & Accessory.
describe customer_churn;
select distinct preferredordercat from customer_churn;
select citytier,count(*) as customer_count
 from customer_churn
 where churnstatus='churned' and
 preferredordercat='laptop & accessory'
 group by citytier
 order by customer_count desc 
 limit 1;
 
 -- the most preferred payment mode among active customers.
select preferredpaymentmode,count(*) as  customer_count
from customer_churn
where churnstatus='active'
group by preferredpaymentmode
order by customer_count desc
limit 1;

-- ➢  the total order amount hike from last year for customers who are single and prefer mobile phones for ordering.
describe customer_churn;
select distinct preferredlogindevice from customer_churn;

 select sum(orderamounthikefromlastyear) as orderamounthikefromlastyear from customer_churn
 where maritalstatus='single' and
 preferredlogindevice='mobile phone';
 
 -- ➢  the average number of devices registered among customers who used UPI as their preferred payment mode.
select * from customer_churn;
select avg(numberofdeviceregistered) as avg_preferredlogindevice_usingUPI from customer_churn
where preferredpaymentmode='UPI';

-- ➢  the city tier with the highest number of customers
select citytier, count(*) as no_of_customers from customer_churn
group by citytier
order by no_of_customers desc
limit 1;

-- ➢ the gender that utilized the highest number of coupons.
select gender, sum(couponused) as no_of_couponused from customer_churn
group by gender
order by no_of_couponused desc
limit 1;

-- ➢ the number of customers and the maximum hours spent on the app in each preferred order category.
select * from customer_churn;
select PreferredOrderCat, max(HoursSpentOnApp) as maxhours_spend_onapp, count(*) as no_of_customers from customer_churn
group by PreferredOrderCat;

-- ➢  the total order count for customers who prefer using credit cards and have the maximum satisfaction score.
select sum(ordercount) as total_ordercount from customer_churn
where PreferredPaymentMode='credit card' and
SatisfactionScore=( select max(SatisfactionScore) from customer_churn);

-- ➢  the average satisfaction score of customers who have complained?
select avg(SatisfactionScore) as AVg_satisfactionscore from customer_churn
where ComplaintReceived='yes';

-- ➢  the preferred order category among customers who used more than 5 coupons.
select * from customer_churn;
select PreferredOrderCat ,count(*) as count from customer_churn 
where CouponUsed=(select count(CouponUsed)>5 from customer_churn)
group by PreferredOrderCat;

-- ➢  the top 3 preferred order categories with the highest average cashback amount.
select  PreferredOrderCat,avg(CashbackAmount) as Avg_CashbackAmount from customer_churn
group by PreferredOrderCat
order by avg_CashbackAmount desc
limit 3;

-- ➢  the preferred payment modes of customers whose average tenure is 10 months and have placed more than 500 orders.

select PreferredPaymentMode, avg(tenure) as avg_tenure from customer_churn
group by PreferredPaymentMode
having avg_tenure>10 and
sum(ordercount)>500;

-- ➢ Categorize customers based on their distance from the warehouse to home , Then display the churn status breakdown for each distance category.

select * from customer_churn;
select
case
    when WarehouseToHome<=5 then'Very close distance'
     when WarehouseToHome<=10 then' close distance' 
      when WarehouseToHome<=15 then'moderate distance'
      else 'Far Distance'
end as Distance_category,
churnstatus,count(*) as customer_count from customer_churn
group by Distance_category,ChurnStatus;

-- ➢the customer’s order details who are married, live in City Tier-1, and their order counts are more than the average number of orders placed by all  customers.

select * from customer_churn;
select count(*) as customer_count from customer_churn
where MaritalStatus='married' and
CityTier=1
having count(OrderCount)>avg(ordercount);

-- Create a ‘customer_returns’ table in the ‘ecomm’ database and insert data 
create table customer_returns(ReturnID int primary key,
CustomerID int,ReturnDate date,RefundAmount decimal(12,2),
 foreign key (CustomerID) references customer_churn(CustomerID));

 
  insert into customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount) values
									(1001 ,50022, '2023-01-01', 2130),
									(1002, 50316, '2023-01-23', 2000),
                                    (1003, 51099, '2023-02-14', 2290),
									(1004, 52321, '2023-03-08', 2510),
									(1005, 52928, '2023-03-20', 3000),
                                    (1006, 53749, '2023-04-17', 1740),
									(1007, 54206, '2023-04-21', 3250),
                                    (1008, 54838, '2023-04-30', 1990);
                                    
select * from customer_churn;
select * from  customer_churn as c inner join 	customer_returns as r
on c.CustomerID=r.CustomerID
where c.ChurnStatus='churned'and c.ComplaintReceived='yes';
 



  






 
 






