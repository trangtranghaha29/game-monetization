-- 3_segmentation.sql

-- gom nhóm
CREATE OR REPLACE TABLE `project-2-507310.game_analystics.player_segments` as
SELECT
    user_id,
    testgroup,
    revenue,
    CASE
        WHEN revenue = 0 THEN 'non_payer'
        WHEN testgroup = 'offer a' AND revenue <=  393.3 THEN 'payer'
        WHEN testgroup = 'offer b' AND revenue <= 3795.8 THEN 'payer'
        ELSE 'top_10pct_payer'
    END AS segment
FROM `project-2-507310.game_analystics.ab_test_labeled`;


-- 2. Players và revenue mỗi nhóm
SELECT
    testgroup,
    segment,
    COUNT(*) as players,
    SUM(revenue) as total_revenue,
    COUNT(*)/SUM(COUNT(*)) OVER (PARTITION BY testgroup) AS pct_players,
    SUM(revenue)/SUM(SUM(revenue)) OVER (PARTITION BY testgroup) AS rev_share
FROM `project-2-507310.game_analystics.player_segments`
GROUP BY testgroup, segment
ORDER BY testgroup, segment;
