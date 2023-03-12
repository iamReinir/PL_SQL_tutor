/*
Q1. Ai là quản lý phòng ban có tên là "Phòng nghiên cứu và phát triên"
Thông tin yêu cầu: mã số, họ tên nhân viên, mã số phòng ban, tên phòng ban
"Nghiên cứu và phát triển" --> "research and development"
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
*/
SELECT
    employees.code, employees.fullname
FROM
    (((SELECT code FROM employees WHERE fullname='Mai Duy An') e_supervised
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
    (((supervise
    JOIN employee AS e_supervisor
        ON supervise.supervisor=e_supervisor.code)
    JOIN employee AS e_supervised
        ON supervise.supervised=e_supervised.code)
    JOIN departments
        ON e_supervised.department=departments.code)
GROUP BY (e_supervised.department);X


