-- Traffic Source Analysis
-- Compares effectiveness of different traffic sources for commerce content
-- Demonstrates: GROUP BY, aggregations, calculated conversion metrics

SELECT 
  traffic_source,
  COUNT(DISTINCT article_id) AS total_articles,
  SUM(pageviews) AS total_pageviews,
  SUM(affiliate_clicks) AS total_clicks,
  SUM(conversions) AS total_conversions,
  SUM(affiliate_revenue) AS total_revenue,
  
  -- Performance metrics by source
  ROUND(AVG(affiliate_clicks::NUMERIC / NULLIF(pageviews, 0) * 100), 2) AS avg_ctr,
  ROUND(AVG(conversions::NUMERIC / NULLIF(affiliate_clicks, 0) * 100), 2) AS avg_conversion_rate,
  ROUND(SUM(affiliate_revenue) / NULLIF(SUM(pageviews), 0) * 1000, 2) AS revenue_per_1k_pageviews,
  ROUND(SUM(affiliate_revenue) / NULLIF(SUM(affiliate_clicks), 0), 2) AS revenue_per_click,
  
  -- Efficiency score (revenue per pageview)
  ROUND(SUM(affiliate_revenue) / NULLIF(SUM(pageviews), 0), 4) AS efficiency_score
  
FROM commerce_performance
WHERE date >= CURRENT_DATE - INTERVAL '60 days'
GROUP BY traffic_source
ORDER BY total_revenue DESC;
