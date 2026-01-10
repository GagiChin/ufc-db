USE ufc_analytics;

-- check for nulls
SELECT COUNT(*)
FROM bronze_raw_event_details
WHERE event_id IS NULL OR event_id = '';

SELECT COUNT(*)
FROM bronze_raw_fight_details
WHERE fight_id IS NULL OR fight_id = '';

SELECT COUNT(*)
FROM bronze_raw_fighter_details
WHERE id IS NULL OR id = '';

-- check if ignore line 1 worked
SELECT COUNT(*) 
FROM bronze_raw_event_details
WHERE event_id = 'event_id' OR fight_id = 'fight_id';

SELECT COUNT(*)
FROM bronze_raw_fight_details
WHERE event_id = 'event_id' OR fight_id = 'fight_id';

SELECT COUNT(*)
FROM bronze_raw_fighter_details
WHERE id = 'id' OR name = 'name';


-- check for duplicates, if rows_total > distinct_id then duplicates exist --

SELECT
  COUNT(*) AS rows_total,
  COUNT(DISTINCT id) AS distinct_fighter_id
FROM bronze_raw_fighter_details;

SELECT
  COUNT(*) AS rows_total,
  COUNT(DISTINCT fight_id) AS distinct_fight_id
FROM bronze_raw_fight_details;

SELECT
  COUNT(*) AS rows_total,
  COUNT(DISTINCT fight_id) AS distinct_fight_id
FROM bronze_raw_event_details;


-- check first 5 rows from each table--

SELECT * FROM bronze_raw_fighter_details LIMIT 5;
SELECT * FROM bronze_raw_fight_details   LIMIT 5;
SELECT * FROM bronze_raw_event_details   LIMIT 5;