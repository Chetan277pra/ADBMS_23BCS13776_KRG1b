CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    gender TEXT NOT NULL,
    department TEXT NOT NULL
);

INSERT INTO employees (emp_name, gender, department) VALUES
('Chetan', 'Male', 'IT'),
('Shivam', 'Male', 'Finance'),
('Yateen', 'Male', 'IT'),
('Amit', 'Male', 'Sales'),
('Anita', 'Female', 'HR'),
('Pooja', 'Female', 'Finance');

CREATE OR REPLACE PROCEDURE get_employee_count_by_gender(
    IN input_gender TEXT,
    OUT emp_count INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO emp_count
    FROM employees
    WHERE gender = input_gender;
END;
$$;

CALL get_employee_count_by_gender('Male', NULL);

CALL get_employee_count_by_gender('Female', NULL);
