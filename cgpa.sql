
CREATE TABLE Student_Info(Student_ID INT IDENTITY (100,2) PRIMARY KEY, student_name VARCHAR(20) UNIQUE,
Department VARCHAR(20) DEFAULT 'Mechanical');
SELECT * FROM Student_Info;


-- inserting into student_info table--
INSERT INTO Student_Info VALUES('Chika Ogbonna', 'Biomedical');
INSERT INTO Student_Info (student_name) VALUES('Akanji Folarin');
INSERT INTO Student_Info VALUES('John Akpan', 'Electrical');
INSERT INTO Student_Info(student_name)  VALUES('Faith Luke');
INSERT INTO Student_Info VALUES('Donald Dave', 'Computer');
INSERT INTO Student_Info (student_name)  VALUES('Wole Steve');



CREATE TABLE Courses (Student_ID INT,Course_Title VARCHAR(20), Course_id VARCHAR(20),Score INT, Unit INT,
FOREIGN KEY (Student_ID) REFERENCES Student_info(Student_ID));
SELECT * FROM Courses;

 alter table drop column grade_point;

-- inserting into course--

-- Inserting computer application course--
INSERT INTO Courses VALUES (100,'Computer Application','CPT101','65',3);
INSERT INTO Courses VALUES (102,'Computer Application','CPT101','42',3);
INSERT INTO Courses VALUES (104,'Computer Application','CPT101','49',3);
INSERT INTO Courses VALUES (106,'Computer Application','CPT101','57',3);
INSERT INTO Courses VALUES (108,'Computer Application','CPT101','32',3);
INSERT INTO Courses VALUES (110,'Computer Application','CPT101','85',3);

-- Inserting Mechanics of Machine course--
INSERT INTO Courses VALUES (100,'Mechanics of Machine','MEE112','75',3);
INSERT INTO Courses VALUES (102,'Mechanics of Machine','MEE112','65',3);
INSERT INTO Courses VALUES (104,'Mechanics of Machine','MEE112','49',3);
INSERT INTO Courses VALUES (106,'Mechanics of Machine','MEE112','61',3);
INSERT INTO Courses VALUES (108,'Mechanics of Machine','MEE112','53',3);
INSERT INTO Courses VALUES (110,'Mechanics of Machine','MEE112','86',3);

-- Inserting Law of Electricity course--
INSERT INTO Courses VALUES (100,'Law of Electricity','ELE122','47',3);
INSERT INTO Courses VALUES (102,'Law of Electricity','ELE122','56',3);
INSERT INTO Courses VALUES (104,'Law of Electricity','ELE122','23',3);
INSERT INTO Courses VALUES (106,'Law of Electricity','ELE122','39',3);
INSERT INTO Courses VALUES (108,'Law of Electricity','ELE122','67',3);
INSERT INTO Courses VALUES (110,'Law of Electricity','ELE122','94',3);

-- Inserting Structural Analysis course--
INSERT INTO Courses VALUES (100,'Structural Analysis','CVE105','59',2);
INSERT INTO Courses VALUES (102,'Structural Analysis','CVE105','49',2);
INSERT INTO Courses VALUES (104,'Structural Analysis','CVE105','55',2);
INSERT INTO Courses VALUES (106,'Structural Analysis','CVE105','62',2);
INSERT INTO Courses VALUES (108,'Structural Analysis','CVE105','57',2);
INSERT INTO Courses VALUES (110,'Structural Analysis','CVE105','72',2);

-- Inserting Workshop Practice course--
INSERT INTO Courses VALUES (100,'Workshop Practice','GNE111','64',1);
INSERT INTO Courses VALUES (102,'Workshop Practice','GNE111','65',1);
INSERT INTO Courses VALUES (104,'Workshop Practice','GNE111','72',1);
INSERT INTO Courses VALUES (106,'Workshop Practice','GNE111','45',1);
INSERT INTO Courses VALUES (108,'Workshop Practice','GNE111','77',1);
INSERT INTO Courses VALUES (110,'Workshop Practice','GNE111','89',1);

SELECT * FROM COURSES;

SELECT * FROM Student_Info;


ALTER TABLE COURSES ADD Grade varchar (1);

-- Assigning each scores to a grade point using CASE conditional statement --
UPDATE Courses  
SET GRADE =
CASE
WHEN Score > 69 THEN 'A'
WHEN Score BETWEEN 60 AND 69 THEN 'B'
WHEN Score BETWEEN 50 AND 59 THEN 'C'
WHEN Score BETWEEN 45 AND 49 THEN 'D'
WHEN Score BETWEEN 40 AND 44 THEN 'E'
ELSE 'F'
END;

select * from courses


ALTER TABLE COURSES ADD Grade_point INT;

UPDATE COURSES 
SET Grade_point= CASE
WHEN Score > 69 THEN '5'
WHEN Score BETWEEN 60 AND 69 THEN '4'
WHEN Score BETWEEN 50 AND 59 THEN '3'
WHEN Score BETWEEN 45 AND 49 THEN '2'
WHEN Score BETWEEN 40 AND 44 THEN '1'
ELSE '0'
END 

--- Or Alternatively --
UPDATE COURSES 
SET Grade_point= 5 WHERE Score > 69 
UPDATE COURSES
SET Grade_point= 4 WHERE Score BETWEEN 60 AND 69
UPDATE COURSES
SET Grade_point =3 WHERE Score BETWEEN 50 AND 59
UPDATE COURSES
SET Grade_point= 2 WHERE Score BETWEEN 45 AND 49
UPDATE COURSES
SET Grade_point= 1 WHERE Score BETWEEN 40 AND 44
UPDATE COURSES
SET Grade_point= 0 WHERE Score < 40;



-- CGPA calculations working to see which one works--
SELECT  CAST(Grade_point * unit / Unit AS DECIMAL(5,2)) AS CGPA FROM Courses;

ALTER TABLE Courses DROP COLUMN CGPA;
ALTER TABLE Courses DROP COLUMN Grade;



-- final cgpa real column calculations and update --
ALTER TABLE Courses ADD CGPA DECIMAL(5,2);

UPDATE Courses
SET CGPA = CAST(Grade_point * unit / Unit AS DECIMAL(5,2));



SELECT * FROM COURSES


-- RETRIEVEING SOME DATA--

-- Retrieving the Students cgpa --
SELECT  Student_ID, CAST(SUM(Unit * Grade_point) * 1.0 / SUM(Unit) AS DECIMAL(5,2)) AS CGPA
FROM Courses
GROUP BY Student_ID
ORDER BY Student_ID;

-- Retrieving the Students Who Failed Any Course --
SELECT  Student_ID, Course_Title, Course_ID, Score, Grade FROM Courses
WHERE Grade = 'F';




DROP TABLE IF EXISTS Student_Info;
DROP TABLE IF EXISTS courses;


