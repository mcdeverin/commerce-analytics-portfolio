-- Conversion Funnel Analysis
-- Tracks user journey from pageview to click to conversion
-- Demonstrates: Multi-stage funnel metrics, drop-off calculations

WITH funnel_metrics AS (
  SELECT 
    brand,
    category,
    SUM(pageviews) AS stage_1_pageviews,
    SUM(affiliate_clicks) AS stage_2_clicks,
    SUM(conversions) AS stage_3_conversions,
    SUM(affiliate_revenue) AS total_revenue
  FROM commerce_performance
  WHERE date >= CURRENT_DATE - INTERVAL '30 days'
  GROUP BY brand, category
)
SELECT 
  brand,
  category,
  
  -- Funnel stages
  stage_1_pageviews,
  stage_2_clicks,
  stage_3_conversions,
  
  -- Conversion rates at each stage
  ROUND((stage_2_clicks::NUMERIC / NULLIF(stage_1_pageviews, 0) * 100), 2) AS pageview_to_click_rate,
  ROUND((stage_3_conversions::NUMERIC / NULLIF(stage_2_clicks, 0) * 100), 2) AS click_to_conversion_rate,
  ROUND((stage_3_conversions::NUMERIC / NULLIF(stage_1_pageviews, 0) * 100), 2) AS overall_conversion_rate,
  
  -- Drop-off analysis
  (stage_1_pageviews - stage_2_clicks) AS dropoff_after_pageview,
  (stage_2_clicks - stage_3_conversions) AS dropoff_after_click,
  
  -- Revenue metrics
  total_revenue,
  ROUND(total_revenue / NULLIF(stage_3_conversions, 0), 2) AS avg_revenue_per_conversion
  
FROM funnel_metrics
ORDER BY stage_3_conversions DESC;
