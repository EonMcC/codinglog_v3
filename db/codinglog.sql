DROP TABLE languages;
DROP TABLE timer;

CREATE TABLE languages (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  log_time FLOAT(10)
);

CREATE TABLE timer (
  id SERIAL8 PRIMARY KEY,
  started BOOLEAN,
  start_time FLOAT,
  stop_time FLOAT,
  elapsed_time FLOAT
);
