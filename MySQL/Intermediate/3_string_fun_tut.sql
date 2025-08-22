-- strings 
# length 
select length('siddhi');

select first_name , length(first_name)
from employee_demographics
order by 2;

select upper('siddhi');
select lower('SIDDHI');

select first_name , upper(first_name)
from employee_demographics
order by 1;

-- trim, left trim, right trim
select trim('     siddhi      ');
select ltrim('     siddhi      ');
select rtrim('     siddhi      ');

select first_name,
left(first_name, 4),
right(first_name, 4),
substring(first_name, 3,2),
birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;

select first_name, replace(first_name, 'n', 's')
from employee_demographics;

select locate('i' , 'siddhi');

select first_name, locate('an', first_name)
from employee_demographics;

select first_name, last_name,
concat(first_name, ' ', last_name) as full_name
from employee_demographics;


