SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT first_name,
last_name,
birth_date,
age,
(age + 10) *10
FROM parks_and_recreation.employee_demographics;
#PEMDAS

SELECT DISTINCT gender 
FROM parks_and_recreation.employee_demographics;

# distinct used to get unique values 
#can inlcude calculations in select statement
#PEMDAS is a oder of operation

