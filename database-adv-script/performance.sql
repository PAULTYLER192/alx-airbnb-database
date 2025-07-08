--  Partitioning the bookings table by check_in date (monthly partitions)
-- Dropping the existing bookings table if it exists
DROP TABLE IF EXISTS bookings CASCADE;

-- Create the parent partitioned table
CREATE TABLE bookings (
    id SERIAL ,
    property_id INT,
    user_id INT,
    check_in DATE,
    total_price DECIMAL(10, 2),
    PRIMARY KEY (id, check_in)
) PARTITION BY RANGE (check_in);

-- Creating monthly partitions for July and August 2025
CREATE TABLE bookings_2025_07 PARTITION OF bookings
FOR VALUES FROM ('2025-07-01') TO ('2025-08-01');

CREATE TABLE bookings_2025_08 PARTITION OF bookings
FOR VALUES FROM ('2025-08-01') TO ('2025-09-01');

-- Inserting existing data into the partitioned table
INSERT INTO bookings (property_id, user_id, check_in, total_price)
VALUES
    (1, 101, '2025-07-10', 10000.00),
    (2, 102, '2025-07-15', 30000.00),
    (1, 103, '2025-07-20', 15000.00),
    (1, 101, '2025-07-25', 16000.00),
    (1, 101, '2025-07-30', 17000.00),
    (1, 101, '2025-08-05', 18000.00);

--  Testing performance with EXPLAIN ANALYZE on a query
EXPLAIN ANALYZE
SELECT u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
WHERE b.check_in >= '2025-07-01' AND b.check_in < '2025-08-01'
GROUP BY u.username
ORDER BY booking_count DESC;