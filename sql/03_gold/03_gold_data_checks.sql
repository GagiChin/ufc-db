USE ufc_gold;


-- Check row count across Gold tables
-- fact_fighter_bout should be 2 * fact_bout
SELECT 'dim_fighter' tbl, COUNT(*) cnt FROM dim_fighter
UNION ALL SELECT 'dim_event', COUNT(*) FROM dim_event
UNION ALL SELECT 'dim_date', COUNT(*) FROM dim_date
UNION ALL SELECT 'fact_bout', COUNT(*) FROM fact_bout
UNION ALL SELECT 'fact_fighter_bout', COUNT(*) FROM fact_fighter_bout;

-- Each fighter has exatly tow fighter rows
SELECT bout_key, COUNT(*) AS rows_per_bout
FROM fact_fighter_bout
GROUP BY bout_key
HAVING COUNT(*) <> 2;

-- winner must be red/blue or NULL
SELECT COUNT(*) AS invalid_result
FROM fact_bout
WHERE winner_fighter_key IS NOT NULL
AND winner_fighter_key NOT IN (red_fighter_key, blue_fighter_key);


-- every date exists in dim_date
SELECT COUNT(*) AS events_missing_date_dim
FROM dim_event e
LEFT JOIN dim_date d
ON d.full_date = e.event_date
WHERE d.date_key IS NOT NULL AND d.date_key IS NULL;

-- null/blank natural keys
SELECT
  SUM(bout_id IS NULL OR bout_id = '') AS null_bout_id,
  SUM(event_key IS NULL) AS null_event_key,
  SUM(red_fighter_key IS NULL) AS null_red_key,
  SUM(blue_fighter_key IS NULL) AS null_blue_key
FROM fact_bout;







