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
*/

SELECT
    employee18.fullname, employee18.dateOfBirth, employees.fullname as supervisor_name
FROM
        ((SELECT
            TRUNC((SYSDATE - TO_DATE(dateOfBirth, 'DD-Mon-YY'))/ 365.25) AS age,
            dateOfBirth,
            code,
            fullname
        FROM employees
        WHERE age > 18) employee18 JOIN supervise ON employee18.code = supervise.supervised)
    JOIN employees ON employees.code = supervise.supervisor;

/*
Q9.	Cho biết những người phụ thuộc là nam giới.
Thông tin yêu cầu: tên, ngày tháng năm sinh của người phụ thuộc, tên nhân viên phụ thuộc vào
*/

SELECT male_emp.fullname, male_emp.dateOfBirth, employee.fullname as supervisor_name
FROM
        ((SELECT
            dateOfBirth,
            code,
            fullname,
        FROM employees
        WHERE gender='male') male_emp JOIN supervise ON male_emp.code = supervise.supervised)
    JOIN employees ON employees.code = supervise.supervisor;
/*
Q10.	Cho biết những nơi làm việc của phòng ban có tên : Phòng Nghiên cứu và phát triển.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, tên nơi làm việc.
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
*/

SELECT female_emp.fullname, employee.fullname as supervisor_name, relation
FROM
        ((SELECT employees.code, employees.name
        FROM (employees JOIN departments ON employees.department=departments.code)
        WHERE departments.dept_name='research and development'
            AND gender='female') female_emp
    JOIN supervise ON female_emp.code = supervise.supervised)
    JOIN employees ON employees.code = supervise.supervisor;

/*
Q13.	Cho biết những người phụ thuộc trên 18 tuổi,
của nhân viên thuộc phòng ban có tên: Phòng Nghiên cứu và phát triển.
Thông tin yêu cầu: tên nhân viên, tên người phụ thuộc,
mối liên hệ giữa người phụ thuộc với nhân viên.
*/
SELECT
    employee18.fullname, employees.fullname as supervisor_name, relation
FROM
        ((SELECT
            TRUNC((SYSDATE - TO_DATE(dateOfBirth, 'DD-Mon-YY'))/ 365.25) AS age,
            dateOfBirth,
            employees.code,
            fullname
        FROM employees JOIN departments ON employees.department=departments.code
        WHERE age > 18 AND dept_name='research and development') employee18
    JOIN supervise ON employee18.code = supervise.supervised)
    JOIN employees ON employees.code = supervise.supervisor;

/*
Q14. Cho biết số lượng người phụ thuộc theo giới tính.
Thông tin yêu cầu: giới tính, số lượng người phụ thuộc
*/

SELECT e_supervised.gender, COUNT(e_supervised.gender) AS total
FROM
    ((supervise
    JOIN employee AS e_supervisor
        ON supervise.supervisor=e_supervisor.code)
    JOIN employee AS e_supervised
        ON supervise.supervised=e_supervised.code)
GROUP BY (e_supervised.gender);

/*
Q15. Cho biết số lượng người phụ thuộc theo mối liên hệ với nhân viên.
Thông tin yêu cầu: mối liên hệ, số lượng người phụ thuộc
*/
SELECT relation, COUNT(relation) AS total
FROM supervise
GROUP BY relation;

/*
Q16.Cho biết số lượng người phụ thuộc theo mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
*/

SELECT e_supervised.department, departments.dept_name, COUNT(e_supervised.department) AS total
FROM
    ((
    supervise JOIN employee AS e_supervised
        ON supervise.supervised=e_supervised.code)
    JOIN departments
        ON e_supervised.department=departments.code)
GROUP BY (e_supervised.department);

/*
Q17.Cho biết phòng ban nào có số lượng người phụ thuộc là ít nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
*/

