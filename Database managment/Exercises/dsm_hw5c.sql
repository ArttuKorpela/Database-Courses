CREATE FUNCTION hw5_get_shipping_info(n varchar) 
RETURNS TABLE (orderid int, shipname varchar, shipaddress varchar, shipcity varchar, shipcountry varchar) 
AS
'
BEGIN
   RETURN QUERY SELECT Orders.orderid, Orders.shipname, Orders.shipaddress, Orders.shipcity, Orders.shipcountry
   FROM Orders WHERE Orders.shipname = n;
END;
' 
LANGUAGE plpgsql;