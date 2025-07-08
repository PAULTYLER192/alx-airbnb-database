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