-- Task 5a: Initial query to retrieve all bookings with user details, property details, and payment details
SELECT 
    b.id AS booking_id,
    u.username,
    u.email AS user_email,
    p.title AS property_title,
    p.price AS property_price,
    b.check_in,
    b.total_price AS payment_amount
FROM bookings b
LEFT JOIN users u ON b.user_id = u.id
LEFT JOIN properties p ON b.property_id = p.id;

-- Task 5b: Analyze the query’s performance using EXPLAIN and identify inefficiencies
EXPLAIN
SELECT 
    b.id AS booking_id,
    u.username,
    u.email AS user_email,
    p.title AS property_title,
    p.price AS property_price,
    b.check_in,
    b.total_price AS payment_amount
FROM bookings b
LEFT JOIN users u ON b.user_id = u.id
LEFT JOIN properties p ON b.property_id = p.id
WHERE b.check_in >= '2025-07-01' AND b.check_in < '2025-08-01';