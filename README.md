# ShopSphere — E-commerce Sales & Customer Analytics

## Project Overview

ShopSphere is an end-to-end e-commerce data analytics project designed to analyze sales performance, customer behavior, product performance, profitability, and returns.

The project demonstrates a complete Data Analyst workflow using Excel, MySQL, Python, Pandas, and Power BI.

## Business Objective

The goal of this project is to answer important business questions such as:

- How much revenue and profit is being generated?
- Which products and categories generate the most revenue?
- Which products are the most profitable?
- Which customers generate the most revenue?
- How many customers are repeat customers?
- What are the major reasons for product returns?
- Which products have higher return activity?
- How do sales change over time?
- How do order statuses and payment methods affect sales?

## Tools & Technologies

- **Excel** — Data understanding, cleaning, formulas, and basic analysis
- **MySQL** — Database creation, data cleaning, SQL analysis, joins, CTEs, and window functions
- **Python** — Data analysis and exploratory data analysis
- **Pandas** — Data manipulation and analysis
- **Matplotlib** — Data visualization
- **Power BI** — Interactive dashboards and business reporting
- **DAX** — Business calculations and Power BI measures
- **GitHub** — Project documentation and version control

## Dataset

The project contains five main tables:

| Table | Description |
|---|---|
| Customers | Customer demographic and signup information |
| Products | Product, category, pricing, and cost information |
| Orders | Order dates, customers, status, and payment methods |
| Order_Items | Product-level order quantities, revenue, cost, and profit |
| Returns | Returned products and return reasons |

### Final Dataset Size

- 14 customers
- 10 products
- 15 orders
- 17 order items
- 4 returns

## Project Workflow

```text
Raw Data
   ↓
Excel Data Understanding & Cleaning
   ↓
MySQL Database
   ↓
SQL Data Cleaning & Analysis
   ↓
Python / Pandas Analysis
   ↓
Exploratory Data Analysis
   ↓
Power BI Data Model
   ↓
DAX Measures
   ↓
Interactive Dashboard
   ↓
Business Insights
```

## SQL Analysis

The SQL analysis includes:

- Total revenue
- Total profit
- Total orders
- Total customers
- Average Order Value (AOV)
- Revenue by product
- Revenue by category
- Profit by category
- Revenue by customer
- Orders per customer
- Repeat customer analysis
- Revenue by payment method
- Orders by status
- Monthly revenue
- Top 5 products by revenue
- Product profitability
- Return analysis
- Customer ranking
- Product ranking
- Running monthly revenue
- Common Table Expressions (CTEs)
- Window functions

## Python Analysis

Python and Pandas were used for:

- Data loading
- Data cleaning
- Missing-value analysis
- Date conversion
- Key Performance Indicator (KPI) calculation
- Sales analysis
- Product analysis
- Customer analysis
- Return analysis
- Payment method analysis
- Monthly analysis
- Customer segmentation
- RFM analysis
- Data visualization

## Power BI Dashboard

The Power BI report contains two main pages.

### Page 1 — Executive Overview

- Total Revenue
- Total Profit
- Total Orders
- Total Customers
- Average Order Value
- Profit Margin
- Monthly Revenue
- Revenue by Category
- Profit by Category
- Top 5 Products by Revenue
- Interactive filters

### Page 2 — Customer & Operations

- Total Customers
- Repeat Customers
- Repeat Customer Rate
- Delivered Revenue
- Top Customers by Revenue
- Orders per Customer
- Order Status Distribution
- Return Reasons
- Returns by Product
- City filter

## Data Quality Checks

The project includes validation checks for:

- Duplicate customers
- Duplicate orders
- Duplicate products
- Missing customer relationships
- Missing order items
- Invalid product relationships
- Invalid return relationships
- Invalid quantities
- Invalid prices
- Revenue calculation errors
- Profit calculation errors
- Missing dates
- Invalid customer ages

The final data-quality validation returned no issues for the checked integrity conditions.

## Project Structure

```text
E-Commerce-Analytics/
│
├── data/
│   ├── Customers.csv
│   ├── Products.csv
│   ├── Orders.csv
│   ├── Order_Items.csv
│   └── Returns.csv
│
├── excel/
│   └── Ecommerce_Analysis.xlsx
│
├── SQL/
│   ├── ECOMMERCE.sql
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_load_customers.sql
│   ├── 04_load_products.sql
│   ├── 05_load_orders.sql
│   ├── 06_load_order_items.sql
│   ├── 07_load_returns.sql
│   ├── 08_data_cleaning.sql
│   ├── 09_analysis.sql
│   └── 10_final_data_quality_check.sql
│
├── python/
│   └── 01_ecommerce_analysis.py
│
├── Power BI/
│   └── ShopSphere_Ecommerce_Analytics_Final.pbix
│
├── .gitignore
└── README.md
```

## Key Skills Demonstrated

- Data Cleaning
- SQL
- MySQL
- Excel
- Python
- Pandas
- Exploratory Data Analysis (EDA)
- Data Visualization
- Customer Segmentation
- RFM Analysis
- Power BI
- DAX
- Data Modeling
- Business Intelligence
- Data Quality Validation

## Business Insights

The analysis provides insights into:

- Overall sales and profitability performance
- Revenue contribution by product and category
- Product-level profitability
- Customer revenue and purchasing behavior
- Repeat customer activity
- Monthly sales trends
- Order status distribution
- Payment method usage
- Product return activity
- Major return reasons
- Products with higher return activity
- Customer segments based on purchasing behavior

These insights can help businesses identify revenue opportunities, understand customer behavior, monitor product performance, and improve operational decision-making.

## Conclusion

This project demonstrates an end-to-end Data Analyst workflow, starting from raw e-commerce data and progressing through data cleaning, SQL analysis, Python-based analysis, customer segmentation, RFM analysis, and interactive Power BI reporting.

The project combines technical data analysis skills with business-focused insights to demonstrate how data can be transformed into useful information for decision-making.
