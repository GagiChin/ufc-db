USE ufc_gold;

-- overall corner advantage when it comes to wins
SELECT corner, 
CONCAT(ROUND(AVG(is_win) * 100, 2), '%') as win_percentage,
COUNT(*) AS fights	
FROM fact_fighter_bout
GROUP BY corner;

SELECT
fb.corner,
COUNT(*) AS total_fights,
SUM(fb.is_win) AS total_wins,
-- finish wins
SUM( 
	CASE 
		WHEN fb.is_win = 1 AND b.method IN ('KO/TKO', 'Submission', "TKO - Doctor''s Stoppage")
        THEN 1 ELSE 0 END) AS finish_wins,
-- decision wins
SUM(
	CASE
		WHEN fb.is_win = 1 AND b.method LIKE '%Decision%' THEN 1 ELSE 0 END) AS decision_wins,

-- finish rate
ROUND(
	SUM( 
		CASE 
			WHEN fb.is_win = 1
            AND b.method IN ('KO/TKO', 'Submission', "TKO - Doctor''s Stoppage")
            THEN 1 ELSE 0 END) *1.0 / NULLIF(SUM(fb.is_win), 0), 2) AS finish_rate 
FROM fact_fighter_bout fb
JOIN fact_bout b
ON fb.bout_key = b.bout_key
GROUP BY fb.corner;

-- why does red corner have an advantage
-- Test whether RED or BLUE corner fighters are,
-- on average, stronger and more experienced.

WITH fighter_career AS (
	SELECT
		fighter_key,
		COUNT(*) AS total_fights,
		AVG(is_win) AS career_win_rate
	FROM fact_fighter_bout
    GROUP BY fighter_key
),

corner_fights AS (
	SELECT
		corner,
        fighter_key,
        opponent_fighter_key
	FROM fact_fighter_bout
)

SELECT 
	cf.corner,
    ROUND(AVG(fc.career_win_rate), 2) AS avg_fighter_win_rate,
    ROUND(AVG(fc.total_fights), 2) AS avg_fighter_total_fights,
    ROUND(AVG(opp_fc.career_win_rate), 4) AS avg_opponent_career_win_rate,
    COUNT(*) AS total_fighter_bouts
    
FROM corner_fights cf
JOIN fighter_career fc
ON cf.fighter_key = fc.fighter_key
JOIN fighter_career opp_fc
ON cf.opponent_fighter_key = opp_fc.fighter_key	
GROUP BY cf.corner;





    