SELECT e_supervised.department, departments.dept_name, COUNT(e_supervised.department) AS total
FROM
    ((supervise JOIN employee AS e_supervised
        ON supervise.supervised=e_supervised.code)
    JOIN departments
        ON e_supervised.department=departments.code)
GROUP BY (e_supervised.department)
ORDER BY total ASC
FETCH FIRST 1 ROW ONLY;

/*
Q18.Cho biết phòng ban nào có số lượng người phụ thuộc là nhiều nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng người phụ thuộc
*/

SELECT e_supervised.department, departments.dept_name, COUNT(e_supervised.department) AS total
FROM
    ((supervise JOIN employee AS e_supervised
        ON supervise.supervised=e_supervised.code)
    JOIN departments
        ON e_supervised.department=departments.code)
GROUP BY (e_supervised.department)
ORDER BY total DESC
FETCH FIRST 1 ROW ONLY;

/*
Q19. Cho biết tổng số giờ tham gia dự án của mỗi nhân viên.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
*/

SELECT SUM(total_hour) as total_hour, employees.code, employees.fullname, department.dept_name
FROM
    ((projectJoin JOIN employees ON projectJoin.employee=employees.code)
    JOIN departments ON employees.department=department.code)
GROUP BY employees.code;

/*
Q20.	Cho biết tổng số giờ làm dự án của mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, tổng số giờ
*/

SELECT SUM(total_hour) as total_hour, departments.code, department.dept_name
FROM
    ((projectJoin JOIN employees ON projectJoin.employee=employees.code)
    JOIN departments ON employees.department=department.code)
GROUP BY departments.code;

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
*/


