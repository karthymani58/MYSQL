USE employee_database;
-- Department details inserted
INSERT INTO department_info (department_id, department_name) VALUES
(1, 'Software Development'),
(2, 'Marketing'),
(3, 'Data Science'),
(4, 'Human Resources'),
(5, 'Product Management'),
(6, 'Content Creation'),
(7, 'Finance'),
(8, 'Design'),
(9, 'Research and Development'),
(10, 'Customer Support'),
(11, 'Business Development'),
(12, 'IT'),
(13, 'Operations');
-- location details
INSERT INTO locations (location) VALUES
('Chennai'),
('Bangalore'),
('Hyderabad'),
('Pune');
ALTER TABLE employees 
RENAME COLUMN date_of_join TO hire_date;
-- employee details
INSERT INTO employees(employee_id, employee_name, gender, age, hire_date, designation, department_id, location_id, salary) VALUES
(5001, 'Vihaan Singh', 'M', 27, '2015-01-20', 'Data Analyst', 3, 4, 60000),
(5002, 'Reyansh Singh', 'M', 31, '2015-03-10', 'Network Engineer', 12, 1, 80000),
(5003, 'Aaradhya Iyer', 'F', 26, '2015-05-20', 'Customer Support Executive', 10, 2, 45000),
(5004, 'Kiara Malhotra', 'F', 29, '2015-07-05', NULL, 8, 3, 70000),
(5005, 'Anvi Chaudhary', 'F', 25, '2015-09-11', 'Business Development Executive', 11, 1, 55000),
(5006, 'Dhruv Shetty', 'M', 28, '2015-11-20', 'UI Developer', 8, 2, 65000),
(5007, 'Anushka Singh', 'F', 32, '2016-01-15', 'Marketing Manager', 2, 3, 90000),
(5008, 'Diya Jha', 'F', 27, '2016-03-05', 'Graphic Designer', 8, 4, 70000),
(5009, 'Kiaan Desai', 'M', 30, '2016-05-20', 'Sales Executive', 11, 3, 55000),
(5010, 'Atharv Yadav', 'M', 29, '2016-07-10', 'Systems Administrator', 12, 4, 80000),
(5011, 'Saanvi Patel', 'F', 28, '2016-09-20', 'Marketing Analyst', 2, 1, 60000),
(5012, 'Myra Verma', 'F', 26, '2016-11-05', 'Operations Manager', 13, 2, 95000),
(5013, 'Arnav Rao', 'M', 33, '2017-01-20', 'Customer Success Manager', 10, 3, 75000),
(5014, 'Vihaan Mohan', 'M', 30, '2017-03-10', 'Supply Chain Analyst', 10, 2, 60000),
(5015, 'Ishaan Kumar', 'M', 27, '2017-05-20', 'Financial Analyst', 7, 1, 85000),
(5016, 'Zoya Khan', 'F', 31, '2017-07-05', 'Legal Counsel', 4, 4, 100000),
(5017, 'Kabir Nair', 'M', 28, '2017-09-11', 'IT Support Specialist', 12, 2, 80000),
(5018, 'Ishan Mishra', 'M', 25, '2017-11-20', 'Research Scientist', 9, 3, 75000),
(5019, 'Ishika Patel', 'F', 29, '2018-01-15', 'Talent Acquisition Specialist', 4, 4, 55000),
(5020, 'Aarav Nair', 'M', 32, '2018-03-05', 'Software Engineer', 1, 1, 90000),
(5021, 'Advik Kapoor', 'M', 26, '2018-05-20', 'Finance Analyst', 7, 3, 85000),
(5022, 'Aadhya Iyengar', 'F', 28, '2018-07-10', 'HR Specialist', 4, 4, 60000),
(5023, 'Anika Paul', 'F', 30, '2018-09-20', 'Public Relations Specialist', 2, 2, 70000),
(5024, 'Aryan Shetty', 'M', 27, '2018-11-05', 'Product Manager', 5, 1, 95000),
(5025, 'Avni Iyengar', 'F', 31, '2019-01-20', 'Data Scientist', 3, 4, 100000),
(5026, 'Vivaan Singh', 'M', 29, '2019-03-10', 'Business Analyst', 3, 2, 75000),
(5027, 'Ananya Paul', 'F', 32, '2019-05-20', 'Content Writer', 6, 3, 60000),
(5028, 'Anaya Kapoor', 'F', 26, '2019-07-05', 'Event Coordinator', 6, 1, 60000),
(5029, 'Arjun Kumar', 'M', 33, '2019-09-11', 'Quality Assurance Analyst', 12, 2, 80000),
(5030, 'Sara Iyer', 'F', 28, '2019-11-20', 'Project Manager', 5, 1, 90000);

-- 1. Distinct Salaries
select distinct salary from employees;

-- 2. Provide aliases Name for AGE and SALARY

select age as employee_age, salary as employee_salary from employees;

-- 3. employees salary > 50000 and hire date before 2016-01-01  using where and Operators

select salary,hire_date from employees where salary > 50000 and hire_date < '2016-01-01';

-- Find the employee whose designation is missing

select * from employees where designation is null or designation = '';

-- fill it with Data Scientist bassed on emp_id

update employees set designation = 'Data Scientist' where employee_id = 5004;

-- Sorting and Grouping Data order By

select * from employees order by department_id asc,salary desc;

-- Limit first 5 employees hired in 2018

select * from employees where year(hire_date) = 2018 order by employee_id ASC LIMIT 5;

-- Aggregate Functions

-- sum of all salaries in the Finance department
select di.department_name,sum(salary) as total_salart from employees e 
join department_info di 
on e.department_id = di.department_id 
where department_name like  "%Finance%"
group by di.department_name;

-- minimum age among all employees

SELECT MIN(age) AS minimum_age 
FROM employees;

-- GROUP BY
-- maximum salary for each location
Select l.location,min(e.salary) as minmun_salary 
from employees e
join locations l 
on e.location_id = l.location_id
 group by l.location;

-- average salary for each designation containing the word Analyst

select designation,avg(salary) from employees 
where designation like '%analyst%' 
group by designation;

-- departments with less than 3 employees
select di.department_name,count(e.employee_id) as total_employee from employees e
join  department_info di
on e.department_id = di.department_id
group by di.department_name
having total_employee <3;

-- locations with female employees whose average age is below 30 rounded age
select l.location,round(avg(e.age)) as average_age from employees e 
join locations l
on  e.location_id = l.location_id
group by l.location
having average_age < 30;

-- joined employee names, their designations, and department
select e.employee_name,e.designation,di.department_name from employees e 
join department_info di
on e.department_id = di.department_id;

-- left join departments along with the total number of employees in each department, including departments with no employees
select di.department_name, count(e.employee_id) as total_employee
from department_info di
left join employees e
on di.department_id = e.department_id
group by di.department_id,di.department_name;

/* all locations along with the names of employees assigned to each location. 
If no employees are assigned to a location, display NULL foremployee name.*/

select l.location,e.employee_name from employees e 
right join locations l
on e.location_id = l.location_id;





