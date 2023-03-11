/*
1. Ai là quản lý phòng ban có tên là "Phòng nghiên cứu và phát triên"
*/

/*Query này lấy tên manager của department bất kỳ*/
SELECT
    employees.code as employee_code,
    employees.fullname,
    departments.code as department_code,
     departments.dept_name as department_name
FROM
    (employees JOIN departments ON employees.managerOf = departments.code)
WHERE
    dept_name = 'research and development';/* Chỗ này tên gì cũng được */

SELECT
    projects.code as project_code,
    proj_name as project_name,
    dept_name as department_name
FROM
    (departments JOIN projects ON department.code = managingDept)
WHERE dept_name = 'research and development';