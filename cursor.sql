
-- ==========================================
-- PROJECT: RailSync
-- FILE: cursor.sql
-- PURPOSE: Display Booking Details
-- ==========================================

USE railsync;

DELIMITER $$

CREATE PROCEDURE display_bookings()
BEGIN
    DECLARE v_booking_id INT;
    DECLARE v_passenger_id INT;
    DECLARE v_train_id INT;
    DECLARE v_seat_number INT;
    DECLARE v_status VARCHAR(20);
    DECLARE finished INT DEFAULT 0;

    DECLARE booking_cursor CURSOR FOR
        SELECT booking_id, passenger_id,
               train_id, seat_number, booking_status
        FROM bookings;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET finished = 1;

    OPEN booking_cursor;

    booking_loop: LOOP

        FETCH booking_cursor
        INTO v_booking_id, v_passenger_id,
             v_train_id, v_seat_number, v_status;

        IF finished = 1 THEN
            LEAVE booking_loop;
        END IF;

        SELECT
            v_booking_id AS Booking_ID,
            v_passenger_id AS Passenger_ID,
            v_train_id AS Train_ID,
            v_seat_number AS Seat_Number,
            v_status AS Booking_Status;

    END LOOP;

    CLOSE booking_cursor;

END $$

DELIMITER ;

-- ==========================================
-- END OF CURSOR
-- ==========================================
