/*
*   Author : Nguyễn Xuân Trung - QE170172
*   Search "Q_" để tìm câu query.
*
*/


/*
Q1. Ai là quản lý phòng ban có tên là "Phòng nghiên cứu và phát triên"
Thông tin yêu cầu: mã số, họ tên nhân viên, mã số phòng ban, tên phòng ban
"Nghiên cứu và phát triển" --> "research and development"

CHECKED
*/
SELECT
    employees.code as employee_code,
    employees.fullname,
    departments.code as department_code,
     departments.dept_name as department_name
FROM
    (employees JOIN departments ON employees.managerOf = departments.code)
WHERE
    dept_name = 'research and development';

/*
Q2.Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào.
Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý

CHECKED
*/

SELECT
    projects.code as project_code,
    proj_name as project_name,
    dept_name as department_name
FROM
    (departments JOIN projects ON departments.code = managingDept)
WHERE dept_name = 'research and development';


/*
Q3.Dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào.
Thông tin yêu cầu: mã số dụ án, tên dự án, tên phòng ban quản lý

CHECKED
*/
SELECT
    projects.code as project_code,
    proj_name as project_name,
    dept_name as department_name
FROM
    (departments JOIN projects ON departments.code = managingDept)
WHERE proj_name = 'ProjectB';

/*
Q4.Những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An.
Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên

CHECKED
*/

SELECT
    employees.code, employees.fullname
FROM
    (((SELECT code FROM employees WHERE fullname='Mai Duy An') e_supervisor
    JOIN supervise
    ON supervise.supervisor = e_supervisor.code)
    JOIN employees ON supervise.supervised = employees.code);

/*
Q5. ai hiện đang giám sát những nhân viên có tên Mai Duy An.
Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên giám sát.

CHECKED
*/
SELECT
    employees.code, employees.fullname
FROM
    (((SELECT code FROM employees WHERE fullname='Kein') e_supervised
    JOIN supervise
    ON supervise.supervised = e_supervised.code)
    JOIN employees ON supervise.supervisor = employees.code);

/*
Q6. dự án có tên ProjectA hiện đang làm việc ở đâu.
Thông tin yêu cầu: mã số, tên vị trí làm việc.
*/
SELECT code, proj_location
FROM projects WHERE proj_name='ProjectA';

/*
Q7. vị trí làm việc có tên Tp. HCM hiện đang là chỗ làm việc của những dự án nào.
Thông tin yêu cầu: mã số, tên dự án
*/

SELECT code, proj_name
FROM projects WHERE proj_location='tp.HCM';


/*
Q8. Cho biết những người phụ thuộc trên 18 tuổi .
Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào.

CHECKED
*/


SELECT
    depend_name as dependant_name,
    dependants.dateOfBirth,
    fullname as employee_name
FROM
    (SELECT
        depend_name,
        dateOfBirth,
        employee,
        TRUNC((SYSDATE - dateOfBirth)/ 365.25) AS age
    FROM
        dependants) dependants JOIN employees ON employee = employees.code
WHERE age > 18;

/*
Q9.	Cho biết những người phụ thuộc là nam giới.
Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào
CHECKED

*/

SELECT
    depend_name,
    dependants.dateOfBirth,
    fullname as employee_name
FROM
    dependants JOIN employees ON employee = employees.code
WHERE
    dependants.gender='male';


/*
Q10.	Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.
CHECKED
*/

SELECT
    departments.code as department_code,
    dept_name,
    proj_location as working_location
FROM
    projects JOIN departments ON managingDept = departments.code
WHERE dept_name='research and development';

/*
Q11.	Cho biết các dự án làm việc tại Tp. HCM.
Thông tin yêu cầu: mã dự án, tên dự án, tên phòng ban chịu trách nhiệm dự án.
CHECKED
*/
SELECT
    projects.code as project_code,
    proj_name,
    dept_name as managing_department
FROM
    projects JOIN departments ON managingDept = departments.code
WHERE proj_location='tp.HCM';

/*
Q12.	Cho biết những người phụ thuộc là nữ giới,
của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển .
Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc,
mối liên hệ giữa người phụ thuộc với nhân viên.
CHECKED
*/

