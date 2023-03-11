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
        ON DELETE CASCADE
);
CREATE TABLE subjects(
    code varchar2(20) PRIMARY KEY,
    sub_name varchar2(20) NOT NULL,
    total_credit int,
    practive_credit int,
    theory_credit int,
    department varchar2(20) NOT NULL,
    CONSTRAINT subject_of_department
        FOREIGN KEY (department)
        REFERENCES departments(code)
        ON DELETE CASCADE
);

CREATE TABLE prerequisite(
    id INT PRIMARY KEY,
    subj varchar2(20) NOT NULL,
    require varchar2(20),
    CONSTRAINT base_subj
        FOREIGN KEY (subj)
        REFERENCES subjects(code)
        ON DELETE CASCADE,
    CONSTRAINT req
        FOREIGN KEY (require)
        REFERENCES subjects(code)
        ON DELETE SET NULL,
    CONSTRAINT bootstrap
        CHECK (subj != require)
);

CREATE TABLE instructors(
    id varchar2(20) PRIMARY KEY,
    fullname varchar2(20) NOT NULL,
    birthdate DATE,
    gender varchar2(20),
    supervise varchar2(20),
    supervise_since DATE,
    department varchar2(20) NOT NULL,
    CONSTRAINT supervising
        FOREIGN KEY (supervise)
        REFERENCES classes(code)
        ON DELETE SET NULL,
    CONSTRAINT instructor_of_dept
        FOREIGN KEY (department)
        REFERENCES departments(code)
        ON DELETE CASCADE

);

CREATE TABLE qualifications(
    id INT PRIMARY KEY,
    specialize_training varchar2(500),
    training_institue varchar2(20) NOT NULL,
    graduation_year NUMBER(4),
    instructor varchar2(20),
    CONSTRAINT qual_of_instructor
        FOREIGN KEY (instructor)
        REFERENCES instructors(id)
        ON DELETE CASCADE
);

CREATE TABLE teach(
    id INT PRIMARY KEY,
    instructor varchar2(20) NOT NULL,
    subj varchar2(20) NOT NULL,
    CONSTRAINT instructor_teach
        FOREIGN KEY (instructor)
        REFERENCES instructors(id)
        ON DELETE CASCADE,
    CONSTRAINT subj_supervised
        FOREIGN KEY (subj)
        REFERENCES subjects(code)
        ON DELETE CASCADE
);
CREATE TABLE students(
    student_number varchar2(20) PRIMARY KEY,
    student_name varchar2(20) NOT NULL,
    SCN varchar2(20) NOT NULL,
    gender varchar2(20),
    student_address varchar2(50),
    class varchar2(20),
    CONSTRAINT student_of_class
        FOREIGN KEY (class)
        REFERENCES classes(code)
        ON DELETE CASCADE
);

CREATE TABLE subject_join(
    id INT PRIMARY KEY,
    subject_code varchar2(20) NOT NULL,
    student_number varchar2(20) NOT NULL,
    practical_grade number,
    theory_grade number,
    CONSTRAINT subj
        FOREIGN KEY (subject_code)
        REFERENCES subjects(code)
        ON DELETE CASCADE,
    CONSTRAINT stud
        FOREIGN KEY (student_number)
        REFERENCES students(student_number)
        ON DELETE CASCADE
);

CREATE TABLE sections(
    class varchar2(20),
    sect_number INT,
    sect_year NUMBER(4),
    sem_no INT,
    instructor varchar2(20) NOT NULL,
    subj varchar2(20) NOT NULL,
    PRIMARY KEY (class, sect_number, sect_year, sem_no),
    CONSTRAINT section_of_class
        FOREIGN KEY (class)
        REFERENCES classes(code)
        ON DELETE CASCADE,
    CONSTRAINT subj_of_section
        FOREIGN KEY (subj)
        REFERENCES subjects(code)
        ON DELETE CASCADE,
    CONSTRAINT instructor_of_section
        FOREIGN KEY (instructor)
        REFERENCES instructors(id)
        ON DELETE CASCADE
);