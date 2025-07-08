-- Aggregation function to count the number of bookings per user
SELECT u.id AS user_id, u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
GROUP BY u.id, u.username
ORDER BY booking_count DESC;

-- Task 3b: Window function to rank properties based on the tal price of their bookings
SELECT p.id AS property_id, p.title, b.total_price,
       RANK() OVER (ORDER BY SUM(b.total_price) OVER (PARTITION BY p.id) DESC) AS price_rank
FROM properties p
LEFT JOIN bookings b ON p.id = b.property_id
GROUP BY p.id, p.title, b.total_price
ORDER BY price_rank;