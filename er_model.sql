
use er_model;
create table student154(
	roll_no int,
    sname varchar(100),
    email_id varchar (100),
    mobile_no decimal(10,0),
    date_of_birth Date,
    
    constraint pk_studnet primary key(roll_no),
    constraint uq_student_email unique(email_id),
    constraint uq_student_mobile unique(mobile_no)
    );
    -- describe student;
    alter table student154 modify sname varchar(100) not null;
    CREATE TABLE Course154 (
    cid INT,
    cname VARCHAR(100) NOT NULL,
    discipline VARCHAR(100),

    CONSTRAINT pk_course PRIMARY KEY (cid)
);
-- describe course;

ALTER TABLE Student154
ADD COLUMN cid INT,
ADD COLUMN year_of_admission YEAR;
ALTER TABLE Student154
ADD CONSTRAINT fk_student_course
FOREIGN KEY (cid)
REFERENCES Course154(cid);

CREATE TABLE Class_Section154 (
    section_id INT,
    batch INT,

    CONSTRAINT pk_class_section PRIMARY KEY (section_id)
);
ALTER TABLE Student154
ADD COLUMN section_id INT;
ALTER TABLE Student154
ADD CONSTRAINT fk_student_section
FOREIGN KEY (section_id)
REFERENCES Class_Section154(section_id);
CREATE TABLE SubjectPaper154 (
    paper_code INT,
    pname VARCHAR(100) NOT NULL,
    credit INT,

    CONSTRAINT pk_subject_paper PRIMARY KEY (paper_code)
);

ALTER TABLE SubjectPaper154
ADD COLUMN cid INT;

desc subjectpaper154;

ALTER TABLE SubjectPaper154
ADD CONSTRAINT fk_subject_paper_course
FOREIGN KEY (cid)
REFERENCES Course154(cid);
ALTER TABLE SubjectPaper154
ADD COLUMN semester INT;
desc subjectpaper154;
CREATE TABLE Faculty154 (
    emp_id INT,
    name VARCHAR(100) NOT NULL,
    mobile_no VARCHAR(15),
    salary DECIMAL(10,2),

    CONSTRAINT pk_faculty PRIMARY KEY (emp_id),
    CONSTRAINT uq_faculty_mobile UNIQUE (mobile_no)
);

ALTER TABLE Faculty154
ADD COLUMN did INT;

ALTER TABLE Faculty154
ADD COLUMN supervisor_emp_id INT;
ALTER TABLE Faculty154
ADD CONSTRAINT fk_faculty_supervisor
FOREIGN KEY (supervisor_emp_id)
REFERENCES Faculty154(emp_id);
    
CREATE TABLE Department154 (
    did INT,
    dname VARCHAR(100) NOT NULL,
    office_location VARCHAR(100),
    year_started YEAR,

    CONSTRAINT pk_department PRIMARY KEY (did)
);

ALTER TABLE Faculty154
ADD CONSTRAINT fk_faculty_department
FOREIGN KEY (did)
REFERENCES Department154(did);

ALTER TABLE Department154
ADD COLUMN head_emp_id INT;

ALTER TABLE Department154
ADD CONSTRAINT fk_department_head
FOREIGN KEY (head_emp_id)
REFERENCES Faculty154(emp_id);

ALTER TABLE Course154
ADD COLUMN did INT;

ALTER TABLE Course154
ADD CONSTRAINT fk_course_department
FOREIGN KEY (did)
REFERENCES Department154(did);

CREATE TABLE Exam154 (
    roll_no INT,
    paper_code INT,
    session VARCHAR(20),
    marks DECIMAL(5,2),

    CONSTRAINT pk_exam PRIMARY KEY (roll_no, paper_code, session),

    CONSTRAINT fk_exam_student
        FOREIGN KEY (roll_no)
        REFERENCES Student154(roll_no),

    CONSTRAINT fk_exam_subject_paper
        FOREIGN KEY (paper_code)
        REFERENCES SubjectPaper154(paper_code)
);


CREATE TABLE Teaches154 (
    emp_id INT,
    paper_code INT,
    session VARCHAR(20),

    CONSTRAINT pk_teaches
        PRIMARY KEY (emp_id, paper_code, session),

    CONSTRAINT fk_teaches_faculty
        FOREIGN KEY (emp_id)
        REFERENCES Faculty154(emp_id),

    CONSTRAINT fk_teaches_subject_paper
        FOREIGN KEY (paper_code)
        REFERENCES SubjectPaper154(paper_code)
);

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'er_model'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
  
  SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_KEY
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'er_model'
ORDER BY TABLE_NAME;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'er_model'
  AND REFERENCED_TABLE_NAME IS NOT NULL;
  
  SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'er_model'
ORDER BY TABLE_NAME;