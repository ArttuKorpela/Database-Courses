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
)PARTITION by RANGE (freight);

CREATE TABLE orders_freight_1 PARTITION OF Orders FOR VALUES FROM ('0.00') TO ('250.00');
CREATE TABLE orders_freight_2 PARTITION OF Orders FOR VALUES FROM ('250.01') TO ('500.00');
CREATE TABLE orders_freight_3 PARTITION OF Orders FOR VALUES FROM ('500.01') TO ('750.00');
CREATE TABLE orders_freight_4 PARTITION OF Orders FOR VALUES FROM ('750.01') TO ('1100');
