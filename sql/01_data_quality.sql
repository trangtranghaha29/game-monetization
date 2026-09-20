-- 1_data_quality.sql
SELECT
    COUNT(*) as total_rows,
    COUNT(DISTINCT user_id) as unique_users,
    COUNTIF(user_id IS NULL) as null_user_id,
    COUNTIF(revenue IS NULL) as null_revenue,
    COUNTIF(testgroup IS NULL) as null_testgroup,
    COUNTIF(revenue < 0) as negative_revenue,
    MIN(revenue) as min_revenue,
    MAX(revenue) as max_revenue
FROM `project-2-507310.game_analystics.ab_test`;

-- đổi tên
CREATE OR REPLACE VIEW `project-2-507310.game_analystics.ab_test_labeled` as
SELECT
    user_id,
    revenue,
    CASE testgroup
        WHEN 'a' THEN 'control'
        WHEN 'b' THEN 'test'    
    END AS testgroup
FROM `project-2-507310.game_analystics.ab_test`;


-- 3. kiểm tra số lượng
SELECT
    testgroup,
    COUNT(*) as players,
    COUNTIF(revenue > 0) as paying_players
FROM `project-2-507310.game_analystics.ab_test_labeled`
GROUP BY testgroup
ORDER BY testgroup;