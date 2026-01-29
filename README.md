# commerce-analytics-portfolio
SQL queries demonstrating commerce analytics skills

# Commerce Analytics Portfolio

**Macauley Deverin** | [LinkedIn](https://linkedin.com/in/macauley-deverin) | mcdeverin@gmail.com

SQL queries and analysis demonstrating commerce analytics skills for affiliate/e-commerce performance reporting.

---

## Project Overview

This portfolio showcases data analysis techniques used in commerce analytics roles, including weekly performance reporting, ad-hoc revenue analysis, traffic optimization, and conversion tracking.

**Skills Demonstrated:**
- SQL (PostgreSQL syntax): CTEs, window functions, JOINs, date operations, aggregations
- Commerce Metrics: Affiliate revenue, CTR, conversion rates, RPM, customer funnel analysis
- Performance Analysis: Week-over-week growth, anomaly detection, trend identification
- Business Intelligence: Translating data into actionable insights

---

## Sample Dataset

Mock commerce data representing a media company's affiliate content portfolio:
- **300 articles** across 5 brands (Vogue, GQ, Wired, Bon Appétit, Allure)
- **60 days** of performance metrics (Oct-Nov 2024)
- **Multiple traffic sources** (organic, social, email, direct)
- **Key metrics**: Pageviews, clicks, conversions, revenue, engagement time

[View Sample Data →](data/commerce_data.csv)

---

## 🔍 SQL Queries

### 1. Weekly Revenue Analysis ([View SQL](sql/01_revenue_analysis.sql))
Week-over-week revenue performance with growth calculations. Mirrors regular performance reporting for executive stakeholders.

**Key Techniques:** CTEs, LAG window function, percentage calculations  
**Key Metrics:** Total revenue, WoW growth %, articles published  
**Business Value:** Tracks revenue trends and identifies growth/decline patterns

---

### 2. Content Performance Analysis ([View SQL](sql/02_content_performance.sql))
Identifies top and bottom performing content by conversion metrics.

**Key Techniques:** CASE statements, calculated fields, performance segmentation  
**Key Metrics:** CTR, conversion rate, revenue per click, RPM  
**Business Value:** Pinpoints high-value content and optimization opportunities

---

### 3. Traffic Source Optimization ([View SQL](sql/03_traffic_source_analysis.sql))
Compares traffic source effectiveness for commerce content.

**Key Techniques:** GROUP BY aggregations, efficiency scoring  
**Key Metrics:** Revenue per 1K pageviews, conversion rate by source  
**Business Value:** Informs traffic acquisition strategy and budget allocation

---

### 4. Conversion Funnel Analysis ([View SQL](sql/04_conversion_funnel.sql))
Tracks user journey from pageview → click → conversion with drop-off analysis.

**Key Techniques:** Multi-stage funnel calculations, drop-off metrics  
**Key Metrics:** Stage conversion rates, funnel drop-off points  
**Business Value:** Identifies friction points in user journey for optimization

---

### 5. Anomaly Detection for Weekly Reporting ([View SQL](sql/05_weekly_reporting_anomalies.sql))
Flags unusual performance patterns using rolling averages and statistical thresholds.

**Key Techniques:** Rolling averages, standard deviation, conditional flagging  
**Key Metrics:** Revenue deviation %, anomaly classification  
**Business Value:** Automatically surfaces issues requiring investigation

---

## Tools & Technologies

- **SQL:** PostgreSQL (compatible with Snowflake, BigQuery)
- **Data Visualization:** Tableau (dashboard coming soon)
- **Skills:** Ad-hoc analysis, performance reporting, data quality validation

---

##  Use Cases

These queries demonstrate capability to:
- Prepare weekly/bi-weekly performance reports highlighting trends and anomalies
- Conduct ad-hoc analyses supporting strategic decision-making
- Develop deep expertise in commerce metrics (affiliate revenue, CTR, conversions)
- Create custom reports addressing specific business questions
- Identify optimization opportunities through data analysis

---

## 📫 Connect

- **LinkedIn:** [linkedin.com/in/macauley-deverin](https://linkedin.com/in/macauley-deverin)
- **Email:** mcdeverin@gmail.com
- **GitHub:** [github.com/mcdeverin](https://github.com/mcdeverin)

---

*Note: All data is synthetic and created for demonstration purposes. This portfolio showcases analytical skills applicable to commerce analytics roles at media and e-commerce companies.*
