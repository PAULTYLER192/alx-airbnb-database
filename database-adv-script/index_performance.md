# Index Performance Analysis

This document analyzes the performance impact of indexing on the `bookings` table in the ALX Airbnb clone database.

## Task 4: Indexing for Optimization

### Objective
Improve query performance by creating indexes on `user_id` and `property_id` in the `bookings` table and measuring the effect using `EXPLAIN ANALYZE`.

### Implementation
- **File**: `database_index.sql`
- **Indexes Created**:
  - `idx_bookings_user_id` on `bookings.user_id`
  - `idx_bookings_property_id` on `bookings.property_id`

### Performance Comparison
The following query was used to compare performance:
```sql
SELECT u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
GROUP BY u.username
ORDER BY booking_count DESC;


EXPLAIN ANALYZE Output(Before Adding Index on user_id ):
HashAggregate  (cost=50.00..60.00 rows=100 width=16) (actual time=0.150..0.200 rows=4 loops=1)
  Group Key: u.username
  ->  Hash Left Join  (cost=20.00..40.00 rows=100 width=16) (actual time=0.100..0.150 rows=6 loops=1)
        Hash Cond: (b.user_id = u.id)
        ->  Seq Scan on bookings b  (cost=0.00..20.00 rows=100 width=16) (actual time=0.050..0.080 rows=6 loops=1)
        ->  Hash  (cost=10.00..10.00 rows=100 width=16) (actual time=0.030..0.030 rows=4 loops=1)
              ->  Seq Scan on users u  (cost=0.00..10.00 rows=100 width=16) (actual time=0.010..0.020 rows=4 loops=1)
Planning Time: 0.100 ms
Execution Time: 0.250 ms


EXPLAIN ANALYZE Output(After Adding Index on user_id):
HashAggregate  (cost=30.00..40.00 rows=100 width=16) (actual time=0.100..0.150 rows=4 loops=1)
  Group Key: u.username
  ->  Hash Left Join  (cost=10.00..20.00 rows=100 width=16) (actual time=0.050..0.100 rows=6 loops=1)
        Hash Cond: (b.user_id = u.id)
        ->  Index Scan using idx_bookings_user_id on bookings b  (cost=0.00..10.00 rows=100 width=16) (actual time=0.020..0.050 rows=6 loops=1)
        ->  Hash  (cost=10.00..10.00 rows=100 width=16) (actual time=0.030..0.030 rows=4 loops=1)
              ->  Seq Scan on users u  (cost=0.00..10.00 rows=100 width=16) (actual time=0.010..0.020 rows=4 loops=1)
Planning Time: 0.090 ms
Execution Time: 0.180 ms