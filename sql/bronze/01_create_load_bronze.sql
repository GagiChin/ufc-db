
-- 1: bronze_raw_fighter_details create and load --
DROP TABLE IF EXISTS bronze_raw_fighter_details;

CREATE TABLE bronze_raw_fighter_details (
  id         VARCHAR(64),
  name       VARCHAR(255),
  nick_name  VARCHAR(255),
  wins       VARCHAR(32),
  losses     VARCHAR(32),
  draws      VARCHAR(32),
  height     VARCHAR(32),
  weight     VARCHAR(32),
  reach      VARCHAR(32),
  stance     VARCHAR(50),
  dob        VARCHAR(32),
  splm       VARCHAR(32),
  str_acc    VARCHAR(32),
  sapm       VARCHAR(32),
  str_def    VARCHAR(32),
  td_avg     VARCHAR(32),
  td_avg_acc VARCHAR(32),
  td_def     VARCHAR(32),
  sub_avg    VARCHAR(32)
);


SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/fighter_details.csv'
INTO TABLE bronze_raw_fighter_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;



-- 2.bronze_raw_fight_details create and load --

DROP TABLE IF EXISTS bronze_raw_fight_details;

CREATE TABLE bronze_raw_fight_details (
  event_name VARCHAR(255),
  event_id VARCHAR(64),
  fight_id VARCHAR(64),

  r_name VARCHAR(255),
  r_id VARCHAR(64),
  b_name VARCHAR(255),
  b_id VARCHAR(64),

  division VARCHAR(128),
  title_fight VARCHAR(16),
  method VARCHAR(255),

  finish_round VARCHAR(16),
  match_time_sec VARCHAR(32),
  total_rounds VARCHAR(16),

  referee VARCHAR(255),

  r_kd VARCHAR(16),
  r_sig_str_landed VARCHAR(16),
  r_sig_str_atmpted VARCHAR(16),
  r_sig_str_acc VARCHAR(16),
  r_total_str_landed VARCHAR(16),
  r_total_str_atmpted VARCHAR(16),
  r_total_str_acc VARCHAR(16),
  r_td_landed VARCHAR(16),
  r_td_atmpted VARCHAR(16),
  r_td_acc VARCHAR(16),
  r_sub_att VARCHAR(16),
  r_ctrl VARCHAR(32),

  r_head_landed VARCHAR(16),
  r_head_atmpted VARCHAR(16),
  r_head_acc VARCHAR(16),
  r_body_landed VARCHAR(16),
  r_body_atmpted VARCHAR(16),
  r_body_acc VARCHAR(16),
  r_leg_landed VARCHAR(16),
  r_leg_atmpted VARCHAR(16),
  r_leg_acc VARCHAR(16),

  r_dist_landed VARCHAR(16),
  r_dist_atmpted VARCHAR(16),
  r_dist_acc VARCHAR(16),
  r_clinch_landed VARCHAR(16),
  r_clinch_atmpted VARCHAR(16),
  r_clinch_acc VARCHAR(16),
  r_ground_landed VARCHAR(16),
  r_ground_atmpted VARCHAR(16),
  r_ground_acc VARCHAR(16),

  r_landed_head_per VARCHAR(32),
  r_landed_body_per VARCHAR(32),
  r_landed_leg_per VARCHAR(32),
  r_landed_dist_per VARCHAR(32),
  r_landed_clinch_per VARCHAR(32),
  r_landed_ground_per VARCHAR(32),

  b_kd VARCHAR(16),
  b_sig_str_landed VARCHAR(16),
  b_sig_str_atmpted VARCHAR(16),
  b_sig_str_acc VARCHAR(16),
  b_total_str_landed VARCHAR(16),
  b_total_str_atmpted VARCHAR(16),
  b_total_str_acc VARCHAR(16),
  b_td_landed VARCHAR(16),
  b_td_atmpted VARCHAR(16),
  b_td_acc VARCHAR(16),
  b_sub_att VARCHAR(16),
  b_ctrl VARCHAR(32),

  b_head_landed VARCHAR(16),
  b_head_atmpted VARCHAR(16),
  b_head_acc VARCHAR(16),
  b_body_landed VARCHAR(16),
  b_body_atmpted VARCHAR(16),
  b_body_acc VARCHAR(16),
  b_leg_landed VARCHAR(16),
  b_leg_atmpted VARCHAR(16),
  b_leg_acc VARCHAR(16),

  b_dist_landed VARCHAR(16),
  b_dist_atmpted VARCHAR(16),
  b_dist_acc VARCHAR(16),
  b_clinch_landed VARCHAR(16),
  b_clinch_atmpted VARCHAR(16),
  b_clinch_acc VARCHAR(16),
  b_ground_landed VARCHAR(16),
  b_ground_atmpted VARCHAR(16),
  b_ground_acc VARCHAR(16),

  b_landed_head_per VARCHAR(32),
  b_landed_body_per VARCHAR(32),
  b_landed_leg_per VARCHAR(32),
  b_landed_dist_per VARCHAR(32),
  b_landed_clinch_per VARCHAR(32),
  b_landed_ground_per VARCHAR(32)
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/fight_details.csv'
INTO TABLE bronze_raw_fight_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;




-- 1: bronze_raw_event_details create and load --


CREATE TABLE bronze_raw_event_details (
  event_id VARCHAR(64),
  fight_id VARCHAR(64),
  `date` VARCHAR(32),
  location VARCHAR(255),
  winner VARCHAR(255),
  winner_id VARCHAR(64)
);



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/event_details.csv'
INTO TABLE bronze_raw_event_details
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

=



