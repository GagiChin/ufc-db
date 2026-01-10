USE ufc_silver;
-- table silver_fighter_details
DROP TABLE IF EXISTS silver_fighter_details;

CREATE TABLE silver_fighter_details (
	fighter_id VARCHAR(70) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    nick_name VARCHAR(255),
    stance VARCHAR(50),
    dob DATE,
    wins INT,
    losses INT,
    draws INT,
    height_cm DECIMAL(5,2),
    weight_kg DECIMAL(7,2),
    reach_cm DECIMAL(5,2),
    
    INDEX ix_fighter_name (name)
);


-- table silver_event_details

DROP TABLE IF EXISTS silver_event_details;

CREATE TABLE silver_event_details (
	event_id VARCHAR(70) PRIMARY KEY,
	event_date DATE,
	location VARCHAR(255),

	INDEX ix_event_date (event_date),
	INDEX ix_event_location (location)
);

-- results table

DROP TABLE IF EXISTS silver_fight_result;

CREATE TABLE silver_fight_result (
	fight_id VARCHAR(70) PRIMARY KEY,
    event_id VARCHAR(70),
    winner_id VARCHAR(70),
    winner_name VARCHAR(200),
    
    INDEX ix_result_event (event_id),
    INDEX ix_result_winner (winner_id)
);

-- create silver_fight_details
DROP TABLE IF EXISTS silver_fight_details;

CREATE TABLE silver_fight_details (
	fight_id VARCHAR(70) PRIMARY KEY,
    event_id VARCHAR(70),
    event_name VARCHAR(70),
    division VARCHAR(100),
    title_fight TINYINT NOT NULL DEFAULT 0,
    method VARCHAR(200),
    finish_round INT,
    total_rounds INT,
    match_time_sec INT,
    referee VARCHAR(200),
    
    red_fighter_id VARCHAR(70),
    red_fighter_name VARCHAR(200),
	blue_fighter_id VARCHAR(70),
    blue_fighter_name VARCHAR(200),
    
	winner_id VARCHAR(70) NULL,
	winner_name VARCHAR(200) NULL,

	INDEX ix_fight_event (event_id),
	INDEX ix_fight_red (red_fighter_id),
	INDEX ix_fight_blue (blue_fighter_id),
	INDEX ix_fight_winner (winner_id)
);
    
    
    
    

