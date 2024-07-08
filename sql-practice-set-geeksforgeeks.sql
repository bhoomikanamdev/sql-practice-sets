-- Create the Student table
CREATE TABLE Student (
    STUDENT_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    GPA DECIMAL(3, 2),
    ENROLLMENT_DATE TIMESTAMP,
    MAJOR VARCHAR(50)
);

-- Insert the records into the Student table
INSERT INTO Student (STUDENT_ID, FIRST_NAME, LAST_NAME, GPA, ENROLLMENT_DATE, MAJOR) VALUES
(201, 'Shivansh', 'Mahajan', 8.79, '2021-09-01 09:30:00', 'Computer Science'),
(202, 'Umesh', 'Sharma', 8.44, '2021-09-01 08:30:00', 'Mathematics'),
(203, 'Rakesh', 'Kumar', 5.60, '2021-09-01 10:00:00', 'Biology'),
(204, 'Radha', 'Sharma', 9.20, '2021-09-01 12:45:00', 'Chemistry'),
(205, 'Kush', 'Kumar', 7.85, '2021-09-01 08:30:00', 'Physics'),
(206, 'Prem', 'Chopra', 9.56, '2021-09-01 09:24:00', 'History'),
(207, 'Pankaj', 'Vats', 9.78, '2021-09-01 14:30:00', 'English'),
(208, 'Navleen', 'Kaur', 7.00, '2021-09-01 06:30:00', 'Mathematics');


-- Create the Scholarship table
CREATE TABLE Scholarship (
    SCHOLARSHIP_ID SERIAL PRIMARY KEY,
    STUDENT_REF_ID INT,
    SCHOLARSHIP_AMOUNT INT,
    SCHOLARSHIP_DATE TIMESTAMP
);

-- Insert the records into the Scholarship table
INSERT INTO Scholarship (STUDENT_REF_ID, SCHOLARSHIP_AMOUNT, SCHOLARSHIP_DATE) VALUES
(201, 5000, '2021-10-15 00:00:00'),
(202, 4500, '2022-08-18 00:00:00'),
(203, 3000, '2022-01-25 00:00:00'),
(201, 4000, '2021-10-15 00:00:00');

select * from student

-- Create the Program table
CREATE TABLE Program (
    STUDENT_REF_ID INT,
    PROGRAM_NAME VARCHAR(50),
    PROGRAM_START_DATE TIMESTAMP,
    PRIMARY KEY (STUDENT_REF_ID, PROGRAM_NAME)
);

-- Insert the records into the Program table
INSERT INTO Program (STUDENT_REF_ID, PROGRAM_NAME, PROGRAM_START_DATE) VALUES
(201, 'Computer Science', '2021-09-01 00:00:00'),
(202, 'Mathematics', '2021-09-01 00:00:00'),
(208, 'Mathematics', '2021-09-01 00:00:00'),
(205, 'Physics', '2021-09-01 00:00:00'),
(204, 'Chemistry', '2021-09-01 00:00:00'),
(207, 'Psychology', '2021-09-01 00:00:00'),
(206, 'History', '2021-09-01 00:00:00'),
(203, 'Biology', '2021-09-01 00:00:00');

select * from Program

	
--Write a SQL query to fetch “FIRST_NAME” from the Student table in upper case and use ALIAS name as STUDENT_N

select upper(First_name) as STUDENT_N 
FROM Student

--Write a SQL query to fetch unique values of MAJOR Subjects from Student table

SELECT distinct(major)
FROM Student

SELECT major from Student group by major

--Write a SQL query to print the first 3 characters of FIRST_NAME from Student table.

select upper(substring(first_name,1,3))
FROM Student

--Write a SQL query to find the position of alphabet (‘a’) int the first name column ‘Shivansh’ from Student table.

select position('a' in first_name) from Student
where first_name = 'Shivansh'

--Write a SQL query that fetches the unique values of MAJOR Subjects from Student table and print its length.

select major, length(major) as length_of_major
from Student
group by major
order by length_of_major desc

--Write a SQL query to print FIRST_NAME from the Student table after replacing ‘a’ with ‘A’.

select replace(first_name,'a','A') from Student

--Write a SQL query to print the FIRST_NAME and LAST_NAME from Student table into single column COMPLETE_NAME.

select concat(first_name,' ',last_name) as full_name
from Student

--Write a SQL query to print all Student details from Student table order by FIRST_NAME Ascending and MAJOR Subject descending .
select * from Student
order by first_name asc , major desc

--Write a SQL query to print details of the Students with the FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.

select * from student
where first_name  in ('Prem','Shivansh')

-- Write a SQL query to print details of the Students excluding FIRST_NAME as ‘Prem’ and ‘Shivansh’ from Student table.

select * from student
where first_name not in ('Prem','Shivansh')

--Write a SQL query to print details of the Students whose FIRST_NAME ends with ‘a’.

select * from student
where first_name like '%a'

--Write an SQL query to print details of the Students whose FIRST_NAME ends with ‘a’ and contains six alphabets.

select * from student
where first_name like '____a'

--13. Write an SQL query to print details of the Students whose GPA lies between 9.00 and 9.99.

select * from student
where GPA between 9.00 and 9.99

--. Write an SQL query to fetch the count of Students having Major Subject ‘Computer Science’.

select count(*),major
from student
where major = 'Computer Science'
group by major

--Write an SQL query to fetch Students full names with GPA >= 8.5 and <= 9.5.

select concat(first_name,' ',last_name) from student
where GPA >= 8.5 and GPA <= 9.5

--Write an SQL query to fetch the no. of Students for each MAJOR subject in the descending order.

select major, count(*) from student
group by major
order by count(*) desc

