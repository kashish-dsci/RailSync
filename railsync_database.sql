
-- ==========================================
-- PROJECT: RailSync
-- Smart Railway Reservation and Seat Management System
-- DATABASE: MySQL
-- ==========================================

-- Step 1: Create Database

CREATE DATABASE IF NOT EXISTS railsync;

USE railsync;


-- Step 2: Create TRAINS Table

CREATE TABLE IF NOT EXISTS trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(100) NOT NULL,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    fare DECIMAL(10,2) NOT NULL
);


-- Step 3: Create PASSENGERS Table

CREATE TABLE IF NOT EXISTS passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(15)
);


-- Step 4: Create BOOKINGS Table

CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    train_id INT NOT NULL,
    booking_date DATE NOT NULL,
    seat_number INT,
    booking_status VARCHAR(20) DEFAULT 'CONFIRMED',

    FOREIGN KEY (passenger_id)
    REFERENCES passengers(passenger_id),

    FOREIGN KEY (train_id)
    REFERENCES trains(train_id)
);


-- Step 5: Create PAYMENTS Table

CREATE TABLE IF NOT EXISTS payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'PAID',

    FOREIGN KEY (booking_id)
    REFERENCES bookings(booking_id)
);


-- Step 6: Display All Tables

SHOW TABLES;


-- Step 7: Check Table Structures

DESCRIBE trains;
DESCRIBE passengers;
DESCRIBE bookings;
DESCRIBE payments;

-- ==========================================
-- END OF DATABASE CREATION
-- ==========================================
