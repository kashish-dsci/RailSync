
-- ==========================================
-- PROJECT: RailSync
-- FILE: procedures.sql
-- PURPOSE: Railway Ticket Booking
-- ==========================================

USE railsync;

DELIMITER $$

CREATE PROCEDURE book_ticket(
    IN p_passenger_id INT,
    IN p_train_id INT
)
BEGIN
    DECLARE v_available INT;
    DECLARE v_total INT;
    DECLARE v_fare DECIMAL(10,2);
    DECLARE v_seat INT DEFAULT 1;
    DECLARE v_count INT DEFAULT 0;
    DECLARE v_booking_id INT;

    -- Rollback if any error occurs
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Check passenger
    SELECT COUNT(*) INTO v_count
    FROM passengers
    WHERE passenger_id = p_passenger_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Passenger does not exist';
    END IF;

    -- Check train
    SELECT COUNT(*) INTO v_count
    FROM trains
    WHERE train_id = p_train_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Train does not exist';
    END IF;

    -- Lock train record and check seats
    SELECT available_seats, total_seats, fare
    INTO v_available, v_total, v_fare
    FROM trains
    WHERE train_id = p_train_id
    FOR UPDATE;

    IF v_available <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No seats available';
    END IF;

    -- Find the lowest available seat number
    SET v_seat = 1;

    seat_search: LOOP

        SELECT COUNT(*) INTO v_count
        FROM bookings
        WHERE train_id = p_train_id
        AND seat_number = v_seat
        AND booking_status = 'CONFIRMED';

        IF v_count = 0 THEN
            LEAVE seat_search;
        END IF;

        SET v_seat = v_seat + 1;

    END LOOP seat_search;

    -- Insert booking
    INSERT INTO bookings
    (passenger_id, train_id, booking_date,
     seat_number, booking_status)
    VALUES
    (p_passenger_id, p_train_id, CURDATE(),
     v_seat, 'CONFIRMED');

    SET v_booking_id = LAST_INSERT_ID();

    -- Reduce available seats
    UPDATE trains
    SET available_seats = available_seats - 1
    WHERE train_id = p_train_id;

    -- Insert payment
    INSERT INTO payments
    (booking_id, amount, payment_date, payment_status)
    VALUES
    (v_booking_id, v_fare, CURDATE(), 'PAID');

    COMMIT;

    SELECT
        v_booking_id AS Booking_ID,
        p_passenger_id AS Passenger_ID,
        p_train_id AS Train_ID,
        v_seat AS Seat_Number,
        v_fare AS Ticket_Fare,
        'CONFIRMED' AS Booking_Status;

END $$

DELIMITER ;

-- ==========================================
-- END OF BOOKING PROCEDURE
-- ==========================================
