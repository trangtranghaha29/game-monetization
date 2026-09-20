-- 1_data_quality.sql
SELECT
    COUNT(*)                   AS total_rows,
    COUNT(DISTINCT user_id)    AS unique_users,
    COUNTIF(user_id IS NULL)   AS null_user_id,
    COUNTIF(revenue IS NULL)   AS null_revenue,
    COUNTIF(testgroup IS NULL) AS null_testgroup,
    COUNTIF(revenue < 0)       AS negative_revenue,
    MIN(revenue)               AS min_revenue,
    MAX(revenue)               AS max_revenue
FROM `project-2-507310.game_analystics.ab_test`;

-- đổi tên
CREATE OR REPLACE VIEW `project-2-507310.game_analystics.ab_test_labeled` AS
SELECT
    user_id,
    revenue,
    CASE testgroup
        WHEN 'a' THEN 'control'   -- Offer A
        WHEN 'b' THEN 'test'      -- Offer B
    END AS testgroup
FROM `project-2-507310.game_analystics.ab_test`;


-- 3. kiểm tra số lượng
SELECT
    testgroup,
    COUNT(*)             AS players,
    COUNTIF(revenue > 0) AS paying_players
FROM `project-2-507310.game_analystics.ab_test_labeled`
GROUP BY testgroup
ORDER BY testgroup;