USE ufc_gold;

START TRANSACTION;



INSERT INTO dim_fighter (
    fighter_id, fighter_name, nick_name, stance, dob,
    height_cm, reach_cm, weight_kg
)
SELECT
    s.fighter_id,
    s.name AS fighter_name,
    s.nick_name,
    s.stance,
    s.dob,
    s.height_cm,
    s.reach_cm,
    s.weight_kg
FROM ufc_silver.silver_fighter_details s;


INSERT INTO dim_event (event_id, event_date, location)
SELECT
    e.event_id,
    e.event_date,
    e.location
FROM ufc_silver.silver_event_details e;


INSERT INTO dim_date (
    date_key, full_date, year, quarter, month, month_name,
    day_of_month, day_of_week, day_name, is_weekend
)
SELECT DISTINCT
    CAST(DATE_FORMAT(e.event_date, '%Y%m%d') AS UNSIGNED) AS date_key,
    e.event_date AS full_date,
    YEAR(e.event_date) AS year,
    QUARTER(e.event_date) AS quarter,
    MONTH(e.event_date) AS month,
    MONTHNAME(e.event_date) AS month_name,
    DAY(e.event_date) AS day_of_month,
    DAYOFWEEK(e.event_date) AS day_of_week,         
    DAYNAME(e.event_date) AS day_name,
    CASE WHEN DAYOFWEEK(e.event_date) IN (1,7) THEN 1 ELSE 0 END AS is_weekend
FROM ufc_silver.silver_event_details e
WHERE e.event_date IS NOT NULL;


INSERT INTO fact_bout (
	bout_id,
    event_key,
    event_date_key,
    red_fighter_key,
    blue_fighter_key,
    winner_fighter_key,
    method,
    rounds_scheduled,
    rounds_fought,
    fight_duration_sec
)
SELECT
	fd.fight_id AS bout_id,
    de.event_key,
    CAST(DATE_FORMAT(se.event_date, '%Y%m%d') AS UNSIGNED) AS event_date_key,
    
	rf.fighter_key AS red_fighter_key,
    bf.fighter_key AS blue_fighter_key,
	wf.fighter_key AS winner_fighter_key,

	fd.method,
    fd.total_rounds AS rounds_scheduled,
    fd.finish_round AS rounds_fought,
    fd.match_time_sec AS fight_duration_sec

FROM ufc_silver.silver_fight_details fd
JOIN ufc_silver.silver_event_details se
ON se.event_id = fd.event_id
JOIN dim_event de
ON de.event_id = fd.event_id
JOIN dim_fighter rf  -- for red corner
ON rf.fighter_id = fd.red_fighter_id
JOIN dim_fighter bf  -- for blue corner
ON bf.fighter_id = fd.blue_fighter_id
LEFT JOIN dim_fighter wf -- for winner 
ON wf.fighter_id = fd.winner_id;



INSERT INTO fact_fighter_bout (
	bout_key,
    fighter_key,
    opponent_fighter_key,
    event_key,
    event_date_key,
    is_win,
    is_loss,
    corner
)
-- RED
SELECT
	b.bout_key,
    b.red_fighter_key AS fighter_key,
    b.blue_fighter_key AS opponent_fighter_key,
    b.event_key,
    b.event_date_key,
    
    CASE WHEN b.winner_fighter_key IS NOT NULL 
		AND b.winner_fighter_key = b.red_fighter_key THEN 1 ELSE 0 END AS is_win,
        
    CASE WHEN b.winner_fighter_key IS NOT NULL 
		AND b.winner_fighter_key <> b.red_fighter_key THEN 1 ELSE 0 END AS is_loss,
	
    'RED' AS corner
FROM fact_bout b

UNION ALL

-- BLUE

SELECT
	b.bout_key,
    b.blue_fighter_key AS fighter_key,
    b.red_fighter_key AS opponent_fighter_key,
    b.event_key,
    b.event_date_key,
    
    CASE WHEN b.winner_fighter_key IS NOT NULL 
		AND b.winner_fighter_key = b.blue_fighter_key THEN 1 ELSE 0 END AS is_win,
        
    CASE WHEN b.winner_fighter_key IS NOT NULL 
		AND b.winner_fighter_key <> b.blue_fighter_key THEN 1 ELSE 0 END AS is_loss,
	
    'BLUE' AS corner
FROM fact_bout b;
    
COMMIT;








