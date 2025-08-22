-- limit
# limit is used to control how many rows you need in output
select *
from employee_demographics
order by age desc
limit 3;

select *
from employee_demographics
order by age desc
limit 2,1;

-- aliasing
# a way to change the name of column 
select gender, avg(age) as avg_age
from employee_demographics 
group by gender 
having avg_age > 40;

select gender, avg(age) avg_age
from employee_demographics 
group by gender 
having avg_age > 40;

# we don't have to write 'as' always 