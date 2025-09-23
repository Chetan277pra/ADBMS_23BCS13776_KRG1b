CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    quantity INT NOT NULL,
    sold INT DEFAULT 0
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity_ordered INT NOT NULL,
    total_price NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO products (product_id, product_name, price, quantity, sold) VALUES
('PR01', 'iPhone14Pro', 119999.00, 12, 0),
('PR02', 'GalaxyS24', 109999.00, 10, 0),
('PR03', 'iPadPro', 64999.00, 6, 0),
('PR04', 'MacBookAirM2', 139999.00, 4, 0),
('PR05', 'BoseQC45', 34999.00, 20, 0);

INSERT INTO orders (order_date, product_id, quantity_ordered, total_price) VALUES
('2025-09-15', 'PR01', 1, 119999.00),
('2025-09-16', 'PR02', 2, 219998.00),
('2025-09-17', 'PR03', 1, 64999.00),
('2025-09-18', 'PR05', 2, 69998.00),
('2025-09-19', 'PR01', 1, 119999.00);

SELECT * FROM products;
SELECT * FROM orders;

CREATE OR REPLACE PROCEDURE purchase_product(
    IN p_name VARCHAR,
    IN p_qty INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    p_id VARCHAR(10);
    p_price NUMERIC(10,2);
    available_count INT;
BEGIN
    SELECT COUNT(*) INTO available_count
    FROM products
    WHERE product_name = p_name
      AND quantity >= p_qty;

    IF available_count > 0 THEN
        SELECT product_id, price INTO p_id, p_price
        FROM products
        WHERE product_name = p_name;

        INSERT INTO orders (order_date, product_id, quantity_ordered, total_price)
        VALUES (CURRENT_DATE, p_id, p_qty, (p_price * p_qty));

        UPDATE products
        SET quantity = quantity - p_qty,
            sold = sold + p_qty
        WHERE product_id = p_id;

        RAISE NOTICE 'ORDER SUCCESSFUL! % unit(s) of % sold.', p_qty, p_name;
    ELSE
        RAISE NOTICE 'INSUFFICIENT STOCK! Cannot process % unit(s) of %.', p_qty, p_name;
    END IF;
END;
$$;

CALL purchase_product('MacBookAirM2', 1);
CALL purchase_product('iPadPro', 7);
CALL purchase_product('GalaxyS24', 3);
