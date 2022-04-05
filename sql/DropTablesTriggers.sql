DROP TRIGGER IF EXISTS check_review ON review;
DROP TRIGGER IF EXISTS check_capacity ON joins;


DROP PROCEDURE create_new_activity(u_email VARCHAR,
									u_activity_name VARCHAR,
									u_category VARCHAR,
									u_start_date_time TIMESTAMP,
									u_venue VARCHAR,
									u_capacity INTEGER);
DROP FUNCTION check_review_func();
DROP FUNCTION check_capacity_func();
DROP PROCEDURE add_new_member(full_name VARCHAR,username VARCHAR,
							  email VARCHAR,phone_number VARCHAR,
							  password VARCHAR);



DROP TABLE joins IF EXISTS;
DROP TABLE report IF EXISTS;
DROP TABLE review IF EXISTS;
DROP TABLE report IF EXISTS;
DROP TABLE activity IF EXISTS;
DROP TABLE category IF EXISTS;
DROP TABLE administrator IF EXISTS;
DROP TABLE member IF EXISTS;
DROP TABLE users IF EXISTS;
