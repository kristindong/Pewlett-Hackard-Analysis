------------- Deliverable 1: Extract retiring employee titles ------------
-- Retirement criteria: born between 1952 and 1955
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO ret_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
-- Note: the to_date = '9999-01-01' filter makes Distinct redundant,
-- because it filters for the current title date, which is by definition most recent
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM ret_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Count the number of retiring employees by current title
SELECT count(title),
	title
INTO ret_titles_count
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC


------------- Deliverable 2: ------------
-- Create a table of eligible mentors
-- Eligibility criteria: current employees born in 1965
-- Note: the results do not exactly match the module answer;
-- module answer does not appear to return the most recent title
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentor_elig
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no, t.to_date DESC;

