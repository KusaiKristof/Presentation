-------------------
-- Create Tables --
-------------------

-- Customers table

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    signup_date DATE NOT NULL,
    country varchar(50) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

-- Products table (prices maximum 10 int long and maximum 2 dot)

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    price NUMERIC(10,2) CHECK (price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

-- Orders table + Foreign Keyek

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP NOT NULL,
    status VARCHAR(50) NOT NULL,

    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
        ON DELETE CASCADE);

-- Order_Itmes table + Foreign Keyek

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),

    CONSTRAINT fk_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id));

-- Order Status

CREATE TYPE order_status AS ENUM (
    'pending',
    'shipped',
    'delivered',
    'cancelled');

-----------------
-- Insert data --
-----------------

-- Customers

INSERT INTO customers (customer_id, signup_date, country, email) VALUES
(1, '2025-01-15', 'Hungary', 'customer1@example.com'),
(2, '2025-02-10', 'Germany', 'customer2@example.com'),
(3, '2025-03-05', 'France', 'customer3@example.com'),
(4, '2025-01-25', 'UK', 'customer4@example.com'),
(5, '2025-02-18', 'USA', 'customer5@example.com'),
(6, '2025-03-12', 'Hungary', 'customer6@example.com'),
(7, '2025-01-30', 'Germany', 'customer7@example.com'),
(8, '2025-02-28', 'France', 'customer8@example.com'),
(9, '2025-03-08', 'UK', 'customer9@example.com'),
(10, '2025-03-15', 'USA', 'customer10@example.com');

-- Products

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Electronics Product 1', 'Electronics', 199.99),
(2, 'Electronics Product 2', 'Electronics', 299.50),
(3, 'Clothing Product 1', 'Clothing', 49.99),
(4, 'Clothing Product 2', 'Clothing', 79.90),
(5, 'Books Product 1', 'Books', 19.99),
(6, 'Books Product 2', 'Books', 29.90),
(7, 'Home Product 1', 'Home', 99.99),
(8, 'Home Product 2', 'Home', 149.50),
(9, 'Toys Product 1', 'Toys', 25.00),
(10, 'Toys Product 2', 'Toys', 35.50),
(11, 'Electronics Product 3', 'Electronics', 499.99),
(12, 'Clothing Product 3', 'Clothing', 59.90),
(13, 'Books Product 3', 'Books', 39.90),
(14, 'Home Product 3', 'Home', 129.99),
(15, 'Toys Product 3', 'Toys', 45.00);

-- ORDERS

INSERT INTO orders (order_id, customer_id, order_date, status) VALUES
(1, 1, '2025-02-20', 'delivered'),
(2, 2, '2025-02-25', 'pending'),
(3, 3, '2025-03-01', 'shipped'),
(4, 4, '2025-03-03', 'delivered'),
(5, 5, '2025-03-05', 'cancelled'),
(6, 6, '2025-03-06', 'pending'),
(7, 7, '2025-03-07', 'shipped'),
(8, 8, '2025-03-08', 'delivered'),
(9, 9, '2025-03-09', 'pending'),
(10, 10, '2025-03-10', 'delivered'),
(11, 1, '2025-03-12', 'pending'),
(12, 2, '2025-03-13', 'delivered'),
(13, 3, '2025-03-14', 'shipped'),
(14, 4, '2025-03-15', 'pending'),
(15, 5, '2025-03-16', 'delivered'),
(16, 6, '2025-03-17', 'cancelled'),
(17, 7, '2025-03-18', 'shipped'),
(18, 8, '2025-03-19', 'delivered'),
(19, 9, '2025-03-20', 'pending'),
(20, 10, '2025-03-21', 'shipped');

-- ORDER_ITMES

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 199.99),
(2, 1, 5, 2, 19.99),
(3, 2, 3, 1, 49.99),
(4, 2, 7, 1, 99.99),
(5, 3, 2, 1, 299.50),
(6, 3, 9, 3, 25.00),
(7, 4, 4, 2, 79.90),
(8, 4, 6, 1, 29.90),
(9, 5, 1, 1, 199.99),
(10, 5, 10, 1, 35.50),
(11, 6, 8, 2, 149.50),
(12, 6, 5, 1, 19.99),
(13, 7, 12, 1, 59.90),
(14, 7, 2, 1, 299.50),
(15, 8, 3, 2, 49.99),
(16, 8, 7, 1, 99.99),
(17, 9, 1, 1, 199.99),
(18, 9, 15, 1, 45.00),
(19, 10, 4, 1, 79.90),
(20, 10, 6, 2, 29.90),
(21, 11, 1, 1, 199.99),
(22, 11, 2, 1, 299.50),
(23, 12, 3, 1, 49.99),
(24, 12, 5, 2, 19.99),
(25, 13, 7, 1, 99.99),
(26, 13, 9, 1, 25.00),
(27, 14, 12, 1, 59.90),
(28, 14, 14, 1, 129.99),
(29, 15, 1, 2, 199.99),
(30, 15, 10, 1, 35.50),
(31, 16, 8, 1, 149.50),
(32, 16, 13, 1, 39.90),
(33, 17, 2, 1, 299.50),
(34, 17, 3, 2, 49.99),
(35, 18, 4, 1, 79.90),
(36, 18, 7, 1, 99.99),
(37, 19, 5, 1, 19.99),
(38, 19, 9, 1, 25.00),
(39, 20, 1, 1, 199.99),
(40, 20, 6, 2, 29.90);



--------------
-- Analysis --
--------------

-- Total Revenue

SELECT SUM(quantity * price) AS total_revenue FROM order_items;

-- Revenue / months

SELECT date_trunc('month', order_date) AS month, SUM(quantity * price) AS revenue
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY month
ORDER BY month;

-- AVG revenue / months

SELECT date_trunc('month', order_date) AS month, AVG(quantity * price) AS AVG_revenue
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id
GROUP BY month
ORDER BY month;

-- Count customer orders

SELECT customer_id, COUNT(DISTINCT order_id) AS num_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id) > 1;

-- Rank products by sales

SELECT products.product_name, SUM(order_items.quantity * order_items.price) AS revenue
FROM order_items
JOIN products ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY revenue DESC;

