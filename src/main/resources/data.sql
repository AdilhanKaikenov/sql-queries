--  commission
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (501, 101, 200, '2010-03-10');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (502, 102, 300, '2010-02-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (503, 103, 400, '2010-04-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (504, 104, 500, '2010-05-10');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (505, 105, 250, '2010-06-15');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (506, 101, 350, '2010-07-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (507, 102, 500, '2010-08-10');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (508, 103, 100, '2010-09-05');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (509, 104, 200, '2010-10-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (510, 105, 300, '2010-03-15');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (511, 101, 400, '2010-04-15');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (512, 102, 300, '2010-02-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (513, 103, 150, '2010-01-15');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (514, 104, 200, '2010-04-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (515, 105, 300, '2010-06-15');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (516, 101, 250, '2010-08-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (517, 102, 300, '2010-09-25');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (518, 103, 400, '2010-11-20');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (519, 104, 200, '2010-12-15');
INSERT INTO commission (id, seller_id, "amount of commission", date) VALUES (520, 105, 100, '2010-03-15');

--  cities
INSERT INTO city (id, city_name) VALUES (401, 'London');
INSERT INTO city (id, city_name) VALUES (402, 'San Jose');
INSERT INTO city (id, city_name) VALUES (403, 'Berlin');
INSERT INTO city (id, city_name) VALUES (404, 'Barcelona');
INSERT INTO city (id, city_name) VALUES (405, 'New York');
INSERT INTO city (id, city_name) VALUES (406, 'Rome');

--  salespeople
INSERT INTO seller (id, seller_name, city, commission) VALUES (101, 'Peel', 401, 0.12);
INSERT INTO seller (id, seller_name, city, commission) VALUES (102, 'Serres', 402, 0.13);
INSERT INTO seller (id, seller_name, city, commission) VALUES (103, 'Motika', 401, 0.11);
INSERT INTO seller (id, seller_name, city, commission) VALUES (104, 'Rifrin', 404, 0.15);
INSERT INTO seller (id, seller_name, city, commission) VALUES (105, 'Axelrod', 405, 0.10);

--  customers
INSERT INTO customer (id, customer_name, city, rating) VALUES (201, 'John Hoffman', 401, 1);
INSERT INTO customer (id, customer_name, city, rating) VALUES (202, 'Giovanni', 406, 2);
INSERT INTO customer (id, customer_name, city, rating) VALUES (203, 'Liudor', 402, 2);
INSERT INTO customer (id, customer_name, city, rating) VALUES (204, 'Grassdor', 403, 3);
INSERT INTO customer (id, customer_name, city, rating) VALUES (205, 'John dorGlemens', 401, 1);
INSERT INTO customer (id, customer_name, city, rating) VALUES (206, 'Cisneros', 402, 3);
INSERT INTO customer (id, customer_name, city, rating) VALUES (207, 'Periera', 406, 1);

--  orders
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (301, 18.68, '2010-03-10', 208, 107);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (302, 767.19, '2010-03-10', 201, 101);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (303, 1900.10, '2010-03-10', 207, 104);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (304, 5160.45, '2010-03-10', 203, 102);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (305, 1068.16, '2010-03-10', 208, 107);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (306, 1713.23, '2010-04-10', 202, 103);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (307, 75.75, '2010-04-10', 204, 102);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (308, 4723.00, '2010-05-10', 206, 101);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (309, 1309.95, '2010-06-10', 204, 102);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (310, 9891.88, '2010-06-10', 206, 101);
INSERT INTO "order" (id, amount, order_date, customer_id, seller_id) VALUES (311, 9891.88, '2010-06-11', 206, 101);