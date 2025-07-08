# Partition Performance Analysis

This report analyzes the performance impact of partitioning the `bookings` table in the ALX Airbnb clone database.

## Task 6: Partitioning Large Tables

### Objective
Enhance database scalability by partitioning the `bookings` table and evaluating the performance impact using `EXPLAIN ANALYZE`.

### Partitioning Strategy
- **Table**: `bookings`
- **Partitioning Method**: Range partitioning by `check_in` date.
- **Partition Details**:
  - `bookings_2025_07`: Covers dates from 2025-07-01 to 2025-08-01.
  - `bookings_2025_08`: Covers dates from 2025-08-01 to 2025-09-01.
- **Rationale**: Monthly partitions enable efficient pruning for date-based queries, improving scalability with large datasets.
- **Primary Key**: `PRIMARY KEY (id, check_in)` to ensure uniqueness across partitions.

### Performance Analysis
The following query was tested:
```sql
SELECT u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
WHERE b.check_in >= '2025-07-01' AND b.check_in < '2025-08-01'
GROUP BY u.username
ORDER BY booking_count DESC;



EXPLAIN ANALYZE Output:
 Sort  (cost=43.90..43.92 rows=7 width=126) (actual time=0.210..0.211 rows=3 loops=1)
   Sort Key: (count(b.id)) DESC
   Sort Method: quicksort  Memory: 25kB
   ->  GroupAggregate  (cost=43.68..43.80 rows=7 width=126) (actual time=0.187..0.190 rows=3 loops=1)
         Group Key: u.username
         ->  Sort  (cost=43.68..43.70 rows=7 width=122) (actual time=0.158..0.160 rows=5 loops=1)
               Sort Key: u.username
               Sort Method: quicksort  Memory: 25kB
               ->  Hash Join  (cost=30.49..43.58 rows=7 width=122) (actual time=0.076..0.080 rows=5 loops=1)
                     Hash Cond: (u.id = b.user_id)
                     ->  Seq Scan on users u  (cost=0.00..12.20 rows=220 width=122) (actual time=0.028..0.029 rows=4 loops=1)
                     ->  Hash  (cost=30.40..30.40 rows=7 width=8) (actual time=0.026..0.027 rows=5 loops=1)                           Buckets: 1024  Batches: 1  Memory Usage: 9kB
                           ->  Seq Scan on bookings_2025_07 b  (cost=0.00..30.40 rows=7 width=8) (actual time=0.012..0.015 rows=5 loops=1)
                                 Filter: ((check_in >= '2025-07-01'::date) AND (check_in < '2025-08-01'::date))
 Planning Time: 2.617 ms
 Execution Time: 0.373 ms
(17 rows)