--Display the details of students who have received scholarships, including their names, scholarship amounts, and scholarship dates.
select s1.first_name,s1.last_name, s2.scholarship_amount , s2.scholarship_date
from student as s1
join scholarship as s2
on s1.student_id = s2.student_ref_id

--Write an SQL query to show only odd rows from Student table.

select * from student
where mod(student_id,2)!=0

--19. Write an SQL query to show only even rows from Student table.

select * from student
where mod(student_id,2)=0

-- List all students and their scholarship amounts if they have received any.
--If a student has not received a scholarship, display NULL for the scholarship details.

select s1.first_name, s2.scholarship_amount
from student as s1
left join scholarship as s2
on s1.student_id = s2.student_ref_id

--Write an SQL query to show the top n (say 5) records of Student table order by descending GPA.

select * from student
order by GPA desc 
limit 5

-- Write an SQL query to determine the nth (say n=5) highest GPA from a table.

SELECT DISTINCT gpa, first_name
FROM student
ORDER BY gpa DESC
LIMIT 1 OFFSET 4;

--23. Write an SQL query to determine the 5th highest GPA without using LIMIT keyword.

with nthhighestGPA as( select GPA, row_number() over(ORDER by GPA desc) as rank 
	from (select distinct gpa from student) as distint_gpa
	)
select s1.gpa,s2.first_name
from nthhighestGPA as s1
join student as s2
on s1.gpa = s2.gpa
where rank = 6

--Write an SQL query to fetch the list of Students with the same GPA.

select s1.*
from student as s1,
student as s2
where s1.gpa = s2.gpa
and s1.student_id != s2.student_id

SELECT s1.* FROM Student s1, Student s2 WHERE s1.GPA = s2.GPA AND s1.Student_id != s2.Student_id;

select * from student

--Write an SQL query to show the second highest GPA from a Student table using sub-query.

select first_name,max(gpa)
from student
where gpa = (select max(gpa) from student where gpa < (select max(gpa)from student))
group by first_name

--Write an SQL query to show one row twice in results from a table.

select first_name from student
union all
select first_name from student

-- Write an SQL query to list STUDENT_ID who does not get Scholarship.

select student_id, first_name
from student
where student_id not in (select student_ref_id from Scholarship)

--Write an SQL query to fetch the first 50% records from a table.

select * from student
having count(student_id) = 

(select * from student limit count(student_id)/2 )

SELECT *
FROM student
WHERE student_id <= (
    SELECT student_id
    FROM student
    ORDER BY student_id
    LIMIT 1 OFFSET (SELECT COUNT(*) / 2 FROM student)
);

--29. Write an SQL query to fetch the MAJOR subject that have less than 4 people in it

select major , count(student_id)
from student
group by major
having count(student_id) < 4

--Write an SQL query to show all MAJOR subject along with the number of people in there.

select major , count(student_id)
from student
group by major

--31. Write an SQL query to show the last record from a table.

select * from student
limit 2
offset (select count(*)-2 from student)

--Write an SQL query to fetch the first row of a table.

select * from student
limit 1

-- Write an SQL query to fetch the last five records from a table.

select * from student
limit 5
offset (select count(*)-5 from student)

-- Write an SQL query to fetch three max GPA from a table using co-related subquery.

with nthhighestGPA as( select GPA, row_number() over(ORDER by GPA desc) as rank 
	from (select distinct gpa from student) as distint_gpa
	)
select s1.gpa,s2.first_name
from nthhighestGPA as s1
join student as s2
on s1.gpa = s2.gpa
where rank in (1,2,3)

SELECT DISTINCT GPA FROM Student S1 
WHERE 3 >= (SELECT COUNT(DISTINCT GPA) FROM Student S2 WHERE S1.GPA <= S2.GPA)
ORDER BY S1.GPA DESC;

---35. Write an SQL query to fetch three min GPA from a table using co-related subquery.

select distinct gpa from student s1
where 3>=(select count(distinct gpa) from student s2 where s1.gpa >= s2.gpa)
order by s1.gpa desc

---Write an SQL query to fetch nth max GPA from a table.

with temp_student as ( select distinct(gpa), row_number() over(order by gpa desc) as rank
from(select distinct(gpa) from student))

select gpa
from temp_student
where rank in (1,2,3,4)

---Write an SQL query to fetch MAJOR subjects along with the max GPA in each of these MAJOR subjects.

select major, max(gpa) as maximum_marks
from student
group by major
order by maximum_marks desc

---Write an SQL query to fetch the names of Students who has highest GPA.

select first_name, max(gpa) from student
where gpa = (select max(gpa) from student)
group by first_name

---Write an SQL query to show the current date and time.

select now()
select current_date

--- Write a query to create a new table which consists of data and structure copied from the other table (say Student) 
--or clone the table named Student.

create table clonetable as select *  from student

---Write an SQL query to update the GPA of all the students in ‘Computer Science’ MAJOR subject to 7.5.

update student 
set gpa = 7.5 
where major = 'Computer Science'

---Write an SQL query to find the average GPA for each major.

select major,round(avg(gpa),2)
from student
group by major

---Write an SQL query to show the top 3 students with the highest GPA.

with cte as ( select distinct(gpa),row_number() over (order by gpa desc) as rank
				from (select distinct(gpa) from student) )

select s1.first_name,s2.gpa
from student as s1
join cte as s2
on s1.gpa = s2.gpa
where rank in (1,2,3)
order by s2.gpa desc

---Write an SQL query to find the number of students in each major who have a GPA greater than 7.5.

select count(student_id), major
from student
where gpa > 7.5
group by major

---Write an SQL query to find the students who have the same GPA as ‘Shivansh Mahajan’.

select first_name, student_id, gpa
from student
where gpa = (select gpa from student where first_name = 'Shivansh' and last_name = 'Mahajan')



