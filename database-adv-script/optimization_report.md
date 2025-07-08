# Optimization Report

This report analyzes the performance of a query retrieving bookings with user, property, and payment details in the ALX Airbnb clone database.

## Task 5: Query Performance Analysis

### Objective
Evaluate the performance of a query joining bookings, users, and properties, and identify potential inefficiencies.

### Query Details
The following query was tested:
```sql
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

EXPLAIN Output:
 Hash Right Join  (cost=43.67..57.86 rows=7 width=594)
   Hash Cond: (p.id = b.property_id)
   ->  Seq Scan on properties p  (cost=0.00..13.00 rows=300 width=238)
   ->  Hash  (cost=43.58..43.58 rows=7 width=364)
         ->  Hash Right Join  (cost=30.49..43.58 rows=7 width=364)
               Hash Cond: (u.id = b.user_id)
               ->  Seq Scan on users u  (cost=0.00..12.20 rows=220 width=340)
               ->  Hash  (cost=30.40..30.40 rows=7 width=32)
                     ->  Seq Scan on bookings_2025_07 b  (cost=0.00..30.40 rows=7 width=32)
                           Filter: ((check_in >= '2025-07-01'::date) AND (check_in < '2025-08-01'::date))
(10 rows)

