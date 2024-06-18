#!/bin/bash
set -e
set -x

# Source the .env file (assuming it's located at /app/.env inside the container)
source /app/.env

# Create SQL statements using environment variables
SQL="
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
USE ${MYSQL_DATABASE};

CREATE TABLE IF NOT EXISTS info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    f_name VARCHAR(30) NOT NULL,
    l_name VARCHAR(30) NOT NULL,
    phone_no INT NOT NULL
);
CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
"

# Output SQL for debugging purposes
echo "SQL: "
echo "${SQL}"

echo "MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}"


# Run the SQL statements using mysql client 
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "${SQL}"