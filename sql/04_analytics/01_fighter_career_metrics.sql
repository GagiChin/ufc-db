USE ufc_gold;

-- Fighter career summary ( win%, finish%, activity, avg fight duration
SELECT COUNT(*), SUM(fb.is_win), SUM(fb.is_loss),
CONCAT(ROUND(AVG(fb.is_win) * 100, 1), '%') AS win_rate,
CONCAT(
	ROUND(
		SUM(CASE WHEN fb.is_win = 1 AND b.method IN ("KO/TKO", "Submission", "TKO - Doctor's Stoppage") THEN 1 ELSE 0 END)
        / NULLIF(SUM(fb.is_win), 0) *100, 1), '%') AS finish_rate,
CONCAT(ROUND(AVG(b.fight_duration_sec) / 60.0, 2), 'min') AS avg_fight_mins,
MIN(d.full_date) AS first_fight, MAX(d.full_date) AS last_fight,
DATEDIFF(MAX(d.full_date), MIN(d.full_date)) AS days_active

FROM fact_fighter_bout fb
JOIN dim_fighter f
ON fb.fighter_key = f.fighter_key
JOIN dim_date d
ON d.date_key = fb.event_date_key
JOIN fact_bout b
ON b.bout_key = fb.bout_key
WHERE f.fighter_name = 'Tom Aspinall';


-- fight history focusing on a single fighter with all the opponents, results, rounds
WITH cte AS (
SELECT 
	f.fighter_key,
	f.fighter_name,
	fb.opponent_fighter_key,
	fb.is_win,
	fb.is_loss,
    fb.event_date_key,
    b.method,
    b.rounds_scheduled,
    b.rounds_fought
FROM dim_fighter f
JOIN fact_fighter_bout fb
ON f.fighter_key = fb.fighter_key
JOIN fact_bout b
ON b.bout_key = fb.bout_key
WHERE f.fighter_name = 'Jan Blachowicz')

SELECT c.fighter_name, f1.fighter_name AS opponent_name,
CASE
  WHEN c.is_win = 1 THEN CONCAT('won by ', c.method)
  WHEN c.is_loss = 1 THEN CONCAT('lost by ', c.method)
  ELSE 'no winner (draw/NC/unknown)'
END AS result,
c.rounds_scheduled,
c.rounds_fought,
d.full_date AS fight_date
FROM cte c 
JOIN dim_fighter f1
ON c.opponent_fighter_key = f1.fighter_key
JOIN dim_date d
ON c.event_date_key = d.date_key
ORDER BY full_date DESC;











