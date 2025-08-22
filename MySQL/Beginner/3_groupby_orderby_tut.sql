-- GROUP BY
select gender, avg (age), max(age), min(age), count(age)
from parks_and_recreation.employee_demographics
group by gender;

select occupation, salary
from employee_salary
group by occupation, salary;

-- ORDER BY
select *
from parks_and_recreation.employee_demographics
order by gender, age;

#group by used for grouping rows which have same value
#order by used for arranging columns in ASC/DESC or a-z