SELECT
    depend_name AS dependant,
    fullname as employee_name,
    relationship
FROM
    dependants JOIN employees ON employee = employees.code
WHERE
    dependants.gender='female';


/*
Q13.Cho biết những người phụ thuộc trên 18 tuổi,
của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.
Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc,
mối liên hệ giữa người phụ thuộc với nhân viên.
CHECKED
*/
SELECT fullname AS employee, dependant_name, relationship
FROM
    (SELECT
        depend_name as dependant_name,
        dependants.dateOfBirth,
        employees.code,
        employees.department,
 	relationship,
	fullname
    FROM
        (SELECT
            depend_name,
            dateOfBirth,
            employee,
	    relationship,
            TRUNC((SYSDATE - dateOfBirth)/ 365.25) AS age
        FROM
            dependants) dependants JOIN employees ON employee = employees.code
    WHERE age > 18) emp_depd
    JOIN departments
        ON departments.code = department
WHERE dept_name = 'research and development';

/*
Q14. Cho biết số lượng người phụ thuộc theo giới tính.
Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
CHECKED
*/

SELECT gender, COUNT(gender) AS gender_count
FROM dependants
GROUP BY gender;

/*
Q15. Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên.
Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
CHECKED
*/
SELECT relationship, COUNT(relationship) AS total
FROM dependants
GROUP BY relationship;

/*
Q16.Cho biết số lượng người phụ thuộc theo mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc

CHECKED
*/

SELECT d.code, dept_name, dependants_count
FROM
(SELECT
    departments.code as code,
    COUNT(dependants.id) AS dependants_count
FROM
    (dependants JOIN employees
        ON dependants.employee = employees.code)
    JOIN departments
    ON department=departments.code
GROUP BY departments.code) d JOIN departments ON departments.code=d.code;

/*
Q17.Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
CHECKED
*/
SELECT d.code, dept_name, dependants_count
FROM
    (SELECT
        departments.code as code,
        COUNT(dependants.id) AS dependants_count
    FROM
        (dependants JOIN employees
            ON dependants.employee = employees.code)
        RIGHT JOIN departments
        ON department=departments.code
    GROUP BY departments.code) d
    JOIN departments ON departments.code=d.code
ORDER BY dependants_count ASC
FETCH FIRST 1 ROW ONLY;



/*
Q18.Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
CHECKED
*/

SELECT d.code, dept_name, dependants_count
FROM
    (SELECT
        departments.code as code,
        COUNT(dependants.id) AS dependants_count
    FROM
        (dependants JOIN employees
            ON dependants.employee = employees.code)
        RIGHT JOIN departments
        ON department=departments.code
    GROUP BY departments.code) d
    JOIN departments ON departments.code=d.code
ORDER BY dependants_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q19. Cho biết tổng số giờ tham gia dự án của mỗi nhân viên.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
CHECKED
*/

SELECT departments.code, fullname, dept_name, total_hour
FROM
    (SELECT
        SUM(total_hour) as total_hour,
        employee
    FROM projectJoin
    GROUP BY employee)
    JOIN employees ON employee = employees.code
    JOIN departments ON department = departments.code;
/*
Q20.Cho biết tổng số giờ làm dự án của mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, tổng số giờ
CHECKED
*/

SELECT total_hour, code, dept_name as department
FROM
    (SELECT
        SUM(total_hour) as total_hour, department
    FROM
    (projectJoin
    JOIN employees ON employee = employees.code
    JOIN departments ON department = departments.code)
    GROUP BY department) dept 
    JOIN departments ON department = departments.code;

/*
Q21.Cho biết nhân viên nào có số giờ tham gia dự án là ít nhất.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
*/



SELECT SUM(total_hour) as total_hours, employees.code, employees.fullname, department.dept_name
FROM
    ((projectJoin JOIN employees ON projectJoin.employee=employees.code)
    JOIN departments ON employees.department=department.code)
GROUP BY employees.code
ORDER BY total_hours ASC
FETCH FIRST 1 ROW ONLY;

/*
Q22.Cho biết nhân viên nào có số giờ tham gia dự án là nhiều nhất.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tổng số giờ tham gia dự án
*/


