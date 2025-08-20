CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

INSERT INTO department (dept_id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');


INSERT INTO employee (emp_id, emp_name, salary, dept_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);


SELECT d.dept_name, e.emp_name, e.salary
FROM employee AS e
INNER JOIN department AS d ON d.dept_id = e.dept_id
WHERE e.salary = (
    SELECT MAX(salary)
    FROM employee
    WHERE dept_id = e.dept_id
)
ORDER BY d.dept_name, e.emp_name;
