INSERT INTO review (activity_id,timestamp,participant,rating,comment)
SELECT DISTINCT j.activity_id, (a.start_date_time + '8 hours' + RANDOM() * (NOW()-a.start_date_time)) AS random_timestamp, j.participant, ROUND(RANDOM()*(5-4)+4) AS random_rating, rc.comment
FROM joins j, activity a, random_comments rc
WHERE j.activity_id = a.activity_id
AND a.start_date_time < NOW()
AND j.participant <> a.inviter
AND j.activity_id IN (
	SELECT j1.activity_id
	FROM joins j1
	GROUP BY j1.activity_id
	HAVING COUNT(*) > 1
)
LIMIT (
	SELECT COUNT(*)
	FROM (
		SELECT j2.activity_id, a2.start_date_time, j2.participant
		FROM joins j2, activity a2
		WHERE j2.activity_id = a2.activity_id
		AND a2.start_date_time < NOW()
		AND j2.participant <> a2.inviter
		AND j2.activity_id IN (
			SELECT j3.activity_id
			FROM joins j3
			GROUP BY j3.activity_id
			HAVING COUNT(*) > 1
		)
	) AS past_joined_by_many
);