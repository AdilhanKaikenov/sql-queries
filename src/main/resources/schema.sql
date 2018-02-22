DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS seller CASCADE;
DROP TABLE IF EXISTS "order" CASCADE;
DROP TABLE IF EXISTS city CASCADE;
DROP TABLE IF EXISTS commission CASCADE;

CREATE TABLE public.customer
(
  id            SERIAL PRIMARY KEY NOT NULL,
  customer_name VARCHAR(45)        NOT NULL,
  city          INT                NOT NULL,
  rating        DOUBLE PRECISION   NOT NULL
);
CREATE UNIQUE INDEX customer_id_uindex
  ON public.customer (id);


CREATE TABLE public.seller
(
  id          SERIAL PRIMARY KEY NOT NULL,
  seller_name VARCHAR(45)        NOT NULL,
  city        INT                NOT NULL,
  commission  DOUBLE PRECISION   NOT NULL
);
CREATE UNIQUE INDEX seller_id_uindex
  ON public.seller (id);

CREATE TABLE public."order"
(
  id          SERIAL PRIMARY KEY NOT NULL,
  amount      DECIMAL(15, 2)     NOT NULL,
  order_date  TIMESTAMP          NOT NULL,
  customer_id INT                NOT NULL,
  seller_id   INT                NOT NULL
);
CREATE UNIQUE INDEX order_id_uindex
  ON public."order" (id);

CREATE TABLE public.city
(
  id        SERIAL PRIMARY KEY NOT NULL,
  city_name VARCHAR(45)        NOT NULL
);
CREATE UNIQUE INDEX city_id_uindex
  ON public.city (id);
CREATE UNIQUE INDEX city_name_uindex
  ON public.city (city_name);

CREATE TABLE public.commission
(
  id                     SERIAL PRIMARY KEY NOT NULL,
  seller_id              INT                NOT NULL,
  amount_of_commission DOUBLE PRECISION   NOT NULL,
  date                   TIMESTAMP          NOT NULL
);
CREATE UNIQUE INDEX commission_id_uindex
  ON public.commission (id);

-- examples of using ALTER TABLE
/**
ALTER TABLE customers RENAME TO customer;
ALTER TABLE salespeople RENAME TO seller;
ALTER TABLE orders RENAME TO order;
ALTER TABLE order RENAME COLUMN amt TO amount;
ALTER TABLE order RENAME COLUMN odate TO order_date;
ALTER TABLE order RENAME COLUMN c_id TO customer_id;
ALTER TABLE order RENAME COLUMN s_id TO seller_id;
 */

-- - add check constraint in 'customers' table for 'rating' column to be higher than 0 and less then 10
ALTER TABLE customer
  ADD CONSTRAINT CK_Rating_Higher_0_And_Less_10 CHECK (rating > 0 AND rating < 10);