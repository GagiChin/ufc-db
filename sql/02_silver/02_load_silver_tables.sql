
-- insert into silver_fighter_details from bronze_raw_fighter_details

TRUNCATE TABLE silver_fighter_details;

INSERT INTO silver_fighter_details (
	fighter_id, name, nick_name, stance,
    dob, wins, losses, draws, height_cm,
    weight_kg, reach_cm
) 
SELECT
	TRIM(id) AS fighter_id,
    TRIM(name) AS name,
    NULLIF(TRIM(nick_name), '') AS nick_name,
    NULLIF(TRIM(stance), '') AS stance,
    STR_TO_DATE(NULLIF(TRIM(dob), ''), '%M %e, %Y') AS dob,
    CAST(NULLIF(TRIM(wins), '') AS SIGNED) AS wins,
    CAST(NULLIF(TRIM(losses), '') AS SIGNED) AS losses,
    CAST(NULLIF(TRIM(draws), '') AS SIGNED) AS draws,
    CAST(NULLIF(TRIM(height), '') AS DECIMAL(5,2)) AS height_cm,
  CAST(NULLIF(TRIM(weight), '') AS DECIMAL(7,2)) AS weight_kg,
  CAST(NULLIF(TRIM(reach), '')  AS DECIMAL(5,2)) AS reach_cm
FROM ufc_bronze.bronze_raw_fighter_details;

-- insert into silver_event_details from bronze_raw_event_details

TRUNCATE TABLE silver_event_details;

INSERT INTO silver_event_details (event_id, event_date, location)
SELECT 
	TRIM(event_id) AS event_id,
    STR_TO_DATE(NULLIF(TRIM(date), ''), '%M %e, %Y') AS event_date,
    NULLIF(TRIM(location), '') AS location
FROM ufc_bronze.bronze_raw_event_details
GROUP BY 1,2,3;

-- insert into silver_fight_result
TRUNCATE TABLE silver_fight_result;

INSERT INTO silver_fight_result (fight_id, event_id, winner_id, winner_name)
SELECT
	TRIM(fight_id) AS fight_id,
    TRIM(event_id) AS event_id,
    NULLIF(TRIM(winner_id), '') AS winner_id,
    NULLIF(TRIM(winner), '') AS winner_name
FROM ufc_bronze.bronze_raw_event_details;

-- insert into silver_fight_details

TRUNCATE TABLE silver_fight_details;

INSERT INTO silver_fight_details (
  fight_id, event_id, event_name,
  division, title_fight, method, finish_round, total_rounds, match_time_sec, referee,
  red_fighter_id, red_fighter_name, blue_fighter_id, blue_fighter_name,
  winner_id, winner_name
)
SELECT
	TRIM(fd.fight_id) AS fight_id,
	TRIM(fd.event_id) AS event_id,
	NULLIF(TRIM(fd.event_name), '') AS event_name,
	NULLIF(TRIM(fd.division), '') AS division,
    CAST(NULLIF(TRIM(fd.title_fight), '') AS UNSIGNED) AS title_fight,
    NULLIF(TRIM(fd.method), '') AS method,
	CAST(ROUND(CAST(NULLIF(TRIM(fd.finish_round), '') AS DECIMAL(5,2))) AS UNSIGNED),
    CAST(ROUND(CAST(NULLIF(TRIM(fd.total_rounds), '') AS DECIMAL(5,2))) AS UNSIGNED),
    CAST(ROUND(CAST(NULLIF(TRIM(fd.match_time_sec), '') AS DECIMAL(10,2))) AS UNSIGNED),
    NULLIF(TRIM(fd.referee), '') AS referee,
    
	NULLIF(TRIM(fd.r_id), '') AS red_fighter_id,
	NULLIF(TRIM(fd.r_name), '') AS red_fighter_name,
	NULLIF(TRIM(fd.b_id), '') AS blue_fighter_id,
	NULLIF(TRIM(fd.b_name), '') AS blue_fighter_name,
    
	fr.winner_id,
	fr.winner_name

FROM ufc_bronze.bronze_raw_fight_details fd
LEFT JOIN ufc_silver.silver_fight_result fr
  ON fr.fight_id = TRIM(fd.fight_id);






    
    
