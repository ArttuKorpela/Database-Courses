
CREATE PROCEDURE hw4b_add_freight()
LANGUAGE plpgsql
AS
'
BEGIN
UPDATE Orders SET freight = freight*1.10;
END;
';