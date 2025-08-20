DROP TABLE IF EXISTS TableA;
DROP TABLE IF EXISTS TableB;

CREATE TABLE TableA (
    EmpID INT,
    Ename VARCHAR(50),
    Salary INT
);

CREATE TABLE TableB (
    EmpID INT,
    Ename VARCHAR(50),
    Salary INT
);

INSERT INTO TableA VALUES
(1, 'AA', 1000),
(2, 'BB', 300);

INSERT INTO TableB VALUES
(2, 'BB', 400),
(3, 'CC', 100);

SELECT EmpID, Ename, Salary
FROM (
    SELECT EmpID, Ename, Salary,
           ROW_NUMBER() OVER (PARTITION BY EmpID ORDER BY Salary ASC) AS rn
    FROM (
        SELECT EmpID, Ename, Salary FROM TableA
        UNION ALL
        SELECT EmpID, Ename, Salary FROM TableB
    ) AS combined
) AS ranked
WHERE rn = 1
ORDER BY EmpID;
