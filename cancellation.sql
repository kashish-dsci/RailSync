
-- ==========================================
-- PROJECT: RailSync
-- FILE: cancellation.sql
-- PURPOSE: Railway Ticket Cancellation
-- ==========================================

USE railsync;

DELIMITER $$

CREATE PROCEDURE cancel_ticket(
    IN p_booking_id INT
)
BEGIN
    DECLARE v_train_id INT;
    DECLARE v_status VARCHAR(20);
    DECLARE v_count INT DEFAULT 0;

    -- Handle errors and rollback
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Check booking existence
    SELECT COUNT(*) INTO v_count
    FROM bookings
    WHERE booking_id = p_booking_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Booking does not exist';
    END IF;

    -- Get booking details
    SELECT train_id, booking_status
    INTO v_train_id, v_status
    FROM bookings
    WHERE booking_id = p_booking_id
    FOR UPDATE;

    -- Check whether already cancelled
    IF v_status = 'CANCELLED' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ticket is already cancelled';
    END IF;

    -- Cancel booking
    UPDATE bookings
    SET booking_status = 'CANCELLED'
    WHERE booking_id = p_booking_id;

    -- Update payment status
    UPDATE payments
    SET payment_status = 'REFUNDED'
    WHERE booking_id = p_booking_id;

    -- Increase available seats
    UPDATE trains
    SET available_seats = available_seats + 1
    WHERE train_id = v_train_id;

    COMMIT;

    SELECT
        p_booking_id AS Booking_ID,
        'CANCELLED' AS Booking_Status,
        'REFUNDED' AS Payment_Status;

END $$

DELIMITER ;

-- ==========================================
-- END OF CANCELLATION PROCEDURE
-- ==========================================
