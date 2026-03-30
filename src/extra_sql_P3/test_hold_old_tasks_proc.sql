CONNECT TO COMP421@

SELECT codename, cmpt_name, obj_id, task_no, creation_date, status
FROM CS421G02.task
WHERE codename = 'Bear'
ORDER BY cmpt_name, obj_id, task_no@

CALL CS421G02.hold_old_open_tasks('Bear', 30, ?)@

SELECT codename, cmpt_name, obj_id, task_no, creation_date, status
FROM CS421G02.task
WHERE codename = 'Bear'
ORDER BY cmpt_name, obj_id, task_no@