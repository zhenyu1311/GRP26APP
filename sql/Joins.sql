INSERT INTO joins (activity_id, participant) 
(
	(
		SELECT activity_id, inviter 
		FROM activity
	)
	UNION
	(
		SELECT a.activity_id, u.email
 		FROM activity a, users u
		WHERE u.email <> a.inviter
		ORDER BY RANDOM()
		LIMIT (SELECT COUNT(*) FROM activity)
	)
);
