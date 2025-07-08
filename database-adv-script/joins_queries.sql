-- INNER JOIN to retrieve all bookings and respective users
SELECT b.id AS booking_id, u.username, p.title, b.check_in, b.total_price
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
ORDER BY b.id;

-- LEFT JOIN to retrieve all properties and their reviews, including properties with no reviews
SELECT p.id AS property_id, p.title, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id
ORDER BY p.id;

-- FULL OUTER JOIN to retrieve all users and all bookings, even if no match exists
SELECT u.id AS user_id, u.username, b.id AS booking_id, b.check_in, b.total_price
FROM users u
FULL OUTER JOIN bookings b ON u.id = b.user_id
ORDER BY u.id;