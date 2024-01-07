CREATE TABLE Orders
(
  orderid        INT          NOT NULL,
  custid         INT          NULL,
  empid          INT          NOT NULL,
  orderdate      TIMESTAMP     NOT NULL,
  requireddate   TIMESTAMP     NOT NULL,
  shippeddate    TIMESTAMP     NULL,
  shipperid      INT          NOT NULL,
  freight        MONEY        NOT NULL
    CONSTRAINT DFT_Orders_freight DEFAULT(0),
  shipname       VARCHAR(40) NOT NULL,
  shipaddress    VARCHAR(60) NOT NULL,
  shipcity       VARCHAR(15) NOT NULL,
  shipregion     VARCHAR(15) NULL,
  shippostalcode VARCHAR(10) NULL,
  shipcountry    VARCHAR(15) NOT NULL 
)PARTITION by RANGE (orderdate);

CREATE TABLE orders_1 PARTITION OF orders FOR VALUES FROM ('20060703 00:00:00.000000') TO ('20070205 00:00:00.000000');
CREATE TABLE orders_2 PARTITION OF orders FOR VALUES FROM ('20070205 00:00:00.000000') TO ('20070819 00:00:00.000000');
CREATE TABLE orders_3 PARTITION OF orders FOR VALUES FROM ('20070819 00:00:00.000000') TO ('20080123 00:00:00.000000');
CREATE TABLE orders_4 PARTITION OF orders FOR VALUES FROM ('20080123 00:00:00.000000') TO ('20080507 00:00:00.000000');

