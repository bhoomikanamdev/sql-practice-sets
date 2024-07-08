CREATE TABLE EmployeeInfo (
    EmpID SERIAL PRIMARY KEY,
    EmpFname VARCHAR(50),
    EmpLname VARCHAR(50),
    Department VARCHAR(50),
    Project VARCHAR(50),
    Address VARCHAR(100),
    DOB DATE,
    Gender CHAR(1)
);

INSERT INTO EmployeeInfo (EmpID, EmpFname, EmpLname, Department, Project, Address, DOB, Gender) VALUES
(1, 'Sanjay', 'Mehra', 'HR', 'P1', 'Hyderabad(HYD)', '1976-12-01', 'M'),
(2, 'Ananya', 'Mishra', 'Admin', 'P2', 'Delhi(DEL)', '1968-05-02', 'F'),
(3, 'Rohan', 'Diwan', 'Account', 'P3', 'Mumbai(BOM)', '1980-01-01', 'M'),
(4, 'Sonia', 'Kulkarni', 'HR', 'P1', 'Hyderabad(HYD)', '1992-05-02', 'F'),
(5, 'Ankit', 'Kapoor', 'Admin', 'P2', 'Delhi(DEL)', '1994-07-03', 'M');

CREATE TABLE EmployeePosition (
    EmpID INT REFERENCES EmployeeInfo(EmpID),
    EmpPosition VARCHAR(50),
    DateOfJoining DATE,
    Salary INT,
    PRIMARY KEY (EmpID, EmpPosition, DateOfJoining)
);

INSERT INTO EmployeePosition (EmpID, EmpPosition, DateOfJoining, Salary) VALUES
(1, 'Manager', '2024-05-01', 500000),
(2, 'Executive', '2024-05-02', 75000),
(3, 'Manager', '2024-05-01', 90000),
(2, 'Lead', '2024-05-02', 85000),
(1, 'Executive', '2024-05-01', 300000);


-- Write a query to fetch the EmpFname from the EmployeeInfo table in upper case and use the ALIAS name as EmpName.

select upper(empfname) as EmpName from employeeinfo

---Q2. Write a query to fetch the number of employees working in the department ‘HR’

select count(empid) from employeeinfo
where department = 'HR'

--Write a query to get the current date.

select current_date

--Q4. Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.

select substring(Emplname,1,4) from EmployeeInfo

--- Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

select address from EmployeeInfo

SELECT 
    substring(Address from '^(.*?)\s*\(') AS PlaceName
FROM 
    EmployeeInfo;

---. Write a query to create a new table which consists of data and structure copied from the other table.

create table copyOfEmp as select * from EmployeeInfo

---Write q query to find all the employees whose salary is between 50000 to 100000.

select e1.empfname, e2.salary
from EmployeeInfo as e1
join employeeposition as e2
on e1.empid = e2.empid
where e2.salary between 50000 and 100000

---Q8. Write a query to find the names of employees that begin with ‘S’


select empfname from EmployeeInfo
where empfname like'S%'

--Write a query to fetch top N records.

select * from EMployeeposition
order by salary desc limit 10

--Q10. Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space.

select concat(empfname,' ',emplname) as Fullname from employeeinfo

--Q11. Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1975 and are grouped according to gender

select count(*), gender
from employeeinfo
where dob between '1970-05-02' and '1975-12-31'
group by gender

select * from employeeinfo

--Q12. Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order.

select * from EmployeeInfo
order by EmpLname desc , Department asc

--Q13. Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

select empfname,emplname from employeeinfo
where emplname like '____a'

--Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table.

select * from employeeinfo
where empfname not in ('Sanjay', 'Sonia')

--Q15. Write a query to fetch details of employees with the address as “DELHI(DEL)”.

select * from employeeinfo
where address like 'DELHI(DEL)%'

--Q16. Write a query to fetch all employees who also hold the managerial position.

select s1.* from employeeinfo as s1
join employeeposition as s2
on s1.empid = s2.empid
where empposition ='Manager'
select * from employeeposition

--Q17. Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order.

select count(empid)as no_of_emp,department from employeeinfo
group by department
order by no_of_emp asc

--Q18. Write a query to calculate the even and odd records from a table.

select * from employeeinfo where empid%2=0 order by empid asc
select * from employeeinfo where empid%2!=0 order by empid asc

--Q19. Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table.

select distinct(s1.*) from employeeinfo as s1
right join employeeposition as s2
on s1.empid =s2.empid 

SELECT * FROM EmployeeInfo E
WHERE EXISTS
(SELECT * FROM EmployeePosition P WHERE E.EmpId = P.EmpId);

--Q20. Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table.

select distinct(salary) from employeeposition as s1
where 2 >= (select count(distinct(salary)) from employeeposition as s2 where s1.salary <= s2.salary ) order by s1.salary desc


select distinct(salary) from employeeposition as s1
where 2 >= (select count(distinct(salary)) from employeeposition as s2 where s1.salary > s2.salary ) order by s1.salary desc

--Q21. Write a query to find the Nth highest salary from the table without using TOP/limit keyword.

with cte as (select salary, row_number() over (order by salary desc)as rank from employeeposition)
select salary
from cte 
where rank in (1,2,3,4)

--Q22. Write a query to retrieve duplicate records from a table.

select empid, empposition, dateofjoining,salary, count(*)
from employeeposition
group by empid, empposition, dateofjoining,salary
having count(*) >1


SELECT EmpID, EmpFname, Department, COUNT(*)
FROM EmployeeInfo GROUP BY EmpID, EmpFname, Department
HAVING COUNT(*) > 1;

--Q23. Write a query to retrieve the list of employees working in the same department.

Select DISTINCT E.EmpID, E.EmpFname, E.Department
FROM EmployeeInfo E, EmployeeInfo E1
WHERE E.Department = E1.Department AND E.EmpID != E1.EmpID;

---Q24. Write a query to retrieve the last 3 records from the EmployeeInfo table.

select * from Employeeinfo
limit 3
offset (select count(*)-3 from Employeeinfo)

---Q25. Write a query to find the third-highest salary from the EmpPosition table.

with cte as ( select salary, row_number() over(order by salary desc) as rank from (select distinct(salary)from employeeposition))

select salary from cte
where rank = 3

---Q26. Write a query to display the first and the last record from the EmployeeInfo table.

select * from employeeinfo where empId = (select min(empId) from employeeinfo )  
select * from employeeinfo where empId = (select max(empId) from employeeinfo )  

--
--Q27. Write a query to add email validation to your database

SELECT Email FROM EmployeeInfo WHERE NOT REGEXP_LIKE(Email, ‘[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}’, ‘i’);

--Q28. Write a query to retrieve Departments who have less than 2 employees working in it.

select department, count(empId) as total_emp
from employeeinfo
group by department
having count(empId) < 2

---Q29. Write a query to retrieve EmpPostion along with total salaries paid for each of them.

select empposition, sum(salary) from employeeposition
group by empposition

---Q30. Write a query to fetch 50% records from the EmployeeInfo table.

select * from employeeinfo 
where empid <= (select count(empid)/2 from employeeinfo)



