-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO COMP421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables have already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.
-- =========================
-- Core entity: EMPLOYEE
-- =========================
CREATE TABLE employee (
  emp_id          INTEGER      NOT NULL,
  name            VARCHAR(100) NOT NULL,
  position_title  VARCHAR(100) NOT NULL,
  start_date      DATE         NOT NULL,
  email           VARCHAR(254) NOT NULL,
  password        VARCHAR(255) NOT NULL,
  CONSTRAINT pk_employee PRIMARY KEY (emp_id),
  CONSTRAINT uq_employee_email UNIQUE (email)
);

-- =========================
-- ISA specialization tables
-- =========================
CREATE TABLE manager (
  emp_id INTEGER NOT NULL,
  CONSTRAINT pk_manager PRIMARY KEY (emp_id),
  CONSTRAINT fk_manager_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE
);

-- =========================
-- TEAM (managed by a manager)
-- =========================
CREATE TABLE team (
  team_id     INTEGER      NOT NULL,
  department  VARCHAR(100) NOT NULL,
  manager_id  INTEGER      NOT NULL,
  CONSTRAINT pk_team PRIMARY KEY (team_id),
  CONSTRAINT fk_team_manager
    FOREIGN KEY (manager_id) REFERENCES manager(emp_id)
    ON DELETE RESTRICT
);

-- =========================
-- STANDARD employees belong to a team
-- =========================
CREATE TABLE standard (
  emp_id  INTEGER NOT NULL,
  team_id INTEGER,
  CONSTRAINT pk_standard PRIMARY KEY (emp_id),
  CONSTRAINT fk_standard_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,
  CONSTRAINT fk_standard_team
    FOREIGN KEY (team_id) REFERENCES team(team_id)
    ON DELETE RESTRICT
);

-- =========================
-- PROJECT (run by a director)
-- =========================
CREATE TABLE project (
  codename       VARCHAR(50)   NOT NULL,
  charter        VARCHAR(2000),
  start_date     DATE          NOT NULL,
  deadline_date  DATE          NOT NULL,
  CONSTRAINT pk_project PRIMARY KEY (codename),
  CONSTRAINT ck_project_dates CHECK (deadline_date >= start_date)
);

