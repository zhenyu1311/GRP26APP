CREATE TABLE IF NOT EXISTS users (
  full_name VARCHAR(64) NOT NULL,
  username VARCHAR(32) UNIQUE NOT NULL,
  email VARCHAR(64) PRIMARY KEY,
  phone_number VARCHAR(64) NOT NULL,
  password VARCHAR(128) NOT NULL,
  type VARCHAR(64) NOT NULL
);

CREATE TABLE IF NOT EXISTS member (
  email VARCHAR(64) REFERENCES users(email)
  ON UPDATE CASCADE 
  ON DELETE CASCADE
  DEFERRABLE INITIALLY DEFERRED
  NOT NULL
);

CREATE TABLE IF NOT EXISTS administrator (
  email VARCHAR(64) REFERENCES users (email)
  ON UPDATE CASCADE
  ON DELETE CASCADE
  DEFERRABLE INITIALLY DEFERRED
  NOT NULL
);

CREATE TABLE IF NOT EXISTS activity (
  activity_id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  driver VARCHAR(64) REFERENCES users(email)
  	ON UPDATE CASCADE 
	ON DELETE CASCADE
  	DEFERRABLE INITIALLY DEFERRED
	NOT NULL,
  start_point VARCHAR(128) NOT NULL,
  start_date_time TIMESTAMP NOT NULL,
  destination VARCHAR(128) NOT NULL,
  price NUMERIC NOT NULL,
  capacity INTEGER NOT NULL CHECK (capacity >= 2 AND capacity <= 6)
);

CREATE TABLE IF NOT EXISTS joins (
  activity_id INT REFERENCES activity(activity_id) NOT NULL,
  passenger VARCHAR(64) REFERENCES users(email) NOT NULL,
  PRIMARY KEY (activity_id,passenger)
);

CREATE TABLE IF NOT EXISTS review (
  activity_id INT REFERENCES activity(activity_id) NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  passenger VARCHAR(64) REFERENCES users(email) NOT NULL,
  rating INT NOT NULL,
  comment VARCHAR(4096) NOT NULL,
  PRIMARY KEY (activity_id,timestamp,passenger)
);

CREATE TABLE IF NOT EXISTS report (
  submitter VARCHAR(64) REFERENCES users(email) NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  report_user VARCHAR(64) REFERENCES users(email) NOT NULL,
  comment VARCHAR(4096) NOT NULL,
  severity VARCHAR(6) NOT NULL CHECK (severity = 'low' OR severity = 'medium' OR severity = 'high'),
  PRIMARY KEY (submitter,timestamp)
);

CREATE TABLE IF NOT EXISTS random_comments (
	comment VARCHAR(4096) PRIMARY KEY UNIQUE
); 

CREATE TABLE IF NOT EXISTS random_report (
	comment VARCHAR(4096) PRIMARY KEY
); 

CREATE TABLE IF NOT EXISTS requests(
	username VARCHAR(64) PRIMARY KEY ,
	reason VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS category (
  category VARCHAR(32) PRIMARY KEY);
