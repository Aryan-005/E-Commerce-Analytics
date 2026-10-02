import pandas as pd
import matplotlib.pyplot as plt

customers = pd.read_csv("Data/customers.csv")
products = pd.read_csv("Data/products.csv")
orders = pd.read_csv("Data/orders.csv")
order_items = pd.read_csv("Data/order_items.csv")
returns = pd.read_csv("Data/returns.csv")

#---check missing values
print(customers.isna().sum())
print(products.isna().sum())
print(orders.isna().sum())
print(order_items.isna().sum())
print(returns.isna().sum())




#---Convert dates
orders["order_date"] = pd.to_datetime(orders["order_date"])
customers["signup_date"] = pd.to_datetime(customers["signup_date"])
returns["return_date"] = pd.to_datetime(returns["return_date"])


#---basic python analysis

#---total revenue
total_revenue =order_items["revenue"].sum()
print("Total Revenue:",total_revenue)

#---Total Profit
total_profit =order_items["profit"].sum()
print("Total Profit:",total_profit)

#---total orders
total_orders =orders["order_id"].nunique()
print("Total Orders:",total_orders)

#---Total Customers
total_customers = customers["customer_id"].nunique()
print("Total Customers:",total_customers)

#---Revenue by product
product_revenue = (
      order_items.groupby("product_id")["revenue"]
      .sum()
      .sort_values(ascending=False)
)

print(product_revenue)

#---Revenue by category
product_data = order_items.merge(
    products,
    on="product_id",
    how="left"
)

category_revenue = (
    product_data.groupby("category")['revenue'].sum()
    .sort_values(ascending = False)
)
print(category_revenue)


#Python Exploratory Data Analysis (EDA)


#---Revenue by month
orders["order_date"] = pd.to_datetime(orders["order_date"])

orders["month"] = orders["order_date"].dt.to_period("M")

monthly_revenue = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("month")["revenue"]
    .sum()
)

print(monthly_revenue)

#---Revenue by customer
customer_revenue = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("customer_id")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print(customer_revenue)

#---Top 5 customers
top_customers = customer_revenue.head(5)

print(top_customers)

#---Revenue by category
category_analysis = (
    product_data.groupby("category")
    .agg(
        total_revenue=("revenue", "sum"),
        total_profit=("profit", "sum")
    )
    .sort_values("total_revenue", ascending=False)
)

print(category_analysis)
#---Profit Margin
category_analysis["profit_margin"] = (
    category_analysis["total_profit"] /
    category_analysis["total_revenue"] * 100
)

print(category_analysis)

#---Average Order Value (AOV)
aov = (
    order_items["revenue"].sum() /
    orders["order_id"].nunique()
)

print("Average Order Value (AOV):", aov)

#---Repeat customers
customer_orders = (
    orders.groupby("customer_id")["order_id"]
    .nunique()
)

repeat_customers = customer_orders[customer_orders > 1]

print(repeat_customers)

#---Return analysis
return_analysis = (
    returns.groupby("return_reason")["return_id"]
    .count()
    .sort_values(ascending=False)
)

print(return_analysis)

#---Key Performance Indicators (KPIs)
total_revenue = order_items["revenue"].sum()

total_profit = order_items["profit"].sum()

total_orders = orders["order_id"].nunique()

total_customers = customers["customer_id"].nunique()

total_returns = returns["return_id"].nunique()

average_order_value = total_revenue / total_orders

profit_margin = (total_profit / total_revenue) * 100

print("Total Revenue:", total_revenue)
print("Total Profit:", total_profit)
print("Total Orders:", total_orders)
print("Total Customers:", total_customers)
print("Total Returns:", total_returns)
print("Average Order Value (AOV):", average_order_value)
print("Profit Margin:", profit_margin)

#---Profit by Product
product_profit = (
    order_items.groupby("product_id")["profit"]
    .sum()
    .sort_values(ascending=False)
)

print(product_profit)
#---Top 5 Products by Profit
top_profit_products = product_profit.head(5)

print(top_profit_products)

#---Product Profit Margin
product_analysis = (
    order_items.groupby("product_id")
    .agg(
        total_revenue=("revenue", "sum"),
        total_profit=("profit", "sum")
    )
)

product_analysis["profit_margin"] = (
    product_analysis["total_profit"] /
    product_analysis["total_revenue"] * 100
)

product_analysis = product_analysis.sort_values(
    "profit_margin",
    ascending=False
)

print(product_analysis)

#---Orders by Status
order_status_analysis = (
    orders["order_status"]
    .value_counts()
)

print(order_status_analysis)

#---Revenue by Order Status
status_revenue = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("order_status")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print(status_revenue)

#---Revenue by Payment Method
payment_analysis = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("payment_method")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print(payment_analysis)

#---Orders by Payment Method
payment_orders = (
    orders["payment_method"]
    .value_counts()
)

print(payment_orders)

#---Revenue by State
state_revenue = (
    orders.merge(order_items, on="order_id", how="inner")
    .merge(customers, on="customer_id", how="left")
    .groupby("state")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print(state_revenue)

#---Revenue by City
city_revenue = (
    orders.merge(order_items, on="order_id", how="inner")
    .merge(customers, on="customer_id", how="left")
    .groupby("city")["revenue"]
    .sum()
    .sort_values(ascending=False)
)

print(city_revenue)

#---Number of Orders per Customer
customer_order_count = (
    orders.groupby("customer_id")["order_id"]
    .nunique()
    .sort_values(ascending=False)
)

print(customer_order_count)

#---Customer Average Order Value
customer_aov = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("customer_id")
    .agg(
        total_revenue=("revenue", "sum"),
        total_orders=("order_id", "nunique")
    )
)

