-- 2_monetization_metrics.sql

-- số tiền players đã chi
SELECT
    testgroup,
    revenue,
    COUNT(*) AS players
FROM `project-2-507310.game_analystics.ab_test_labeled`
WHERE revenue > 0
GROUP BY testgroup, revenue
ORDER BY players DESC;


-- tính conversion rate, ẢPPU, ARPU
SELECT
    testgroup,
    COUNT(*) as players,
    COUNTIF(revenue > 0) as payers,
    SUM(revenue) as total_revenue,
    COUNTIF(revenue > 0) / COUNT(*) AS conversion_rate,
    SUM(revenue)/COUNTIF(revenue>0) as arppu,
    SUM(revenue)/COUNT(*) as arpu
FROM `project-2-507310.game_analystics.ab_test_labeled`
GROUP BY testgroup
ORDER BY testgroup;

-- số tiền payers đã chi (min, max, p50,p90)
SELECT
    testgroup,
    COUNT(*) as payers,
    MIN(revenue) as min_revenue,
    PERCENTILE_CONT(revenue, 0.5) OVER(PARTITION BY testgroup) as median, 
    PERCENTILE_CONT(revenue, 0.9) OVER(PARTITION BY testgroup) as p90, 
    MAX(revenue) as max_revenue
FROM `project-2-507310.game_analystics.ab_test_labeled`
WHERE revenue > 0
GROUP BY testgroup
ORDER BY testgroup;