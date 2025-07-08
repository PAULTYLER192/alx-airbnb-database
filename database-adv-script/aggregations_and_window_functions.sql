-- Aggregation function to count the number of bookings per user
SELECT u.id AS user_id, u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
GROUP BY u.id, u.username
ORDER BY booking_count DESC;

-- Task 3b: Window function to rank properties based on the total number of bookings they have received
SELECT subquery.property_id, subquery.title, subquery.booking_count,
       ROW_NUMBER() OVER (ORDER BY subquery.booking_count DESC) AS booking_rank
FROM (
    SELECT p.id AS property_id, p.title, COUNT(b.id) AS booking_count
    FROM properties p
    LEFT JOIN bookings b ON p.id = b.property_id
    GROUP BY p.id, p.title
) AS subquery
ORDER BY booking_rank;