-- - select customers whose name starts with 'John'
SELECT
  customer_name,
  city_name,
  rating
FROM customer
  INNER JOIN city ON city.id = customer.city
WHERE customer.customer_name LIKE 'John%';

-- - select customers whose name contains 'dor'
SELECT
  customer_name,
  city_name,
  rating
FROM customer
  INNER JOIN city ON city.id = customer.city
WHERE customer.customer_name LIKE '%dor%';

-- - select customers with rating > 3 or from London
SELECT
  customer_name,
  city_name,
  rating
FROM customer
  INNER JOIN city ON city.id = customer.city
WHERE rating > 3 OR city_name = 'London';

-- - select customers who have at least one order
SELECT
  customer_name,
  rating,
  COUNT(customer_id) AS order_number
FROM customer
  INNER JOIN "order" ON "order".customer_id = customer.id
GROUP BY customer_name, rating
HAVING COUNT(customer_id) >= 1;

-- - select how many customers in each city
SELECT
  city_name,
  COUNT(customer_name) AS customer_number
FROM customer
  INNER JOIN city ON city.id = customer.city
GROUP BY city_name
ORDER BY COUNT(customer_name);

-- - select salespeople name and max commission, and min commission
SELECT
  seller_name,
  max(c.amount_of_commission),
  min(c.amount_of_commission)
FROM commission c
  INNER JOIN seller ON c.seller_id = seller.id
GROUP BY seller_name;
--
SELECT
  seller_name,
  seller.commission,
  'max commission' AS info
FROM seller
WHERE commission = (SELECT MAX(commission)
                    FROM seller)
UNION
SELECT
  seller_name,
  seller.commission,
  'min commission'
FROM seller
WHERE commission = (SELECT MIN(commission)
                    FROM seller);

-- - select salespeople name and total commission
SELECT
  seller_name,
  ROUND(SUM(amount * seller.commission)::NUMERIC, 2) AS total_commission
FROM seller
  INNER JOIN "order" ON seller_id = seller.id
GROUP BY seller_name;
--
SELECT
  seller_name,
  SUM(c.amount_of_commission)
FROM commission c
  INNER JOIN seller ON c.seller_id = seller.id
GROUP BY seller_name;

-- - select salespeople who worked with more than 2 clients
SELECT
  seller_name,
  COUNT(DISTINCT customer_id) AS customer_number
FROM "order"
  INNER JOIN seller ON "order".seller_id = seller.id
GROUP BY seller_name
HAVING COUNT(DISTINCT customer_id) >= 2;

-- - select customers who do not have any orders (use 3 different approaches)
-- the first approach
SELECT *
FROM customer
  LEFT JOIN "order" ON customer_id = customer.id
WHERE "order".customer_id IS NULL;
-- the second approach
SELECT *
FROM customer
WHERE id NOT IN (SELECT customer_id
                  FROM "order");
-- the third approach
SELECT *
FROM customer
WHERE NOT EXISTS (SELECT *
                   FROM "order"
                   WHERE customer_id = customer.id);

-- - select salespeople name and total commission for London city, where total commission more than 1000
SELECT
  seller_name,
  city_name,
  SUM(amount * seller.commission) AS total_commission
FROM seller
  INNER JOIN "order" ON seller_id = seller.id
  INNER JOIN city ON seller.city = city.id
WHERE city_name = 'London'
GROUP BY seller_name, city_name
HAVING SUM(amount * seller.commission) > 1000;

-- - select salespeople who have made more than 2 sales
SELECT
  seller.id,
  seller_name,
  city_name,
  commission
FROM "order"
  INNER JOIN seller ON "order".seller_id = seller.id
  INNER JOIN city ON seller.city = city.id
GROUP BY seller.id, seller_name, city_name, commission
HAVING COUNT(seller_id) > 2;

-- - select customer with most orders
SELECT
  customer_name,
  COUNT(customer_id) AS max
FROM "order" o
  INNER JOIN customer ON o.customer_id = customer.id
GROUP BY customer_name
ORDER BY COUNT(customer_id) DESC
LIMIT 1;

-- - select how many orders we have per day in specific month
SELECT
  d.as_of_date,
  COUNT(o.id)
FROM (
       SELECT d.date AS as_of_date
       FROM GENERATE_SERIES('2010-01-1','2010-01-31', INTERVAL '1 day') d) d
  LEFT JOIN "order" o ON o.order_date = d.as_of_date
GROUP BY d.as_of_date;

-- - select customers with most orders in each city
CREATE VIEW customer_order_num AS
  SELECT
    c.id,
    c.customer_name,
    city_name,
    COUNT(customer_id) AS order_number
  FROM "order" o
    INNER JOIN customer c ON o.customer_id = c.id
    INNER JOIN city ON city.id = c.city
  GROUP BY c.id, city_name;

SELECT
  customer_name,
  city_name,
  order_number
FROM customer_order_num AS a1
WHERE order_number = (SELECT MAX(order_number)
                      FROM customer_order_num AS a2
                      WHERE a1.city_name = a2.city_name);

-- - select how many orders we have per day
SELECT
  TO_CHAR(d.as_of_date, 'dd.MM.yyyy') AS date,
  COUNT(o.id) AS order_number
FROM (
       SELECT d.date AS as_of_date
       FROM GENERATE_SERIES('2010-01-1', '2010-01-31', INTERVAL '1 day') d) d
  LEFT JOIN "order" o ON o.order_date = d.as_of_date
