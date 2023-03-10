INSERT INTO departments (code, dept_name) VALUES ('D001','human resource');
INSERT INTO departments (code, dept_name) VALUES ('D002','finance');
INSERT INTO departments (code, dept_name) VALUES ('D003','research and development');
INSERT INTO departments (code, dept_name) VALUES ('D004','marketing');
INSERT INTO departments (code, dept_name) VALUES ('D005','production');
INSERT INTO departments (code, dept_name) VALUES ('D006','Empty');


INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E001','mr jame','male','1996-01-01','D001',NULL);
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E002','jmmy','male','2006-01-08','D002',NULL);
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E003','manager-san','female','1996-01-08','D003','D001');
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E004','Sanny','female','2006-01-08','D004',NULL);
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E005','John','male','1996-01-08','D005',NULL);
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E006','Kein','male','1996-01-08','D002',NULL);
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E007','Aris','female','1996-01-08','D001',NULL);
INSERT INTO
employees (code, fullname, gender, dateOfBirth, department, managerOf)
VALUES ('E008','Alicia','female','1996-01-08','D003','D003');


INSERT INTO supervise (supervisor, supervised)
VALUES ('E001', 'E002');
INSERT INTO supervise (supervisor, supervised)
VALUES ('E001', 'E003');
INSERT INTO supervise (supervisor, supervised)
VALUES ('E002', 'E004');
INSERT INTO supervise (supervisor, supervised)
VALUES ('E003', 'E005');
INSERT INTO supervise (supervisor, supervised)
VALUES ('E008', 'E006');
INSERT INTO supervise (supervisor, supervised)
VALUES ('E002', 'E006');

INSERT INTO dependants (id,depend_name,gender,dateOfBirth,relationship,employee) VALUES
('DP001','Josh10','male','2013-06-06','Offspring','E001');

INSERT INTO dependants (id,depend_name,gender,dateOfBirth,relationship,employee) VALUES
('DP002','Josh20','male','2003-06-06','Offspring','E002');

INSERT INTO dependants (id,depend_name,gender,dateOfBirth,relationship,employee) VALUES
('DP003','Jish10','female','2013-06-06','Offspring','E002');

INSERT INTO dependants (id,depend_name,gender,dateOfBirth,relationship,employee) VALUES
('DP004','Jish20','female','2003-06-06','Offspring','E001');

INSERT INTO dependants (id,depend_name,gender,dateOfBirth,relationship,employee) VALUES
('DP005','Jish20','female','1999-06-06','Wife','E001');

INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P001', 'Solar Power Plant', 'Arizona', 'D001');
INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P002', 'Wind Farm', 'Texas', 'D002');
INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P003', 'Hydroelectric Dam', 'Washington', 'D003');
INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P004', 'Nuclear Power Plant', 'California', 'D004');
INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P005', 'Geothermal Power Plant', 'Hawaii', 'D005');
INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P006', 'Biomass Power Plant', 'Oregon', 'D003');
INSERT INTO projects(code, proj_name, proj_location, managingDept)
VALUES ('P007', 'Steam power plant', 'Oregon', 'D001');

INSERT INTO projectJoin(employee, project, total_hour, stillInProject)
VALUES ('E001', 'P001', 40, 1);
INSERT INTO projectJoin(employee, project, total_hour, stillInProject)
VALUES ('E002', 'P002', 30, 1);
INSERT INTO projectJoin(employee, project, total_hour, stillInProject)
VALUES ('E003', 'P003', 20, 0);
INSERT INTO projectJoin(employee, project, total_hour, stillInProject)
VALUES ('E002', 'P001', 15, 0);
INSERT INTO projectJoin(employee, project, total_hour, stillInProject)
VALUES ('E001', 'P003', 30, 1);