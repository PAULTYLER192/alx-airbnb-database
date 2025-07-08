# Optimization Report

This report documents the partitioning strategy and performance analysis for the `bookings` table in the ALX Airbnb clone database.

## Task 5: Partitioning for Scalability

### Objective
Enhance database scalability by partitioning the `bookings` table and evaluating the performance impact using `EXPLAIN ANALYZE`.

### Partitioning Strategy
- **Table**: `bookings`
- **Partitioning Method**: Range partitioning by `check_in` date.
- **Partition Details**:
  - `bookings_2025_07`: Covers dates from 2025-07-01 to 2025-08-01.
  - `bookings_2025_08`: Covers dates from 2025-08-01 to 2025-09-01.
- **Rationale**: Monthly partitions align with booking trends, enabling efficient pruning for date-based queries as the dataset grows.

### Performance Analysis
The following query was tested:
```sql
SELECT u.username, COUNT(b.id) AS booking_count
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
WHERE b.check_in >= '2025-07-01' AND b.check_in < '2025-08-01'
GROUP BY u.username
ORDER BY booking_count DESC;