select S.emp_id, E1.name, E1.email, M.emp_id as mgr_emp_id, E2.name as mgr_name, E2.email as mgr_email, count(case 
when current_date - date(Tk.creation_date) <= 30 then 1
end) as num_of_tasks
from Manager M, Assigns A, Standard S, Task Tk
left join Employee E1 on S.emp_id = E1.emp_id
left join Employee E2 on M.emp_id = E2.emp_id
where M.emp_id = A.mngr_emp_id and S.emp_id = A.std_emp_id and Tk.task_no = A.task_no and Tk.cmpt_name = A.cmpt_name and Tk.obj_id = A.obj_id and Tk.codename = A.codename
group by S.emp_id, E1.name, E1.email, M.emp_id, E2.name, E2.email
having count(case 
when current_date - date(Tk.creation_date) <= 30 then 1
end) < 2
order by num_of_tasks;

