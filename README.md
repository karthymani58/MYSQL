# Employee Database Management & SQL Analysis

This project contains SQL scripts for populating, updating, and querying a relational employee database (`employee_database`). It demonstrates core SQL operations including DDL modifications, DML insertions/updates, filtering, aggregation, grouping, and various types of table joins.

---

## 📋 Table of Contents
- [Database Schema Overview](#database-schema-overview)
- [Setup & Data Population](#setup--data-population)
- [Key SQL Operations Covered](#key-sql-operations-covered)
  - [1. Data Filtering & Cleaning](#1-data-filtering--cleaning)
  - [2. Sorting & Pagination](#2-sorting--pagination)
  - [3. Aggregations & Grouping](#3-aggregations--grouping)
  - [4. Table Joins](#4-table-joins)
- [Notes & Query Observations](#notes--query-observations)

---

## 🗄️ Database Schema Overview

The script interacts with three primary tables within `employee_database`:

1. **`department_info`**: Stores department IDs and names (13 departments ranging from *Software Development* to *Operations*).
2. **`locations`**: Stores office locations (*Chennai*, *Bangalore*, *Hyderabad*, *Pune*).
3. **`employees`**: Stores employee records including personal details, `hire_date` (renamed from `date_of_join`), `designation`, `salary`, and foreign keys linking to `department_info` and `locations`.

---

## 🚀 Setup & Data Population

1. **Select Database**: Switches context to `employee_database`.
2. **Schema Modification**: Renames `date_of_join` to `hire_date` in the `employees` table using `ALTER TABLE`.
3. **Data Insertion**:
   - Populates `department_info` with 13 departments.
   - Populates `locations` with 4 Indian cities.
   - Inserts 30 employee records (`employee_id` 5001 to 5030).

---

## 🔍 Key SQL Operations Covered

### 1. Data Filtering & Cleaning
* **Distinct Values**: Retrieves unique salary tiers across the organization (`SELECT DISTINCT`).
* **Column Aliasing**: Renames `age` and `salary` outputs for readability.
* **Conditional Filtering**: Filters employees earning $> 50,000$ hired before `2016-01-01` using `WHERE` and `AND`.
* **Handling Missing Data**: Identifies `NULL` or empty designations (`employee_id = 5004`) and updates the record to `'Data Scientist'`.

### 2. Sorting & Pagination
* **Multi-Column Sorting**: Orders employees by `department_id` (ascending) and `salary` (descending).
* **Limiting Results**: Fetches the first 5 employees hired in `2018` using `YEAR()` and `LIMIT`.

### 3. Aggregations & Grouping
* **Departmental Totals**: Calculates the sum of salaries in the *Finance* department.
* **Minimum Values**: Finds the youngest employee's age using `MIN()`.
* **Location Metrics**: Groups employees by `location` to calculate salary metrics and average rounded ages (`ROUND(AVG(...))`).
* **Pattern Matching**: Calculates average salaries for all designations containing the word `"Analyst"` using `LIKE '%analyst%'`.
* **Having Clause**: Filters grouped results to find departments with fewer than 3 employees (`HAVING total_employee < 3`) and locations with an average age below 30.

### 4. Table Joins
* **`INNER JOIN`**: Combines `employees` and `department_info` to display employee names, designations, and department names.
* **`LEFT JOIN`**: Lists all departments alongside their employee headcount, ensuring departments with `0` employees are still included.
* **`RIGHT JOIN`**: Lists all office locations and their assigned employees, displaying `NULL` if a location has no assigned staff.

---

## 💡 Notes & Query Observations

If you plan to refine or reuse these queries in production, keep the following minor adjustments in mind:
* **Maximum vs. Minimum Salary Query**: Under `-- maximum salary for each location`, the query currently uses `MIN(e.salary)`. Change `MIN` to `MAX` if you intend to retrieve the highest salary per city.
* **Female Employees Filter**: Under `-- locations with female employees whose average age is below 30`, consider adding `WHERE e.gender = 'F'` before the `GROUP BY` clause to filter specifically for female employees.
* **Typo Fixes**: Column aliases like `total_salart` and `minmun_salary` can be updated to `total_salary` and `minimum_salary` for cleaner output headers.