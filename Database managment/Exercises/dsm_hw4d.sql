
ALTER TABLE Orders ADD COLUMN shippedbeforerequired BOOLEAN;

CREATE PROCEDURE hw4d_set_shipped()
LANGUAGE plpgsql
AS 
'
BEGIN
    UPDATE Orders SET shippedbeforerequired =
        CASE
            WHEN shippeddate IS NULL OR requireddate IS NULL THEN false
            ELSE shippeddate <= requireddate
        END;
END;
';