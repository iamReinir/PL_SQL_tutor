/*
1. Ai là quản lý phòng ban có tên là "Phòng nghiên cứu và phát triên"
*/
SELECT employees.code, employees.fullname, departments.code, departments.dept_name
FROM
    (employees JOIN departments);