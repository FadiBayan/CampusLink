DELIMITER $$
-- VERIF TOKEN EXISTENCE
CREATE FUNCTION CheckVerifTokenExists (token_input VARCHAR(50))
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE token_exists INT;

    SELECT EXISTS(SELECT 1 FROM VerificationTokens WHERE token = token_input) INTO token_exists;

    RETURN token_exists;
END$$

-- @block
CREATE PROCEDURE InsertVerifToken (token_input VARCHAR(50), username_input VARCHAR(50))
BEGIN
    INSERT INTO VerificationTokens (token, username)
    VALUES (token_input, username_input);
END$$

-- @block
-- GET USER FROM VERIF TOKEN
CREATE PROCEDURE GetUserFromVerifToken (token_input VARCHAR(50))
BEGIN
    SELECT username FROM VerificationTokens WHERE token = token_input LIMIT 1;
END$$

-- @block
-- This function automatically (1) sets the user's verified to true, (2) removes the verification token from the VerificationTokens table
CREATE PROCEDURE VerifyUser (username_input VARCHAR(50))
BEGIN  
    UPDATE Users SET verified = true WHERE username = username_input;
    DELETE FROM VerificationTokens WHERE username = username_input;
END$$

-- @block
CREATE PROCEDURE DeleteExpiredVerifTokens ()
BEGIN
    DELETE FROM VerificationTokens WHERE expires_at <= CURRENT_TIMESTAMP;
END$$

-- @block
CREATE PROCEDURE DeleteVerifTokenByUser (username_input VARCHAR(50))
BEGIN
    DELETE FROM VerificationTokens WHERE username = username_input;
END$$

DELIMITER ;