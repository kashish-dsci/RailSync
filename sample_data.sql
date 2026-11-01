
-- ==========================================
-- PROJECT: RailSync
-- FILE: sample_data.sql
-- ==========================================

USE railsync;

-- Insert Train Records

INSERT INTO trains
(train_name, source, destination, total_seats, available_seats, fare)
VALUES
('Shatabdi Express', 'Delhi', 'Chandigarh', 100, 100, 850.00),
('Rajdhani Express', 'Delhi', 'Mumbai', 120, 120, 1500.00),
('Vande Bharat', 'Chandigarh', 'Delhi', 80, 80, 950.00),
('Duronto Express', 'Mumbai', 'Pune', 100, 100, 700.00),
('Intercity Express', 'Delhi', 'Jaipur', 90, 90, 600.00);


-- Insert Passenger Records

INSERT INTO passengers
(passenger_name, age, gender, phone)
VALUES
('Rahul Sharma', 25, 'Male', '9876543210'),
('Priya Verma', 22, 'Female', '9876543211'),
('Amit Kumar', 30, 'Male', '9876543212'),
('Sneha Singh', 24, 'Female', '9876543213'),
('Rohan Gupta', 28, 'Male', '9876543214');


-- Display Train Records

SELECT * FROM trains;


-- Display Passenger Records

SELECT * FROM passengers;

-- ==========================================
-- END OF SAMPLE DATA
-- ==========================================
