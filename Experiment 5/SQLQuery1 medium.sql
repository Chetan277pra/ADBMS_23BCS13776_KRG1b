CREATE TABLE transaction_info (
    user_id INT,
    purchase_value DECIMAL
);

INSERT INTO transaction_info (user_id, purchase_value)
SELECT 1, random() * 1000
FROM generate_series(1, 1000000);

INSERT INTO transaction_info (user_id, purchase_value)
SELECT 2, random() * 1000
FROM generate_series(1, 1000000);

CREATE OR REPLACE VIEW purchase_summary_view AS
SELECT
    user_id,
    COUNT(*) AS order_count,
    SUM(purchase_value) AS total_amount,
    AVG(purchase_value) AS average_amount
FROM transaction_info
GROUP BY user_id;

CREATE MATERIALIZED VIEW purchase_summary_mv AS
SELECT
    user_id,
    COUNT(*) AS order_count,
    SUM(purchase_value) AS total_amount,
    AVG(purchase_value) AS average_amount
FROM transaction_info
GROUP BY user_id;


CREATE TABLE random_data (
    group_id INT,
    metric_value DECIMAL
);

INSERT INTO random_data
SELECT 1, random() FROM generate_series(1, 1000000);

INSERT INTO random_data
SELECT 2, random() FROM generate_series(1, 1000000);

SELECT
    group_id,
    AVG(metric_value),
    COUNT(*)
FROM random_data
GROUP BY group_id;

CREATE MATERIALIZED VIEW mv_random_data AS
SELECT
    group_id,
    AVG(metric_value),
    COUNT(*)
FROM random_data
GROUP BY group_id;

SELECT * FROM mv_random_data;

REFRESH MATERIALIZED VIEW mv_random_data;
