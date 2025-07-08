--  Non-correlated subquery to find all properties with a price higher than the average price
SELECT p.id AS property_id, p.title, p.price
FROM properties p
WHERE p.id IN  (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.id;
    

--  Correlated subquery to find users who have made more than 2 bookings
SELECT id AS user_id, username
FROM users u
WHERE 3 < (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
)
ORDER BY id;