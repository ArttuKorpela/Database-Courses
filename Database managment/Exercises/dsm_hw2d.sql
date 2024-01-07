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

CREATE TABLE orders_1 PARTITION OF orders FOR VALUES FROM ('20060703 00:00:00.000000') TO ('20070205 00:00:00.000000') PARTITION BY LIST (substr(shipcountry,1,1));
CREATE TABLE orders_2 PARTITION OF orders FOR VALUES FROM ('20070205 00:00:00.000000') TO ('20070819 00:00:00.000000') PARTITION BY LIST (substr(shipcountry,1,1));
CREATE TABLE orders_3 PARTITION OF orders FOR VALUES FROM ('20070819 00:00:00.000000') TO ('20080123 00:00:00.000000') PARTITION BY LIST (substr(shipcountry,1,1));
CREATE TABLE orders_4 PARTITION OF orders FOR VALUES FROM ('20080123 00:00:00.000000') TO ('20080507 00:00:00.000000') PARTITION BY LIST (substr(shipcountry,1,1));

CREATE TABLE orders_1_A_H PARTITION OF orders_1 FOR VALUES IN ('A','B','C','D','E','F','G','H');
CREATE TABLE orders_1_I_Q PARTITION OF orders_1 FOR VALUES IN ('I','J','K','L','M','N','O','P','Q');
CREATE TABLE orders_1_R_Z PARTITION OF orders_1 FOR VALUES IN ('R','S','T','U','V','W','Y','X','Z');

CREATE TABLE orders_2_A_H PARTITION OF orders_2 FOR VALUES IN ('A','B','C','D','E','F','G','H');
CREATE TABLE orders_2_I_Q PARTITION OF orders_2 FOR VALUES IN ('I','J','K','L','M','N','O','P','Q');
CREATE TABLE orders_2_R_Z PARTITION OF orders_2 FOR VALUES IN ('R','S','T','U','V','W','Y','X','Z');

CREATE TABLE orders_3_A_H PARTITION OF orders_3 FOR VALUES IN ('A','B','C','D','E','F','G','H');
CREATE TABLE orders_3_I_Q PARTITION OF orders_3 FOR VALUES IN ('I','J','K','L','M','N','O','P','Q');
CREATE TABLE orders_3_R_Z PARTITION OF orders_3 FOR VALUES IN ('R','S','T','U','V','W','Y','X','Z');

CREATE TABLE orders_4_A_H PARTITION OF orders_4 FOR VALUES IN ('A','B','C','D','E','F','G','H');
CREATE TABLE orders_4_I_Q PARTITION OF orders_4 FOR VALUES IN ('I','J','K','L','M','N','O','P','Q');
CREATE TABLE orders_4_R_Z PARTITION OF orders_4 FOR VALUES IN ('R','S','T','U','V','W','Y','X','Z');
