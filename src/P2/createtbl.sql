-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO COMP421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables have already been created.

-- This is only an example of how you add create table ddls to this file.
--   You may remove it.

CREATE TABLE employee (
  emp_id          INTEGER      NOT NULL,
  name            VARCHAR(40) NOT NULL,
  position_title  VARCHAR(50) NOT NULL,
  start_date      DATE         NOT NULL,
  email           VARCHAR(40) NOT NULL,
  password        VARCHAR(20)  NOT NULL,
  CONSTRAINT pk_employee PRIMARY KEY (emp_id),
  CONSTRAINT uq_employee_email UNIQUE (email)
);


CREATE TABLE manager (
  emp_id INTEGER           NOT NULL,
  CONSTRAINT pk_manager PRIMARY KEY (emp_id),
  CONSTRAINT fk_manager_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE
);


CREATE TABLE team (
  team_id     INTEGER      NOT NULL,
  department  VARCHAR(30) NOT NULL,
  mngr_emp_id  INTEGER      NOT NULL,
  CONSTRAINT pk_team PRIMARY KEY (team_id),
  CONSTRAINT fk_team_manager
    FOREIGN KEY (mngr_emp_id) REFERENCES manager(emp_id)
    ON DELETE RESTRICT
);


CREATE TABLE standard (
  emp_id  INTEGER     NOT NULL,
  team_id INTEGER,
  CONSTRAINT pk_standard PRIMARY KEY (emp_id),
  CONSTRAINT fk_standard_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,
  CONSTRAINT fk_standard_team
    FOREIGN KEY (team_id) REFERENCES team(team_id)
    ON DELETE RESTRICT
);


CREATE TABLE project (
  codename       VARCHAR(20)   NOT NULL,
  charter        VARCHAR(2000),
  start_date     DATE          NOT NULL,
  deadline_date  DATE          NOT NULL,
  CONSTRAINT pk_project PRIMARY KEY (codename),
  CONSTRAINT ck_project_dates CHECK (deadline_date >= start_date)
);


CREATE TABLE component (
  codename                VARCHAR(20)  NOT NULL,
  cmpt_name          VARCHAR(100) NOT NULL,
  parent_name		  VARCHAR(100),
  is_complete             BOOLEAN      NOT NULL,
  priority_num            INTEGER,

  CONSTRAINT pk_component PRIMARY KEY (codename, cmpt_name),

  CONSTRAINT fk_project
    FOREIGN KEY (codename) REFERENCES project(codename)
    ON DELETE CASCADE,

-- foreign key for the parent component automatically uses
-- the same project codename
  CONSTRAINT fk_component_parent
    FOREIGN KEY (codename, parent_name)
    REFERENCES component(codename, cmpt_name)
    ON DELETE CASCADE,

  CONSTRAINT ck_component_priority CHECK ((is_complete = 'FALSE' AND priority_num > 0) OR (is_complete = 'TRUE' AND priority_num IS NULL))
);

CREATE TABLE supervisor (
  emp_id INTEGER NOT NULL,
  codename VARCHAR(20),
  cmpt_name   VARCHAR(100),

  CONSTRAINT pk_supervisor PRIMARY KEY (emp_id),
  CONSTRAINT fk_supervisor_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_supervisor_component
    FOREIGN KEY (codename, cmpt_name)
    REFERENCES component(codename, cmpt_name)
    ON DELETE SET NULL,

-- constraint to ensure that project name and component name are added simultaneously
  CONSTRAINT ck_supervised_component_pair
  CHECK (
    (codename IS NULL AND cmpt_name IS NULL)
    OR
    (codename IS NOT NULL AND cmpt_name IS NOT NULL)
  )
);

CREATE TABLE director (
  emp_id INTEGER NOT NULL,
  codename  VARCHAR(20),

  CONSTRAINT pk_director PRIMARY KEY (emp_id),
  CONSTRAINT fk_director_employee
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_director_project
    FOREIGN KEY (codename) REFERENCES project(codename)
     ON DELETE SET NULL
);


