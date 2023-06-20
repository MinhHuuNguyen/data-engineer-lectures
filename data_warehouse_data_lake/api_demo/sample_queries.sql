-- Create sample database
CREATE DATABASE sample_db;

-- Create sample schema
CREATE SCHEMA sample_schema;

-- Create sample table
CREATE TABLE sample_schema.sample_table (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INTEGER,
    email VARCHAR(50)
);

-- Insert 100 sample records
INSERT INTO sample_schema.sample_table (name, age, email) VALUES
    ('John Doe', 30, 'johndoe@example.com'),
    ('Jane Smith', 25, 'janesmith@example.com'),
    ('Bob Johnson', 45, 'bobjohnson@example.com'),
    ('Mary Brown', 35, 'marybrown@example.com'),
    ('Tom Lee', 28, 'tomlee@example.com'),
    ('Sue Lee', 26, 'suelee@example.com'),
    ('Mike Davis', 50, 'mikedavis@example.com'),
    ('Lisa Garcia', 42, 'lisagarcia@example.com'),
    ('David Kim', 39, 'davidkim@example.com'),
    ('Sarah Jones', 32, 'sarahjones@example.com'),
    ('Chris Evans', 31, 'chrisevans@example.com'),
    ('Linda Johnson', 48, 'lindajohnson@example.com'),
    ('Peter Smith', 37, 'petersmith@example.com'),
    ('Karen Chen', 29, 'karenchen@example.com'),
    ('Paul Wilson', 44, 'paulwilson@example.com'),
    ('Amy Brown', 27, 'amybrown@example.com'),
    ('Bill Lee', 36, 'billlee@example.com'),
    ('Cindy Chen', 33, 'cindychen@example.com'),
    ('Tom Brown', 41, 'tombrown@example.com'),
    ('Emily Davis', 24, 'emilydavis@example.com'),
    ('Steve Kim', 47, 'stevekim@example.com'),
    ('Julia Wilson', 38, 'juliawilson@example.com'),
    ('George Brown', 49, 'georgebrown@example.com'),
    ('Grace Kim', 23, 'gracekim@example.com'),
    ('Eric Davis', 40, 'ericdavis@example.com'),
    ('Megan Chen', 31, 'meganchen@example.com'),
    ('Ken Wilson', 46, 'kenwilson@example.com'),
    ('Diana Lee', 22, 'dianalee@example.com'),
    ('Adam Brown', 34, 'adambrown@example.com'),
    ('Stephanie Kim', 30, 'stephaniekim@example.com'),
    ('Frank Smith', 43, 'franksmith@example.com'),
    ('Jenny Chen', 28, 'jennychen@example.com'),
    ('Richard Davis', 51, 'richarddavis@example.com'),
    ('Tina Lee', 25, 'tinalee@example.com'),
    ('James Wilson', 42, 'jameswilson@example.com'),
    ('Kelly Johnson', 36, 'kellyjohnson@example.com'),
    ('Tim Brown', 33, 'timbrown@example.com'),
    ('Julie Kim', 29, 'juliekim@example.com'),
    ('Mark Davis', 45, 'markdavis@example.com'),
    ('Sophia Lee', 26, 'sophialee@example.com'),
    ('John Smith', 40, 'johnsmith@example.com'),
    ('Carla Johnson', 37, 'carlajohnson@example.com'),
    ('Jack Brown', 30, 'jackbrown@example.com');
