
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
        REFERENCES departments(code)
        ON DELETE CASCADE,
    CONSTRAINT manager_of_department
        FOREIGN KEY (managerOf)
        REFERENCES departments(code)
        ON DELETE SET NULL
);

CREATE TABLE supervise(
    supervisor varchar2(20),
    supervised varchar2(20),
    PRIMARY KEY (supervisor, supervised),
    CONSTRAINT supervisor_fk
        FOREIGN KEY (supervisor)
        REFERENCES employees(code)
        ON DELETE SET NULL,
    CONSTRAINT supervised_fk
        FOREIGN KEY (supervised)
        REFERENCES employees(code)
        ON DELETE CASCADE,
    CONSTRAINT bootstrap
        CHECK (supervisor != supervised)
);

CREATE TABLE dependants(
    id varchar2(20) PRIMARY KEY,
    employee varchar2(20) NOT NULL,
    depend_name varchar2(50) NOT NULL,
    gender varchar2(20),
    dateOfBirth DATE NOT NULL,
    relationship varchar2(50),
    CONSTRAINT dependant_of_employee
        FOREIGN KEY (employee)
        REFERENCES employees(code)
        ON DELETE CASCADE
);

CREATE TABLE projects(
    code varchar2(20) PRIMARY KEY,
    proj_name varchar2(50) NOT NULL,
    proj_location varchar2(50),
    managingDept varchar2(20),
    CONSTRAINT managingDept_fk
        FOREIGN KEY (managingDept)
        REFERENCES departments(code)
        ON DELETE SET NULL
);

CREATE TABLE projectJoin(
    employee varchar2(20),
    project varchar2(20),
    total_hour INT DEFAULT 0,
    stillInProject NUMBER(1) DEFAULT 0,
    PRIMARY KEY (employee, project),
    CONSTRAINT employee_fk
        FOREIGN KEY (employee)
        REFERENCES employees(code)
        ON DELETE CASCADE,
    CONSTRAINT project_fk
        FOREIGN KEY (project)
        REFERENCES projects(code)
        ON DELETE CASCADE,
    CONSTRAINT positiveHour
        CHECK (total_hour >= 0)
);
