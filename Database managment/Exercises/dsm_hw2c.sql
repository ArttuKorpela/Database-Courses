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
)PARTITION by LIST (empid);

CREATE TABLE orders_emp_1 PARTITION OF Orders FOR VALUES IN (1,2,3);
CREATE TABLE orders_emp_2 PARTITION OF Orders FOR VALUES IN (4,5,6);
CREATE TABLE orders_emp_3 PARTITION OF Orders FOR VALUES IN (7,8,9);
