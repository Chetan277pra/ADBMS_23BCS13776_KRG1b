CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    StudentID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

INSERT INTO Students (StudentID, StudentName) VALUES (1, 'ARJUN MALIK');
INSERT INTO Students (StudentID, StudentName) VALUES (2, 'PRIYA SHARMA');
INSERT INTO Students (StudentID, StudentName) VALUES (3, 'KAVYA MEHRA');

INSERT INTO Courses (CourseID, CourseName, StudentID) VALUES (101, 'DATA STRUCTURES', 1);
INSERT INTO Courses (CourseID, CourseName, StudentID) VALUES (102, 'DATABASE SYSTEMS', 2);

SELECT 
    S.StudentName,
    C.CourseName
FROM 
    Students S
LEFT OUTER JOIN 
    Courses C ON S.StudentID = C.StudentID;
