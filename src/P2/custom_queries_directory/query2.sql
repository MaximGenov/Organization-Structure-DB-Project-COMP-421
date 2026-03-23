/* select emp_id
from STANDARD S1
minus
select S2.emp_id
from STANDARD S2
join ASSIGNS A
on S2.emp_id = A.std_emp_id

where
group by
order by
having; */
with emp_untasked (std_id) as (
	select S1.emp_id
	from STANDARD S1
	minus
	--Query to get employees that have been assigned at least one task
	select S2.emp_id
	from STANDARD S2
	inner join ASSIGNS A2
	on S2.emp_id = A2.std_emp_id
)
select S3.std_id, E.name, E.email
from emp_untasked S3, EMPLOYEE E
where E.emp_id = S3.std_id;

