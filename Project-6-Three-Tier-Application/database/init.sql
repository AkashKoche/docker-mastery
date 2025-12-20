CREATE DATABASE testdb;
USE testdb;


CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


INSERT INFO users (name) VALUES ('John Doe'), ('Jane Smith');
