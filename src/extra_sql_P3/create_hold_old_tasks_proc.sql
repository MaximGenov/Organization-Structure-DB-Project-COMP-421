CONNECT TO COMP421@

CREATE OR REPLACE PROCEDURE CS421G02.hold_old_open_tasks (
    IN p_codename VARCHAR(20),
    IN p_age_days INTEGER,
    OUT p_tasks_updated INTEGER
)
LANGUAGE SQL
BEGIN
    DECLARE v_done INTEGER DEFAULT 0;
    DECLARE v_codename VARCHAR(20);
    DECLARE v_cmpt_name VARCHAR(100);
    DECLARE v_obj_id INTEGER;
    DECLARE v_task_no INTEGER;

    DECLARE old_task_cursor CURSOR FOR
        SELECT t.codename, t.cmpt_name, t.obj_id, t.task_no
        FROM CS421G02.task t
        JOIN CS421G02.objective o
          ON o.codename = t.codename
         AND o.cmpt_name = t.cmpt_name
         AND o.obj_id = t.obj_id
        WHERE t.codename = p_codename
          AND o.is_complete = 'FALSE'
          AND t.status IN ('TODO', 'IN_PROGRESS')
          AND DAYS(CURRENT DATE) - DAYS(t.creation_date) > p_age_days;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = 1;

    SET p_tasks_updated = 0;

    OPEN old_task_cursor;

    fetch_loop:
    LOOP
        FETCH old_task_cursor
        INTO v_codename, v_cmpt_name, v_obj_id, v_task_no;

        IF v_done = 1 THEN
            LEAVE fetch_loop;
        END IF;

        UPDATE CS421G02.task
        SET status = 'ON_HOLD'
        WHERE codename = v_codename
          AND cmpt_name = v_cmpt_name
          AND obj_id = v_obj_id
          AND task_no = v_task_no;

        SET p_tasks_updated = p_tasks_updated + 1;
    END LOOP;

    CLOSE old_task_cursor;
END@