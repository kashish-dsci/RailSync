USE railsync;

DROP FUNCTION IF EXISTS calculate_fare;

DELIMITER $$

CREATE FUNCTION calculate_fare(p_train_id INT)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_fare DECIMAL(10,2);

    SELECT fare
    INTO v_fare
    FROM trains
    WHERE train_id = p_train_id;

    RETURN v_fare;
END $$

DELIMITER ;

SELECT calculate_fare(1) AS Ticket_Fare;
