CREATE TABLE customer_data (
    customer_id SERIAL PRIMARY KEY,
    customer_name TEXT NOT NULL
);

CREATE TABLE product_data (
    item_id SERIAL PRIMARY KEY,
    item_name TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE sales_data (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer_data(customer_id),
    item_id INT REFERENCES product_data(item_id),
    qty INT NOT NULL,
    discount DECIMAL(5,2),
    order_date DATE NOT NULL
);

INSERT INTO customer_data (customer_name) VALUES ('Rohit'), ('Meera'), ('Karan');
INSERT INTO product_data (item_name, price) VALUES ('Laptop', 55000), ('Phone', 25000), ('Tablet', 18000);

INSERT INTO sales_data (customer_id, item_id, qty, discount, order_date) VALUES
(1, 1, 2, 10, '2025-09-01'),
(2, 2, 1, 5, '2025-09-05'),
(3, 3, 3, 0, '2025-09-10');

CREATE OR REPLACE VIEW vw_order_summary AS
SELECT 
    s.order_id,
    s.order_date,
    p.item_name,
    (p.price * s.qty) - ((p.price * s.qty) * s.discount / 100) AS net_amount
FROM sales_data AS s
JOIN product_data AS p ON p.item_id = s.item_id;

SELECT * FROM vw_order_summary;

CREATE ROLE chetan LOGIN PASSWORD '1234';

GRANT SELECT ON vw_order_summary TO chetan;

CREATE TABLE staff_records (
    staff_id SERIAL PRIMARY KEY,
    staff_name TEXT NOT NULL,
    division TEXT NOT NULL
);

INSERT INTO staff_records (staff_name, division) VALUES
('Aman', 'Sales'),
('Deepak', 'Finance'),
('Anita', 'Sales');

CREATE OR REPLACE VIEW vw_sales_team AS
SELECT staff_id, staff_name, division
FROM staff_records
WHERE division = 'Sales'
WITH CHECK OPTION;

SELECT * FROM vw_sales_team;

INSERT INTO vw_sales_team (staff_id, staff_name, division) VALUES (10, 'Pooja', 'Admin');
