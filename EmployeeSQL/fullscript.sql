-- Create the Tables through QuickDB

CREATE TABLE "Departments" (
    "dept_no" varchar(30)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "Dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(30)   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

CREATE TABLE "Dept_manager" (
    "dept_no" varchar(30)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

CREATE TABLE "Employees" (
    "emp_no" int   NOT NULL,
    "birth_date" varchar(30)   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar(30)   NOT NULL,
    "hire_date" varchar(30)   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "Salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

CREATE TABLE "Titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(30)   NOT NULL,
    "from_date" varchar(30)   NOT NULL,
    "to_date" varchar(30)   NOT NULL
);

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

-- Check that data was imported correctly

select * from "Departments"
select * from "Dept_emp"
select * from "Dept_manager"
select * from "Employees"
select * from "Salaries"
select * from "Titles"

-- Data Analysis Question 1
--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

select "Employees".emp_no, "Employees".first_name, "Employees".last_name, 
"Employees".gender, "Salaries".salary
FROM "Employees"
JOIN "Salaries"
ON "Employees".emp_no = "Salaries".emp_no;

-- Data Analysis Question 2
--List employees who were hired in 1986.

select first_name, last_name, hire_date 
from "Employees" 
where hire_date between '1986-01-01' and '1987-01-01';

-- Data Analysis Question 3
--List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name, 
--and start and end employment dates.

select "Dept_manager".emp_no, "Dept_manager".dept_no, "Employees".first_name,
"Employees".last_name, "Dept_manager".from_date, "Dept_manager".to_date,
"Departments".dept_name
from "Departments"
join "Dept_manager"
on "Departments".dept_no = "Dept_manager".dept_no
join "Employees"
on "Employees".emp_no = "Dept_manager".emp_no;

-- Data Analysis Question 4
--List the department of each employee with the following information: employee number, 
--last name, first name, and department name.

select "Departments".dept_name, "Dept_emp".emp_no, "Employees".first_name,
"Employees".last_name, "Departments".dept_no
from "Dept_emp"
join "Employees"
on "Dept_emp".emp_no = "Employees".emp_no
join "Departments"
on "Departments".dept_no = "Dept_emp".dept_no;

-- Data Analysis Quesiton 5
--List all employees whose first name is "Hercules" and last names begin with "B."

select "Employees".first_name, "Employees".last_name
from "Employees"
where first_name = 'Hercules' and last_name like 'B%';

-- Data Analysis Question 6
--List all employees in the Sales department, including their employee number, last name, 
--first name, and department name.

select "Employees".emp_no, "Employees".first_name, "Employees".last_name,
"Departments".dept_name
from "Employees"
join "Departments"
on "Departments".dept_name = 'Sales';

-- Data Analysis Question 7
--List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.

select "Employees".emp_no, "Employees".first_name, "Employees".last_name,
"Departments".dept_name
from "Employees"
join "Departments"
on "Departments".dept_name = 'Sales' 
or "Departments".dept_name = 'Development';

-- Data Analysis Question 8
--In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

select last_name, count(last_name) as namecount
from "Employees"
group by last_name
order by namecount desc;