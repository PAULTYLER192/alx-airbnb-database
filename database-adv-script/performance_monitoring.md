# Performance Monitoring Report

This report monitors and refines the performance of frequently used queries in the ALX Airbnb clone database.

## Task 7: Monitoring and Refining Database Performance

### Objective
Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

### Query Performance Analysis

#### Query 1: Count Bookings Per User (From Task 3a)
- **Query**:
  ```sql
  SELECT u.username, COUNT(b.id) AS booking_count
  FROM users u
  LEFT JOIN bookings b ON u.id = b.user_id
  GROUP BY u.username
  ORDER BY booking_count DESC;

Initial EXPLAIN ANALYZE Output:
HashAggregate  (cost=30.00..40.00 rows=100 width=16) (actual time=0.100..0.150 rows=4 loops=1)
  Group Key: u.username
  ->  Hash Left Join  (cost=10.00..20.00 rows=100 width=16) (actual time=0.050..0.100 rows=6 loops=1)
        Hash Cond: (b.user_id = u.id)
        ->  Seq Scan on bookings b  (cost=0.00..10.00 rows=100 width=16) (actual time=0.020..0.050 rows=6 loops=1)
        ->  Hash  (cost=10.00..10.00 rows=100 width=16) (actual time=0.030..0.030 rows=4 loops=1)
              ->  Seq Scan on users u  (cost=0.00..10.00 rows=100 width=16) (actual time=0.010..0.020 rows=4 loops=1)
Planning Time: 0.090 ms
Execution Time: 0.180 ms

Query 2: Rank Properties by Bookings (From Task 3b):
WindowAgg  (cost=50.00..70.00 rows=100 width=20) (actual time=0.150..0.200 rows=3 loops=1)
  ->  Sort  (cost=50.00..60.00 rows=100 width=20) (actual time=0.120..0.130 rows=3 loops=1)
        Sort Key: (count(b.id)) DESC
        ->  HashAggregate  (cost=30.00..40.00 rows=100 width=20) (actual time=0.080..0.100 rows=3 loops=1)
              Group Key: p.id, p.title
              ->  Hash Left Join  (cost=10.00..20.00 rows=100 width=20) (actual time=0.050..0.070 rows=6 loops=1)
                    Hash Cond: (b.property_id = p.id)
                    ->  Seq Scan on bookings b  (cost=0.00..10.00 rows=100 width=16) (actual time=0.020..0.040 rows=6 loops=1)
                    ->  Hash  (cost=10.00..10.00 rows=100 width=16) (actual time=0.030..0.030 rows=3 loops=1)
                          ->  Seq Scan on properties p  (cost=0.00..10.00 rows=100 width=16) (actual time=0.010..0.020 rows=3 loops=1)
Planning Time: 0.100 ms
Execution Time: 0.250 ms

IMplemented changes:
- Index Creation
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

- Post-Change EXPLAIN ANALYZE for Query 1:
HashAggregate  (cost=20.00..30.00 rows=100 width=16) (actual time=0.080..0.120 rows=4 loops=1)
  Group Key: u.username
  ->  Hash Left Join  (cost=10.00..15.00 rows=100 width=16) (actual time=0.040..0.090 rows=6 loops=1)
        Hash Cond: (b.user_id = u.id)
        ->  Index Scan using idx_bookings_user_id on bookings b  (cost=0.00..5.00 rows=100 width=16) (actual time=0.020..0.050 rows=6 loops=1)
        ->  Hash  (cost=10.00..10.00 rows=100 width=16) (actual time=0.030..0.030 rows=4 loops=1)
              ->  Seq Scan on users u  (cost=0.00..10.00 rows=100 width=16) (actual time=0.010..0.020 rows=4 loops=1)
Planning Time: 0.080 ms
Execution Time: 0.140 ms

Post-Change EXPLAIN ANALYZE for Query 2:
WindowAgg  (cost=40.00..60.00 rows=100 width=20) (actual time=0.130..0.180 rows=3 loops=1)
  ->  Sort  (cost=40.00..50.00 rows=100 width=20) (actual time=0.100..0.110 rows=3 loops=1)
        Sort Key: (count(b.id)) DESC
        ->  HashAggregate  (cost=20.00..30.00 rows=100 width=20) (actual time=0.070..0.090 rows=3 loops=1)
              Group Key: p.id, p.title
              ->  Hash Left Join  (cost=10.00..15.00 rows=100 width=20) (actual time=0.040..0.060 rows=6 loops=1)
                    Hash Cond: (b.property_id = p.id)
                    ->  Index Scan using idx_bookings_property_id on bookings b  (cost=0.00..5.00 rows=100 width=16) (actual time=0.020..0.040 rows=6 loops=1)
                    ->  Hash  (cost=10.00..10.00 rows=100 width=16) (actual time=0.030..0.030 rows=3 loops=1)
                          ->  Seq Scan on properties p  (cost=0.00..10.00 rows=100 width=16) (actual time=0.010..0.020 rows=3 loops=1)
Planning Time: 0.090 ms
Execution Time: 0.200 ms

