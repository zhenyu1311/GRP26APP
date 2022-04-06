INSERT INTO report (submitter, timestamp, report_user, comment, severity)
(
	SELECT j1.passenger, (a.start_date_time + '8 hours' + RANDOM() * (NOW()-a.start_date_time)) AS random_timestamp, j2.passenger, (SELECT comment FROM random_report ORDER BY RANDOM() LIMIT 1) AS comment, 'low'
	FROM joins j1, joins j2, activity a
	WHERE j1.activity_id = a.activity_id
	AND j2.activity_id = a.activity_id
	AND j1.passenger <> j2.passenger
	ORDER BY RANDOM()
	LIMIT 1
)
UNION
(
	SELECT j1.passenger, (a.start_date_time + '8 hours' + RANDOM() * (NOW()-a.start_date_time)) AS random_timestamp, j2.passenger, (SELECT comment FROM random_report ORDER BY RANDOM() LIMIT 1) AS comment, 'medium'
	FROM joins j1, joins j2, activity a
	WHERE j1.activity_id = a.activity_id
	AND j2.activity_id = a.activity_id
	AND j1.passenger <> j2.passenger
	ORDER BY RANDOM()
	LIMIT 1
)
UNION
(
	SELECT j1.passenger, (a.start_date_time + '8 hours' + RANDOM() * (NOW()-a.start_date_time)) AS random_timestamp, j2.passenger, (SELECT comment FROM random_report ORDER BY RANDOM() LIMIT 1) AS comment, 'high'
	FROM joins j1, joins j2, activity a
	WHERE j1.activity_id = a.activity_id
	AND j2.activity_id = a.activity_id
	AND j1.passenger <> j2.passenger
	ORDER BY RANDOM()
	LIMIT 1
); 
