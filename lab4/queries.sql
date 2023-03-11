/*
1. Ai là quản lý phòng ban có tên là "Phòng nghiên cứu và phát triên"
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
2.Phòng Nghiên cứu và phát triển hiện đang quản lý dự án nào.
*/

SELECT
    projects.code as project_code,
    proj_name as project_name,
    dept_name as department_name
FROM
    (departments JOIN projects ON departments.code = managingDept)
WHERE dept_name = 'research and development';

/*
3.Dự án có tên ProjectB hiện đang được quản lý bởi phòng ban nào.
*/
SELECT
    projects.code as project_code,
    proj_name as project_name,
    dept_name as department_name
FROM
    (departments JOIN projects ON departments.code = managingDept)
WHERE proj_name = 'ProjectB';

/*
4.Những nhân viên nào đang bị giám sát bởi nhân viên có tên Mai Duy An.
*/

SELECT
    employee.code, employees.fullname
FROM
    (
    ((SELECT code FROM employees WHERE fullname='Mai Duy An') AS e_supervisor
    JOIN supervise
    ON supervise.supervisor = e_supervisor.code)
    JOIN employees ON supervise.supervised = employees.code
    )