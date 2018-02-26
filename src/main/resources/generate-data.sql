DROP FUNCTION IF EXISTS insert_order_test_date(INT);
DROP FUNCTION IF EXISTS insert_seller_test_date(INT);
DROP FUNCTION IF EXISTS insert_customer_test_date(INT);

CREATE FUNCTION insert_order_test_date(rowsnumber INT)
  RETURNS VOID AS $$
BEGIN
  FOR i IN 1..rowsnumber LOOP
    INSERT INTO "order"(id, amount, order_date, customer_id, seller_id)
    VALUES(322 + i,i * 2, now(), trunc(random() * (10007-201) + 201), trunc(random() * (100005 - 101) + 101));
  END LOOP;
END;
$$
LANGUAGE 'plpgsql';

CREATE FUNCTION insert_seller_test_date(rowsnumber INT)
  RETURNS VOID AS $$
BEGIN
  FOR i IN 1..rowsnumber LOOP
    INSERT INTO seller(id, seller_name, city, commission)
    VALUES(105 + i, concat('seller_Name', i), trunc(random() * (406-401) + 401), trunc(random() * 100));
  END LOOP;
END;
$$
LANGUAGE 'plpgsql';

CREATE FUNCTION insert_customer_test_date(rowsnumber INT)
  RETURNS VOID AS $$
BEGIN
  FOR i IN 1..rowsnumber LOOP
    INSERT INTO customer(id, customer_name, city, rating)
    VALUES(207 + i, concat('customer_Name', i), trunc(random() * (406-401) + 401), trunc(random() * (5 - 1) + 1));
  END LOOP;
END;
$$
LANGUAGE 'plpgsql';

SELECT insert_order_test_date(100000);
SELECT insert_seller_test_date(100000);
SELECT insert_customer_test_date(100000);

-- INDEXES
-- show existing indexes
SELECT * FROM pg_indexes WHERE tablename = 'seller';

DROP INDEX IF EXISTS seller_name_index;

CREATE INDEX seller_name_index ON seller USING BTREE(seller_name);

EXPLAIN ANALYSE SELECT *
                FROM seller
                WHERE seller_name = 'seller_Name99511';

EXPLAIN ANALYSE SELECT *
                FROM seller
                WHERE id = 5000;

