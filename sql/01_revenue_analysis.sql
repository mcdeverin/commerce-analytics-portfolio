-- Weekly Revenue Analysis
-- Analyzes week-over-week affiliate revenue performance by brand
-- Demonstrates: CTEs, window functions, percentage calculations

WITH weekly_revenue AS (
  SELECT 
    DATE_TRUNC('week', date) AS week_start,
    brand,
    SUM(affiliate_revenue) AS total_revenue,
    SUM(affiliate_clicks) AS total_clicks,
    SUM(pageviews) AS total_pageviews,
    COUNT(DISTINCT article_id) AS articles_published
  FROM commerce_performance
  WHERE date >= CURRENT_DATE - INTERVAL '90 days'
  GROUP BY 1, 2
),
week_over_week AS (
  SELECT 
    week_start,
    brand,
    total_revenue,
    LAG(total_revenue) OVER (PARTITION BY brand ORDER BY week_start) AS prev_week_revenue,
    ROUND(
      ((total_revenue - LAG(total_revenue) OVER (PARTITION BY brand ORDER BY week_start)) 
      / NULLIF(LAG(total_revenue) OVER (PARTITION BY brand ORDER BY week_start), 0) * 100), 
      2
    ) AS revenue_growth_pct
  FROM weekly_revenue
)
SELECT 
  week_start,
  brand,
  total_revenue,
  prev_week_revenue,
  revenue_growth_pct
FROM week_over_week
ORDER BY week_start DESC, brand;
