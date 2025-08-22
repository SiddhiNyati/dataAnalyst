create procedure large_salaries()
select * 
from employee_salary
where salary >=50000;

call large_salaries();

create procedure large_salaries2()
select * 
from employee_salary
where salary >=50000;
select *
from employee_salary
where salary >=10000;


delimiter $$
create procedure large_salaries3()
Begin
select * 
from employee_salary
where salary >=50000;
select *
from employee_salary
where salary >=10000;
end $$
delimiter ;
call large_salaries3();