CREATE TABLE objective (
  codename VARCHAR(20)  NOT NULL,
  cmpt_name   VARCHAR(100) NOT NULL,
  obj_id          INTEGER      NOT NULL,
  description      VARCHAR(2000),
  goal_name        VARCHAR(100) NOT NULL,
  is_complete      BOOLEAN      NOT NULL,
  priority_num     INTEGER,

  CONSTRAINT pk_objective PRIMARY KEY (codename, cmpt_name, obj_id),

  CONSTRAINT fk_objective_component
    FOREIGN KEY (codename, cmpt_name)
    REFERENCES component(codename, cmpt_name)
    ON DELETE CASCADE,

  CONSTRAINT ck_objective_priority CHECK ((is_complete = 'FALSE' AND priority_num > 0) OR (is_complete = 'TRUE' AND priority_num IS NULL))
);


CREATE TABLE task (
  codename VARCHAR(20)  NOT NULL,
  cmpt_name   VARCHAR(100) NOT NULL,
  obj_id        INTEGER     NOT NULL,
  task_no       INTEGER     NOT NULL,
  creation_date DATE 	    NOT NULL,
  closure_date  DATE,
  status        VARCHAR(12) NOT NULL,
  description   VARCHAR(2000),
  priority_num  INTEGER,

  CONSTRAINT pk_task PRIMARY KEY (codename, cmpt_name, obj_id, task_no),

  CONSTRAINT fk_task_objective
    FOREIGN KEY (codename, cmpt_name, obj_id)
    REFERENCES objective(codename, cmpt_name, obj_id)
    ON DELETE CASCADE,

-- make sure that closure_date is either not NULL or the status is complete and closure_date is after creation_date
  CONSTRAINT ck_task_closure CHECK (closure_date IS NULL OR (closure_date >= creation_date AND (status = 'DONE' OR status = 'ABANDONED'))),
  
-- make sure that status is only a discrete set of values
  CONSTRAINT ck_task_status CHECK (status IN ('TODO','IN_PROGRESS','DONE','ON_HOLD', 'ABANDONED')),

  CONSTRAINT ck_task_priority CHECK (priority_num IS NULL OR priority_num >= 0)
);


CREATE TABLE meeting (
  meeting_id   INTEGER      NOT NULL,
  title        VARCHAR(50) NOT NULL,
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


CREATE TABLE assigns (
  codename VARCHAR(20) NOT NULL,
  cmpt_name   VARCHAR(100) NOT NULL,
  obj_id           INTEGER     NOT NULL,
  task_no     INTEGER NOT NULL,
  std_emp_id INTEGER NOT NULL,
  mngr_emp_id  INTEGER NOT NULL,

  CONSTRAINT pk_assigns PRIMARY KEY (codename, cmpt_name, obj_id, task_no),

  CONSTRAINT fk_assigns_task
    FOREIGN KEY (codename, cmpt_name, obj_id, task_no)
    REFERENCES task(codename, cmpt_name, obj_id, task_no)
    ON DELETE CASCADE,

  CONSTRAINT fk_assigns_standard
    FOREIGN KEY (std_emp_id) REFERENCES standard(emp_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_assigns_manager
    FOREIGN KEY (mngr_emp_id) REFERENCES manager(emp_id)
    ON DELETE RESTRICT

);


CREATE TABLE distributes (
  codename VARCHAR(20)  NOT NULL,
  cmpt_name   VARCHAR(100) NOT NULL,
  obj_id        INTEGER NOT NULL,
  spvr_emp_id INTEGER NOT NULL,
  team_id       INTEGER NOT NULL,

  CONSTRAINT pk_distributes PRIMARY KEY (codename, cmpt_name, obj_id),

  CONSTRAINT fk_distributes_objective
    FOREIGN KEY (codename, cmpt_name, obj_id)
    REFERENCES objective(codename, cmpt_name, obj_id)
    ON DELETE CASCADE,

  CONSTRAINT fk_distributes_supervisor
    FOREIGN KEY (spvr_emp_id) REFERENCES supervisor(emp_id),

  CONSTRAINT fk_distributes_team
    FOREIGN KEY (team_id) REFERENCES team(team_id)
);
