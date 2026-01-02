-- Content Performance Analysis
-- Identifies top and bottom performing content by conversion metrics
-- Demonstrates: CASE statements, calculated metrics, performance tiers

SELECT 
  article_id,
  title,
  brand,
  category,
  pageviews,
  affiliate_clicks,
  conversions,
  affiliate_revenue,
  
  -- Calculate key metrics
  ROUND((affiliate_clicks::NUMERIC / NULLIF(pageviews, 0) * 100), 2) AS click_through_rate,
  ROUND((conversions::NUMERIC / NULLIF(affiliate_clicks, 0) * 100), 2) AS conversion_rate,
  ROUND((affiliate_revenue / NULLIF(affiliate_clicks, 0)), 2) AS revenue_per_click,
  ROUND((affiliate_revenue / NULLIF(pageviews, 0) * 1000), 2) AS rpm,
  
  -- Categorize performance
  CASE 
    WHEN (conversions::NUMERIC / NULLIF(affiliate_clicks, 0)) > 0.15 THEN 'High Performer'
    WHEN (conversions::NUMERIC / NULLIF(affiliate_clicks, 0)) > 0.08 THEN 'Average'
    ELSE 'Underperformer'
  END AS performance_tier,
  
  -- Time metrics
  avg_time_on_page,
  traffic_source
  
FROM commerce_performance
WHERE date >= CURRENT_DATE - INTERVAL '30 days'
ORDER BY affiliate_revenue DESC
LIMIT 50;
