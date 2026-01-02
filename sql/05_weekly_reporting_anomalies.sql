-- Weekly Reporting with Anomaly Detection
-- Flags unusual performance patterns for executive reporting
-- Demonstrates: Window functions, rolling averages, conditional logic

WITH weekly_stats AS (
  SELECT 
    DATE_TRUNC('week', date) AS week_start,
    brand,
    SUM(affiliate_revenue) AS weekly_revenue,
    SUM(pageviews) AS weekly_pageviews,
    SUM(affiliate_clicks) AS weekly_clicks,
    AVG(affiliate_clicks::NUMERIC / NULLIF(pageviews, 0) * 100) AS avg_ctr
  FROM commerce_performance
  GROUP BY 1, 2
),
anomaly_detection AS (
  SELECT 
    week_start,
    brand,
    weekly_revenue,
    weekly_pageviews,
    weekly_clicks,
    avg_ctr,
    
    -- Calculate 3-week rolling average (excluding current week)
    AVG(weekly_revenue) OVER (
      PARTITION BY brand 
      ORDER BY week_start 
      ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
    ) AS rolling_avg_revenue,
    
    -- Calculate standard deviation for anomaly threshold
    STDDEV(weekly_revenue) OVER (
      PARTITION BY brand 
      ORDER BY week_start 
      ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
    ) AS revenue_stddev,
    
    -- Flag anomalies
    CASE 
      WHEN weekly_revenue > AVG(weekly_revenue) OVER (
        PARTITION BY brand 
        ORDER BY week_start 
        ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
      ) * 1.2 
      THEN 'Revenue Spike ⬆️'
      
      WHEN weekly_revenue < AVG(weekly_revenue) OVER (
        PARTITION BY brand 
        ORDER BY week_start 
        ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
      ) * 0.8 
      THEN 'Revenue Drop ⬇️'
      
      ELSE 'Normal'
    END AS anomaly_flag,
    
    -- Percent deviation from average
    ROUND(
      ((weekly_revenue - AVG(weekly_revenue) OVER (
        PARTITION BY brand 
        ORDER BY week_start 
        ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
      )) / NULLIF(AVG(weekly_revenue) OVER (
        PARTITION BY brand 
        ORDER BY week_start 
        ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING
      ), 0) * 100),
      2
    ) AS pct_deviation
    
  FROM weekly_stats
)
SELECT 
  week_start,
  brand,
  weekly_revenue,
  rolling_avg_revenue,
  anomaly_flag,
  pct_deviation,
  weekly_pageviews,
  weekly_clicks,
  ROUND(avg_ctr, 2) AS avg_ctr
FROM anomaly_detection
WHERE week_start >= CURRENT_DATE - INTERVAL '90 days'
ORDER BY week_start DESC, brand;
