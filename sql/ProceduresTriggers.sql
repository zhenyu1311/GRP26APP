CREATE OR REPLACE PROCEDURE add_new_member(full_name VARCHAR,
										   username VARCHAR,
										   email VARCHAR,
										   phone_number VARCHAR,
										   password VARCHAR) AS $$
BEGIN
	INSERT INTO users VALUES (full_name,username,email,phone_number,password,'member');
	INSERT INTO member VALUES (email);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE add_new_member(full_name VARCHAR,
										   username VARCHAR,
										   email VARCHAR,
										   phone_number VARCHAR,
										   password VARCHAR) AS $$
BEGIN
	INSERT INTO users VALUES (full_name,username,email,phone_number,password,'member');
	INSERT INTO member VALUES (email);
END
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE create_new_activity(u_email VARCHAR,
											   u_price VARCHAR,
												u_start_point VARCHAR,
											   u_start_date_time TIMESTAMP,
											   u_destination VARCHAR,
											   u_capacity INTEGER) AS $$
DECLARE
	id INTEGER;
BEGIN
	INSERT INTO activity (driver,price,start_point,start_date_time,destination,capacity) VALUES (u_email,u_price,u_start_point,u_start_date_time,u_destination,u_capacity)
	RETURNING activity_id INTO id;
	INSERT INTO joins (activity_id,passenger) VALUES (id,u_email);
END
$$ LANGUAGE plpgsql;

----- capacity trigger for joins

CREATE OR REPLACE FUNCTION check_capacity_func() RETURNS TRIGGER AS $$
DECLARE
	curr_participation INTEGER;
	activity_capacity INTEGER;
BEGIN
	SELECT COUNT(*) INTO curr_participation
	FROM joins j
	WHERE j.activity_id = NEW.activity_id;
	
	SELECT capacity INTO activity_capacity
	FROM activity a
	WHERE a.activity_id = NEW.activity_id;
	
	IF activity_capacity - curr_participation<1 THEN
		RAISE EXCEPTION 'Maximum capacity for activity reached.';
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_capacity
BEFORE INSERT OR UPDATE
ON joins
FOR EACH ROW 
EXECUTE FUNCTION check_capacity_func();


----trigger to check validity of review

CREATE OR REPLACE FUNCTION check_review_func() RETURNS TRIGGER AS $$
DECLARE 
	passenger VARCHAR;
	activity_happened NUMERIC;
BEGIN
	SELECT j.passenger INTO passenger
	FROM joins j 
	WHERE j.activity_id = NEW.activity_id 
	AND j.passenger = NEW.passenger;
	
	SELECT a.activity_id INTO activity_happened
	FROM activity a 
	WHERE a.activity_id = NEW.activity_id
	AND a.start_date_time < NOW();
	
	IF passenger IS NULL THEN
		RAISE EXCEPTION 'You did not register for this event, 
		hence you are not eligible to give a review.';
		RETURN NULL;
	ELSIF activity_happened IS NULL THEN
		RAISE EXCEPTION 'Event has not happened, hence you cannot give a review';
		RETURN NULL;
	ELSE
		RETURN NEW;
	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER check_review
BEFORE INSERT OR UPDATE
ON review
FOR EACH ROW 
EXECUTE FUNCTION check_review_func();


CREATE OR REPLACE PROCEDURE become_admin(
										   username VARCHAR,
										   reason VARCHAR) AS $$
BEGIN
	INSERT INTO requests VALUES (username,reason);
END
$$ LANGUAGE plpgsql;							  
							  
							  
							  
							  
