-- union 
select first_name, last_name
from employee_demographics
union
select first_name, last_name
from employee_salary;

select first_name, last_name
from employee_demographics
union all
select first_name, last_name
from employee_salary;

select first_name, last_name, 'old man' as Label
from employee_demographics
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'old lady' as Label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name, last_name, 'highly paid employee' as Label
from employee_salary
where salary > 70000
order by first_name, last_name;


#union is by default distinct but if we have to get all the value we have to write 'union all'

