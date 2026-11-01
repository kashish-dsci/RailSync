
-- ==========================================
-- PROJECT: RailSync
-- FINAL PROJECT TESTING
-- ==========================================

USE railsync;

-- 1. Display all trains
SELECT * FROM trains;

-- 2. Display all passengers
SELECT * FROM passengers;

-- 3. Display all bookings
SELECT * FROM bookings;

-- 4. Display all payments
SELECT * FROM payments;

-- 5. Test fare calculation
SELECT calculate_fare(1) AS Ticket_Fare;

-- 6. Test booking cursor
CALL display_bookings();

-- 7. Check available seats
SELECT train_name, total_seats, available_seats
FROM trains;

-- 8. Check database tables
SHOW TABLES;

-- ==========================================
-- END OF TESTING
-- ==========================================
