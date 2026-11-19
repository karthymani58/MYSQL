# E-Learning Purchase Analysis (MySQL)

A MySQL project that designs a relational database for an online learning platform and analyzes purchase data to uncover sales trends, learner behavior, and popular course categories.

## Project Structure

```
elearning_project/
├── elearning_analysis.sql   # Schema, sample data, join queries, Q1-Q5
├── Summary_Report.docx      # One-page insights and recommendations (or .pdf)
└── README.md                # This file
```

## Database Schema

**Database:** `elearning_db`

| Table | Columns | Notes |
|---|---|---|
| `learners` | `learner_id` (PK), `full_name`, `country` | One row per learner |
| `courses` | `course_id` (PK), `course_name`, `category`, `unit_price` | `unit_price` must be > 0 |
| `purchases` | `purchase_id` (PK), `learner_id` (FK), `course_id` (FK), `quantity`, `purchase_date` | `quantity` must be > 0 |

### Relationships

- `purchases.learner_id` references `learners.learner_id`
- `purchases.course_id` references `courses.course_id`
- One learner can make many purchases; one course can appear in many purchases.

## Sample Data

- 5 learners (India, USA, Brazil, Ireland)
- 5 courses across 4 categories (Programming, Data Science, Marketing, Design)
- 8 purchase records (January to April 2026)

The data is designed so that every query has something meaningful to show:

- **Paul Stirling** has no purchases (demonstrates `LEFT JOIN`).
- **Machine Learning A-Z** is never purchased (demonstrates `RIGHT JOIN` and Q5).

## How to Run

### Option 1: MySQL Workbench

1. Open MySQL Workbench and connect to your server.
2. Go to **File → Open SQL Script** and select `elearning_analysis.sql`.
3. Click the lightning bolt icon to run the whole script.
4. Check each result tab in the output grid.

### Option 2: Command line

```bash
mysql -u root -p < elearning_analysis.sql
```

### Option 3: Inside the MySQL shell

```sql
SOURCE /path/to/elearning_analysis.sql;
```

## What the Script Contains

### 1. Setup
- `CREATE DATABASE`, `CREATE TABLE` with primary keys, foreign keys, `NOT NULL`, and `CHECK` constraints
- `INSERT` statements for all three tables

### 2. Data Exploration with Joins

| Query | Join type | Purpose |
|---|---|---|
| 4a | `INNER JOIN` | Full purchase details (learner, course, category, quantity, total, date) |
| 4b | `LEFT JOIN` | All learners, including those with no purchases |
| 4c | `RIGHT JOIN` | All courses, including those never purchased |

### 3. Analytical Queries

| # | Question | Key SQL concepts |
|---|---|---|
| Q1 | Total spending per learner with country | `SUM`, `LEFT JOIN`, `GROUP BY`, `COALESCE` |
| Q2 | Top 3 most purchased courses | `SUM`, `ORDER BY`, `LIMIT` |
| Q3 | Revenue and unique learners per category | `SUM`, `COUNT(DISTINCT)`, `GROUP BY` |
| Q4 | Learners who bought from more than one category | `COUNT(DISTINCT)`, `HAVING` |
| Q5 | Courses never purchased | `LEFT JOIN`, `WHERE ... IS NULL` |

## Expected Results

| Query | Expected output |
|---|---|
| Q1 | Smriti Mandhana 209.96, Corey Anderson 189.97, Virat Kohli 189.96, Lucas Perri 39.99, Paul Stirling 0.00 |
| Q2 | Python for Beginners (4), Data Analysis with SQL (4), Digital Marketing Basics (3) |
| Q3 | Data Science 239.96 (3 learners), Programming 199.96 (2), Marketing 119.97 (2), Design 69.99 (1) |
| Q4 | Virat Kohli (3 categories), Corey Anderson (2), Smriti Mandhana (2) |
| Q5 | Machine Learning A-Z |

**Total revenue:** 629.88

## Formatting Conventions

- Currency values are formatted to 2 decimal places using `FORMAT(value, 2)`.
- Every output column uses a readable alias (for example `AS total_revenue`).
- Results are sorted logically (for example highest spender first).
- Revenue formula: `quantity * unit_price`

## Key Insights (Summary)

- Data Science is the top category by revenue and by unique learners.
- Python for Beginners and Data Analysis with SQL are the best sellers.
- Most buying learners purchase across multiple categories.
- One course has no sales and one learner has no purchases, both of which are opportunities.

See `Summary_Report.docx` for the full findings and recommendations.

## Requirements

- MySQL 8.0.16 or later (needed for `CHECK` constraints to be enforced)
- MySQL Workbench or any MySQL client

## Skills Demonstrated

- Database setup and data entry
- `INNER`, `LEFT`, and `RIGHT` joins
- Aggregation and filtering (`GROUP BY`, `HAVING`, `WHERE`, `ORDER BY`, `LIMIT`)
- Derived calculations (revenue, totals, distinct counts)
- Clear result presentation and business insights

## Author

Karthik.M
Date: November 2026
