USE lab3_part1;
-- Zane Mullinax   10/15/25


-- 1
SELECT employee_number, employee_last_name, employee_first_name, employee_initial
FROM employees
WHERE BINARY employee_first_name LIKE 'John%'
ORDER BY employee_number;

-- 2
SELECT 
  e.employee_first_name,
  e.employee_last_name,
  j.job_title
FROM employees e
JOIN jobs j 
  ON j.job_code = e.job_code
ORDER BY e.employee_first_name, e.employee_last_name;


-- 3
SELECT p.project_name, p.project_value, p.project_balance,
       e.employee_last_name, e.employee_first_name, e.employee_initial,
       j.job_code, j.job_title, j.job_chg_hour
FROM projects p
JOIN employees e ON e.employee_number = p.employee_number
JOIN jobs j      ON j.job_code = e.job_code
ORDER BY p.project_value DESC;

-- 4
SELECT p.project_name, p.project_value, p.project_balance,
       e.employee_last_name, e.employee_first_name, e.employee_initial,
       j.job_code, j.job_title, j.job_chg_hour
FROM projects p
JOIN employees e ON e.employee_number = p.employee_number
JOIN jobs j      ON j.job_code = e.job_code
ORDER BY e.employee_first_name;

-- 5
SELECT DISTINCT project_number
FROM assignments
ORDER BY project_number;

-- 6
SELECT 
    a.assignment_number,
    a.employee_number,
    a.project_number,
    a.assignment_charge AS assignment_charge,
    ROUND(a.assignment_chg_hr * a.assignment_hours, 2) AS `Calculated Assignment Charge`
FROM assignments a
ORDER BY a.assignment_number;


-- 7
SELECT 
    e.employee_number,
    e.employee_last_name,
    SUM(a.assignment_hours) AS `sum of assignment hours`,
    ROUND(SUM(a.assignment_charge), 2) AS `sum of assignment charge`
FROM employees e
JOIN assignments a 
    ON e.employee_number = a.employee_number
GROUP BY e.employee_number, e.employee_last_name
ORDER BY e.employee_number;


-- 8)
SELECT a.project_number,
       SUM(a.assignment_hours)              AS total_hours,
       ROUND(SUM(a.assignment_charge), 2)   AS total_charges
FROM assignments a
GROUP BY a.project_number
ORDER BY a.project_number;

-- 9
SELECT SUM(assignment_hours)  AS total_hours_all,
       ROUND(SUM(assignment_charge), 2) AS total_charges_all
FROM assignments;

-- 10
SELECT employee_number
FROM assignments
GROUP BY employee_number
HAVING COUNT(DISTINCT project_number) >= 2
ORDER BY employee_number;

-- 11
SELECT DISTINCT p.project_name
FROM projects p
JOIN assignments a
  ON a.project_number = p.project_number
WHERE a.employee_number = 1
ORDER BY p.project_name;

-- 12
SELECT
  p.project_name AS project_name,
  COUNT(DISTINCT a.employee_number) AS `Number of Employees Assigned`
FROM projects p
LEFT JOIN assignments a
  ON a.project_number = p.project_number
GROUP BY p.project_name
ORDER BY p.project_name;


-- 13
SELECT 
    e.employee_number,
    e.employee_last_name,
    e.employee_first_name,
    e.employee_initial,
    e.job_code,
    e.employee_hire_date,
    e.employee_years,
    e.employee_email,
    e.employee_phone_number
FROM employees e
LEFT JOIN assignments a
    ON e.employee_number = a.employee_number
WHERE a.employee_number IS NULL
ORDER BY e.employee_number;

-- 14
SELECT *
FROM projects
ORDER BY project_balance DESC
LIMIT 1;

-- 15
SELECT job_code, COUNT(*) AS "Number of employees"
FROM employees
GROUP BY job_code
ORDER BY job_code;

-- 16
SELECT j.job_title, COUNT(*) AS "Number of employees"
FROM employees e
JOIN jobs j ON j.job_code = e.job_code
GROUP BY j.job_title
ORDER BY j.job_title;

-- 17
SELECT employee_number
FROM assignments
GROUP BY employee_number
HAVING SUM(assignment_hours) > 10
ORDER BY employee_number;

-- 18
SELECT DISTINCT e.employee_number, e.employee_first_name, e.employee_last_name
FROM assignments a
JOIN projects p  ON p.project_number  = a.project_number
JOIN employees e ON e.employee_number = a.employee_number
WHERE p.project_value > 50000
ORDER BY e.employee_number;

-- 19
SELECT job_title
FROM jobs
WHERE job_chg_hour = (SELECT MAX(job_chg_hour) FROM jobs);


-- 20
SELECT 
    job_code, 
    job_title, 
    job_chg_hour, 
    job_last_update
FROM jobs
WHERE job_last_update = (SELECT MAX(job_last_update) FROM jobs);


-- 21
SELECT 
    e2.employee_first_name,
    e2.employee_last_name
FROM employees e2
JOIN jobs j ON j.job_code = e2.job_code
WHERE e2.job_code = (
    SELECT e.job_code
    FROM employees e
    WHERE e.employee_first_name = 'Emily'
      AND e.employee_last_name = 'Johnson'
)
ORDER BY e2.employee_first_name;

