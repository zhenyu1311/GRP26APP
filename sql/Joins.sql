INSERT INTO joins (activity_id, passenger) 
(
	(
		SELECT activity_id, driver 
		FROM activity
	)
	UNION
	(
		SELECT a.activity_id, u.email
 		FROM activity a, users u
		WHERE u.email <> a.driver
		ORDER BY RANDOM()
		LIMIT (SELECT COUNT(*) FROM activity)
	)
);
