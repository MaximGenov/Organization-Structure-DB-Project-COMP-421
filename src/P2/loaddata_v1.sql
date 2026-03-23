-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO COMP421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the insert for the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.
-- A more complex syntax that saves you typing effort.
INSERT INTO employee(emp_id, name, position_title, start_date, email, password) VALUES
 (1, 'John Doe', 'Power Systems Intern', '2025-09-02', 'johndoe@yahoo.com', 'iLikeEmpanadas3'),
 (2, 'Amelia Dubey', 'Senior Power Engineer', '2012-10-02', 'ameliadubey1@gmail.com', 'boopitY91'),
 (3, 'Dave Ciabatta', 'Junior Power Systems Specialist', '2000-1-04', 'davit3cia@rogers.com', 'Ilikebeaches1'),
 (4, 'Maria Carella', 'RFIC Specialist', '2015-11-02', 'mariella1993@yahoo.com', 'ItaliaForLif3'),
 (5, 'Samantha Krey', 'RF Engineer', '2009-03-09', 'samkrocks@sympatico.ca', 'sammywhammy02'),
 (6, 'Hank Burrow', 'Junior Structural Engineer', '2017-11-02', 'hank4ever@hotmail.com', 'carpetStain9'),
 (7, 'Chloe Shaw', 'Senior Materials Engineer', '2020-05-02', 'cshaaw@yahoo.com', 'grenadaIsBeautiful2'),
 (8, 'Luigi Carbonara', 'Electrical Systems Manager', '2015-08-27', 'luigi3521@gmail.com', 'Blue32'),
 (9, 'Felix Liaschuk', 'Electrical Infrastructure Supervisor', '2016-02-11', 'felix2@infra.com', '>structural:['),
 (10, 'Catherine Cortina', 'Senior Advisor: Solids and Structures', '1999-07-02', 'ccortina@belllabs.ca', 'boop'),
 (11, 'Mia Evangelou', 'Mechanical Structures Supervisor', '2021-12-06', 'miaeva@hotmail.com', 'Seafood24'),
 (12, 'Ellie Lock', 'Electrical Subsystems Supervisor', '2014-04-03', 'elock43@gmail.com', 'GiveMeaRaze100%'),
 (13, 'Anna Novikov', 'Project Direction Specialist', '2008-11-02', 'annikov9@sympatico.com', 'iLoveMyJob*'),
 (1405, 'Madeline Mora', 'Chief Technical Officer', '2011-06-14', 'maddiem49@crosstrek.com', 'wheresMyCoffee08')
;

INSERT INTO manager(emp_id) VALUES
 (8),
 (10)
;

INSERT INTO team(team_id, department, mngr_emp_id) VALUES
 (32, 'Power Systems', 8),
 (21, 'RF & Antennas', 8),
 (8, 'Solids and Structures', 10)
;

INSERT INTO standard(emp_id, team_id) VALUES
 (1, 32),
 (2, 32),
 (3, 32),
 (4, 21),
 (5, 21),
 (6, 8),
 (7, 8)
;

INSERT INTO project(codename, charter, start_date, deadline_date) VALUES
 ('Bear', 'Contract to design and supply 34 application-specific electric vehicles for the client', '2023-05-02', '2028-07-03'), 
 ('Cobra', 'Contract to design and supply 10 electric supply vehicles for long-distance cargo-hauls', '2024-11-02', '2027-08-31') 
;

INSERT INTO component(codename, cmpt_name, parent_name, is_complete, priority_num) VALUES
 ('Bear', 'Structural', NULL, 'FALSE', 3),
 ('Bear', 'Electrical', NULL, 'FALSE', 5),
 ('Bear', 'Vehicle Frame', 'Structural', 'FALSE', 2),
 ('Cobra', 'Electrical', NULL, 'FALSE', 4),
 ('Cobra', 'Power', 'Electrical', 'TRUE', NULL),
 ('Cobra', 'Communications', 'Electrical', 'FALSE', 5),
 ('Cobra', 'RF Electronics', 'Communications', 'FALSE', 5)
;

INSERT INTO supervisor(emp_id, codename, cmpt_name) VALUES
 ('11', 'Bear', 'Structural'),
 ('9', 'Bear', 'Electrical'),
 ('12', 'Cobra', 'Electrical')
;

INSERT INTO director(emp_id, codename) VALUES
 ('13', 'Bear'),
 ('1405', 'Cobra')
;

