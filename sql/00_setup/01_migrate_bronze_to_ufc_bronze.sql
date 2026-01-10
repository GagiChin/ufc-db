
-- figher details
DROP TABLE IF EXISTS ufc_bronze.bronze_raw_fighter_details;
CREATE TABLE ufc_bronze.bronze_raw_fighter_details
LIKE ufc_analytics.bronze_raw_fighter_details;

INSERT INTO ufc_bronze.bronze_raw_fighter_details
SELECT * FROM ufc_analytics.bronze_raw_fighter_details;

-- fight_details
DROP TABLE IF EXISTS ufc_bronze.bronze_raw_fight_details;
CREATE TABLE ufc_bronze.bronze_raw_fight_details
LIKE ufc_analytics.bronze_raw_fight_details;

INSERT INTO ufc_bronze.bronze_raw_fight_details
SELECT * FROM ufc_analytics.bronze_raw_fight_details;

-- event details
DROP TABLE IF EXISTS ufc_bronze.bronze_raw_event_details;
CREATE TABLE ufc_bronze.bronze_raw_event_details
LIKE ufc_analytics.bronze_raw_event_details;

INSERT INTO ufc_bronze.bronze_raw_event_details
SELECT * FROM ufc_analytics.bronze_raw_event_details;

