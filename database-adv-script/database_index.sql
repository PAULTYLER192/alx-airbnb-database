-- Creating an index on the user_id column in the bookings table
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

--  Creating an index on the property_id column in the bookings table
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

--  Comparing performance of a JOIN query before and after adding the index on user_id
-- First, running EXPLAIN ANALYZE without the index (drops it temporarily if already exists)
DROP INDEX IF EXISTS idx_bookings_user_id;
EXPLAIN ANALYZE
SELECT u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
GROUP BY u.username
ORDER BY booking_count DESC;

-- Recreating the index and run EXPLAIN ANALYZE again
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
EXPLAIN ANALYZE
SELECT u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
GROUP BY u.username
ORDER BY booking_count DESC;