Create database Sql_Project;

use Sql_Project;

Select * from `Sales team_usa`;
Select * from `sales order_usa`;

Select sum(`Unit Price` - `Unit Cost` - `Discount Applied`) as Net_Profit from `sales order_usa`;


Select sum(`Order Quantity`) as Total_Qty from `sales order_usa`;

Select count(distinct _CustomerID) as Customer from `sales order_usa`;

describe `sales order_usa`;

Update `sales order_usa`
set `Unit Price` = replace(`Unit Price`, ',', '');

alter table `sales order_usa` 
modify column `Unit Price` decimal(10,2);

Update `sales order_usa`
set `Unit cost` = replace(`Unit cost`, ',', '');

alter table `sales order_usa` 
modify column `Unit cost` decimal(10,2);

-- adding a new column which is price minus cost and discount

Alter table `sales order_usa`
Add Net_Profit decimal(10,2);

Update `sales order_usa`
set Net_Profit = `Unit Price` - `Unit Cost` - `Discount Applied`;

-- we join both tables 

Select *
from `sales order_usa`
join `Sales team_usa`
on `sales order_usa`._SalesTeamID = `Sales team_usa`._SalesTeamID;

-- we create a new table that has all from both tables, which is the combination of both tables

Create table Final_sales as
Select `sales order_usa`.*, `Sales team_usa`.Region
from `sales order_usa`
join `Sales team_usa`
on `sales order_usa`._SalesTeamID = `Sales team_usa`._SalesTeamID;

select * from final_sales;

-- we need to find Total profit per Region and which region performs best and by the query it is Midwest

Select Region, sum(Net_Profit) as Region_sales from final_sales
group by Region
order by Region_sales desc;

-- To get the highest product by Revenue for each Region

select Region, _ProductID, Net_Profit, rank() over (partition by Region order by Net_profit desc) as ProductRegion
from final_sales;

-- In the sales Channel, In store is the higest contributor to profit seconded by online then Distributor, lastly wholesale

Select `Sales Channel`, sum(Net_Profit) as Channel_sales from final_sales
group by `Sales Channel`;

-- Average profit across Regions

Select Region, avg(Net_Profit) as Avg_sales from final_sales
group by Region;


select * from final_sales;

-- Top 10 highest buying Customers

Select _CustomerID, sum(Net_Profit) as HighRate from final_sales
group by _CustomerID
order by HighRate desc
limit 10;

-- Customers per Region

Select Region, count(Distinct _CustomerID) as RegCus from final_sales
group by Region;

-- salesteam with most revenue

Select _SalesTeamID, sum(Net_Profit) as SalesTeam from final_sales
group by _SalesTeamID
order by SalesTeam desc;

-- Todd Roberts ID 13 is the team with the most revenue



