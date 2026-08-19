use er_model;
INSERT INTO Department154
    (did, dname, office_location, year_started)
VALUES
    (1, 'Computer Science and Engineering', 'Block A', 2005),
    (2, 'Electronics and Communication Engineering', 'Block B', 2006),
    (3, 'Electrical Engineering', 'Block C', 2007),
    (4, 'Mechanical Engineering', 'Block D', 2008),
    (5, 'Information Technology', 'Block E', 2010);
    
    -- SELECT * FROM Department;
    
    -- Insert 5 courses
INSERT INTO Course154
    (cid, cname, discipline, did)
VALUES
    (101, 'B.Tech CSE', 'Computer Science', 1),
    (102, 'B.Tech ECE', 'Electronics', 2),
    (103, 'B.Tech EE', 'Electrical', 3),
    (104, 'B.Tech ME', 'Mechanical', 4),
    (105, 'B.Tech IT', 'Information Technology', 5);
    
    -- select * from course;
    
-- Insert 5 class sections
INSERT INTO Class_Section154
    (section_id, batch)
VALUES
    (1, 2024),
    (2, 2024),
    (3, 2025),
    (4, 2025),
    (5, 2026);
    
    -- select * from class_section;
-- Insert 5 subject papers
INSERT INTO SubjectPaper154
    (paper_code, pname, credit, cid, semester)
VALUES
    (501, 'Data Structures', 4, 101, 3),
    (502, 'Database Management System', 4, 101, 5),
    (503, 'Digital Electronics', 4, 102, 3),
    (504, 'Electrical Circuits', 4, 103, 3),
    (505, 'Engineering Mechanics', 3, 104, 3);
    
    -- select * from subjectpaper;
    
    -- Insert 5 faculty members
INSERT INTO Faculty154
    (emp_id, name, mobile_no, salary, did, supervisor_emp_id)
VALUES
    (101, 'Dr. Amit Sharma', '9000000001', 75000.00, 1, NULL),
    (102, 'Dr. Priya Singh', '9000000002', 72000.00, 2, NULL),
    (103, 'Dr. Rahul Kumar', '9000000003', 70000.00, 3, NULL),
    (104, 'Dr. Neha Gupta', '9000000004', 68000.00, 4, NULL),
    (105, 'Dr. Arjun Das', '9000000005', 65000.00, 5, NULL);
    
    -- SELECT * FROM Faculty;
    ALTER TABLE Student154
ADD COLUMN house_no_locality VARCHAR(100),
ADD COLUMN city VARCHAR(50),
ADD COLUMN pincode VARCHAR(10);
    -- Insert 5 students
INSERT INTO Student154
    (roll_no, sname, email_id, mobile_no, date_of_birth,
     house_no_locality, city, pincode, cid, year_of_admission, section_id)
VALUES
    (1, 'Rahim', 'rahim@gmail.com', '9000000011', '2004-05-12',
     'House 12, Main Road', 'Madhubani', '847211', 101, 2024, 1),

    (2, 'Aman', 'aman@gmail.com', '9000000012', '2004-08-20',
     'House 25, Station Road', 'Kolkata', '700001', 102, 2024, 2),

    (3, 'Ravi', 'ravi@gmail.com', '9000000013', '2005-01-15',
     'House 8, College Road', 'Patna', '800001', 103, 2025, 3),

    (4, 'Priya', 'priya@gmail.com', '9000000014', '2004-11-10',
     'House 17, Park Road', 'Delhi', '110001', 104, 2025, 4),

    (5, 'Neha', 'neha@gmail.com', '9000000015', '2005-03-25',
     'House 30, Market Road', 'Ranchi', '834001', 105, 2026, 5);
     
     -- describe student;
     -- select * from student;
     
     -- Insert 5 exam records
INSERT INTO Exam154
    (roll_no, paper_code, session, marks)
VALUES
    (1, 501, '2026', 85),
    (2, 502, '2026', 78),
    (3, 503, '2026', 91),
    (4, 504, '2026', 74),
    (5, 505, '2026', 88);
    
	-- Insert 5 teaching relationship records
INSERT INTO Teaches154
    (emp_id, paper_code, session)
VALUES
    (101, 501, '2026'),
    (102, 503, '2026'),
    (103, 504, '2026'),
    (104, 505, '2026'),
    (105, 502, '2026');
    
    -- Assign heads to departments
UPDATE Department154
SET head_emp_id = 101
WHERE did = 1;

UPDATE Department154
SET head_emp_id = 102
WHERE did = 2;

UPDATE Department154
SET head_emp_id = 103
WHERE did = 3;

UPDATE Department154
SET head_emp_id = 104
WHERE did = 4;

UPDATE Department154
SET head_emp_id = 105
WHERE did = 5;




-- Assign faculty supervisors
UPDATE Faculty154
SET supervisor_emp_id = 101
WHERE emp_id IN (102, 103);

UPDATE Faculty154
SET supervisor_emp_id = 102
WHERE emp_id = 104;

UPDATE Faculty154
SET supervisor_emp_id = 103
WHERE emp_id = 105;

/*SELECT emp_id, name, supervisor_emp_id
FROM Faculty;
*/

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'er_model'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'er_model'
ORDER BY TABLE_NAME;
