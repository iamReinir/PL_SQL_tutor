CREATE TABLE departments(
    code varchar2(20) PRIMARY KEY,
    dept_name varchar2(20) NOT NULL,
    office_no int NOT NULL,
    phone varchar2(15)
);
CREATE TABLE classes(
    code varchar2(20) PRIMARY KEY,
    course_program  varchar2(500),
    department varchar2(20) NOT NULL,
    CONSTRAINT class_of_dept
        FOREIGN KEY (department)
        REFERENCES departments(code)
);
CREATE TABLE subjects(
    code varchar2(20) PRIMARY KEY,
    sub_name varchar2(20) NOT NULL,
    total_credit int,
    practive_credit int,
    theory_credit int,
    department varchar2(20) NOT NULL,
    CONSTRAINT subject_of_department
        FOREIGN KEY department
        REFERENCES departments(code)
);

CREATE TABLE instructors(
    id varchar2(20) PRIMARY KEY,
    fullname varchar2(20) NOT NULL,
    birthdate DATE,
    gender varchar2(20),
    supervise varchar2(20),
    department varchar2(20) NOT NULL
);

ALTER TABLE instructors
    ADD CONSTRAINT instructor_of_dept
        FOREIGN KEY department
        REFERENCES departments(code);
ALTER TABLE instructors
    ADD CONSTRAINT supervising
        FOREIGN KEY supervise
        REFERENCES classes(code)