with project_realm (prjct_codename, name, obj_id, task_no) as (
	select distinct P.codename, C.cmpt_name, O.obj_id, T.task_no
	from project P inner join
		component C on P.codename = C.codename
		inner join objective O on C.cmpt_name = O.cmpt_name
		inner join task T on O.obj_id = T.obj_id
)
select distinct D.emp_id, E1.name, E1.email, E1.position_title
from Director D join project_realm PD
	on D.codename = PD.prjct_codename
join Employee E1 on D.emp_id = E1.emp_id

union

select distinct S1.emp_id, E2.name, E2.email, E2.position_title
from Supervisor S1 join Employee E2 on S1.emp_id = E2.emp_id
	join project_realm PS
        on S1.cmpt_name = PS.name

union

select distinct S2.emp_id, E3.name, E3.email, E3.position_title
from Supervisor S2 join Employee E3 on S2.emp_id = E3.emp_id
join distributes Dist1 on Dist1.spvr_emp_id = S2.emp_id
join project_realm PO on PO.obj_id = Dist1.obj_id

union

select distinct M.emp_id, E4.name, E4.email, E4.position_title
from Manager M, Employee E4, Assigns A1, project_realm PM
where M.emp_id = E4.emp_id and M.emp_id = A1.mngr_emp_id and A1.task_no = PM.task_no

union

select distinct Std.emp_id, E5.name, E5.email, E5.position_title
from Standard Std, Employee E5, Assigns A2, project_realm PStd
where Std.emp_id = E5.emp_id and Std.emp_id = A2.std_emp_id and A2.task_no = Pstd.task_no;
--order by project_realm.prjct_codename;
