-- init.sql

-- Create user and Permissions
CREATE USER 'BeispielUser'@'localhost' IDENTIFIED BY 'BeispielPasswort';





CREATE DATABASE IF NOT EXISTS RetzepteDB;
USE RetzepteDB;

CREATE TABLE IF NOT EXISTS info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    value VARCHAR(255) NOT NULL
);

-- Grant the user rights to create databases
-- GRANT ALL PRIVILEGES ON *.* TO 'BeispielUser'@'%' WITH GRANT OPTION;
-- FLUSH PRIVILEGES;


CREATE DATABASE IF NOT EXISTS RetzepteDB;
USE RetzepteDB;

CREATE TABLE IF NOT EXISTS info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(30) NOT NULL,
    l_name VARCHAR(30) NOT NULL,
    phone_no INT NOT NULL
);
