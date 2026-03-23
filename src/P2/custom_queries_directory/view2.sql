CONNECT TO COMP421;

Create VIEW active_emp_on_bear_and_cobra (emp_id, name, position_title, 
	project_codename, project_cmpt_name, obj_id, task_no, creation_date, status, priority_num, description)
AS SELECT DISTINCT std.emp_id, std.name, std.position_title,
	t.codename, t.cmpt_name, t.obj_id, t.task_no, t.creation_date, t.status, t.priority_num, t.description
FROM employee std, assigns a, task t
WHERE std.emp_id = a.std_emp_id AND a.codename = t.codename AND a.cmpt_name = t.cmpt_name 
	AND a.obj_id = t.obj_id AND a.task_no = t.task_no AND t.status = 'IN_PROGRESS' 
	AND std.emp_id IN (SELECT DISTINCT A1.std_emp_id FROM
			   assigns A1, task T1, assigns A2, task T2
			   WHERE A1.codename = T1.codename AND A1.cmpt_name = T1.cmpt_name AND A1.obj_id = T1.obj_id AND A1.task_no = T1.task_no
				   AND A2.codename = T2.codename AND A2.cmpt_name = T2.cmpt_name AND A2.obj_id = T2.obj_id AND A2.task_no = T2.task_no
				   AND A1.std_emp_id = A2.std_emp_id AND A1.codename = 'Bear' AND A2.codename = 'Cobra' 
				   AND T1.status = 'IN_PROGRESS' AND T2.status = 'IN_PROGRESS');

SELECT emp_id, name, position_title,                                          
       SUBSTR(project_codename,1,5) AS proj_codename, SUBSTR(project_cmpt_name,1,20) AS proj_cmpt_name, obj_id, task_no, creation_date, status, priority_num, 
	SUBSTR(description, 1, 63) AS description
FROM active_emp_on_bear_and_cobra FETCH FIRST 5 ROWS ONLY;

INSERT INTO active_emp_on_bear_and_cobra (emp_id, name, position_title, 
            project_codename, project_cmpt_name, obj_id, task_no, creation_date, status, priority_num, description)
	    VALUES
	    (2121, 'John Smith', 'View Tester',
	    'Bear', 'Structural', 12, 10, DATE('2026-03-06'), 'ABANDONED', 100, 'Just testing the second view');

DROP VIEW active_emp_on_bear_and_cobra;
