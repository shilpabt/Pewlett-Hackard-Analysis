--Deliverable 1: The Number of Retiring Employees by Title
--Retiring employees information 
--retirement_titles

SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles AS t 
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no; 

-- Export the retirement_titles table
--Check for csv file and data
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
--unique_titles

SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date='9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

--Export the unique_titles table and check for csv file and the data
SELECT * FROM unique_titles;

--The number of employees by their most recent job title who are about to retire
--retiring_titles

SELECT COUNT(emp_no), title
INTO retiring_titles	   
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;			 

--Export into retiring_titles.csv
--Check for the data
SELECT * FROM retiring_titles;

--Deliverable 2: The Employees Eligible for the Mentorship Program
--mentorship_eligibility

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
	ON e.emp_no = de.emp_no
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND de.to_date = ('9999-01-01')
ORDER BY e.emp_no;
--Export into mentorship_eligibilty.csv

SELECT COUNT(emp_no), title
--INTO retiring_titles	   
FROM unique_titles
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

SELECT * FROM mentorship_eligibility
where title = 'Manager';

SELECT COUNT(emp_no), title
--INTO retiring_titles	   
FROM mentorship_eligibility
GROUP BY title
ORDER BY COUNT(emp_no) DESC;