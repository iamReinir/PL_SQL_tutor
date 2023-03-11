
CREATE TABLE departments(
    code varchar2(20) PRIMARY KEY,
    dept_name varchar2(50) NOT NULL
);

CREATE TABLE employees(
    code varchar2(20) PRIMARY KEY,
    fullname varchar2(50) NOT NULL,
    gender varchar2(20),
    dateOfBirth DATE NOT NULL,
    department varchar2(20) NOT NULL,
    managerOf varchar2(20),
    CONSTRAINT employee_of_department
        FOREIGN KEY (department)
        REFERENCES departments(code),
    CONSTRAINT manager_of_department
        FOREIGN KEY (managerOf)
        REFERENCES departments(code)
);

CREATE TABLE supervise(
    supervisor varchar2(20),
    supervised varchar2(20),
    relation varchar2(50),
    PRIMARY KEY (supervisor, supervised),
    CONSTRAINT supervisor_fk
        FOREIGN KEY (supervisor)
        REFERENCES employees(code),
    CONSTRAINT supervised_fk
        FOREIGN KEY (supervised)
        REFERENCES employees(code),
    CONSTRAINT bootstrap
        CHECK (supervisor != supervised)
);

CREATE TABLE projects(
    code varchar2(20) PRIMARY KEY,
    proj_name varchar2(50) NOT NULL,
    proj_location varchar2(50),
    managingDept varchar2(20),
    CONSTRAINT managingDept_fk
        FOREIGN KEY (managingDept)
        REFERENCES departments(code)
);

CREATE TABLE projectJoin(
    employee varchar2(20),
    project varchar2(20),
    total_hour INT DEFAULT 0,
    stillInProject NUMBER(1) DEFAULT 0,
    CONSTRAINT employee_fk
        FOREIGN KEY (employee)
        REFERENCES employees(code),
    CONSTRAINT project_fk
        FOREIGN KEY (project)
        REFERENCES projects(code),
    CONSTRAINT positiveHour
        CHECK (total_hour >= 0)
);
