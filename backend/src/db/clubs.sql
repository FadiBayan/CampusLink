DELIMITER $$

CREATE PROCEDURE GetClub(crn_input INT)
BEGIN

    SELECT * FROM Clubs WHERE crn = crn_input;

END$$

-- @block

CREATE FUNCTION CheckClubExists(crn_input INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE club_exists INT;

    SELECT EXISTS(SELECT 1 FROM Clubs WHERE crn = crn_input LIMIT 1) INTO club_exists;

    RETURN club_exists;

END$$

-- Club password queries

CREATE FUNCTION CheckClubPassHash (crn_input INT, password_hash_input VARCHAR(255))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE user_pass_hash VARCHAR(255);

    SELECT password_hash FROM Clubs WHERE crn = crn_input INTO user_pass_hash;

    RETURN IF(user_pass_hash = password_hash_input, 1, 0);

END$$

DELIMITER ;