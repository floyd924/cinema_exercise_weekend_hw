DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds VARCHAR(255)
);


CREATE TABLE films(
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE screenings(
  id SERIAL8 PRIMARY KEY,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  show_time INT,
  tickets_available INT
);

CREATE TABLE tickets(
  id SERIAL8 PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  screening_id INT REFERENCES screenings(id) ON DELETE CASCADE
);
