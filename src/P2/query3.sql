select T.team_id, S.emp_id, substr(E.name, 1, 40) as name, O.obj_id, substr(O.goal_name, 1, 5) as goal_name, substr(O.description, 1, 90) as description
from Team T, Supervisor S, Employee E, Distributes D, Objective O
where T.team_id = D.team_id and S.emp_id = D.spvr_emp_id and E.emp_id = S.emp_id and O.obj_id = D.obj_id and O.priority_num = 1 and O.is_complete = false
order by team_id;
--group by
--order by
--having;