INSERT INTO objective(codename, cmpt_name, obj_id, description, goal_name, is_complete, priority_num) VALUES
 ('Bear', 'Vehicle Frame', 12, 'Ensure that the vehicle frame is structurally stable enough to adhere to withstand impacts and dampen mechanical vibrations', 'Frame Sensitivity', 'FALSE', 2),
 ('Bear', 'Structural', 2, 'Complete the designs of the mechanical structures of the vehicle', 'Design Schematics', 'TRUE', NULL),
 ('Bear', 'Electrical', 3, 'Complete the electrical wiring to provide power to the lighting, HUD, and entertainment systems', 'Wiring', 'FALSE', 6),
 ('Cobra', 'Electrical', 8, 'Prepare the relevant documentation and testing results for the upcoming design review', 'D.R. Documentation', 'FALSE', 3),
 ('Cobra', 'Power', 4, 'Conduct further testing to determine the updated power requirements for the vehicle', 'Power Requirements', 'TRUE', NULL),
 ('Cobra', 'RF Electronics', 9, 'Ensure the RFIC chips  meet operational requirements and lack defects', 'Chip Validation', 'FALSE', 5),
 ('Cobra', 'RF Electronics', 15, 'Ensure the robustness and reliability of the on-board communications systems', 'Comms Reliability', 'FALSE', 8)
;

INSERT INTO task(codename, cmpt_name, obj_id, task_no, creation_date, closure_date, status, description, priority_num) VALUES
 ('Bear', 'Vehicle Frame', 12, 45, '2026-02-03', NULL, 'IN_PROGRESS', 'Conduct a vibration analysis for the front right strut of the frame in AutoCad', 1),
 ('Bear', 'Structural', 2, 20, '2023-11-12', '2024-02-01', 'DONE', 'Provide designs for the vehicle suspension', NULL),
 ('Bear', 'Electrical', 3, 18, '2024-03-02', '2024-04-27', 'DONE', 'Determine the specifications for the necessary wiring', NULL),
 ('Bear', 'Electrical', 3, 52, '2026-02-14', NULL, 'ON_HOLD', 'Acquire the wiring from our third party provider', NULL),
 ('Cobra', 'Power', 4, 31, '2025-12-22', NULL, 'IN_PROGRESS', 'Conduct power electronics tests in the high frequency range of the VFD', 2),
 ('Cobra', 'RF Electronics', 9, 51, '2026-03-04', NULL, 'IN_PROGRESS', 'Test the RFIC communications chips for defects', 3),
 ('Cobra', 'RF Electronics', 15, 45, '2026-02-14', NULL, 'IN_PROGRESS', 'Produce a sufficient noise filter for RF interference on high-frequency communication channels', 5)
;

INSERT INTO meeting(meeting_id, title, start_time, end_time, description) VALUES
 (1252, 'Team 32 weekly meeting', '2024-11-12 13.30.00', '2024-11-12 14.30.00', 'To go over the new team objectives for the week and provide progress updates'),
 (1634, 'Bear: Objective 12 status', '2026-02-23 09.30.00', '2026-02-23 11.00.00', 'To discuss the progress on objective 12 with the manager, supervisor, and director'),
 (1322, 'John Doe Performance Review', '2025-12-23 14.00.00', '2025-12-23 15.00.00', 'Annual Performance Review for John Doe'),
 (900, 'Team 21 Kickstarter meeting for project Cobra', '2024-11-05 08.30.00', '2024-11-05 09.30.00', 'To provide an overview of the current responsibilities for the team')
;

INSERT INTO attends(emp_id, meeting_id) VALUES
 (1, 1252),
 (2, 1252),
 (3, 1252),
 (8, 1252),
 (7, 1634),
 (10, 1634),
 (11, 1634),
 (13, 1634),
 (1, 1322),
 (8, 1322),
 (4, 900),
 (5, 900),
 (8, 900)
;

INSERT INTO assigns(codename, cmpt_name, obj_id, task_no, std_emp_id, mngr_emp_id) VALUES
 ('Bear', 'Vehicle Frame', 12, 45, 7, 10),
 ('Bear', 'Structural', 2, 20, 6, 10),
 ('Bear', 'Electrical', 3, 18, 3, 8),
 ('Bear', 'Electrical', 3, 52, 2, 8),
 ('Cobra', 'Power', 4, 31, 7, 8),
 ('Cobra', 'RF Electronics', 9, 51, 4, 8),
 ('Cobra', 'RF Electronics', 15, 45, 5, 8)
;

INSERT INTO Distributes(codename, cmpt_name, obj_id, spvr_emp_id, team_id) VALUES
 ('Bear', 'Vehicle Frame', 12, 11, 8),
 ('Bear', 'Structural', 2, 11, 8),
 ('Bear', 'Electrical', 3, 9, 32),
 ('Cobra', 'Electrical', 8, 12, 32),
 ('Cobra', 'Power', 4, 12, 32),
 ('Cobra', 'RF Electronics', 9, 12, 21),
 ('Cobra', 'RF Electronics', 15, 12, 21)
;
