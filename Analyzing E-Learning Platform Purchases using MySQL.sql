CREATE DATABASE elearning_db;
USE elearning_db;

CREATE TABLE learners (
    learner_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name  VARCHAR(100) NOT NULL,
    country    VARCHAR(50)  NOT NULL
);

CREATE TABLE courses (
    course_id   INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    category    VARCHAR(50)  NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL CHECK (unit_price > 0)
);

CREATE TABLE purchases (
    purchase_id   INT PRIMARY KEY AUTO_INCREMENT,
    learner_id    INT NOT NULL,
    course_id     INT NOT NULL,
    quantity      INT NOT NULL CHECK (quantity > 0),
    purchase_date DATE NOT NULL,
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

INSERT INTO learners (learner_id, full_name, country) VALUES
(1, 'Virat Kohli',  'India'),
(2, 'Corey Anderson', 'USA'),
(3, 'Lucas Perri', 'Brazil'),
(4, 'Smriti Mandhana',    'India'),
(5, 'Paul Stirling',  'Ireland');

INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(101, 'Python for Beginners',     'Programming',  49.99),
(102, 'Data Analysis with SQL',   'Data Science', 59.99),
(103, 'Digital Marketing Basics', 'Marketing',    39.99),
(104, 'UI/UX Design Fundamentals','Design',       69.99),
(105, 'Machine Learning A-Z',     'Data Science', 89.99);

INSERT INTO purchases (purchase_id, learner_id, course_id, quantity, purchase_date) VALUES
(1, 1, 101, 1, '2026-01-10'),
(2, 1, 102, 1, '2026-01-15'),
(3, 2, 102, 2, '2026-02-05'),
(4, 3, 103, 1, '2026-02-12'),
(5, 4, 101, 3, '2026-03-01'),
(6, 2, 104, 1, '2026-03-10'),
(7, 4, 102, 1, '2026-03-20'),
(8, 1, 103, 2, '2026-04-02');



-- INNER JOIN: full purchase details

SELECT l.full_name AS learner_name,
       c.course_name AS course_name,
       c.category AS category,
       p.quantity AS quantity,
       FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
       p.purchase_date AS purchase_date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses  c ON p.course_id  = c.course_id
ORDER BY p.quantity * c.unit_price DESC;

-- LEFT JOIN: all learners, including those with no purchases
SELECT l.full_name AS learner_name,
       c.course_name AS course_name,
       p.quantity AS quantity,
       p.purchase_date AS purchase_date
FROM learners l
LEFT JOIN purchases p ON l.learner_id = p.learner_id
LEFT JOIN courses   c ON p.course_id  = c.course_id
ORDER BY l.full_name;

-- RIGHT JOIN: all courses, including those never purchased

SELECT c.course_name AS course_name,
       c.category AS category,
       p.purchase_id AS purchase_id,
       p.quantity AS quantity
FROM purchases p
RIGHT JOIN courses c ON p.course_id = c.course_id
ORDER BY c.course_name;

-- Q1: Total spending per learner with country

SELECT l.full_name AS learner_name,
       l.country AS country,
       FORMAT(COALESCE(SUM(p.quantity * c.unit_price), 0), 2) AS total_spent
FROM learners l
LEFT JOIN purchases p ON l.learner_id = p.learner_id
LEFT JOIN courses   c ON p.course_id  = c.course_id
GROUP BY l.learner_id, l.full_name, l.country
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- Q2: Top 3 most purchased courses
SELECT c.course_name AS course_name,
       SUM(p.quantity) AS total_quantity_sold
FROM purchases p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY total_quantity_sold DESC, c.course_name
LIMIT 3;

-- Q3: Revenue and unique learners per category
SELECT c.category AS category,
       FORMAT(SUM(p.quantity * c.unit_price), 2) AS total_revenue,
       COUNT(DISTINCT p.learner_id) AS unique_learners
FROM purchases p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.category
ORDER BY SUM(p.quantity * c.unit_price) DESC;

-- Q4: Learners who bought from more than one category
SELECT l.full_name AS learner_name,
       COUNT(DISTINCT c.category) AS categories_purchased
FROM learners l
JOIN purchases p ON l.learner_id = p.learner_id
JOIN courses   c ON p.course_id  = c.course_id
GROUP BY l.learner_id, l.full_name
HAVING COUNT(DISTINCT c.category) > 1
ORDER BY categories_purchased DESC;

-- Q5: Courses never purchased
SELECT c.course_id AS course_id,
       c.course_name AS course_name,
       c.category AS category
FROM courses c
LEFT JOIN purchases p ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;