customer_aov["average_order_value"] = (
    customer_aov["total_revenue"] /
    customer_aov["total_orders"]
)

print(customer_aov.sort_values(
    "average_order_value",
    ascending=False
))

#---Most Common Return Reasons
return_reason_percentage = (
    returns["return_reason"]
    .value_counts(normalize=True) * 100
)

print(return_reason_percentage)

#---Product Return Count
product_returns = (
    returns.groupby("product_id")["return_id"]
    .count()
    .sort_values(ascending=False)
)

print(product_returns)

#---Customer Segmentation — Basic Version
customer_segments = customer_revenue.to_frame(
    name="total_revenue"
)

customer_segments["segment"] = pd.cut(
    customer_segments["total_revenue"],
    bins=[0, 5000, 10000, float("inf")],
    labels=["Low Value", "Medium Value", "High Value"]
)

print(customer_segments)

#--- Count Customers in Each Segment
segment_count = (
    customer_segments["segment"]
    .value_counts()
)

print(segment_count)

#---Revenue Generated by Each Segment
segment_revenue = (
    customer_segments.groupby(
        "segment",
        observed=True
    )["total_revenue"]
    .sum()
    .sort_values(ascending=False)
)

print(segment_revenue)

#---Monthly Profit
monthly_profit = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("month")["profit"]
    .sum()
)

print(monthly_profit)

#---Monthly Revenue + Profit Together
monthly_analysis = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("month")
    .agg(
        total_revenue=("revenue", "sum"),
        total_profit=("profit", "sum")
    )
)

monthly_analysis["profit_margin"] = (
    monthly_analysis["total_profit"] /
    monthly_analysis["total_revenue"] * 100
)

print(monthly_analysis)

#---Customer Revenue + Order Count
customer_analysis = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("customer_id")
    .agg(
        total_revenue=("revenue", "sum"),
        total_orders=("order_id", "nunique")
    )
    .sort_values("total_revenue", ascending=False)
)

print(customer_analysis)

#---Monthly revenue chart

plt.figure(figsize=(10, 5))

plt.plot(
    monthly_revenue.index.astype(str),
    monthly_revenue.values,
    marker="o"
)

plt.title("Monthly Revenue")
plt.xlabel("Month")
plt.ylabel("Revenue")

plt.xticks(rotation=45)

plt.tight_layout()

plt.show()

#---Customer recency

latest_date = orders["order_date"].max()

customer_recency = (
    orders.groupby("customer_id")["order_date"]
    .max()
    .reset_index()
)

customer_recency["recency_days"] = (
    latest_date - customer_recency["order_date"]
).dt.days

print(customer_recency)

#---Customer frequency

customer_frequency = (
    orders.groupby("customer_id")["order_id"]
    .nunique()
    .reset_index(name="frequency")
)

print(customer_frequency)

#---Customer monetary value

customer_monetary = (
    orders.merge(order_items, on="order_id", how="inner")
    .groupby("customer_id")["revenue"]
    .sum()
    .reset_index(name="monetary")
)

print(customer_monetary)

#---Combine RFM analysis

rfm = customer_recency[
    ["customer_id", "recency_days"]
].merge(
    customer_frequency,
    on="customer_id"
).merge(
    customer_monetary,
    on="customer_id"
)

print(rfm)

#---RFM scoring

rfm["recency_score"] = pd.qcut(
    rfm["recency_days"],
    5,
    labels=[5, 4, 3, 2, 1],
    duplicates="drop"
)

rfm["frequency_score"] = pd.qcut(
    rfm["frequency"].rank(method="first"),
    5,
    labels=[1, 2, 3, 4, 5]
)

rfm["monetary_score"] = pd.qcut(
    rfm["monetary"],
    5,
    labels=[1, 2, 3, 4, 5],
    duplicates="drop"
)

print(rfm)

#---Overall RFM score

rfm["rfm_score"] = (
    rfm["recency_score"].astype(int) +
    rfm["frequency_score"].astype(int) +
    rfm["monetary_score"].astype(int)
)

print(rfm)

#---Customers ranked by RFM score

rfm = rfm.sort_values(
    "rfm_score",
    ascending=False
)

print(rfm)
#---Best performing product

best_product = product_analysis.sort_values(
    "total_revenue",
    ascending=False
).head(1)

print(best_product)

#---Most profitable product

most_profitable_product = product_analysis.sort_values(
    "total_profit",
    ascending=False
).head(1)

print(most_profitable_product)

#---Best performing category

best_category = category_analysis.sort_values(
    "total_revenue",
    ascending=False
).head(1)

print(best_category)

#---Most profitable category

most_profitable_category = category_analysis.sort_values(
    "total_profit",
    ascending=False
).head(1)

print(most_profitable_category)

#---Highest-value customers

high_value_customers = rfm[
    rfm["rfm_score"] >= rfm["rfm_score"].quantile(0.75)
]

print(high_value_customers)

#---Customer revenue contribution

customer_analysis["revenue_percentage"] = (
    customer_analysis["total_revenue"] /
    customer_analysis["total_revenue"].sum() * 100
)

print(customer_analysis)

#---Overall return rate

return_rate = (
    total_returns /
    total_orders * 100
)

print("Overall Return Rate:", return_rate)

#---Final KPI summary

kpi_summary = {
    "Total Revenue": total_revenue,
    "Total Profit": total_profit,
    "Total Orders": total_orders,
    "Total Customers": total_customers,
    "Total Returns": total_returns,
    "Average Order Value": average_order_value,
    "Profit Margin": profit_margin,
    "Return Rate": return_rate
}

print(kpi_summary)


