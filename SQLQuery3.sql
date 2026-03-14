
create DATABASE Online_Retails;
use Online_Retails

select * from dbo.[Online Retails]
-- 1. Recency  how recently a customer made their last purchase or interaction with a business
with max_date as( 
select max(InvoiceDate) as ref_date from dbo.[Online Retails]
)
select CustomerID,DATEDIFF(Day,max(InvoiceDate),(select ref_date from max_date)) as Recency 
from dbo.[Online Retails] group by CustomerID;

--- 2. Frequency how often a customer makes purchases within a specific time period.

with max_date as( 
select max(InvoiceDate) as ref_date from dbo.[Online Retails]
)
select CustomerID,DATEDIFF(Day,max(InvoiceDate),(select ref_date from max_date)) as Recency,
count(Distinct InvoiceNo) As Frequency
from dbo.[Online Retails] 
group by CustomerID;

-- Monetry represents the total money spent by a customer across all their transactions.

with max_date as( 
select max(InvoiceDate) as ref_date from dbo.[Online Retails]
),
RFM as (
select CustomerID,DATEDIFF(Day,max(InvoiceDate),(select ref_date from max_date)) as Recency,
count(Distinct InvoiceNo) As Frequency,
sum(UnitPrice*Quantity) AS Monetry
from dbo.[Online Retails] 
group by CustomerID)
select * from RFM;

-- Giving score out of 5 
-- Higher Recency Higher the Score
-- lower Frequency Lower Score
-- Lower Monetry lower score

with max_date as( 
select max(InvoiceDate) as ref_date from dbo.[Online Retails]
),
RFM as (
select CustomerID,DATEDIFF(Day,max(InvoiceDate),(select ref_date from max_date)) as Recency,
count(Distinct InvoiceNo) As Frequency,
sum(UnitPrice*Quantity) AS Monetry
from dbo.[Online Retails] 
group by CustomerID),
RFM_Score as (
select 
CustomerID,Recency,Frequency,Monetry,
NTILE(5) over (order by Recency desc) as Recency_score,
NTILE(5) over (order by Frequency Asc) as Frequency_score,
NTILE(5) over (order by Monetry Asc) as Monetry_score
from RFM)

select * from RFM_Score;

--- Customer Segementation score >= 4 Loyal_customer , score between 2 and 3 good_customer , Else Seed_customer

with max_date as( 
select max(InvoiceDate) as ref_date from dbo.[Online Retails]
),
RFM as (
select CustomerID,DATEDIFF(Day,max(InvoiceDate),(select ref_date from max_date)) as Recency,
count(Distinct InvoiceNo) As Frequency,
sum(UnitPrice*Quantity) AS Monetry
from dbo.[Online Retails] 
group by CustomerID),
RFM_Score as (
select 
CustomerID,Recency,Frequency,Monetry,
NTILE(5) over (order by Recency desc) as Recency_score,
NTILE(5) over (order by Frequency Asc) as Frequency_score,
NTILE(5) over (order by Monetry Asc) as Monetry_score
from RFM)

select CustomerID,Recency,Frequency,Monetry,
Recency_score,Frequency_score,Monetry_score,
case
when Recency_score >= 4 and Frequency_score >= 4 and Monetry_score >= 4 THEN  'loyal_customer' 
when Recency_score between 2 and 3 and Frequency_score between 2 and 3 and Monetry_score between 2 and 3THEN  'Good_customer' 
else 'Seed_costomer'
end as Customer_segement 
from RFM_Score order by  Recency_score desc;