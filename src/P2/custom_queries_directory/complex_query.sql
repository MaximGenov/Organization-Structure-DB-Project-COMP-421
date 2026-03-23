WITH objective_stats AS (
    SELECT
        c.codename,
        c.cmpt_name,
        COUNT(CASE WHEN o.is_complete = 'FALSE' THEN 1 END) AS incomplete_objectives
    FROM CS421G02.component c
    LEFT JOIN CS421G02.objective o
      ON o.codename = c.codename
     AND o.cmpt_name = c.cmpt_name
    GROUP BY c.codename, c.cmpt_name
),
task_stats AS (
    SELECT
        c.codename,
        c.cmpt_name,
        COUNT(CASE WHEN t.status IN ('TODO','IN_PROGRESS','ON_HOLD') THEN 1 END) AS active_tasks,
        COUNT(CASE WHEN t.status = 'ON_HOLD' THEN 1 END) AS on_hold_tasks
    FROM CS421G02.component c
    LEFT JOIN CS421G02.objective o
      ON o.codename = c.codename
     AND o.cmpt_name = c.cmpt_name
    LEFT JOIN CS421G02.task t
      ON t.codename = o.codename
     AND t.cmpt_name = o.cmpt_name
     AND t.obj_id = o.obj_id
    GROUP BY c.codename, c.cmpt_name
),
component_stats AS (
    SELECT
        o.codename,
        o.cmpt_name,
        o.incomplete_objectives,
        t.active_tasks,
        t.on_hold_tasks
    FROM objective_stats o
    JOIN task_stats t
      ON t.codename = o.codename
     AND t.cmpt_name = o.cmpt_name
)
SELECT
    codename,
    cmpt_name AS component_name,
    incomplete_objectives,
    active_tasks,
    on_hold_tasks,
    DENSE_RANK() OVER (
        PARTITION BY codename
        ORDER BY incomplete_objectives DESC,
                 active_tasks DESC,
                 on_hold_tasks DESC
    ) AS risk_rank_in_project
FROM component_stats
ORDER BY codename, risk_rank_in_project, component_name;
