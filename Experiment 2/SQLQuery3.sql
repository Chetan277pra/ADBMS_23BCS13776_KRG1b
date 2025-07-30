CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL
);

ALTER TABLE Employee  
ADD CONSTRAINT FK_Employee FOREIGN KEY (ManagerID)
REFERENCES Employee(EmpID);

INSERT INTO Employee (EmpID, EmpName, Department, ManagerID) VALUES
(1, 'Mohan', 'Admin', NULL),
(2, 'Ankit', 'Sales', 1),
(3, 'Nisha', 'HR', 2),
(4, 'Meena', 'Sales', 2),
(5, 'Rohit', 'Admin', 1),
(6, 'Komal', 'HR', 3),
(7, 'Sameer', 'IT', 2);

SELECT 
    E1.EmpName AS [EMPLOYEE NAME], 
    E2.EmpName AS [MANAGER NAME],
    E1.Department AS [EMP_DEPARTMENT], 
    E2.Department AS [MANAGER_DEPT]
FROM Employee AS E1
LEFT OUTER JOIN Employee AS E2
    ON E1.ManagerID = E2.EmpID;