SELECT SUM(total_hour) as total_hours, employees.code, employees.fullname, department.dept_name
FROM
    ((projectJoin JOIN employees ON projectJoin.employee=employees.code)
    JOIN departments ON employees.department=department.code)
GROUP BY employees.code
ORDER BY total_hours DESC
FETCH FIRST 1 ROW ONLY;

/*
Q23.Cho biết những nhân viên nào lần đầu tiên tham gia dụ án.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
CHECKED
*/


SELECT employees.code, employees.fullname, departments.dept_name
FROM
    (((SELECT 
	employee, 
    	COUNT(employee) AS count_code 	
    FROM projectJoin 
    GROUP BY employee) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=1;

/*
Q24.Cho biết những nhân viên nào lần thứ hai tham gia dụ án.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
CHECKED
*/

SELECT employees.code, employees.fullname, departments.dept_name
FROM
    (((SELECT 
	employee, 
    	COUNT(employee) AS count_code 	
    FROM projectJoin 
    GROUP BY employee) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=2;
/*
Q25.Cho biết những nhân viên nào tham gia tối thiểu hai dụ án.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
CHECKED
*/

SELECT employees.code, employees.fullname, departments.dept_name
FROM
    (((SELECT 
	employee, 
    	COUNT(employee) AS count_code 	
    FROM projectJoin 
    GROUP BY employee) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code>=2;

/*
Q26.Cho biết số lượng thành viên của mỗi dự án.
Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
CHECKED
*/
SELECT code, proj_name, member_count
FROM
    (SELECT project, COUNT(employee) as member_count
    FROM projectJoin
    GROUP BY project)
    RIGHT JOIN projects ON code = project;

/*
Q27.Cho biết tổng số giờ làm của mỗi dự án.
Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
CHECKED
*/
SELECT proj.code, proj_name, total_hour
FROM
    (SELECT code, sum(NVL(total_hour,0)) as total_hour
    FROM projectJoin RIGHT JOIN projects ON code = project
    GROUP BY code) proj
    RIGHT JOIN projects ON proj.code = projects.code;

/*
Q28.Cho biết dự án nào có số lượng thành viên là ít nhất.
Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
CHECKED
*/

SELECT proj.code, proj_name, member_count
FROM
    projects LEFT JOIN (SELECT code, COUNT(employee) as member_count
    FROM (projects LEFT JOIN projectJoin ON code = project)
    GROUP BY code) proj ON proj.code = projects.code
ORDER BY member_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q29. Cho biết dự án nào có số lượng thành viên là nhiều nhất.
Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
CHECKED
*/


SELECT proj.code, proj_name, member_count
FROM
    projects LEFT JOIN (SELECT code, COUNT(employee) as member_count
    FROM (projects LEFT JOIN projectJoin ON code = project)
    GROUP BY code) proj ON proj.code = projects.code
ORDER BY member_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q30.Cho biết dự án nào có tổng số giờ làm là ít nhất.
Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
*/
SELECT proj.code, proj_name, total_hour
FROM
    (SELECT code, sum(NVL(total_hour,0)) as total_hour
    FROM projectJoin RIGHT JOIN projects ON code = project
    GROUP BY code) proj
    RIGHT JOIN projects ON proj.code = projects.code
ORDER BY total_hour ASC
FETCH FIRST 1 ROW ONLY;

/*
Q31.Cho biết dự án nào có tổng số giờ làm là nhiều nhất.
Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
CHECKED
*/
SELECT proj.code, proj_name, total_hour
FROM
    (SELECT code, sum(NVL(total_hour,0)) as total_hour
    FROM projectJoin RIGHT JOIN projects ON code = project
    GROUP BY code) proj
    RIGHT JOIN projects ON proj.code = projects.code
ORDER BY total_hour DESC
FETCH FIRST 1 ROW ONLY;

/*
Q32.Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc.
Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
CHECKED
*/

SELECT COUNT(managingDept) as departments_count, proj_location
FROM projects
GROUP BY proj_location;

/*
Q33. Cho biết số lượng chỗ làm việc theo mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
CHECKED
*/
SELECT dept_location.dept, dept_name, location_count
FROM
    ((SELECT departments.code as dept, COUNT(proj_location) as location_count
    FROM projects RIGHT JOIN departments ON departments.code = managingDept
    GROUP BY departments.code) dept_location
    JOIN departments ON departments.code = dept_location.dept);

/*
Q34.	Cho biết phòng ban nào có nhiều chỗ làm việc nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
CHECKED
*/

SELECT dept_location.dept, dept_name, location_count
FROM
    ((SELECT departments.code as dept, COUNT(proj_location) as location_count
    FROM projects RIGHT JOIN departments ON departments.code = managingDept
    GROUP BY departments.code) dept_location
    JOIN departments ON departments.code = dept_location.dept)
ORDER BY location_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q35.	Cho biết phòng ban nào có it chỗ làm việc nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
CHECKED
*/

SELECT dept_location.dept, dept_name, location_count
FROM
    ((SELECT departments.code as dept, COUNT(proj_location) as location_count
    FROM projects RIGHT JOIN departments ON departments.code = managingDept
    GROUP BY departments.code) dept_location
    JOIN departments ON departments.code = dept_location.dept)
ORDER BY location_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q36.	Cho biết địa điểm nào có nhiều phòng ban làm việc nhất.
Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
CHECKED
*/
SELECT *
FROM
    (SELECT 
	proj_location as project_location, 
     	COUNT(departments.code) as dept_count
    FROM projects RIGHT JOIN departments ON departments.code = managingDept
    GROUP BY proj_location) dept_location
ORDER BY dept_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q37.	Cho biết địa điểm nào có ít phòng ban làm việc nhất.
Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
CHECKED
*/
SELECT *
FROM
    (SELECT 
	proj_location as project_location, 
     	COUNT(departments.code) as dept_count
    FROM projects RIGHT JOIN departments ON departments.code = managingDept
    GROUP BY proj_location) dept_location
ORDER BY dept_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q38.Cho biết nhân viên nào có nhiều người phụ thuộc nhất.
Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
*/

SELECT supervisor_total.supervisor, fullname, supervised_count
FROM
    ((SELECT supervisor, COUNT(supervised) AS supervised_count
    FROM supervise
    GROUP BY supervisor) supervisor_total
    JOIN employees ON supervisor=employees.code)
ORDER BY supervised_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q39.Cho biết nhân viên nào có ít người phụ thuộc nhất.
Thông tin yêu cầu: mã số, họ tên nhân viên, số lượng người phụ thuộc
*/

SELECT supervisor_total.supervisor, fullname, supervised_count
FROM
    ((SELECT supervisor, COUNT(supervised) AS supervised_count
    FROM supervise
    GROUP BY supervisor) supervisor_total
    JOIN employees ON supervisor=employees.code)
ORDER BY supervised_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q40.Cho biết nhân viên nào không có người phụ thuộc.
Thông tin yêu cầu: mã số nhân viên, họ tên nhân viên, tên phòng ban của nhân viên
*/
SELECT employees.code, employees.fullname, dept_name
FROM
    (((SELECT employess.code FROM employees
    MINUS
    SELECT UNIQUE supervisor AS code FROM supervise) not_supervise
    JOIN employees ON employees.code = not_supervise.code)
    JOIN departments ON employees.department=department.code);

/*
Q41. Cho biết phòng ban nào không có người phụ thuộc.
Thông tin yêu cầu: mã số phòng ban, tên phòng ban
*/
SELECT code, dept_name
FROM
    (SELECT employees.department AS code
    FROM (supervise JOIN employees ON employees.code = supervised)
    MINUS
    SELECT code FROM departments) dept
    JOIN departments ON dept.code = departments;

/*
Q42.	Cho biết những nhân viên nào chưa hề tham gia vào bất kỳ dự án nào.
Thông tin yêu cầu: mã số, tên nhân viên, tên phòng ban của nhân viên
CHECKED
*/

SELECT employees.code, employees.fullname, departments.dept_name
FROM
    (((SELECT 
	e.code as employee, 
    	COUNT(project) AS count_code 	
    FROM projectJoin RIGHT JOIN (employees) e ON employee=e.code
    GROUP BY e.code) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=0;
/*
Q43.	Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án.
Thông tin yêu cầu: mã số phòng ban, tên phòng ban.
*/
SELECT UNIQUE departments.code, departments.dept_name
FROM
    (((SELECT 
	e.code as employee, 
    	COUNT(project) AS count_code 	
    FROM projectJoin RIGHT JOIN (employees) e ON employee=e.code
    GROUP BY e.code) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=0;
CODE                 DEPARTMENT           COUNT_CODE
-------------------- -------------------- ----------
E005                 D005                          0
E004                 D004                          0
E002                 D002                          2
E007                 D001                          0
E001                 D001                          2
E003                 D003                          1
E008                 D003                          0
E006                 D002                          0

/*
Q44.Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA.
Thông tin yêu cầu: mã số phòng ban, tên phòng ban
*/
SELECT UNIQUE departments.code, departments.dept_name
FROM
    (((SELECT 
	e.code as employee, 
    	COUNT(project) AS count_code 	
    FROM (projectJoin JOIN projects ON project=code AND proj_name != 'Hydroelelectric Dam')
    RIGHT JOIN (employees) e ON employee=e.code
    GROUP BY e.code) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=0;

/*
45.	Cho biết số lượng dự án được quản lý theo mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
*/

SELECT departments.code, dept_name, projects_count
FROM
    ((SELECT managingDept, COUNT(managingDept) AS projects_count
    FROM projects
    GROUP BY managingDept) JOIN departments ON managingDept=departments.code);
/*
46.	Cho biết phòng ban nào quản lý it dự án nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
*/

SELECT departments.code, dept_name, projects_count
FROM
    ((SELECT managingDept, COUNT(managingDept) AS projects_count
    FROM projects
    GROUP BY managingDept) JOIN departments ON managingDept=departments.code);
ORDER BY projects_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q47.	Cho biết phòng ban nào quản lý nhiều dự án nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng dự án
*/

SELECT departments.code, dept_name, projects_count
FROM
    ((SELECT managingDept, COUNT(managingDept) AS projects_count
    FROM projects
    GROUP BY managingDept) JOIN departments ON managingDept=departments.code)
ORDER BY projects_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q48.	Cho biết những phòng ban nào có nhiểu hơn 5 nhân viên đang quản lý dự án gì.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng nhân viên của phòng ban,
tên dự án quản lý
*/

SELECT departments.code, dept_name, emp_count, proj_name
(((SELECT code, emp_count
FROM
    (SELECT departments.code, COUNT(employees.code) AS emp_count
    FROM
        (employees JOIN departments ON employees.department=department.code)
    GROUP BY departments.code)
WHERE emp_count > 5) moreThan5
JOIN projects ON projects.managingDept = code)
JOIN departments ON moreThan5.code = departments.code);

/*
Q49.Cho biết những nhân viên thuộc phòng có tên là Phòng nghiên cứu,
và không có người phụ thuộc. Thông tin yêu cầu: mã nhân viên,họ tên nhân viên
*/
SELECT employees.code, fullname
FROM
    ((SELECT employees.code AS emp_code
    FROM (employees JOIN departments
        ON employees.department=departments.code)
    WHERE dept_name='research and development')
    MINUS
    (SELECT supervised AS emp_code FROM supervise))
    JOIN employees ON emp_code=employees.code;

/*
Q50. biết tổng số giờ làm của các nhân viên,
mà các nhân viên này không có người phụ thuộc.
Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, tổng số giờ làm
*/

SELECT SUM(total_hour) as total_hour, employees.code, employees.fullname
FROM
    ((projectJoin JOIN employees ON projectJoin.employee=employees.code)
    JOIN ((SELECT supervisor AS code FROM supervise
        MINUS
        SELECT code FROM employees) not_supervise
        JOIN employees on employees.code = not_supervise.code) not_supervising
    ON not_supervising.code = employees.code)
GROUP BY employees.code;

/*
Q51.Cho biết tổng số giờ làm của các nhân viên,
mà các nhân viên này có nhiều hơn 3 người phụ thuộc.
Thông tin yêu cầu: mã nhân viên,họ tên nhân viên, số lượng người phụ thuộc, tổng số giờ làm
*/




