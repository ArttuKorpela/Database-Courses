CREATE PROCEDURE hw4c_round_freight()
LANGUAGE plpgsql
AS
'
BEGIN
UPDATE Orders SET freight = round(CAST(freight AS NUMERIC), -1)::MONEY;
END;
';