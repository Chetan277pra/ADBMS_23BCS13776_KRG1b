
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    Ename VARCHAR(50),
    Department VARCHAR(50),
    ManagerID INT
);

INSERT INTO Employee (EmpID, Ename, Department, ManagerID) VALUES
(1, 'Rajiv', 'HR', NULL),
(2, 'Meera', 'Finance', 1),
(3, 'Arjun', 'IT', 1),
(4, 'Sneha', 'Finance', 2),
(5, 'Vikram', 'IT', 3),
(6, 'Pooja', 'HR', 1);

ALTER TABLE Employee 
ADD CONSTRAINT Fk_Employee FOREIGN KEY (ManagerID)
REFERENCES Employee(EmpID);

SELECT 
    e1.Ename AS 'Employee Name',
    e1.Department AS 'Employee Department',
    e2.Ename AS 'Manager Name',
    e2.Department AS 'Manager Department'
FROM 
    Employee AS e1
LEFT OUTER JOIN 
    Employee AS e2
ON 
    e1.ManagerID = e2.EmpID;

