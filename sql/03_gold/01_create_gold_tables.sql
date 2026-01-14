USE ufc_gold;


CREATE TABLE dim_fighter (
	fighter_key INT AUTO_INCREMENT PRIMARY KEY,
    fighter_id VARCHAR(70) NOT NULL,
    fighter_name VARCHAR(255) NOT NULL,
    nick_name VARCHAR(255),
    stance VARCHAR(50),
    dob DATE,
    height_cm DECIMAL(5,2),
    reach_cm DECIMAL(5,2),
    weight_kg DECIMAL(7,2),
    
    CONSTRAINT uq_dim_fighter_id UNIQUE (fighter_id),
    INDEX ix_fighter_name (fighter_name)
);

CREATE TABLE dim_event (
	event_key INT AUTO_INCREMENT PRIMARY KEY,
    event_id VARCHAR(70) NOT NULL,
    event_date DATE,
    location VARCHAR(255),
    
    CONSTRAINT uq_dim_event_id UNIQUE (event_id),
    INDEX ix_dim_event_date (event_date)
    
);

CREATE TABLE dim_date (
	date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(30),
    day_of_month INT,
    day_of_week INT,
    day_name VARCHAR(30),
    is_weekend BOOLEAN,
    
    CONSTRAINT uq_dim_date_full_date UNIQUE (full_date)
);

CREATE TABLE fact_bout (
	bout_key INT AUTO_INCREMENT PRIMARY KEY,
    bout_id VARCHAR(70) NOT NULL,
    -- foreign keys
    event_key INT NOT NULL,
    event_date_key INT NOT NULL,
    red_fighter_key INT NOT NULL,
    blue_fighter_key INT NOT NULL,
    winner_fighter_key INT,
    
    method VARCHAR(50),
    rounds_scheduled TINYINT,
    rounds_fought TINYINT,
    fight_duration_sec INT,
    
    CONSTRAINT uq_fact_bout_id UNIQUE (bout_id),
    
    CONSTRAINT fk_bout_event
        FOREIGN KEY (event_key) REFERENCES dim_event(event_key),

    CONSTRAINT fk_bout_date
        FOREIGN KEY (event_date_key) REFERENCES dim_date(date_key),
    
    CONSTRAINT fk_bout_red
        FOREIGN KEY (red_fighter_key) REFERENCES dim_fighter(fighter_key),

    CONSTRAINT fk_bout_blue
        FOREIGN KEY (blue_fighter_key) REFERENCES dim_fighter(fighter_key),

    CONSTRAINT fk_bout_winner
        FOREIGN KEY (winner_fighter_key) REFERENCES dim_fighter(fighter_key),
        
        
	-- Indexes for joins/filters
    INDEX ix_fact_bout_event_key (event_key),
    INDEX ix_fact_bout_event_date_key (event_date_key),
    INDEX ix_fact_bout_red_fighter_key (red_fighter_key),
    INDEX ix_fact_bout_blue_fighter_key (blue_fighter_key),
    INDEX ix_fact_bout_winner_fighter_key (winner_fighter_key),
    INDEX ix_fact_bout_method (method)
    
);
    

CREATE TABLE fact_fighter_bout (
	fighter_bout_key INT AUTO_INCREMENT PRIMARY KEY,
    
    bout_key INT NOT NULL,
    fighter_key INT NOT NULL,
    opponent_fighter_key INT NOT NULL,
    event_key INT NOT NULL,
    event_date_key INT NOT NULL,
	is_win BOOLEAN NOT NULL DEFAULT 0,
    is_loss BOOLEAN NOT NULL DEFAULT 0,
    
	corner ENUM('RED', 'BLUE') NOT NULL,
    
    CONSTRAINT uq_fb_bout_fighter UNIQUE (bout_key, fighter_key),
    CONSTRAINT uq_fb_bout_corner  UNIQUE (bout_key, corner),
    
    CONSTRAINT fk_fb_bout
        FOREIGN KEY (bout_key) REFERENCES fact_bout(bout_key),

    CONSTRAINT fk_fb_fighter
        FOREIGN KEY (fighter_key) REFERENCES dim_fighter(fighter_key),

    CONSTRAINT fk_fb_opponent
        FOREIGN KEY (opponent_fighter_key) REFERENCES dim_fighter(fighter_key),

    CONSTRAINT fk_fb_event
        FOREIGN KEY (event_key) REFERENCES dim_event(event_key),

    CONSTRAINT fk_fb_date
        FOREIGN KEY (event_date_key) REFERENCES dim_date(date_key),
        
        
	INDEX idx_fb_fighter_key (fighter_key),
    INDEX idx_fb_opponent_fighter_key (opponent_fighter_key),
    INDEX idx_fb_event_key (event_key),
    INDEX idx_fb_event_date_key (event_date_key),
    INDEX idx_fb_corner (corner),
    INDEX idx_fb_outcome (is_win, is_loss)
);







    
    
    
    
    
    
    