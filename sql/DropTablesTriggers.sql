DROP TRIGGER IF EXISTS check_review ON review;
DROP TRIGGER IF EXISTS check_capacity ON joins;


DROP PROCEDURE IF EXISTS create_new_activity(u_email VARCHAR,
									u_activity_name VARCHAR,
									u_category VARCHAR,
									u_start_date_time TIMESTAMP,
									u_venue VARCHAR,
									u_capacity INTEGER);
DROP FUNCTION IF EXISTS check_review_func();
DROP FUNCTION IF EXISTS check_capacity_func();
DROP PROCEDURE IF EXISTS add_new_member(full_name VARCHAR,username VARCHAR,
							  email VARCHAR,phone_number VARCHAR,
							  password VARCHAR);



DROP TABLE IF EXISTS joins;
DROP TABLE IF EXISTS report;
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS activity;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS administrator;
DROP TABLE IF EXISTS member;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS random_comments;
DROP TABLE IF EXISTS random_report;
DROP TABLE IF EXISTS requests;
