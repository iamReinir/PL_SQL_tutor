INSERT INTO departments (code, dept_name) VALUES ('001','human resource');
INSERT INTO departments (code, dept_name) VALUES ('002','finance');
INSERT INTO departments (code, dept_name) VALUES ('003','reseach and development');
INSERT INTO departments (code, dept_name) VALUES ('004','marketing');
INSERT INTO departments (code, dept_name) VALUES ('005','production');

INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('001','mr jame','male','08-jan-1996','001',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('002','jmmy','male','08-jan-1996','002',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('003','manager-san','female','08-jan-1996','003','001');
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('004','Sanny','female','08-jan-1996','004',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('005','John','male','08-jan-1996','005',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('006','Kein','male','08-jan-1996','002',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('007','Aris','female','08-jan-1996','001',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('008','Alicia','female','08-jan-1996','003','003');