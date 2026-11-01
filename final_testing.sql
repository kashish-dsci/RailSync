
USE railsync;

-- =====================================
-- 1. DISPLAY ALL DATABASE TABLES
-- =====================================

SHOW TABLES;

-- =====================================
-- 2. DISPLAY TRAIN DETAILS
-- =====================================

SELECT * FROM trains;

-- =====================================
-- 3. DISPLAY PASSENGER DETAILS
-- =====================================

SELECT * FROM passengers;

-- =====================================
-- 4. DISPLAY BOOKING DETAILS
-- =====================================

SELECT * FROM bookings;

-- =====================================
-- 5. DISPLAY PAYMENT DETAILS
-- =====================================

SELECT * FROM payments;

-- =====================================
-- 6. TEST FARE CALCULATION FUNCTION
-- =====================================

SELECT calculate_fare(1) AS Ticket_Fare;

-- =====================================
-- 7. TEST BOOKING CURSOR
-- =====================================

CALL display_bookings();

-- =====================================
-- 8. CHECK AVAILABLE SEATS
-- =====================================

SELECT
    train_id,
    train_name,
    total_seats,
    available_seats
FROM trains;

-- =====================================
-- 9. BOOKING PROCEDURE TEST
-- Run separately when you want to test a new booking.
-- Example: CALL book_ticket(1, 1);
-- =====================================

-- =====================================
-- 10. CANCELLATION PROCEDURE TEST
-- Run separately using an existing booking ID.
-- Example: CALL cancel_ticket(1);
-- =====================================
