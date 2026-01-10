
-- comparing count from original vs migrated tables
SELECT
  (SELECT COUNT(*) FROM ufc_analytics.bronze_raw_fighter_details) AS src_fighters,
  (SELECT COUNT(*) FROM ufc_bronze.bronze_raw_fighter_details)    AS dst_fighters;

SELECT
  (SELECT COUNT(*) FROM ufc_analytics.bronze_raw_fight_details) AS src_fights,
  (SELECT COUNT(*) FROM ufc_bronze.bronze_raw_fight_details)    AS dst_fights;

SELECT
  (SELECT COUNT(*) FROM ufc_analytics.bronze_raw_event_details) AS src_events,
  (SELECT COUNT(*) FROM ufc_bronze.bronze_raw_event_details)    AS dst_events;
  
  
-- null check  
SELECT COUNT(*) AS dst_event_missing_event_id
FROM ufc_bronze.bronze_raw_event_details
WHERE event_id IS NULL OR event_id = '';

SELECT COUNT(*) AS dst_fight_missing_fight_id
FROM ufc_bronze.bronze_raw_fight_details
WHERE fight_id IS NULL OR fight_id = '';

SELECT COUNT(*) AS dst_event_winner_id_has_cr
FROM ufc_bronze.bronze_raw_event_details
WHERE winner_id LIKE '%\r%';
