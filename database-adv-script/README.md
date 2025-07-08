# Database Advanced Scripts

This directory contains SQL scripts for advanced database operations on the ALX Airbnb clone project.

## Task 1: Write Complex Queries with JOINs
-  **Objective**: Master SQL joins by writing complex queries.
- **Files**:
  - `joins_queries.sql`: Contains queries using INNER JOIN, LEFT JOIN, and FULL OUTER JOIN.
- **Instructions**:
  - a) INNER JOIN to retrieve all bookings and respective users.
  - b) LEFT JOIN to retrieve all properties and their reviews, including properties with no reviews.
  - c) FULL OUTER JOIN to retrieve all users and all bookings, even with no matches.
- **Status**: In progress - Queries implemented in `joins_queries.sql` with ORDER BY added and LEFT JOIN fixed to include all properties.

## Task 2: Practice Subqueries
- **Objective**: Develop proficiency in writing SQL subqueries.
- **Files**:
  - `subqueries.sql`: Contains queries using non-correlated and correlated subqueries.
- **Instructions**:
  - a) Non-correlated subquery to find properties with price above average.
  - b) Correlated subquery to find users with more than 3 bookings.
- **Status**: Completed - Queries updated to include average rating > 4.0 and > 3 bookings check.

## Task 3: Aggregations and Window Functions
- **Objective**: Enhance SQL skills with aggregations and window functions.
- **Files**:
  - `aggregations_and_window_functions.sql`: Contains queries using aggregation and window functions.
- **Instructions**:
  - a) Aggregation function to count bookings per user.
  - b) Window function to rank properties by total number of bookings
- **Status**: Completed - Queries implemented, Task 3b updated to use RANK() and ROW_NUMBER() to address review feedback inconsistencies.

## Task 4: Indexing for Optimization
- **Objective**: Improve query performance with indexing.
- **Files**:
  - `indexing_optimization.sql`: Contains index creation and performance analysis queries.
- **Instructions**:
  - a) Create an index on the user_id column in bookings.
  - b) Create an index on the property_id column in bookings.
  - c) Use EXPLAIN ANALYZE to compare JOIN performance before and after the user_id index.
- **Status**: In progress - Indexes and performance comparison implemented in `indexing_optimization.sql`.

## Task 5: Partitioning for Scalability
- **Objective**: Enhance scalability with table partitioning.
- **Files**:
  - `performance.sql`: Contains partitioning setup and performance test.
  - `optimization_report.md`: Documents partitioning strategy and results.
- **Instructions**:
  - a) Partition the bookings table by check_in date.
  - b) Test performance with EXPLAIN ANALYZE.
  - c) Document the strategy and results in optimization_report.md.
- **Status**: In progress - Partitioning and performance analysis implemented