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
LEFT JOIN properties p ON b.property_id = p.id;