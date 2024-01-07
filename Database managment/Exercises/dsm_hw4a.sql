/*create procedure hw4a_add_days(x integer, id1 integer, id2 integer)
language plpgsql 
as 
' 
begin
IF id1 IS NULL THEN
    update 

update Orders set shippeddate = NULL;
commit; 
end; ';*/


CREATE PROCEDURE hw4a_add_days(
    IN p_orderid INTEGER,
    IN p_custid INTEGER,
    IN p_days INTEGER
)
LANGUAGE plpgsql
AS
'
BEGIN
    IF p_orderid IS NOT NULL THEN
        UPDATE Orders SET requireddate = requireddate + INTERVAL ''1'' day * p_days
        WHERE orderid = p_orderid;
    ELSE
        UPDATE Orders SET requireddate = requireddate + INTERVAL ''1'' day * p_days
        WHERE custid = COALESCE(p_custid, custid);
    END IF;
END;
';