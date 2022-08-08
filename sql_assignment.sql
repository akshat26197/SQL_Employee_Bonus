--Create a database with the name ‘Institute’
-- create database database_name
create database Institute

--Create the above tables with the specified constraints in the above
--database.
-- crreate table table_name ( column datatype)
create table employee(Employee_id int primary key, First_name varchar(100) unique, Last_name varchar(100),Salary int,Joining_date date, Department varchar(30))
-- column_name datatype primary key
-- column_name datatype uniqe

create table employee_bonus(Employee_ref_id int foreign key references employee(Employee_id),Bonus_Amount int,Bonus_Date date)
-- column_name dtype foreign key referances table(column(pk))
-- column_name dtype not null


create table employee_title(Employee_ref_id int not null, Employee_title varchar(100) not null, Effective_Date date)
-- column_name dtype check(codition)

insert into employee(Employee_id,First_name,Last_name,Salary,Joining_date,Department) 
select 1, 'Anika','Arora',100000,'2020-02-14 9:00:00','HR' union all
select 2, 'Veena','Verma',80000,'2011-06-15 9:00:00','Admin' union all
select 3, 'Vishal','Singhal',300000,'2020-02-16 9:00:00','HR' union all
select 4,  'Sushanth','Singh',600000,'2020-02-17 9:00:00','Admin' union all
select 5, 'Bhupal','Bhati',500000,'2011-06-18 9:00:00','Admin' union all
select 6,'Dheeraj','Diwan',200000,'2011-06-19 9:00:00','Account' union all
select 7,'Karan','Kumar',75000,'2020-01-14 9:00:00','Account' union all
select 8,'Chandrika','Chauhan',90000,'2011-04-15 9:00:00','Admin' 

update employee set Salary=500000 where First_name='Sushanth'

insert into employee_bonus(Employee_ref_id,Bonus_Amount,Bonus_Date)
select 1,6000,'2020-02-16 0:00:00' union all
select 2,3000,'2011-06-16 0:00:00' union all
select 3,4000,'2020-02-16 0:00:00' union all
select 1,4500,'2020-02-16 0:00:00' union all
select 2,3600,'2011-06-16 0:00:00'

update employee_bonus set Bonus_Amount=5000 where Employee_ref_id=1


insert into employee_title(Employee_ref_id,Employee_title,Effective_Date)
values(1,'Manager','2016-02-20 0:00:00'),(2,'Executive','2016-06-11 0:00:00'),
(8,'Executive','2016-06-11 0:00:00'),(5,'Manager','2016-06-11 0:00:00'),
(4,'Asst. Manager','2016-06-11 0:00:00'),(7,'Executive','2016-06-11 0:00:00'),
(6,'Lead','2016-06-11 0:00:00'),(3,'Lead','2016-06-11 0:00:00')

--1 Display the “FIRST_NAME” from Employee table using the alias name
--as Employee_name.
select First_name as Employee_name from employee

--2 Display “LAST_NAME” from Employee table in upper case.
select UPPER(Last_Name) from employee

--3 Display unique values of DEPARTMENT from EMPLOYEE table.
select distinct Department from employee

--4 Display the first three characters of LAST_NAME from EMPLOYEE table.
select SUBSTRING(Last_Name,1,3) from employee

--5 Display the unique values of DEPARTMENT from EMPLOYEE table and
--prints its length.
select distinct Department,LEN(Department) as Length from employee

--6 Display the FIRST_NAME and LAST_NAME from EMPLOYEE table into a
--single column AS FULL_NAME.
--a space char should separate them.
select CONCAT(First_Name,' ',Last_Name) as Full_Name from employee

--7 DISPLAY all EMPLOYEE details from the employee table
--order by FIRST_NAME Ascending.
select * from employee
order by First_name

--8. Display all EMPLOYEE details order by FIRST_NAME Ascending and
--DEPARTMENT Descending.
select * from employee 
order by First_Name asc,Department desc

--9 Display details for EMPLOYEE with the first name as “VEENA” and “KARAN” from EMPLOYEE table.
select * from employee where First_name='Veena' or First_name='Karan'

--10 Display details of EMPLOYEE with DEPARTMENT name as “Admin”.
select * from employee where Department='Admin'

--11 DISPLAY details of the EMPLOYEES whose FIRST_NAME contains ‘V’.
select * from employee where First_name like '%v%'

--12 DISPLAY details of the EMPLOYEES whose SALARY lies between 100000 and 500000.
select * from employee where Salary BETWEEN 100000 and 500000

--13 Display details of the employees who have joined in Feb-2020.
select * from employee where Joining_date like '%2020-02%'

--14 Display employee names with salaries >= 50000 and <= 100000.
select CONCAT(First_Name,' ',Last_Name) as Full_Name from employee where Salary>=50000 and Salary<=100000

--16 DISPLAY details of the EMPLOYEES who are also Managers.
select * from employee e 
join employee_title t
on e.Employee_id=t.Employee_ref_id
where t.Employee_title='Manager'

--17 DISPLAY duplicate records having matching data in some fields of a table.
select Effective_Date, COUNT(Effective_Date) from employee_title
group by Effective_Date
having count(Effective_Date)>1

--18 Display only odd rows from a table.
select * from employee where Employee_id % 2 =1

--19 Clone a new table from EMPLOYEE table.
select * into employee_new from employee where 1=1
select * from employee_new

--20 DISPLAY the TOP 2 highest salary from a table.
select top 2 * from employee 
order by Salary desc

--21. DISPLAY the list of employees with the same salary.
select CONCAT(e.First_name,' ',e.Last_name) as Employee_Name from employee e 
join employee t
on e.Salary=t.Salary and e.Employee_id<>t.Employee_id

--22 Display the second highest salary from a table.
select Salary from employee where Salary=(select min(Salary) from employee
where Salary in(select distinct top 2 Salary from employee order by Salary desc))

--23 Display the first 50% records from a table.
select top 50 percent * from employee_title

--24. Display the departments that have less than 4 people in it.
select Department,count(Department) as People from employee group by Department
having count(Department)<4

--25. Display all departments along with the number of people in there.
select Department,count(Department) as People from employee group by Department

--26 Display the name of employees having the highest salary in each department.
select CONCAT(First_Name,' ',Last_Name) as HR_topper from employee
where Salary=(select max(Salary) from employee where Department='HR')
select CONCAT(First_Name,' ',Last_Name) as Admin_topper from employee
where Salary=(select max(Salary) from employee where Department='Admin')
select CONCAT(First_Name,' ',Last_Name) as Account_topper from employee
where Salary=(select max(Salary) from employee where Department='Account')

--27 Display the names of employees who earn the highest salary.
select CONCAT(First_Name,' ',Last_Name) as Full_Name from employee
where Salary=(select max(Salary) from employee)

--28 Diplay the average salaries for each department
select avg(Salary) as HR_avg from employee where Department='HR'
select avg(Salary) as Admin_avg from employee where Department='Admin'
select avg(Salary) as Account_avg from employee where Department='Account'

--29 display the name of the employee who has got maximum bonus
select distinct CONCAT(e.First_Name,' ',e.Last_Name) as Full_Name from employee e 
join employee_bonus b
on e.Employee_id=b.Employee_ref_id
where b.Bonus_Amount=(select max(Bonus_Amount) from employee_bonus)

--30 Display the first name and title of all the employees
select distinct e.First_name,t.Employee_title from employee e
inner join employee_title t
on e.Employee_id=t.Employee_ref_id





