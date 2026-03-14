Customer Segmentation using RFM Analysis (SQL Project)
Project Overview

This project performs customer segmentation using RFM analysis (Recency, Frequency, Monetary) on retail transaction data. The objective is to identify valuable customers and segment them based on their purchasing behavior.

Using SQL Server, customer transactions were analyzed to calculate RFM metrics. Customers were then assigned scores from 1–5 for Recency, Frequency, and Monetary values, which were used to determine the overall customer segment.

This analysis helps businesses understand customer value and develop targeted marketing strategies.

Business Objective

The goal of this project is to:

Identify high-value customers

Understand customer purchasing behavior

Segment customers for targeted marketing

Detect low engagement customers

Support data-driven decision making

RFM Metrics
Recency

Measures how recently a customer made a purchase.

DATEDIFF(DAY, MAX(InvoiceDate), GETDATE())
Frequency

Measures how often a customer makes purchases.

COUNT(DISTINCT InvoiceNo)
Monetary

Measures total amount spent by the customer.

SUM(UnitPrice * Quantity)
RFM Scoring

Customers were assigned scores from 1 to 5 for each metric based on their ranking.

Higher scores indicate better customer engagement.


Example:

Metric	Meaning
Recency Score	More recent purchase = higher score
Frequency Score	More purchases = higher score
Monetary Score	Higher spending = higher score

Customer Segmentation Logic

Customers were segmented based on the final RFM score.

Score	Segment
≥ 4	Loyal Customers
2 – 3	Good Customers
< 2	Seed Customers

This segmentation helps businesses focus marketing efforts on retaining loyal customers and improving engagement with lower segments.

Technologies Used

SQL Server

RFM Analysis

Customer Segmentation

Data Aggregation

Business Analytics

Key Insights

Identified high-value loyal customers

Detected moderately engaged customers

Found low engagement seed customers

Enabled targeted marketing strategies

Project Outcome

The project demonstrates how SQL can be used for customer behavior analysis and segmentation, enabling businesses to identify valuable customers and improve customer retention strategies.
