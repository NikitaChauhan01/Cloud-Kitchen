# Cloud Kitchen Market Analysis — Dehradun

> **Note: This project uses synthetically generated data for demonstration and analytical purposes. The dataset does not represent actual customer, restaurant, order, or market data from Dehradun.**

## 📌 Project Overview

This project analyzes a hypothetical cloud kitchen market in Dehradun to identify the most suitable location, target customers, cuisine strategy, pricing strategy, and delivery-platform strategy for a new cloud kitchen.

The project combines **Python, SQL Server, and Power BI** to transform synthetic raw data into business insights and a final launch recommendation.

## 🎯 Business Objective

The main objective is to answer:

- Where should a new cloud kitchen be launched?
- Which customer segments should be targeted?
- Which cuisines show the strongest opportunity?
- What price range should be used?
- Which food-delivery platforms should be prioritized?
- What time periods and days show the highest demand?
- How does competition vary across localities?
- Which restaurants and market segments represent potential opportunities?

## 🛠️ Tools & Technologies

- **Python** — Data generation, cleaning, analysis and exploratory data analysis
- **Pandas & NumPy** — Data manipulation and synthetic data generation
- **Matplotlib & Seaborn** — Data visualization
- **SQL Server / SSMS** — Business-oriented SQL analysis
- **Power BI** — Interactive dashboard and business reporting
- **Jupyter Notebook / Google Colab** — Python workflow
- **GitHub** — Project documentation and version control

## 📊 Dataset

The project contains five synthetic datasets:

| Dataset | Description |
|---|---|
| `customers.csv` | Customer demographics, segments, preferences and ordering behavior |
| `localities.csv` | Dehradun locality characteristics, demographics and competition indicators |
| `menu_items.csv` | Restaurant menu items, cuisine, category, price and popularity |
| `orders.csv` | Order-level transaction data including date, time, platform, status, price and revenue |
| `restaurants.csv` | Restaurant-level information including rating, revenue-related metrics and competition indicators |

The dataset contains:

- 5,000 customers
- 10 localities
- 150 restaurants
- 1,164 menu items
- 30,000 orders

## 🔍 Analysis Performed

### 1. Customer Analysis

- Customer segmentation
- Customer retention and repeat-order behavior
- Customer value and activity analysis
- Preferred cuisine analysis
- High-value customer identification

### 2. Restaurant & Competition Analysis

- Restaurant revenue performance
- Restaurant ratings and operational performance
- Market concentration
- Competitive positioning
- Locality-level competition analysis

### 3. Demand Analysis

- Monthly order and revenue trends
- Day-of-week demand
- Meal-period demand
- Weekend vs weekday performance

### 4. Pricing Analysis

- Order performance by price band
- Revenue contribution by price band
- Cuisine-level pricing analysis
- Premium order and revenue analysis

### 5. Platform Analysis

Performance comparison across:

- Swiggy
- Zomato
- Direct ordering

Metrics include orders, revenue, average order value, delivery success, cancellation and failure rates.

### 6. Location Opportunity Analysis

Localities were evaluated using:

- Population density
- Average monthly income
- Student share
- Office-worker share
- Residential share
- Tourism score
- Competition opportunity

A weighted opportunity score and a broader decision matrix were used to compare potential launch locations.

## 📈 SQL Analysis

SQL Server was used to answer business questions such as:

- Top restaurants by revenue
- High-revenue restaurants and ratings
- Cuisine performance
- Platform performance
- Meal-period performance
- Weekend vs weekday performance
- Locality demand and revenue
- Locality demand vs competition
- Customer segment performance
- Price-band performance
- Top restaurant in each locality
- Customers generating revenue above their segment average

Advanced SQL techniques include **CTEs, window functions, ranking, aggregation and subqueries**.

## 📊 Power BI Dashboard

The Power BI dashboard contains four main sections:

### Executive Overview

Provides an overall view of:

- Orders
- Revenue
- Average Order Value
- Customers
- Delivery Success Rate
- Average Rating
- Cuisine performance
- Meal-period performance
- Locality performance

### Customer & Demand Analysis

Focuses on:

- Customer segments
- Price bands
- Day-of-week demand
- Monthly revenue
- Customer order frequency

### Location & Competition Analysis

Focuses on:

- Locality demand
- Competition scores
- Demand vs competition
- Locality-level performance

### Strategy & Recommendation

Summarizes:

- Premium order performance
- Price-band revenue
- Platform performance
- Delivery success
- Final cloud-kitchen strategy

## 💡 Key Findings

### Recommended Location

**Vasant Vihar** was selected as the recommended launch location based on the overall decision matrix.

Vasant Vihar achieved the highest overall decision score because it provides a strong balance between demand, customer fit, opportunity and competitive conditions.

### Target Customers

The recommended target audience is:

- **Students**
- **Working Professionals**

### Cuisine Strategy

The recommended concept is:

**Pizza-led**, supported by:

- North Indian
- Biryani
- Healthy food options

### Pricing Strategy

- Core price range: **₹150–₹200**
- Premium range: **₹200–₹300+**

### Platform Strategy

Prioritize:

- **Swiggy**
- **Zomato**

The analysis indicates stronger delivery performance on these platforms compared with direct ordering.

### Demand Strategy

The strongest demand is concentrated around:

- Lunch
- Dinner
- Weekends

A delivery-focused operating model with reliable service and competitive value is recommended.

## 🗂️ Project Structure

```text
Cloud-Kitchen/
│
├── README.md
├── requirements.txt
│
├── data/
│   ├── customers.csv
│   ├── localities.csv
│   ├── menu_items.csv
│   ├── orders.csv
│   └── restaurants.csv
│
├── python/
│   └── Cloud_Kitchen_Data_Generation.ipynb
│
├── sql/
│   └── cloud_kitchen_analysis.sql
│
├── powerbi/
│   └── Cloud_Kitchen_Market_Analysis.pbix
│
├── screenshots/
│   ├── executive_overview.png
│   ├── customer_demand.png
│   ├── location_competition.png
│   └── strategy_recommendation.png
│
└── data_dictionary/
    └── data_dictionary.xlsx
