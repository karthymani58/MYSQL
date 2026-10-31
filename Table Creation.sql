
-- Department Table Created
CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100)
);
-- Location Table Created
CREATE TABLE location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    location VARCHAR(30)
);
-- Employee Table Created
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(50),
    gender ENUM("Male","Female"),
    age INT,
    hire_date DATE,
    designation VARCHAR(50),
    department_id INT,
    location_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (location_id) REFERENCES location(location_id)
);

-- Inserted Email id in Employee
ALTER TABLE employees 
ADD email_id VARCHAR(30);

-- Modified Designation Column Data Type 
ALTER TABLE employees MODIFY COLUMN designation VARCHAR(100);

-- Dropping Age Column From Employee Table
ALTER TABLE employees 
DROP COLUMN age;

-- Renaming Column Name Hire Date to Date Of Join
ALTER TABLE employees
RENAME COLUMN hire_date TO date_of_join;

-- Renaming Table Name Department to Department Info
RENAME TABLE department TO department_info;

-- Renaming Table Name Location to Locations
RENAME TABLE location TO locations;

-- Drop DB Employee
DROP DATABASE IF EXISTS employee;

-- Department Column Data Type Changed
ALTER TABLE department 
MODIFY COLUMN department_name VARCHAR(100) NOT NULL UNIQUE;

-- Location table Alter
ALTER TABLE locations 
MODIFY COLUMN location VARCHAR(30) NOT NULL;
ALTER TABLE locations 
ADD CONSTRAINT uk_location UNIQUE (location);

-- Employee Table Alter
ALTER TABLE employees 
    MODIFY COLUMN employee_name VARCHAR(50) NOT NULL,
    MODIFY COLUMN gender CHAR(1) CHECK (gender IN ('M', 'F')),
    ADD COLUMN age INT CHECK (age >= 18),
    MODIFY COLUMN date_of_join DATE DEFAULT (CURRENT_DATE),
    ADD CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES department_info(department_id),
    ADD CONSTRAINT fk_emp_loc FOREIGN KEY (location_id) REFERENCES locations(location_id);

