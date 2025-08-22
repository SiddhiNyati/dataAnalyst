select first_name,
last_name,
age,
case 
  when age <= 30 then 'young' 
  when age between 31 and 50 then 'old'
  when age >= 60 then 'dead'
end as label
from employee_demographics;  


-- case study 
-- < 50000 = 5% inc
-- > 50000 = 7% inc
-- finance dept = 10% bonus
select first_name, last_name, salary,
case 
  when salary < 50000 then salary * 1.05
  when salary > 50000 then salary * 1.07
end as new_salary,
case
  when dept_id = 6 then salary * .10
end as bonus
from employee_salary;



