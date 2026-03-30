-- Include your drop table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO COMP421;

-- Remember to put the drop table ddls for the tables with foreign key references
--    BEFORE the ddls to drop the parent tables (reverse of the creation order).

-- This is only an example of how you add drop table ddls to this file.
--   You may remove it.

DROP INDEX idx_assigns_std_emp_id;
DROP TABLE attends;
DROP TABLE distributes;
DROP TABLE assigns;

DROP TABLE task;
DROP TABLE objective;
DROP TABLE component;

DROP TABLE meeting;
DROP TABLE project;

DROP TABLE standard;
DROP TABLE team;

DROP TABLE director;
DROP TABLE supervisor;
DROP TABLE manager;

DROP TABLE employee;