SELECT employees.code, employees.fullname, department.dept_name
FROM
    (((SELECT employee, COUNT(employee) AS count_code FROM projectJoin GROUP BY code) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=1;

/*
Q24.Cho biết những nhân viên nào lần thứ hai tham gia dụ án.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
*/

SELECT employees.code, employees.fullname, department.dept_name
FROM
    (((SELECT employee, COUNT(employee) AS count_code FROM projectJoin GROUP BY code) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code=2;

/*
Q25.Cho biết những nhân viên nào tham gia tối thiểu hai dụ án.
Thông tin yêu cầu: mã nhân viên, tên nhân viên, tên phòng ban của nhân viên
*/

SELECT employees.code, employees.fullname, department.dept_name
FROM
    (((SELECT employee, COUNT(employee) AS count_code FROM projectJoin GROUP BY code) proj_count
    JOIN employees ON employees.code = proj_count.employee)
    JOIN departments ON employees.department=departments.code)
WHERE count_code>=2;

/*
Q26.Cho biết số lượng thành viên của mỗi dự án.
Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
*/

SELECT project, proj_name, COUNT(employee) AS employee_count
FROM
    projectJoin JOIN projects ON projects.code=projectJoin.project
GROUP BY project;

/*
Q27.Cho biết tổng số giờ làm của mỗi dự án.
Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
*/
SELECT project, proj_name, SUM(total_hour) AS hour_count
FROM
    projectJoin JOIN projects ON projects.code=projectJoin.project
GROUP BY project;

/*
Q28.Cho biết dự án nào có số lượng thành viên là ít nhất.
Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
*/

SELECT project, proj_name, COUNT(employee) AS employee_count
FROM
    projectJoin JOIN projects ON projects.code=projectJoin.project
GROUP BY project
ORDER BY employee_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q29. Cho biết dự án nào có số lượng thành viên là nhiều nhất.
Thông tin yêu cầu: mã dự án, tên dự án, số lượng thành viên
*/

SELECT project, proj_name, COUNT(employee) AS employee_count
FROM
    projectJoin JOIN projects ON projects.code=projectJoin.project
GROUP BY project
ORDER BY employee_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q30.Cho biết dự án nào có tổng số giờ làm là ít nhất.
Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
*/

SELECT project, proj_name, SUM(total_hour) AS hour_count
FROM
    projectJoin JOIN projects ON projects.code=projectJoin.project
GROUP BY project
ORDER BY hour_count ASC
FETCH FIRST 1 ROW ONLY;

/*
Q31.Cho biết dự án nào có tổng số giờ làm là nhiều nhất.
Thông tin yêu cầu: mã dự án, tên dự án, tổng số giờ làm
*/
SELECT project, proj_name, SUM(total_hour) AS hour_count
FROM
    projectJoin JOIN projects ON projects.code=projectJoin.project
GROUP BY project
ORDER BY hour_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q32.Cho biết số lượng phòng ban làm việc theo mỗi nơi làm việc.
Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
*/

SELECT proj_location, COUNT(department) as departments_count
FROM projects
GROUP BY proj_location;

/*
Q33. Cho biết số lượng chỗ làm việc theo mỗi phòng ban.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
*/
SELECT dept_location.code, dept_name, location_count
FROM
    ((SELECT department, COUNT(proj_location) as location_count
    FROM projects
    GROUP BY department) dept_location
    JOIN departments ON departments.code = dept_location.department);

/*
Q34.	Cho biết phòng ban nào có nhiều chỗ làm việc nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
*/

SELECT dept_location.code, dept_name, location_count
FROM
    (SELECT department, COUNT(proj_location) as location_count
    FROM projects
    GROUP BY department) dept_location
    JOIN departments ON departments.code = dept_location.department)
ORDER BY location_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q35.	Cho biết phòng ban nào có it chỗ làm việc nhất.
Thông tin yêu cầu: mã phòng ban, tên phòng ban, số lượng chỗ làm việc
*/

SELECT dept_location.code, dept_name, location_count
FROM
    (SELECT department, COUNT(proj_location) as location_count
    FROM projects
    GROUP BY department) dept_location
    JOIN departments ON departments.code = dept_location.department)
ORDER BY location_count ASC
FETCH FIRST 1 ROW ONLY;
/*
Q36.	Cho biết địa điểm nào có nhiều phòng ban làm việc nhất.
Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
*/
SELECT proj_location, departments_count
FROM
    (SELECT proj_location, COUNT(department) as departments_count
    FROM projects
    GROUP BY proj_location)
ORDER BY departments_count DESC
FETCH FIRST 1 ROW ONLY;

/*
Q37.	Cho biết địa điểm nào có ít phòng ban làm việc nhất.
Thông tin yêu cầu: tên nơi làm việc, số lượng phòng ban
*/
SELECT proj_location, departments_count
FROM
    (SELECT proj_location, COUNT(department) as departments_count
    FROM projects
    GROUP BY proj_location)
ORDER BY departments_count ASC
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
*/

SELECT emp.code AS employee_code, fullname, dept_name
FROM
    ((SELECT employee AS code FROM projectJoin
    MINUS
    SELECT code FROM employees) emp
    JOIN employees ON emp.code = employees.code)
    JOIN departments ON employees.department = departments.code;

/*
Q43.	Cho biết phòng ban không có nhân viên nào tham gia (bất kỳ) dự án.
Thông tin yêu cầu: mã số phòng ban, tên phòng ban.
*/
SELECT UNIQUE departments.code, dept_name
FROM
    ((SELECT employee AS code FROM projectJoin
    MINUS
    SELECT code FROM employees) emp
    JOIN employees ON emp.code = employees.code)
    JOIN departments ON employees.department = departments.code;

/*
Q44.Cho biết phòng ban không có nhân viên nào tham gia vào dự án có tên là ProjectA.
Thông tin yêu cầu: mã số phòng ban, tên phòng ban
*/
SELECT UNIQUE departments.code, dept_name
FROM
    ((SELECT employee AS code
    FROM (projectJoin JOIN projects ON code = project)
    WHERE proj_name='ProjectA'
    MINUS
    SELECT code FROM employees) emp
    JOIN employees ON emp.code = employees.code)
    JOIN departments ON employees.department = departments.code;

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
    GROUP BY managingDept) JOIN departments ON managingDept=departments.code);
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




