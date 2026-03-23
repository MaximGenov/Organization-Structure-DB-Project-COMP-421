CREATE VIEW employee_profile_view AS
SELECT
    emp_id,
    name,
    position_title,
    start_date,
    email,
    password,
    YEAR(CURRENT DATE) - YEAR(start_date) AS years_at_company,
    SUBSTR(email, LOCATE('@', email) + 1) AS email_domain,
    CASE
        WHEN YEAR(CURRENT DATE) - YEAR(start_date) >= 10 THEN 'Senior'
        WHEN YEAR(CURRENT DATE) - YEAR(start_date) >= 5 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS seniority_level
FROM employee;
