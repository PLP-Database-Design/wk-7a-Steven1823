-- Create the database
DROP DATABASE IF EXISTS normalization_exercise;
CREATE DATABASE normalization_exercise;
USE normalization_exercise;

-- Question 1: Achieving 1NF (First Normal Form)
-- The original table has a multi-valued Products column, which violates 1NF.
-- We need to split each product into its own row.

-- Step 1: Create the new 1NF table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Step 2: Insert data, one product per row
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Now, each row represents a single product for an order, satisfying 1NF.

-- ------------------------------------------------------------

-- Question 2: Achieving 2NF (Second Normal Form)
-- The original table is in 1NF but has a partial dependency: CustomerName depends only on OrderID.
-- To achieve 2NF, we split the table into two:
--   1. Orders table (OrderID, CustomerName)
--   2. OrderItems table (OrderID, Product, Quantity)

-- Step 1: Create the Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Create the OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 3: Insert data into Orders (one row per order)
INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 4: Insert data into OrderItems (one row per product per order)
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Now, all non-key columns in each table fully depend on the whole primary key, satisfying 2NF.
