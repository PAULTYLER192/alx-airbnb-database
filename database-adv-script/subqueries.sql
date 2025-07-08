--  Non-correlated subquery to find all properties with a price higher than the average price
SELECT id AS property_id, title, price
FROM properties
WHERE price > (SELECT AVG(price) FROM properties)
ORDER BY price DESC;

--  Correlated subquery to find users who have made more than 2 bookings
SELECT id AS user_id, username
FROM users u
WHERE 2 < (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
)
ORDER BY id;