-- =========================
-- COMPONENT (project comprises components)
-- + recursive subcomponent relationship
-- =========================
CREATE TABLE component (
  project_codename        VARCHAR(50)  NOT NULL,
  component_name          VARCHAR(200) NOT NULL,
  is_complete             BOOLEAN      NOT NULL,
  priority_num            INTEGER      NOT NULL,

  parent_project_codename VARCHAR(50),
  parent_component_name   VARCHAR(200),

  CONSTRAINT pk_component PRIMARY KEY (project_codename, component_name),

  CONSTRAINT fk_component_project
    FOREIGN KEY (project_codename) REFERENCES project(codename)
    ON DELETE CASCADE,

  CONSTRAINT fk_component_parent
    FOREIGN KEY (parent_project_codename, parent_component_name)
    REFERENCES component(project_codename, component_name)
    ON DELETE CASCADE,

  CONSTRAINT ck_component_priority CHECK (priority_num >= 0),

  -- keeps parent component in same project (still doesn't prevent cycles)
  CONSTRAINT ck_component_parent_same_project
    CHECK (parent_project_codename IS NULL OR parent_project_codename = project_codename)
);

CREATE TABLE supervisor (
  emp_id INTEGER NOT NULL,
  supervised_project_codename VARCHAR(50),
  supervised_component_name   VARCHAR(200),

  CONSTRAINT pk_supervisor PRIMARY KEY (emp_id),
  CONSTRAINT fk_supervisor_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_supervisor_component
    FOREIGN KEY (supervised_project_codename, supervised_component_name)
    REFERENCES component(project_codename, component_name)
    ON DELETE SET NULL,

  CONSTRAINT ck_supervised_component_pair
  CHECK (
    (supervised_project_codename IS NULL AND supervised_component_name IS NULL)
    OR
    (supervised_project_codename IS NOT NULL AND supervised_component_name IS NOT NULL)
  )
);

CREATE TABLE director (
  emp_id INTEGER NOT NULL,
  codename  VARCHAR(50),

  CONSTRAINT pk_director PRIMARY KEY (emp_id),
  CONSTRAINT fk_director_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_director_project
    FOREIGN KEY (codename) REFERENCES project(codename)
     ON DELETE SET NULL
);

-- =========================
-- OBJECTIVE (for a component)
-- =========================
CREATE TABLE objective (
  obj_id          INTEGER      NOT NULL,
  project_codename VARCHAR(50)  NOT NULL,
  component_name   VARCHAR(200) NOT NULL,
  goal_name        VARCHAR(200) NOT NULL,
  description      VARCHAR(2000),
  is_complete      BOOLEAN      NOT NULL,
  priority_num     INTEGER      NOT NULL,

  CONSTRAINT pk_objective PRIMARY KEY (project_codename, component_name, obj_id),

  CONSTRAINT fk_objective_component
    FOREIGN KEY (project_codename, component_name)
    REFERENCES component(project_codename, component_name)
    ON DELETE CASCADE,

  CONSTRAINT ck_objective_priority CHECK (priority_num >= 0)
);

-- =========================
-- TASK (for an objective)
-- =========================
CREATE TABLE task (
  project_codename VARCHAR(50)  NOT NULL,
  component_name   VARCHAR(200) NOT NULL,
  task_no       INTEGER     NOT NULL,
  obj_id        INTEGER     NOT NULL,
  status        VARCHAR(30) NOT NULL,
  description   VARCHAR(2000),
  priority_num  INTEGER,

  CONSTRAINT pk_task PRIMARY KEY (project_codename, component_name, obj_id, task_no),

  CONSTRAINT fk_task_objective
    FOREIGN KEY (project_codename, component_name, obj_id)
    REFERENCES objective(project_codename, component_name, obj_id)
    ON DELETE CASCADE,

  CONSTRAINT ck_task_priority CHECK (priority_num IS NULL OR priority_num >= 0),

  CONSTRAINT ck_task_status CHECK (status IN ('TODO','IN_PROGRESS','DONE','BLOCKED'))
);

-- =========================
-- MEETING + Employee joins meeting (M:N)
-- =========================
CREATE TABLE meeting (
  meeting_id   INTEGER      NOT NULL
               GENERATED ALWAYS AS IDENTITY
               (START WITH 1 INCREMENT BY 1),
  title        VARCHAR(200) NOT NULL,
  start_time   TIMESTAMP    NOT NULL,
  end_time     TIMESTAMP    NOT NULL,
  description  VARCHAR(2000),

  CONSTRAINT pk_meeting PRIMARY KEY (meeting_id),
  CONSTRAINT ck_meeting_time CHECK (end_time > start_time)
);

CREATE TABLE attends (
  emp_id     INTEGER NOT NULL,
  meeting_id INTEGER NOT NULL,

  CONSTRAINT pk_employee_meeting PRIMARY KEY (emp_id, meeting_id),

  CONSTRAINT fk_em_meeting_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_em_meeting_meeting
    FOREIGN KEY (meeting_id) REFERENCES meeting(meeting_id)
    ON DELETE CASCADE
);

-- =========================
-- ASSIGNS (manager assigns a task to a standard employee)
-- =========================
CREATE TABLE assigns (
  standard_id INTEGER NOT NULL,
  manager_id  INTEGER NOT NULL,
  project_codename VARCHAR(50) NOT NULL,
  component_name   VARCHAR(200) NOT NULL,
  obj_id           INTEGER     NOT NULL,
  task_no     INTEGER NOT NULL,

  CONSTRAINT pk_assigns PRIMARY KEY (standard_id, project_codename, component_name, obj_id, task_no),

  CONSTRAINT fk_assigns_standard
    FOREIGN KEY (standard_id) REFERENCES standard(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_assigns_manager
    FOREIGN KEY (manager_id) REFERENCES manager(emp_id)
    ON DELETE RESTRICT,

  CONSTRAINT fk_assigns_task
    FOREIGN KEY (project_codename, component_name, obj_id, task_no)
    REFERENCES task(project_codename, component_name, obj_id, task_no)
    ON DELETE CASCADE,

  -- since each task can be assigned to at most one standard employee:
  CONSTRAINT uq_assigns_task UNIQUE (project_codename, component_name, obj_id, task_no)
);

-- =========================
-- DISTRIBUTES (supervisor distributes objective to a team)
-- =========================
CREATE TABLE distributes (
  project_codename VARCHAR(50)  NOT NULL,
  component_name   VARCHAR(200) NOT NULL,
  obj_id        INTEGER NOT NULL,
  supervisor_id INTEGER NOT NULL,
  team_id       INTEGER NOT NULL,

  CONSTRAINT pk_distributes PRIMARY KEY (project_codename, component_name, obj_id),

  CONSTRAINT fk_distributes_objective
    FOREIGN KEY (project_codename, component_name, obj_id)
    REFERENCES objective(project_codename, component_name, obj_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_distributes_supervisor
    FOREIGN KEY (supervisor_id) REFERENCES supervisor(emp_id),

  CONSTRAINT fk_distributes_team
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);
