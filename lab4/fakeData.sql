INSERT INTO departments (code, dept_name) VALUES ('D001','human resource');
INSERT INTO departments (code, dept_name) VALUES ('D002','finance');
INSERT INTO departments (code, dept_name) VALUES ('D003','reseach and development');
INSERT INTO departments (code, dept_name) VALUES ('D004','marketing');
INSERT INTO departments (code, dept_name) VALUES ('D005','production');

INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E001','mr jame','male','08-jan-1996','001',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E002','jmmy','male','08-jan-1996','002',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E003','manager-san','female','08-jan-1996','003','001');
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E004','Sanny','female','08-jan-1996','004',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E005','John','male','08-jan-1996','005',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E006','Kein','male','08-jan-1996','002',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E007','Aris','female','08-jan-1996','001',NULL);
INSERT INTO employees (code, fullname, gender, dateOfBirth, department, managerOf)
    VALUES ('E008','Alicia','female','08-jan-1996','003','003');

supervise
INSERT INTO supervise (supervisor, supervised, relation) VALUES ('E001', 'E002', 'Direct manager');
INSERT INTO supervise (supervisor, supervised, relation) VALUES ('E001', 'E003', 'Indirect manager');
INSERT INTO supervise (supervisor, supervised, relation) VALUES ('E002', 'E004', 'Mentor');
INSERT INTO supervise (supervisor, supervised, relation) VALUES ('John', 'Jane', 'Team Leader');
INSERT INTO supervise (supervisor, supervised, relation) VALUES ('Alice', 'Bob', 'Junior Analyst');
INSERT INTO supervise (supervisor, supervised, relation) VALUES ('Mr B', 'Mr A', 'Senior Analyst');
Project
INSERT INTO projects(code, proj_name, proj_location, managingDept) VALUES ('P001', 'Solar Power Plant', 'Arizona', 'D001');
INSERT INTO projects(code, proj_name, proj_location, managingDept) VALUES ('P002', 'Wind Farm', 'Texas', 'D002');
INSERT INTO projects(code, proj_name, proj_location, managingDept) VALUES ('P003', 'Hydroelectric Dam', 'Washington', 'D003');
INSERT INTO projects(code, proj_name, proj_location, managingDept) VALUES ('P004', 'Nuclear Power Plant', 'California', 'D004');
INSERT INTO projects(code, proj_name, proj_location, managingDept) VALUES ('P005', 'Geothermal Power Plant', 'Hawaii', 'D005');
INSERT INTO projects(code, proj_name, proj_location, managingDept) VALUES ('P006', 'Biomass Power Plant', 'Oregon', 'D006');
Project join
INSERT INTO projectJoin(employee, project, total_hour, stillInProject) VALUES ('001', 'P001', 40, 1);
INSERT INTO projectJoin(employee, project, total_hour, stillInProject) VALUES ('002', 'P002', 30, 1);
INSERT INTO projectJoin(employee, project, total_hour, stillInProject) VALUES ('003', 'P003', 20, 0);