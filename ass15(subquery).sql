use hr_db;
# MySQL Sub Query

#Assignment 1: Employees in Specific Departments
#Task: Retrieve the EMPLOYEE_ID, FIRST_NAME, and LAST_NAME of employees who work in departments located in cities that start with the letter 'S'.
#Hint: Use a subquery after the WHERE clause to find DEPARTMENT_IDs based on LOCATION_IDs from the locations table.
select EMPLOYEE_ID,FIRST_NAME,LAST_NAME from employees where department_id in (
       select department_id from departments where location_id in (
			  select location_id from locations where city like 'S%'
       )
);


#Assignment 2: High Salary Jobs
#Task: List the JOB_ID and JOB_TITLE for jobs that have a minimum salary greater than the average salary across all jobs.
#Hint: Use a subquery after the WHERE clause to calculate the average salary.
select job_id, job_title from jobs where MIN_SALARY > (
 select avg(salary) from employees 
);
-- or 
select job_id, job_title from jobs where MIN_SALARY > (
 select avg(max_salary) from jobs 
);

-- Assignment 3: Employee and Their Manager's Details
-- Task: Display EMPLOYEE_ID, FIRST_NAME, LAST_NAME, and MANAGER_ID of employees along with the FIRST_NAME and LAST_NAME of their managers.
-- Hint: Use a subquery after the FROM clause to join the employees table to itself to get the manager's details.
select * from (
       select e1.employee_id,e1.first_name,e1.last_name,e1.manager_id, e2.first_name as managerFirstName, e2.last_name as managerLastName from
              employees as e1 inner join employees as e2  on e1.manager_id = e2.employee_id
 ) as employee_with_manager;
 
 
-- Assignment 4: Departments with Employees Hired After a Specific Date
-- Task: Retrieve DEPARTMENT_ID and DEPARTMENT_NAME for departments that have employees hired after '01-JAN-2010'.
-- Hint: Use a subquery after the WHERE clause to find departments based on hire dates in the employees table.
select department_id,DEPARTMENT_NAME from departments where department_id in (
  select department_id from employees where hire_date > '2010-01-01' 
);


-- Assignment 5: Locations with Multiple Departments
-- Task: List LOCATION_ID and CITY for locations that have more than one department.
-- Hint: Use a subquery after the FROM clause to group and count departments per location.
select * from ( 
   select * from locations where location_id in 
      (select location_id from departments group by location_id having count(*)>1)
	) as loc;


-- Assignment 6: Employees with Maximum Salary in Their Department
-- Task: Retrieve the EMPLOYEE_ID, FIRST_NAME, LAST_NAME, and SALARY of employees who earn the maximum salary in their respective departments.
-- Hint: Use a subquery after the WHERE clause to find the maximum salary per department.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY from employees where salary in (
       select  max(salary) as highSalary from employees group by department_id
);


-- Assignment 7: Jobs with Employees in More Than One Department
-- Task: List JOB_ID and JOB_TITLE for jobs where employees have worked in more than one department (including past jobs from the job_history table).
-- Hint: Use a subquery after the WHERE clause to check the number of distinct departments per employee from the job_history table.
select employee_id,count(*) from job_history group by job_id,employee_id having count(distinct department_id)= 1;
select Job_id, job_title from jobs where job_id in  (
       select job_id from job_history group by job_id,employee_id having count(distinct department_id) >=1
);


-- Assignment 8: Departments Without Managers
-- Task: Retrieve DEPARTMENT_ID and DEPARTMENT_NAME for departments that do not have a manager assigned.
-- Hint: Use a subquery after the WHERE clause to identify departments where MANAGER_ID is NULL.
select department_id , department_name from departments where manager_id in (
       select manager_id from departments where manager_id = 0
);


-- Assignment 9: Employees Hired in Regions with a Specific Name
-- Task: Display EMPLOYEE_ID, FIRST_NAME, LAST_NAME, and HIRE_DATE of employees who were hired in regions with the name 'Europe'.
-- Hint: Use a subquery after the FROM clause to join employees with locations, countries, and regions tables.
select * from regions where REGION_name = "Europe";

select employee_id, first_name,last_name,hire_date from employees where department_id in (
  select department_id from departments where location_id in (
      select location_id from locations where location_id in (
          select location_id from countries where REGION_ID = (
              select REGION_ID from regions where REGION_id = 1
       )
   )
)     
);



-- Assignment 10: Recent Job Changes
-- Task: List EMPLOYEE_ID, FIRST_NAME, LAST_NAME, and the latest job JOB_ID for employees who have had more than one job.
-- Hint: Use a subquery after the FROM clause to get the latest START_DATE from the job_history table. 
#step 1
select max(start_date) from job_history group by employee_id having count(*) > 1 and max(start_date) ;

#step 2
select * from employees where employee_id in  (
     select employee_id from job_history group by employee_id having count(*) > 1 and max(start_date) 
);
#step 3
select jobs.employee_id, jobs.first_name,jobs.last_name,jobs.job_id from (
     select * from employees where employee_id in  (
           select employee_id from job_history group by employee_id having count(*) > 1 and max(start_date) 
)
)as jobs

