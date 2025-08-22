-- inner joins
select *
from employee_demographics
join employee_salary
 on employee_demographics.employee_id = employee_salary.employee_id;
 
select *
from employee_demographics as demo
join employee_salary as sal
 on demo.employee_id = sal.employee_id;

-- outer join (left and right outer join) 
select *
from employee_demographics demo
left join employee_salary sal 
 on demo.employee_id = sal.employee_id;
 
select *
from employee_demographics demo
right join employee_salary sal 
 on demo.employee_id = sal.employee_id;
 
-- self join 
select * 
from employee_salary as emp1
join employee_salary as emp2
 on emp1.employee_id + 1 = emp2.employee_id;
 
 
-- multiple join 
select *
from employee_demographics as demo
inner join employee_salary as sal
 on demo.employee_id = sal.employee_id
inner join parks_departments as pd 
 on sal.dept_id = pd.department_id;
 
#inner join used to return rows which have same columns in both table 