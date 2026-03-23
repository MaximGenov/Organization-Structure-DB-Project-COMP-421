WITH employee_task_counts AS (
    SELECT
        s.team_id,
        e.emp_id,
        e.name,
        COUNT(CASE
            WHEN t.status IN ('TODO', 'IN_PROGRESS', 'ON_HOLD') THEN 1
        END) AS active_task_count
    FROM CS421G02.standard s
    JOIN CS421G02.employee e
      ON e.emp_id = s.emp_id
    LEFT JOIN CS421G02.assigns a
      ON a.std_emp_id = s.emp_id
    LEFT JOIN CS421G02.task t
      ON t.codename = a.codename
     AND t.cmpt_name = a.cmpt_name
     AND t.obj_id = a.obj_id
     AND t.task_no = a.task_no
    GROUP BY s.team_id, e.emp_id, e.name
)
SELECT
    team_id,
    emp_id,
    name,
    active_task_count,
    DENSE_RANK() OVER (
        PARTITION BY team_id
        ORDER BY active_task_count DESC, emp_id
    ) AS workload_rank_in_team
FROM employee_task_counts
ORDER BY team_id, workload_rank_in_team, emp_id;