GROUP BY d.as_of_date;

-- - select how many orders we have per month
SELECT
  TO_CHAR(dd.year_month_date, 'dd.MM.yyyy') AS date,
  COUNT(o.id) AS order_number
FROM (SELECT
        DATE_TRUNC('year', dd)  AS year,
        DATE_TRUNC('month', dd) AS year_month_date
      FROM GENERATE_SERIES('2010-01-01', '2010-12-01', INTERVAL '1 month') AS dd) dd
  LEFT JOIN "order" o ON DATE_TRUNC('month', o.order_date) = dd.year_month_date
GROUP BY dd.year_month_date
ORDER BY dd.year_month_date;

-- - select order with max amount per month, salesman who sold it and customer who ordered it
-- (if there are 2 identical order, select first by date)
SELECT
  TO_CHAR(dd, 'dd.MM.yyyy')      AS date,
  COALESCE(s.seller_name, '-')   AS seller_name,
  COALESCE(c.customer_name, '-') AS customer_name,
  COALESCE(o_max.amount, 0)      AS max_amount
FROM GENERATE_SERIES('2010-01-01', '2010-12-01', INTERVAL '1 month') AS dd
  LEFT JOIN (SELECT
               seller_id,
               customer_id,
               order_date,
               amount
             FROM "order" o RIGHT JOIN (SELECT
                                          MAX(order_max.order_date) AS o_date,
                                          MAX(order_max.amount)     AS o_amount
                                        FROM "order" order_max
                                        GROUP BY DATE_TRUNC('month', order_date)) AS max_month_amount
                 ON o.order_date = max_month_amount.o_date
                    AND o.amount = max_month_amount.o_amount) AS o_max
    ON DATE_TRUNC('month', dd.dd) = DATE_TRUNC('month', o_max.order_date)
  LEFT JOIN seller s ON s.id = o_max.seller_id
  LEFT JOIN customer c ON c.id = o_max.customer_id;

-- - select salespeople name and 'Profitable' if average commission per month more than 400, 'Neutral' if average commission
-- more than 200 and less than 400, 'Detrimental' if average commission is less than 200

-- using SWITCH
SELECT
  seller_name,
  ROUND(SUM(c.amount_of_commission / 12) :: NUMERIC, 2) AS avg,
  CASE
  WHEN (SUM(c.amount_of_commission / 12)) > 100
    THEN 'Profitable'
  WHEN (SUM(c.amount_of_commission / 12)) BETWEEN 50 AND 100
    THEN 'Neutral'
  WHEN (SUM(c.amount_of_commission / 12)) < 50
    THEN 'Detrimental'
  END
FROM commission c
  INNER JOIN seller s ON c.seller_id = s.id
GROUP BY seller_name;

DROP VIEW average_commission; -- DROP VIEW

CREATE VIEW average_commission AS -- CREATE VIEW
  SELECT
    seller_name,
    ROUND(SUM(c.amount_of_commission / 12)::numeric, 2) AS avg
  FROM commission c
    INNER JOIN seller s ON c.seller_id = s.id
  GROUP BY seller_name;

-- using UNION
SELECT
  *,
  'Profitable' AS info
FROM average_commission ac
WHERE ac.avg > 100
UNION
SELECT
  *,
  'Neutral'
FROM average_commission ac
WHERE ac.avg BETWEEN 50 AND 100
UNION
SELECT
  *,
  'Detrimental'
FROM average_commission ac
WHERE ac.avg < 50
ORDER BY avg;

-- using FUNCTION
DROP FUNCTION IF EXISTS FUNC_INFO(avarage DOUBLE PRECISION ); -- DROP FUNCTION

CREATE FUNCTION FUNC_INFO(average DOUBLE PRECISION) -- CREATE FUNCTION
  RETURNS VARCHAR(45) AS
$BODY$DECLARE
  info_str VARCHAR;
BEGIN
  info_str = '';
  IF (average > 100)
  THEN
    info_str = 'Profitable';
  END IF;
  IF (average BETWEEN 50 AND 100)
  THEN
    info_str = 'Neutral';
  END IF;
  IF (average < 50)
  THEN
    info_str = 'Detrimental';
  END IF;
  RETURN info_str;
END;
$BODY$
LANGUAGE 'plpgsql';

SELECT
  *,
  FUNC_INFO(ac.avg) AS info
FROM average_commission ac;

-- - select how many sales did a salesman in last month for each day
-- (format date in dd.MM.yyyy, salesman had holidays of course)
SELECT
  TO_CHAR(days, 'dd.MM.yyyy')                 AS date,
  COALESCE(seller_sales_num.seller_name, '-') AS info,
  COALESCE(seller_sales_num.sales_num, 0)     AS sales_number
FROM GENERATE_SERIES('2010-01-1', '2010-01-31', INTERVAL '1 day') AS days
  LEFT JOIN (SELECT
               o.order_date,
               COUNT(o.seller_id)       AS sales_num,
               (SELECT seller_name
                FROM seller s
                WHERE s.id = seller_id) AS seller_name
             FROM "order" o
             WHERE seller_id = 102 AND -- parameter seller ID
                   EXTRACT(MONTH FROM NOW()) - 1
                   = EXTRACT(MONTH FROM
                             o.order_date)
             GROUP BY seller_name,
               o.order_date
            ) AS seller_sales_num
    ON seller_sales_num.order_date = days.days;