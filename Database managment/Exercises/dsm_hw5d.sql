CREATE FUNCTION hw5_get_shipping_info(n varchar, t TIMESTAMP, m MONEY) 
RETURNS TABLE (orderid int, shipname varchar, shipaddress varchar, shipcity varchar, shipcountry varchar) 
AS
'
BEGIN
   RETURN QUERY SELECT Orders.orderid, Orders.shipname, Orders.shipaddress, Orders.shipcity, Orders.shipcountry
   FROM Orders WHERE Orders.shipname = n AND
   Orders.orderdate <= t AND
   ((Orders.freight - m)::numeric::int <= 10) AND ((Orders.freight - m)::numeric::int >= -10);
END;
' 
LANGUAGE plpgsql;