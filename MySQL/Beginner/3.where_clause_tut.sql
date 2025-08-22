select *
from employee_salary
where salary > 50000;

select *
from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01';

-- logicial operator 
-- and or not 
select *
from parks_and_recreation.employee_demographics
where age > 35 
AND
gender = 'Female';

select *
from parks_and_recreation.employee_demographics
where (first_name = 'Leslie' AND age = 44) OR age > 55;


-- like statement
# % and _ used % for anything and _ for specific value 

select *
from parks_and_recreation.employee_demographics
where first_name like 'jer%';

select *
from parks_and_recreation.employee_demographics
where first_name like 'a___%';

