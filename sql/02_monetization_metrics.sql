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
    COUNT(*)                          AS players,
    COUNTIF(revenue > 0)              AS payers,
    SUM(revenue)                      AS total_revenue,
    COUNTIF(revenue > 0) / COUNT(*)   AS conversion_rate,
    SUM(revenue) / COUNTIF(revenue>0) AS arppu,
    SUM(revenue) / COUNT(*)           AS arpu
FROM `project-2-507310.game_analystics.ab_test_labeled`
GROUP BY testgroup
ORDER BY testgroup;

-- số tiền payers đã chi (min, max, p50,p90)
SELECT
    testgroup,
    COUNT(*)                                   AS payers,
    MIN(revenue)                               AS min_revenue,
    APPROX_QUANTILES(revenue, 100)[OFFSET(50)] AS median,
    APPROX_QUANTILES(revenue, 100)[OFFSET(90)] AS p90,
    MAX(revenue)                               AS max_revenue
FROM `project-2-507310.game_analystics.ab_test_labeled`
WHERE revenue > 0
GROUP BY testgroup
ORDER BY testgroup;