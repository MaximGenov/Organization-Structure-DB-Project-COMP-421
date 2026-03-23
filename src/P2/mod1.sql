insert into Supervisor (Supervisor.emp_id, Supervisor.codename, Supervisor.cmpt_name)
select Std.emp_id, null as codename, null as cmpt_name
from Standard Std, Employee E
where Std.emp_id = E.emp_id and current_date - date(E.start_date) > 365;
